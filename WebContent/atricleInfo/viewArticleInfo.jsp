<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>安吉朗-文章详情</title>
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />

<link href="<c:url value='../manager/css/bootstrap.min.css' />" rel="stylesheet">
<link href="<c:url value='../manager/css/datepicker3.css' />" rel="stylesheet">
<link href="<c:url value='../manager/css/bootstrap-table.css' />" rel="stylesheet">
<link href="<c:url value='../manager/css/styles.css' />" rel="stylesheet">

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
	function delectArticle(id,userId){
		parent.delectArticleParent(id,userId);
	}
</script>
</head>
<body>
	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">		
		<div class="row">
			<div class="col-md-8" style="margin:0 auto;line-height:22px;font-size:24px;padding:20px 50px 0px 50px;" >
				<div class="panel panel-default">
					<div class="panel-heading"><span class="glyphicon glyphicon-envelope"></span><span style="">文章详情</span></div>
					<div class="panel-body" style="width:800px;">
						<form class="form-horizontal" action="<c:url value='/infor/save.do' />" method="post">
							<fieldset>
								<div class="form-group">
									<label class="col-md-3 control-label" for="name">文章标题</label>
									<div class="col-md-9" style="margin:5px 30px;">
										${articleInfo.title}
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label" for="name">文章发布人</label>
									<div class="col-md-9" style="margin:5px 30px;">
									${userInfo.userName}
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label" for="name">发布时间</label>
									<div class="col-md-9" style="margin:5px 30px;">
											<fmt:formatDate value="${articleInfo.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">文章内容</label>
									<div class="col-md-9" style="margin:5px 30px;">
										<textarea class="form-control" readonly="readonly" id="content"   placeholder="请输入详细内容" rows="20" name="content">${articleInfo.content}</textarea>
										<script type="text/javascript">CKEDITOR.replace('content');</script>
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-md-12 widget-right">
										<button type="button" onclick="javascript:history.back()" class="btn btn-default btn-md pull-right" style="margin:10px;">返回</button>
										<input type="hidden" id="picture" name="picture">
									</div>
								</div>
							</fieldset>
							
							<input type="hidden" id="typeId" name="id" value="${id }">
						</form>
					</div>
				</div>
				</div>
				</div>
	</div>	<!--/.main-->
	
	<script src="<c:url value='/manager/js/jquery-1.11.1.min.js' />"></script>
	<script src="<c:url value='/manager/js/bootstrap.min.js' />"></script>
	<script src="<c:url value='/manager/js/chart.min.js' />"></script>
	<script src="<c:url value='/manager/js/chart-data.js' />"></script>
	<script src="<c:url value='/manager/js/easypiechart.js' />"></script>
	<script src="<c:url value='/manager/js/easypiechart-data.js' />"></script>
	<script src="<c:url value='/manager/js/bootstrap-datepicker.js' />"></script>
	<script src="<c:url value='/manager/js/bootstrap-table.js' />"></script>
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