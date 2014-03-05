<!DOCTYPE html>
<%@ page session="false" %>
<html lang="en">
<head><title>Invalidate Http Session</title></head>
<body>
<h1>Invalidate Http Session</h1>
<p>Invalidating Http Session is useful during load tests to prevent OutOfMemoryErrors due to the number of live sessions.</p>
<%
    HttpSession session = request.getSession(false);
    if (session == null) {
       %>No Session exists<%
    } else {
       session.invalidate();
       %>Http Session is invalidated<%
    }
%>
</body>
</html>