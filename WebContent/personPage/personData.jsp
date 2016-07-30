<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	/* $("#mainFrame").load(function(){
		var mainheight = $(this).contents().find("body").height()+30; 
		$(this).height(mainheight); 
	}); */
	/* $(function(){
		var hmain = parent.document.getElementById("mainFrame");
		hmain.style.height = 1150+ 'px';
	}); */
	$(window.parent.document).find("#mainFrame").load(function() {
		var main = $(window.parent.document).find("#mainFrame");
		var thisheight = $(document).height() + 30;
		main.height(thisheight);
	});
</script>
</HEAD>
<body style="height: 800px;">
	<div class="contentBox">
		<div style="background: #cecfce; padding: 5px; margin-top: 50px;">
			<div class="person_detl">
				<em></em> <em class="top"></em>
				<h1 class="title">详细资料</h1>
				<ul>
					<li class="clearfix"><label>姓名</label>
					<p>${user.realName }</p></li>
					<li class="clearfix"><label>性别</label>
					<p><c:if test="${user.sex=='1'}">男</c:if><c:if test="${user.sex=='2'}">女</c:if></p></li>
					<li class="clearfix"><label>职业营养师编号</label>
					<p>${user.certificateNo }</p></li>
					<li class="clearfix"><label>个人签名</label>
					<p>${user.signature }</p></li>
				</ul>
				<h3>擅长项目</h3>
				<div class="tagBox">
					<c:forEach items="${projects }" var="info">
		            	<span>${info.diseaseName }</span>
		            </c:forEach>
				</div>
				<h3>教育背景</h3>
				<ul>
					<li class="clearfix"><label>学历</label>
					<p>${user.education }</p></li>
					<li class="clearfix"><label>学校</label>
						<p>${user.eduExperience }<br/></p>
					</li>
				</ul>
				<h3>工作信息</h3>
				<ul>
					<li class="clearfix"><label>职称</label>
					<p>${user.title }</p></li>
					<li class="clearfix"><label>单位</label>
					<p>${user.hospital }</p></li>
				</ul>
				<h3>个人简介</h3>
				<ul>
					<li class="txt">${user.resume }</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>