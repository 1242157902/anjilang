<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>提示页</TITLE>
<META content="text/html; charset=UTF-8">
<META name="description" content="">
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/reset.css '/>" media="screen">
<style type="text/css">
  .result_box{ width:300px; margin:0 auto; text-align:center; margin-top:100px;}
  .result_box span{ display:block; width:92px; height:92px; background:url(<c:url value='/image/common/icon_result.png' />) no-repeat 0 0; margin-bottom:20px; margin:0 auto;}
  .result_box h2{ font: normal 20px "微软雅黑"; padding-top:20px;}
</style>
<script type="text/javascript">     
function countDown(secs){     
	 //alert(surl);     
	 var jumpTo = document.getElementById('jumpTo');
	 jumpTo.innerHTML=secs;  
	 if(--secs>0){     
	    setTimeout("countDown("+secs+")",1000);     
	 } else{       
	    location.href="<c:url value='/index/index.do' />";     
	 }     
 }     
</script> 
</HEAD>
<body>
<div class="result_box">
   <span></span>
   <h2>${message}</h2>
   <p style="padding-top:50px;"><a href="<c:url value='/index/index.do' />">点击此处返回</a></p>
   <div id="jumpTo">3</div>秒后自动跳转到首页
   <script type="text/javascript">countDown(3);</script>
</div>
</body>
</html>