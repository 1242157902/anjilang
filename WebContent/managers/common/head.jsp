<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.anjilang.entity.User" %>

<%
	User user=(User)request.getSession().getAttribute("user");
	if(user==null || !user.getType().equals("3")){
		%>
			<script type="text/javascript">
				window.location.href="<c:url value='/index/index.do' />";
			</script>
		<%
	}
%>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#sidebar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#"><span>安吉</span>朗</a>
				<ul class="user-menu">
					<li class="dropdown pull-right">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span>欢迎您：<%=user.getRealName() %> 操作 <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="<c:url value='/index/index.do' />" target="_blank"><span class="glyphicon glyphicon-user"></span> 前往前台</a></li>
							<li><a href="<c:url value='/login/logout.do' />"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div><!-- /.container-fluid -->
	</nav>