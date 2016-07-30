<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>注册-安吉朗</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META name="description" content="">
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/regreset.css'/>" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/reglogin.css'/>" media="screen">
<SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js'/>"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/userreg.js'/>"></SCRIPT>
</HEAD>
<body class="login_bg">
<blockquote>&nbsp;</blockquote>
<a href="<c:url value='/index/index.do' />"><div class="login_logo"></div></a>
<div class="loginBox" style=" height:320px;">
	<div class="selectReg">
		<ul>
			<li id="emailreg"> 邮箱注册 </li>
			<li id="phonereg" >手机注册 </li>
		</ul>
	</div>
   <div class="signup-box">
      <form action="<c:url value='/regist/userreg.do'/>" method="post">
      <ul class="signup-common">
      	<c:if test="${code != null && code != '' && code != '0' }">
      		<li class="tishi"><em></em>${msg }</li>
      	</c:if>
         <li><input type="text" name="email" value="${email }" placeholder="您的邮箱"></li>
      </ul>
       <ul class="reg_main">
         <li><input type="submit" value="立即注册" /></li>
      </ul>
      </form>
      <div class="word_ms">
        <span class="fl">已有帐号？<a href="<c:url value='/login/login.jsp'/>">登录</a></span>
        <span  style="clear:both;">&nbsp;&nbsp;注册视为同意安吉朗<a href="">用户协议</a></span>
      </div>
      <ul class="reg_main">
         <li class="ohl">
          <span>用合作网站账户直接登录</span>
         <a href="<c:url value='/login/qqLogin.do '/>"></a><a class="sina" href="<c:url value='/login/weiboLogin.do '/>"></a></li>
      </ul>
   </div>
	 <div class="signup-phone-box"   style="display: none;">
      <form action="<c:url value='/regist/userreg1.do'/>" method="post">
      <ul class="signup-common">
      	<c:if test="${code != null && code != '' && code != '0' }">
      		<li class="tishi"><em></em>${msg }</li>
      	</c:if>
         <li><input type="text"  id="phone"  name="phone" value="${phone }" placeholder="您的手机号"><span><input id="btnSendCode" type="button"   value="发送短信"/></span><span class="span" id="s_phone"></span> </li>
         <li><input type="text"  id="message"  name="verifycode" value="${verifycode }" placeholder="您的验证码"><span class="span" id="s_verifycode"></span> </li>
      </ul>
       <ul class="reg_main">
         <li><input  id="submit" type="submit" value="立即注册" /></li>
      </ul>
      </form>
      <div class="word_ms">
        <span class="fl">已有帐号？<a href="<c:url value='/login/login.jsp'/>">登录</a></span>
        <span style="clear:both;">&nbsp;&nbsp;注册视为同意安吉朗<a href="">用户协议</a></span>
      </div>
      <ul class="reg_main">
         <li class="ohl">
          <span>用合作网站账户直接登录</span>
         <a href="<c:url value='/login/qqLogin.do '/>"></a><a class="sina" href="<c:url value='/login/weiboLogin.do '/>"></a></li>
      </ul>
   </div>
</div>


</body>
</HTML>