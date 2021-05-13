<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Medirevv - Application Page</title>
        <link href="styles/normalize.css" rel="stylesheet">
        <link href="styles/main.css" rel="stylesheet">
    </head>
    <body>
        <header>
            <nav>
                <ul>
                    <li><a href="<c:url value="/jobs" />">View Jobs</a></li>
                    <li><a href="<c:url value="/applications" />">Applications</a></li>
                    <c:if test="${sessionScope.username != null}">
                        <li><a href="<c:url value="/login?logout" />">Logout</a></li>
                    </c:if>
                </ul>
            </nav>
            <h1>Medirevv</h1>
        </header>
        <main>
            <h2>Job Applicants</h2>
            <div class="container">
                <c:forEach items="${applications}" var="application">
                    <div class="application">
                        <table>
                            <tr>
                                <td>Job Title:</td><td><a href="<c:url value="/applications"><c:param name="id" value="${application.value.id}" /></c:url>"><c:out value="${application.value.jobTitle}" /></a></td>
                            </tr>
                            <tr>
                                <td>Name:</td><td><c:out value="${application.value.firstName}" />&nbsp;<c:out value="${application.value.lastName}" /></td>
                            </tr>
                            <tr>    
                                <td>Email:</td><td><c:out value="${application.value.email}" /></td>
                            </tr>
                        </table>
                    </div>
                </c:forEach>
            </div>
        </main>
    </body>
</html>
