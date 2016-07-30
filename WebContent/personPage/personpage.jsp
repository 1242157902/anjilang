﻿<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>${user.realName }_营养师的个人主页-安吉朗,治疗膳食专家</TITLE>
<META content="text/html;charset=UTF-8">
<meta name="keywords" content="${user.realName },营养师,电话咨询,营养师问答">
<meta name="description" content="${user.realName }营养师为用户提供电话健康指导，全方位的远程健康帮助！"/>
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/reset.css '/>" media="screen">
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/common.css '/>" media="screen">
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/secpage.css '/>" media="screen">
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/index.css '/>" media="screen">
<SCRIPT type="text/javascript"
	src="<c:url value='/js/jquery-1.7.2.min.js '/>"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js '/>"></SCRIPT>
<script type="text/javascript">
		function queryQuestion(id){
			var path = "<%=path%>";
			path=path + "/question/list.do?userId="+id;
			document.getElementById("mainFrame").src=path; 
		}
		function queryArticleInfo(id){
			var path = "<%=path%>";
			path=path + "/articleInfo/list.do?userId="+id;
			document.getElementById("mainFrame").src=path; 
		}
		function queryPersonIndex(id){
			var path = "<%=path%>";
			path=path + "/personPage/toPersonIndex.do?id="+id;
			document.getElementById("mainFrame").src=path; 
		}
		function queryPersonData(id){
			var path = "<%=path%>";
			path=path + "/user/toPersonData.do?id="+id;
			document.getElementById("mainFrame").src=path; 
		}
		$(function(){//访客+1
		    $.ajax({
				type : 'POST',
				url : '<c:url value="/userCaller/toPersonCaller.do" />',
				data:{"userId":$("#userCallerId").val()},
			    dataType:'json',    
			    success:function(data) {
			    	
			    }
			 });
		});
		function delectArticleParent(id,userId){
			if(window.confirm("确实要删除吗？")){
				$.ajax({
					type : 'POST',
					url : '<c:url value="/articleInfo/articleInfoDelect.do" />',
					data:{
						"userId":userId,
						"id":id
						},
				    dataType:'json',    
				    success:function(data) {
				    	if("00"==data){
				    		alert("删除成功" );
				    		var path = "<%=path%>";
							path = path + "/articleInfo/list.do?userId=" + userId;
							document.getElementById("mainFrame").src = path;
						} else {
							alert("删除失败");
						}
					}
				});
			} else {
				return;
			}
		}
		 function iFrameHeight(){
	        var ifm= document.getElementById("mainFrame");
	        var subWeb = document.frames ? document.frames["mainFrame"].document :
			ifm.contentDocument;
            if(ifm != null && subWeb != null) {
            	ifm.height = subWeb.body.scrollHeight;
            }
	    }
</script>
</HEAD>
<body>
<%@ include file="/common/newhead.jsp"%>
	<div id="content">
		
		<div class="clear"></div>
		<div class="contentBox">
			<div class="banner_top">
				<a href=""> <c:choose>
						<c:when test="${topPic!=null }">
							<img src="<c:url value='/${topPic }' />">
						</c:when>
						<c:otherwise>
							<img src="<c:url value='/image/defaultPersonTop.jpg' />">
						</c:otherwise>
					</c:choose>
				</a>
			</div>
			<div class="user_info">
				<ul>
					<li class="attes"><span>认证营养师</span>如何认证</li>
					<li class="header"><img src="<c:url value='/${user.header }' />"><a href="<c:url value="/answer/addQuestion.do?doctorUserId=${user.id}" />" target="_blank">向TA提问</a></li>
					<li class="data">
						<h3>${user.realName }
							<i></i><span><c:if test="${user.sex=='1'}">男</c:if> <c:if
									test="${user.sex=='2'}">女</c:if>，${user.signature }</span>
						</h3>
						<p>
							<i></i>${province.cityName }<span>|</span>${city.cityName }</p>
						<p>
							<i class="ks"></i>${hospital }</p>
						<p>
							<i class="zw"></i>${user.title }<span>|</span>擅长：
							<c:if test="${isProjectNot!='1'}">
								<c:forEach items="${projects }" var="info">
									<span class="note">${info.diseaseName }</span>
								</c:forEach>
							</c:if>
						</p>
					</li>
					<li class="number"><a href="#"><span>${user.answerNum}</span><span>回答</span></a>
						<a href="#"><span>${articleNum}</span><span>文章</span></a> <a
						href="#"><span>${agreeNum }</span><span>被感谢</span></a> <input
						id="userCallerId" type="hidden" name="userCallerId"
						value="${user.id }" /></li>
				</ul>
			</div>

		</div>
		<div class="clear"></div>
		<div class="user_nav">
			<div class="contentBox">
				<a href="#" onclick="queryPersonIndex('${user.id }')"><i></i>主页</a><span>|</span>
				<a href="#" onclick="queryPersonData('${user.id }')"><i
					class="grzl"></i>个人资料</a><span>|</span> <a href="#"
					onclick="queryQuestion('${user.id }');"><i class="wd"></i>问答</a><span>|</span>
				<a href="#" onclick="queryArticleInfo('${user.id }');"><i
					class="wz"></i>文章</a>
			</div>
		</div>
		<div id="persindex">
			<iframe
				src="<c:url value='/personPage/toPersonIndex.do?id=${user.id }'/>"
				name="mainFrame" frameborder="0" marginheight="0" scrolling="no"
				marginwidth="0" id="mainFrame" height="500px;"
				onload="iFrameHeight();" width="100%"> </iframe>
		</div>
	</div>
	<div class="clear"></div>
	<%@ include file="/common/newfooter.jsp"%>
</body>
</html>