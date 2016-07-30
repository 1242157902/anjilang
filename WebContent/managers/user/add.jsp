<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>安吉朗-后台管理系统</title>

<link href="<c:url value='/managers/css/bootstrap.min.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/datepicker3.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/bootstrap-table.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/styles.css' />" rel="stylesheet">

<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->
<script src="<c:url value='/plus-in/ckeditor/ckeditor.js '/>"></script>

</head>
<body>
	<!-- start head -->
	<%@ include file="../common/head.jsp" %>
	<!-- end head -->
	
	<!-- start head -->
	<%@ include file="../common/left.jsp" %>
	<!-- end head -->
	
	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">		
		<div class="row">
			<div class="col-md-8" style="width:100%">
				<div class="panel panel-default">
					<div class="panel-heading"><span class="glyphicon glyphicon-envelope"></span>添加用户</div>
					<div class="panel-body">
						<form class="form-horizontal" action="<c:url value='/user/userregist.do' />" method="post">
							<fieldset>
								<div class="form-group">
									<label class="col-md-3 control-label" for="name">邮箱</label>
									<div class="col-md-9">
									<input id="userName" name="userName" type="text" placeholder="请输入邮箱" class="form-control">
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="name">昵称</label>
									<div class="col-md-9">
									<input id="realName" name="realName" type="text" placeholder="请输入昵称" class="form-control">
									</div>
								</div>
							
								<div class="form-group">
									<label class="col-md-3 control-label" for="name">密码</label>
									<div class="col-md-9">
									<input id="password" name="password" type="password" placeholder="请输入密码" class="form-control">
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">确认密码</label>
									<div class="col-md-9">
										<input id="password2" name="password2" type="password" placeholder="请输入密码" class="form-control">
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-md-12 widget-right">
										<button type="submit" class="btn btn-default btn-md pull-right" style="margin:10px;">确认</button>
										<button type="button" onclick="javascript:history.back()" class="btn btn-default btn-md pull-right" style="margin:10px;">返回</button>
									</div>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				</div>
				</div>
	</div>	<!--/.main-->
	
	
	<script src="<c:url value='/managers/js/jquery-1.11.1.min.js' />"></script>
	<script src="<c:url value='/managers/js/bootstrap.min.js' />"></script>
	<script src="<c:url value='/managers/js/chart.min.js' />"></script>
	<script src="<c:url value='/managers/js/chart-data.js' />"></script>
	<script src="<c:url value='/managers/js/easypiechart.js' />"></script>
	<script src="<c:url value='/managers/js/easypiechart-data.js' />"></script>
	<script src="<c:url value='/managers/js/bootstrap-datepicker.js' />"></script>
	<script src="<c:url value='/managers/js/bootstrap-table.js' />"></script>
	<script>
		!function ($) {
			$(document).on("click","ul.nav li.parent > a > span.icon", function(){		  
				$(this).find('em:first').toggleClass("glyphicon-minus");	  
			}); 
			$(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function () {
		  if ($(window).width() > 768) $('#sidebar-collapse').collapse('show')
		})
		$(window).on('resize', function () {
		  if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide')
		})
	</script>	
	
</body>
</html>