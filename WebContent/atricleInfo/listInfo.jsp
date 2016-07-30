﻿<%@page import="com.anjilang.dao.base.impl.PaginationSupport"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>安吉朗-文章列表</TITLE>
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
	$(window.parent.document).find("#mainFrame").load(function() {
		var main = $(window.parent.document).find("#mainFrame");
		var thisheight = $(document).height() + 30;
		main.height(thisheight);
	});
	function delectArticle(id,userId){
		parent.delectArticleParent(id,userId);
	}
</script>
</HEAD>
<body>
	<div class="contentBox" id="contentBox">
		<div class="leftBox">
			<c:if test="${message!=null }">
				<span style="color: red;margin-left: 100px">${ message}</span>
			</c:if>
			
			<h2>
				<c:if test="${authorityShow=='0' }">
					<a class="fr fb" href="<c:url value='/articleInfo/articleInfoAdd.do?userId=${userIds }'/>"> 发表文章</a>
				</c:if><span>${user.realName } </span>文章<i>发表了(<span>${totalArticleCount }</span>)篇相关文章
				</i>
			</h2>
			<div class="zixun_con">
				<ul>
					<c:forEach items="${infoList }" var="info">
						<li style="height:100px;overflow:hidden">
							<h3>
								<em></em><a href="<c:url value='/articleInfo/articleInfoView.do?id=${info.id }&userId=${userIds }'/>">${info.title }</a> <span class="fr"><fmt:formatDate
										value="${info.createDate }" pattern="yyyy-MM-dd HH:mm:ss" />
										<c:if test="${authorityShow=='0' }">
											<span style="padding-left: 10px;font-size: 14px;"><a href="#" onclick="delectArticle('${info.id }','${user.id }');">删除</a>
											</span>
											<span style="padding-left: 10px;font-size: 14px;"><a href="<c:url value='/articleInfo/articleInfoToUpdate.do?id=${info.id }&userId=${user.id }'/>">修改</a>
											</span>
										</c:if>
										</span>
							</h3>
							<p class="info" >${info.content }
							</p>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="pageNav">
				<c:if test="${pageNo>1}">
		    		<a href="<c:url value='/articleInfo/list.do?userId=${user.id }&pageNo=${pageNo-1 }' />" class="next">上一页</a>
		    		<c:if test="${pageCount>3 }">
		    			<strong>...</strong>
		    		</c:if>
		    		<a href="<c:url value='/articleInfo/list.do?userId=${user.id }&pageNo=${pageNo-1 }' />">${pageNo-1 }</a>
		    	</c:if>
		       <a href="<c:url value='/articleInfo/list.do?userId=${user.id }&pageNo=${pageNo }' />" class="on">${pageNo }</a>
           		<c:if test="${pageNo<pageCount }">
           			<a href="<c:url value='/articleInfo/list.do?userId=${user.id }&pageNo=${pageNo+1 }' />">${pageNo+1 }</a>
           			<c:if test="${pageNo+1<pageCount }">
           				<strong>...</strong>
           			</c:if>
           			<a href="<c:url value='/articleInfo/list.do?userId=${user.id }&pageNo=${pageNo+1 }' />" class="next">下一页</a>
           		</c:if>
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