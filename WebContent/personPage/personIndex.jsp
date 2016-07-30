﻿<%@ page language="java" contentType="text/html; charset=utf-8"
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
<META content="text/html;charset=UTF-8">
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
$(window.parent.document).find("#mainFrame").load(function() {
	var main = $(window.parent.document).find("#mainFrame");
	var thisheight = $(document).height() + 30;
	main.height(thisheight);
});
	/* $(window.parent.document).find("#mainFrame").load(function() {
		var pTar = $(window.parent.document).find("#mainFrame");
		if (pTar && !window.opera){ 
			pTar.style.display="block";
			if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){ 
				pTar.height = pTar.contentDocument.body.offsetHeight +20; 
				pTar.width = pTar.contentDocument.body.scrollWidth+20; 
			}else if (
				pTar.Document && pTar.Document.body.scrollHeight){ 
				//ie5+ syntax 
				pTar.height = pTar.Document.body.scrollHeight; 
				pTar.width = pTar.Document.body.scrollWidth; 
			} 
		} 
	}); */
</script>
</HEAD>
<body>
	<div class="contentBox">
		<div class="leftBox">
			<c:if test="${isShow!=0 && isShowInfoList!=0 }">
				<h2 style="margin-bottom: 5px">
					<span style="color: red;">该营养师很忙，还没参与话题哦。</span>
				</h2>
			</c:if>
			<c:if test="${isShow==0 }">
				<h2 style="margin-bottom: 5px">
					<span style="color: red;">${user.realName }</span> 的问答
				</h2>
			</c:if>
			<div class="tab-cont">
				<c:forEach items="${listQues }" var="info">
					<ul>
						<li class="tit"><a target="_blank" href="<c:url value='/answer/answer.do?questionId=${info.questionId }'/>" >
							<c:set var="testStr" value="${info.questioncontent}" />
							<c:choose>
								<c:when test="${fn:length(testStr) > 40}">
									<c:out value="${fn:substring(testStr, 0, 40)}" />  ...... 
									</c:when>
								<c:otherwise>
									<c:out value="${testStr}" />
								</c:otherwise>
							</c:choose>
							</a></li>
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
			</div>
			
			<c:if test="${isShowInfoList==0 }">
				<h2>
					<span>${user.realName } </span>文章
				</h2>
			</c:if>
			<div class="zixun_con">
				<ul>
					<c:forEach items="${articleInfo }" var="info">
						<li>
			               <h3><em></em><a href="<c:url value='/articleInfo/articleInfoView.do?id=${info.id }&userId=${user.id }'/>">${info.title }</a><span class="fr"><fmt:formatDate value="${info.createDate }" pattern="yyyy-MM-dd HH:mm:ss" /></span></h3>
			               <p class="info">${info.content }
			               </p>
			            </li>
		            </c:forEach>
				</ul>
			</div>
		</div>
		<div class="rightBox">
			<h2>
				<span>最近</span>来访<i>累计访问（${totalCount }）</i>
			</h2>
			<div class="user_lwp">
				<ul class="clearfix">
					<c:forEach items="${userCallers }" var="info">
						<li><a href="#"><img
								src="<c:url value='/${info.user.header } '/>"
								title="${info.user.realName }"></a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>