<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>找回密码-安吉朗</TITLE>
<META content="text/html; charset=UTF-8">
<META name="description" content="">
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/reset.css' />"
	media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/login.css' />"
	media="screen">
<SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js' />"></SCRIPT>
</HEAD>
<body class="login_bg">
<div class="login_logo"></div>
<div class="loginBox" style=" height:300px;">
   <h1>找回密码</h1>
   <div class="signup-box">
   	<form action="<c:url value='/user/findpwd.do' />" method="post">
      <ul class="signup-common">
          <c:if test="${msg != null && msg != ''}">
      		<li class="tishi"><em></em>${msg }</li>
      	  </c:if>
         <li><input type="text" name="userName" value="" placeholder="您的邮箱"></li>
      </ul>
       <ul class="reg_main">
         <li><input type="submit" value="下一步"></li>
      </ul>
     </form> 
      
   </div>
</div>


</body>
</HTML>