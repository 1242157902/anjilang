<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
﻿﻿<%@page import="com.anjilang.dao.base.impl.PaginationSupport"%>
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
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />

<META name="description" content="">
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

</HEAD>
<body>
	<div class="contentBox" style="padding: 30px 0px 0px 100px;">
			<c:if test="${message!=null }">
				<span style="color: red;font-size:38px;margin-left: 0px 0px 30px 100px;">${ message}</span>
			</c:if>
			<div style="height: 50px;"></div>
			<h3> 点击返回列表   --><a style="margin-top: 50px;" href="<c:url value='/articleInfo/list.do?userId=${userId }'/>">返回文章列表</a></h3>
	</div>
</body>
</html>