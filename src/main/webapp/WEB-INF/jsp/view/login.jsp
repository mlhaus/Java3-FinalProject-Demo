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
            <h2>Login</h2>
            <c:if test="${loginFailed}">
                <p style="font-weight: bold;">The username and password you entered are not correct. Please try again.</p>
            </c:if>
            <form method="POST" action="<c:url value="/login" />">
                <label for="username">Username</label>
                <input type="text" name="username" id="username" /><br><br>
                <label for="password">Password</label>
                <input type="password" name="password" id="password" /><br><br>
                <input type="submit" value="Log In" />
            </form>
        </main>
    </body>
</html>