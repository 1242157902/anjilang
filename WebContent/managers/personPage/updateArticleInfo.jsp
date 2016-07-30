<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>安吉朗-后台管理系统</title>

<link href="<c:url value='/managers/css/bootstrap.min.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/datepicker3.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/bootstrap-table.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/styles.css' />" rel="stylesheet">
<SCRIPT type="text/javascript"
	src="<c:url value='/js/jquery-1.7.2.min.js '/>"></SCRIPT>
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->
<script src="<c:url value='/plus-in/ckeditor/ckeditor.js '/>"></script>
<script type="text/javascript">
$(window.parent.document).find("#mainFrame").load(function() {
	var main = $(window.parent.document).find("#mainFrame");
	var thisheight = $(document).height() + 30;
	main.height(thisheight);
});
</script>
</head>
<body>
	<div class="contentBox">
		<div class="row">
			<div class="col-md-8" style="width:800px;margin:0 auto;line-height:22px;font-size:24px;padding:20px 50px 0px 50px;" >
				<div class="panel panel-default">
					<div class="panel-heading"><span class="glyphicon glyphicon-envelope"></span>修改文章</div>
					<div class="panel-body">
						<form class="form-horizontal" action="<c:url value='/articleInfo/articleInfoModify.do' />" method="post">
							<fieldset>
								<div class="form-group">
									<label class="col-md-3 control-label" for="name">文章标题</label>
									<div class="col-md-9">
									<input id="title" name="title" type="text" value="${articleInfo.title }" class="form-control">
									<input id="id" name="id" type="hidden" value="${articleInfo.id }" class="form-control">
									<input id="userId" name="userId" type="hidden" value="${userId }">
									
									</div>
								</div>
							
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">文章内容</label>
									<div class="col-md-9">
										<textarea class="form-control" id="content" rows="20" name="content">${articleInfo.content }</textarea>
										<script type="text/javascript">CKEDITOR.replace('content');</script>
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-md-12 widget-right">
										<button type="submit" class="btn btn-default btn-md pull-right" style="margin:10px;">提交</button>
										<button type="button" onclick="javascript:history.back()" class="btn btn-default btn-md pull-right" style="margin:10px;">返回</button>
										<input type="hidden" id="picture" name="picture">
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