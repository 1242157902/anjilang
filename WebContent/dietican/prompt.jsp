<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>提示页</title>
<link rel="stylesheet" type="text/css" href="css/prompt.css" />
<link rel="stylesheet" type="text/css" href="css/share.css" />
</head>
<body>



  <!--头部-->
  <div class="top">
  <div class="top-in">
  <div class="top-in-l">
  <p>安吉朗欢迎您的光临...</p>
  </div>
  
  
  <div class="erweima">
    <div class="erweima-x">
      <b></b>
    </div>
  </div>
  
  <div class="qq"><a href="#"></a></div>
  <div class="xlweb"><a href="#"></a></div>
  <div class="top-in-r">
       <ul>
        <li class="num1">
          
          <p><a href="#">营养师注册丨</a></p>
        </li>
        <li class="num2">
            
            <p><a href="#">用户注册丨</a></p>
        </li>
        <li><p><a href="#">登录</a></p></li>
       </ul>
  </div>
  </div>
</div>
<!--logo开始-->
<div class="logo">
 <a href="#" class="img">
   <img src="images/logo.png" />
 </a>
 <div class="logo-bg"></div>
 <div class="input">
  <input id="text" type="text"/>
  <span></span>
   　<i></i>
 </div>
 <div class="logo-r">
   <img src="images/tel.png" />
 </div>
</div>
<!--导航栏开始-->
<div class="nav">
     <div class="nav-in">
     <div class="nav_l">
       <p>最专业的治疗膳食服务平台</p>
       <span></span>
     </div>
       <div class="nav_t">
            <a href="#" class="center">首页</a>
            <a href="#">医生问答</a>
            <a href="#">找医生</a>
            <a href="#">膳食商城</a>
            <span></span>
            <a href="#">患友会</a>
       </div>
      
     </div>
     
</div>
<!--小组申请-->
<div class="apply">
    <div class="apply-in">
      <dl>
         <dt></dt>
         <dd>小组已进入审核状态～</dd>
         <dd>正常内容将会在24小时内显示出来，请耐心等待！</dd>
      </dl>
     <span class="return"><a href="<c:url value='/dietican/addArticle.jsp' />">返回上一页</a></span>
      <span class="indexs"><a href="<c:url value='/dietican/index.do' />">返回首页</a></span>

    </div>
</div>

<div class="nutritionists">
   <div class="nutritionists-1">
    <span></span><h3><a href="#">找营养师</a></h3>
    <p>200城市，200城市，200城市，200城市，200城市，200城市，</p>
   </div>
   <div class="nutritionists-2">
   <span></span><h3><a href="#">找营养师</a></h3>
    <p>200城市，200城市，200城市，200城市，200城市，200城市，</p>
   </div>
   <div class="nutritionists-3">
   <span></span><h3><a href="#">找营养师</a></h3>
    <p>200城市，200城市，200城市，200城市，200城市，200城市，</p>
   </div>
   <div class="nutritionists-4">
   <span></span><h3><a href="#">找营养师</a></h3>
    <p>200城市，200城市，200城市，200城市，200城市，200城市，</p>
   </div>
 </div>
<!--底部-->
<div class="bottom">
  <div class="bottom-in">
   <dl class="logo">
     <dd>
      <img src="images/logo_footer.png" />
     </dd>
   </dl>
   <dl>
     <dt>关于我们</dt>
     <dd><a href="#">公司简介</a></dd>
     <dd><a href="#">公司简介</a></dd>
     <dd><a href="#">公司简介</a></dd>
     <dd><a href="#">公司简介</a></dd>
     <dd><a href="#">公司简介</a></dd>
   </dl>
   <dl>
     <dt>关于我们</dt>
     <dd><a href="#">公司简介</a></dd>
    
   </dl>
   <dl>
     <dt>关于我们</dt>
     <dd><a href="#">公司简介</a></dd>
     <dd><a href="#">公司简介</a></dd>
    
   </dl>
   <dl class="last">
     <div class="last-btn">
       <ul>
         <li><a href="#"></a></li>
         <li><a href="#"></a></li>
         <li><a href="#"></a></li>
       </ul>
     </div>
   </dl>
  </div>
</div>

<div class="link">
  <span>友情链接：</span>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">[更多...]</a>
</div>

<div class="sm">
 <p>本站声明：任何信息都不能替代执业营养师面对面的诊断和治疗，网站内容仅供用户参考，本站不承担由此引起的法律责任。</p>

</body>
</html>
