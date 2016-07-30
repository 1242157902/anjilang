<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
%>
<HTML>
<HEAD>
<TITLE>个人主页</TITLE>
<META content="text/html; charset=UTF-8">
<META name="description" content="">
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css" href="../css/reset.css"
	media="screen">
<LINK rel="stylesheet" type="text/css" href="../css/common.css"
	media="screen">
<LINK rel="stylesheet" type="text/css" href="../css/secpage.css"
	media="screen">
<LINK rel="stylesheet" type="text/css" href="../css/index.css"
	media="screen">
</HEAD>
<body>
       <h2 style="margin-top: 30px;"><span style="color: red;">最近</span>来访<i style="font-size: 12px;margin-left: 20px;">累计访问（${totalCount }）</i></h2>
       <div class="user_lwp">
         <ul class="clearfix"> 
         	<c:forEach items="${userCallers }" var="info">
              	<li><a href="#"><img src="<c:url value='${info.user.header } '/>"  title="${info.user.realName }"></a></li>
              </c:forEach>
         </ul>
       </div>
</body>
</html>