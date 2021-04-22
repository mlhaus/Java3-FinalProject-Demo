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
            <h2>Job Openings</h2>
            <div class="pagination">
                <c:forEach var="i" begin="1" end="${maxPages}">
                    <a <c:if test="${currentPage == i}">class="active"</c:if> href="<c:url value="/jobs"><c:param name="page" value="${i}" /></c:url>">${i}</a>
                </c:forEach>
            </div>
            <div class="container">
                <c:forEach items="${jobs}" var="job" begin="${begin}" end="${end}">
                    <div class="job">
                        <table>
                            <tr>
                                <td>Title:</td><td><a href="<c:url value="/jobs"><c:param name="id" value="${job.id}" /></c:url>"><c:out value="${job.title}" /></a></td>
                            </tr>
                            <tr>
                                <td>Location:</td><td><c:out value="${job.city}" />, <c:out value="${job.state}" /></td>
                            </tr>
                            <tr>    
                                <td>Department:</td><td><c:out value="${job.department}" /></td>
                            </tr>
                        </table>
                        <p>
                            <c:out value="${job.jobDescription}" />
                        </p>
                    </div>
                </c:forEach>
            </div>
        </main>
    </body>
</html>
