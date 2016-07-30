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
						<form class="form-horizontal" action="<c:url value='/user/audit.do' />" method="post">
							<fieldset>
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">真实姓名</label>
									<div class="col-md-9">
										${user.realName }
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">注册城市</label>
									<div class="col-md-9">
										${regAddr }
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">生日</label>
									<div class="col-md-9">
										${birth }
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">工作医院</label>
									<div class="col-md-9">
										${user.hospital }
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">职称</label>
									<div class="col-md-9">
										${user.title }
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">擅长项目</label>
									<div class="col-md-9">
										${pStr }
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">电话</label>
									<div class="col-md-9">
										${user.phone }
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">账号</label>
									<div class="col-md-9">
										${user.userName }
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">头像</label>
									<div class="col-md-9">
										<span id ="showPic"><img style="width: 500px;height: 304px;" src="<c:url value="/${user.header }"/>"/></span>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">注册时间</label>
									<div class="col-md-9">
										${regDateTime }
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">从业证件号</label>
									<div class="col-md-9">
										${user.certificateNo }
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">性别</label>
									<div class="col-md-9">
										<c:choose>
										<c:when test="${user.sex=='1'}">
										男
										</c:when>
										<c:otherwise>
										女
										</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">用户类型</label>
									<div class="col-md-9">
										<c:choose>
										<c:when test="${user.type=='1'}">
										医生
										</c:when>
										<c:otherwise>
										用户
										</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">审核状态</label>
									<div class="col-md-9">
										<c:choose>
										<c:when test="${user.audit=='1'}">
										未审核
										</c:when>
										<c:otherwise>
										审核通过
										</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">医生分类</label>
									<div class="col-md-9">
										<select name="doctorType">
											<c:forEach var="doc" items="${doctorTypeList}">
												<c:choose>
												<c:when test="${doc.id==user.doctorType}">
												<option value="${doc.id }" selected="selected">${doc.name }</option>
												</c:when>
												<c:otherwise>
												<option value="${doc.id }">${doc.name }</option>
												</c:otherwise>
												</c:choose>						 
											</c:forEach>
										</select>
									</div>
								</div>
								
								<input type="hidden" id="audit" name="audit" value="2" />
								<input type="hidden" id="id" name="id" value="${user.id }" />						
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