<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>注册</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META name="description" content="">
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/reset.css'/>" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/login.css'/>" media="screen">
<SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js'/>"></SCRIPT>
</HEAD>
<body class="login_bg">
	<a href="<c:url value='/index/index.do' />"><div class="login_logo"></div></a>
	<div class="loginBox" style="height: 380px;">
		<h1>帐号注册</h1>
		<div class="signup-box">
			<form action="<c:url value='/regist/userregist.do' />" method="post">
			<ul class="signup-common">
				<c:if test="${code != null && code != '' && code != '0' }">
				<li class="tishi"><em></em>${msg }</li>
				</c:if>
				<li>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱:&nbsp;&nbsp;&nbsp;<input type="text" name="userName" value="${userName }" readonly  /></li>
				<li>昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称:&nbsp;&nbsp;&nbsp;<input type="text" name="realName" id="realName" value="" placeholder="昵称" /></li>
				<li>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;&nbsp;&nbsp;<input type="password" name="password" value="" placeholder="您的密码" /></li>
				<li>确认密码:&nbsp;&nbsp;&nbsp;<input type="password" name="password2" value="" placeholder="确认密码" /></li>
			</ul>
			<ul class="reg_main">
				<li><input type="submit" value="完成注册" /></li>
			</ul>
			</form>
		</div>
	</div>

</body>
</HTML>