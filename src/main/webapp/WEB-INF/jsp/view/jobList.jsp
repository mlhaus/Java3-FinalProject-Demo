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
        <title>JSP Page</title>
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
        </header>
        <div class="container">
            <h2>Job Openings</h2>
            <div class="pagination">
                <c:forEach var="i" begin="1" end="${maxPages}">
                    <a <c:if test="${currentPage == i}">class="active"</c:if> href="<c:url value="/jobs"><c:param name="page" value="${i}" /></c:url>">${i}</a>
                </c:forEach>
            </div>
            <div class="jobs">
                <c:forEach items="${jobs}" var="job" begin="${begin}" end="${end}">
                    <div class="job">
                        <p>
                            Title: <c:out value="${job.title}" /><br>
                            Location: <c:out value="${job.city}" />, <c:out value="${job.state}" /><br>
                            Department: <c:out value="${job.department}" />
                        </p>
                        <p>
                            <c:out value="${job.jobDescription}" />
                        </p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>
