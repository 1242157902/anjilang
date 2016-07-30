<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>登录-安吉朗</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	<a href="<c:url value='/index/index.do' />"><div class="login_logo"></div></a>
<div class="loginBox">
   <div class="signup-box">
      <form action="<c:url value='/login/login.do' />" method="post">
      <ul class="signup-common">
         <!-- <li class="tishi"><em></em>帐号不存在，请点击注册</li> -->
         <c:if test="${code != null && code != '' && code != '0' }">
      		<li class="tishi"><em></em>${msg}</li>
      	</c:if>
         <li>
         
         <input type="text" name="userName" value="${userName }"  placeholder="邮箱" />
         
         
         </li>
         <li><input type="password" name="password" value="" placeholder="您的密码" /></li>
      </ul>
      <div style="width:200px;margin-left:60px;margin-top:10px;margin-bottom:10px;">
        <a href="<c:url value='/forgetpassword.jsp' />"><span style="color:red;">忘记密码？</span></a>  没有帐号？<a href="<c:url value='/regist/userreg.jsp' />"><span style="color:red;">立即注册</span></a>
      </div>
      <ul class="reg_main">
         <li><input type="submit" value="立即登录" /></li>
      </ul>
     </form> 
       <ul class="reg_main">
         <li class="ohl">
          <span>用合作网站账户直接登录</span>
         	
         	
         	<a href="<c:url value='/login/qqLogin.do '/>"></a>
         	<a href="<c:url value='/login/weiboLogin.do '/>" class="sina" ></a>
         
         </li>
      </ul>
      
   </div>
</div>

</body>
</HTML>