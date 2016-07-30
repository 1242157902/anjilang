<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>安吉朗-后台管理系统 小组审核</title>
<link href="<c:url value='/managers/css/bootstrap.min.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/datepicker3.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/bootstrap-table.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/styles.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/bootstrap.min.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/styles.css' />" rel="stylesheet">
<script src="<c:url value='/managers/js/jquery-1.11.1.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/managers/js/ajaxfileupload.js' />"></script>

<script type="text/javascript">
</script>

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
					<div class="panel-heading"><span class="glyphicon glyphicon-envelope"></span>审核医生</div>
					<div class="panel-body">
						<form class="form-horizontal" action="<c:url value='/patientGroup/audit.do' />" method="post">
							<fieldset>
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">小组名称</label>
									<div class="col-md-9">
										${patientGroup.groupname }
									</div>
								</div>
						
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">小组描述</label>
									<div class="col-md-9">
										${patientGroup.description }
									</div>
								</div>
							
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">审核状态</label>
									<div class="col-md-9">
										<c:choose>
										<c:when test="${patientGroup.audit=='1'}">
										未审核
										</c:when>
										<c:otherwise>
										审核通过
										</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								
								
								<input type="hidden" id="audit" name="audit" value="2" />
								<input type="hidden" id="id" name="id" value="${patientGroup.id }" />						
								<div class="form-group">
									<div class="col-md-12 widget-right">
										<button type="submit" class="btn btn-default btn-md pull-right" style="margin:10px;">审核通过</button>
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