﻿<%@page import="com.anjilang.dao.base.impl.PaginationSupport"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>安吉朗-问答详情页</TITLE>
<META content="text/html;charset=UTF-8">
<META name="description" content="">
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/reset.css' />" media="screen">
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/common.css' />" media="screen">
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/secpage.css' />" media="screen">
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/index.css' />" media="screen">
<SCRIPT type="text/javascript"
	src="<c:url value='/js/jquery-1.7.2.min.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js' />"></SCRIPT>
<script type="text/javascript">
	$(window.parent.document).find("#mainFrame").load(function(){
		var main = $(window.parent.document).find("#mainFrame"); 
		var thisheight = $(document).height()+30; 
		main.height(thisheight); 
	});
	$(function(){
	    $.ajax({
			type : 'POST',
			url : '<c:url value="/userCaller/toPersonCaller.do" />',
			data:{"userId":$("#userCallerId").val()},
		    dataType:'json',    
		    success:function(data) {
		    }
		 });
	});
</script>
</HEAD>
<body>
	<div id="content">
		<div class="contentBox">
			<div class="leftBox">
				<div class="tab-cont">
				 <ul>
					<li class="tit qus">
						<c:set var="testStr" value="${questionInfo.content}" /> 
						<c:choose> 
						<c:when test="${fn:length(testStr) > 10}"> 
						<c:out value="${fn:substring(testStr, 0, 10)}" />  ...... 
						</c:when> 
						<c:otherwise> 
						<c:out value="${testStr}" /> 
						</c:otherwise> 
						</c:choose>
					</li>
					<li class="dels clearfix" >
					    <span style="width:56px; height:86px; border-radius:50%;">
					       <img height="56px" src="../<c:url value='${userInfo.header }'/>"><br>
					       ${userInfo.realName }
					    </span>
					    <div class="fr_con" style="float:right; width:770px; padding-bottom:10px;border-bottom:1px solid #c9c9c9">
					      <p>${questionInfo.content }</p>
					      <p><a href="#">${questionInfo.disease.diseaseName }</a></p>
					    </div> 
					</li>
					<li class="bottm note clearfix"><span><i></i>
						发布时间：${questionInfo.crTime}
						</span><span>回答（${questionInfo.answerNum}）</span><span>浏览（${questionInfo.num}）</span></li>
        			</ul>
				</div>
				<c:forEach items="${listAnswer }" var="info">
					<div class="tab-cont">
					<ul>
					<li class="dels clearfix" >
					    <span style="width:56px; height:86px; border-radius:50%;">
					       <img height="56px" src="../<c:url value='${info.user.header }'/>"><br>
					       ${info.user.realName }
					    </span>
					    <div class="fr_con" >
					      <p>${info.content }22</p>
					    </div> 
					</li>
					<li class="bottm note clearfix"><span><i></i>
						发布时间：${info.crTime}
						</span></li>
        			</ul>
					</div>
				</c:forEach>
				
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<%@ include file="/common/footer.jsp"%>
</body>
</html>