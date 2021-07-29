<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="WEB-INF/jsp/error/error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- http://localhost:8080/atcrowdfunding-main/ -->
	<jsp:forward page="/index"></jsp:forward><!-- 绝对路径 -->
	
	<!-- 相对于welcome.jsp的请求路径进行查找 -->
	<%-- <jsp:forward page="index"></jsp:forward> --%><!-- 相对路径 -->
	
	<!-- ${pageContext.request.contextPath}上下文路径  （重复的上下文路径）-->
	<%-- <jsp:forward page="${pageContext.request.contextPath}/index"></jsp:forward> --%>

	<%--
  		前台路径：浏览器发起的请求路径。
  		<link rel="stylesheet" href="static/bootstrap/css/bootstrap.min.css">
  		
  		不以 / 开头表示相对路径
  		以 / 开头表示，表示从服务器的根（ROOT）进行查找(8080)
  		<link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">
  		以上下文路径开头，表示当前应用程序的根（atcrowdfunding-main）进行资源查找
  		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css">
   --%>
</body>
</html>