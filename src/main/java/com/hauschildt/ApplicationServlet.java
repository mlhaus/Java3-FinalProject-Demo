/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.hauschildt;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.time.Instant;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author k0519415
 */
@WebServlet(name = "ApplicationServlet", urlPatterns = {"/applications"})
@MultipartConfig(
        fileSizeThreshold = 5_242_880, //5MB
        maxFileSize = 20_971_520L //20MB
)
public class ApplicationServlet extends HttpServlet {
    private Map<Integer, Application> applications = new LinkedHashMap<>();
    private volatile int APPLICATION_ID_SEQUENCE = 1;

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null) {
            response.sendRedirect("login");
            return;
        }
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "download":
                downloadAttachment(request, response);
                break;
            case "list":
            default:
                listApplications(request, response);
                break;
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("username") == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "create":
                createApplication(request, response);
                break;
            case "list":
            default:
                listApplications(request, response);
                break;
        }
    }
    
    private void downloadAttachment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idString = request.getParameter("applicationId");
        Application application = getApplication(idString);
        String name = request.getParameter("attachment");
        if (application == null || name == null) {
            response.sendRedirect("applications");
            return;
        }

        Attachment attachment = application.getResumeUpload();
        if (attachment == null) {
            response.sendRedirect("applications?id=" + idString);
            return;
        }

        response.setHeader("Content-Disposition", "attachment; filename=" + attachment.getName());
        response.setContentType("application/octet-stream");

        try (ServletOutputStream stream = response.getOutputStream()) {
            stream.write(attachment.getContents());
        }
    }
    
    private Application getApplication(String idString) throws ServletException, IOException {
        if (idString == null || idString.length() == 0) {
            return null;
        }

        try {
            Application application = applications.get(Integer.parseInt(idString));
            if (application == null) {
                return null;
            }
            return application;
        } catch (Exception e) {
            return null;
        }
    }
    
    private void createApplication(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Application application = new Application();
        boolean error = false;
        String firstName = request.getParameter("firstName");
        if(firstName == null || firstName.equals("")) {
            error = true;
            application.setFirstNameError("First name required");
        } else {
            application.setFirstName(firstName);
        }
        String lastName = request.getParameter("lastName");
        if(lastName == null || lastName.equals("")) {
            error = true;
            application.setLastNameError("Last name required");
        } else {
            application.setLastName(lastName);
        }
        String email = request.getParameter("email");
        if(email == null || email.equals("")) {
            error = true;
            application.setEmailError("Email required");
        } else {
            application.setEmail(email);
        }
        String phone = request.getParameter("phone");
        if(phone == null || phone.equals("")) {
            error = true;
            application.setPhoneError("Phone number required");
        } else {
            application.setPhone(phone);
        }
        String salary = request.getParameter("salary");
        if(salary == null || salary.equals("")) {
            error = true;
            application.setSalaryError("Desired salary required");
        } else {
            application.setDesiredSalary(Double.parseDouble(salary));
        }
        String startDate = request.getParameter("startDate");
        if(startDate == null || startDate.equals("")) {
            error = true;
            application.setStartDateError("Start date required");
        } else {
            application.setEarliestStartDate(LocalDate.parse(startDate));
        }
        
        Part filePart = request.getPart("resume");
        if (filePart != null && filePart.getSize() > 0) {
            Attachment attachment = processAttachment(filePart);
            if (attachment != null) {
                application.setResumeUpload(attachment);
            }
        } else {
            error = true;
            application.setResumeError("Resume attachment required");
        }
        String jobId = request.getParameter("jobId");
        if(!error) {
            application.setJobid(Integer.parseInt(jobId));
            application.setDateTimeSubmitted(Instant.now());
            application.setActive(true);
            int id;
            synchronized (this) {
                id = this.APPLICATION_ID_SEQUENCE++;
                application.setId(id);
                applications.put(id, application);
            }
            response.sendRedirect("applications");
        } else {
            request.setAttribute("application", application);
            request.getRequestDispatcher("/jobs?id=" + jobId).forward(request, response);
//        response.sendRedirect("jobs?id=" + jobId);
        }
    }
    
    private Attachment processAttachment(Part filePart) throws IOException {
        Attachment attachment = new Attachment();
        try (InputStream inputStream = filePart.getInputStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();) {
            int read;
            final byte[] bytes = new byte[1024];
            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
            attachment.setName(filePart.getSubmittedFileName());
            attachment.setContents(outputStream.toByteArray());
        }
        return attachment;
    }
    
    private void listApplications(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/WEB-INF/jsp/view/applicationList.jsp").forward(request, response);
    }

}
