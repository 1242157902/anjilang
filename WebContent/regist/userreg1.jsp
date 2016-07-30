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
<div class="loginBox" style=" height:300px;">
   <div class="signup-box">
       <div class="notes_sure">
         <em></em><p>邮件已发送到您的邮箱<br/>
${email }<br/>
请点击邮箱中的验证链接完成验证</p>
      </div>
      
       <ul class="reg_main">
         <li><a href="${mailUrl }"><input type="button" value="前往邮箱验证"></a></li>
      </ul>
      <div class="word_ms">
         <p><strong>没有收到验证邮件？</strong></p>
         <p>1. 电子邮件偶尔会有延时状况，请耐心等待<br/>
2. 尝试到垃圾邮件里找找看<br/>
3. 如果仍然没有邮件：重新发送验证邮件<br/>
4. 邮件地址写错了？重新注册</p>
      </div>
   </div>
</div>

</body>
</HTML>