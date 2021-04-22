<%-- 
    Document   : jobList
    Created on : Apr 21, 2021, 4:56:39 PM
    Author     : k0519415
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Medirevv - Career Page</title>
        <link href="styles/normalize.css" rel="stylesheet">
        <link href="styles/main.css" rel="stylesheet">
    </head>
    <body>
        <header>
            <nav>
                <ul>
                    <li><a href="<c:url value="/jobs" />">View Jobs</a></li>
                    <li><a href="<c:url value="/applications" />">Applications</a></li>
                    <li><a href="<c:url value="/login" />">Login</a></li>
                </ul>
            </nav>
            <h1>Medirevv</h1>
        </header>
        <main>
            <div class="container">
                <div class="job single">
                    <h2><c:out value="${job.title}"/></h2>
                    <table>
                        <tr>
                            <td>Location:</td>
                            <td><c:out value="${job.city}, ${job.state}"/></td>
                        </tr>
                        <tr>
                            <td>Employment Type:</td>
                            <td>
                                <c:choose>
                                    <c:when test="${job.fullTime}">
                                        Full-time
                                    </c:when>
                                    <c:otherwise>
                                        Part-time
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td>Department:</td>
                            <td><c:out value="${job.department}"/></td>
                        </tr>
                        <tr>
                            <td>Experience:</td>
                            <td><c:out value="${job.experience}"/></td>
                        </tr>
                        <tr>
                            <td>Salary:</td>
                            <td>
                                <fmt:formatNumber maxFractionDigits="0" type="currency" value="${job.salary}" />
                                <c:choose>
                                    <c:when test="${job.wageCategory == 'Salaried'}">
                                        per year
                                    </c:when>
                                    <c:otherwise>
                                        per hour
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td>Description:</td>
                            <td><c:out value="${job.jobDescription}"/></td>
                        </tr>
                    </table>
                </div>
                <div class="applicationForm">
                    <h2>Apply for this job</h2>
                    <form action="<c:url value="/application" />" method="POST">
                        <input type="hidden" value="${job.id}">
                        <table>
                            <tr>
                                <td><label for="firstName">First Name <span class="required">*</span></label></td>
                                <td>
                                    <input type="text" name="firstName" id="firstName" value="">
                                    <span class="error"></span>
                                </td>
                            </tr>
                            <tr>
                                <td><label for="lastName">Last Name <span class="required">*</span></label></td>
                                <td>
                                    <input type="text" name="lastName" id="lastName" value="">
                                    <span class="error"></span>
                                </td>
                            </tr>
                            <tr>
                                <td><label for="email">Email <span class="required">*</span></label></td>
                                <td>
                                    <input type="text" name="email" id="email" value="">
                                    <span class="error"></span>
                                </td>
                            </tr>
                            <tr>
                                <td><label for="phone">Phone <span class="required">*</span></label></td>
                                <td>
                                    <input type="text" name="phone" id="phone" value="">
                                    <span class="error"></span>
                                </td>
                            </tr>
                            <tr>
                                <td><label for="resume">Resume <span class="required">*</span></label></td>
                                <td>
                                    <input type="file" name="resume" id="resume">
                                    <span class="error"></span>
                                </td>
                            </tr>
                            <tr>
                                <td><label for="salary">Desired Salary <span class="required">*</span></label></td>
                                <td>
                                    <input type="number" name="salary" id="salary">
                                    <span class="error"></span>
                                </td>
                            </tr>
                            <tr>
                                <td><label for="startDate">Earliest Start Date <span class="required">*</span></label></td>
                                <td>
                                    <input type="date" name="startDate" id="startDate">
                                    <span class="error"></span>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" value="Send"></td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </main>
    </body>
</html>
