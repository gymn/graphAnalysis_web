<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>复杂网络分析系统</title>
</head>
<body>
<h1>复杂网络分析系统</h1>
<h2>点击<a href="<%=basePath%>main">这里</a>进入系统</h2>
</body>
</html>
