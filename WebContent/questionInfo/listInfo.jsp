﻿﻿<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<SCRIPT type="text/javascript" src="../js/jquery-1.7.2.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../js/common.js"></SCRIPT>
<script type="text/javascript">
	/* $(function(){
		
		var hmain = parent.document.getElementById("mainFrame");
		alert(hmain.style.height);
		hmain.style.height = 500+ 'px';
	}); */
	$(window.parent.document).find("#mainFrame").load(function() {
		var main = $(window.parent.document).find("#mainFrame");
		var thisheight = $(document).height() + 30;
		main.height(thisheight);
	});
</script>
</HEAD>
<body>
	<div class="contentBox">
		<!-- 问答 -->
		<div class="leftBox">
			<h2>
				问答<i>(<span>${questionSum }</span>)位会员得到了都教授医生的帮助
				</i>
			</h2>
			<div class="tab-cont">

				<c:forEach items="${listQues }" var="info">
					<ul>
						<li class="tit">
						<a target="_blank" href="<c:url value='/answer/answer.do?questionId=${info.questionId }'/>" >
							<c:set var="testStr" value="${info.questioncontent}" />
							<c:choose>
								<c:when test="${fn:length(testStr) > 10}">
									<c:out value="${fn:substring(testStr, 0, 10)}" />  ...... 
									</c:when>
								<c:otherwise>
									<c:out value="${testStr}" />
								</c:otherwise>
							</c:choose>
						</a>
						</li>
						<li class="dels clearfix"><span> <img
								src="<c:url value='/${user.header }'/>">
								<p>${user.realName }</p>
						</span>
							<div class="fr_con">
								<p>${info.answerContent }</p>
								<p>
									<a href="#">${info.diseaseName }</a>
									<!-- <a href="">食疗方法</a> -->
								</p>
							</div></li>
						<li class="bottm clearfix"><span><i></i>发布时间：${info.answerAcrTime} </span><span>回答（${info.answerNum }）</span><span>
						浏览（<%-- ${fn:length(info.answers)} --%>${info.num }）</span></li>
					</ul>
				</c:forEach>
				<div class="pageNav">				
					<c:if test="${pageNo>1}">
			    		<a href="<c:url value='/question/list.do?userId=${user.id }&pageNo=${pageNo-1 }' />" class="next">上一页</a>
			    		<c:if test="${pageCount>3 }">
			    			<strong>...</strong>
			    		</c:if>
			    		<a href="<c:url value='/question/list.do?userId=${user.id }&pageNo=${pageNo-1 }' />">${pageNo-1 }</a>
			    	</c:if>
			       <a href="<c:url value='/question/list.do?userId=${user.id }&pageNo=${pageNo }' />" class="on">${pageNo }</a>
	           		<c:if test="${pageNo<pageCount }">
	           			<a href="<c:url value='/question/list.do?userId=${user.id }&pageNo=${pageNo+1 }' />">${pageNo+1 }</a>
	           			<c:if test="${pageNo+1<pageCount }">
	           				<strong>...</strong>
	           			</c:if>
	           			<a href="<c:url value='/question/list.do?userId=${user.id }&pageNo=${pageNo+1 }' />" class="next">下一页</a>
	           		</c:if>
					
				</div>
			</div>
		</div>
		<div class="rightBox">
			<h2>
				<span>${user.realName }</span>擅长
			</h2>
			<div class="tagBox" style="padding: 0">
				<c:if test="${isProjectNot!='1'}">
					<c:forEach items="${projects }" var="info">
						<span>${info.diseaseName }</span>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<div class="clear"></div>
	</div>
</body>
</html>