<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>安吉朗-后台管理系统</title>

<link href="<c:url value='/managers/css/bootstrap.min.css' />" rel="stylesheet">
<link href="<c:url value='/managers/css/styles.css' />" rel="stylesheet">
<script src="<c:url value='/managers/js/jquery-1.11.1.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/managers/js/ajaxfileupload.js' />"></script>
	<script type="text/javascript">
	function ajaxFileUpload() {
	    $.ajaxFileUpload({
	        url: '<c:url value="/upload/image.do?path=indexspeccol" />', 
	        type: 'post',
	        secureuri: false, //一般设置为false
	        fileElementId: 'file', // 上传文件的id、name属性名
	        dataType: 'text', //返回值类型，一般设置为json、application/json
	        success: function(data, status){  
	            if(data!=null && data!="" && data!="undefined") {
	            	data = jQuery.parseJSON(jQuery(data).text());
		            if(data!=null && data.code=='0') {
		            	//$("#showPic").html("<img src='"+data.url+"'>");;
		            	$("#showPic").html("<img style=\"width: 500px;height: 304px;\" src=\"<c:url value='/"+data.path+"' />\">");
		            	$("#pic").val(data.path);
		            }
	            }
	        },
	        error: function(data, status, e){
	        	 alert(data);
	            alert(e);
	        }
	    });
	}
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
					<div class="panel-heading"><span class="glyphicon glyphicon-envelope"></span>安吉郎专栏</div>
					<div class="panel-body">
						<form class="form-horizontal" action="<c:url value='/speccol/save.do' />" method="post">
							<fieldset>
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">标题</label>
									<div class="col-md-9">
										<input id="title" name="title" type="text" value="" placeholder="标题" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">内容</label>
									<div class="col-md-9">
									<textarea rows="4" cols="30" id="content" name="content" placeholder="内容" class="form-control"></textarea>
										<!-- <input id="content" name="content" type="text" value="" placeholder="内容" class="form-control"> -->
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">上传图片</label>
									<div class="col-md-9">
										<input type="file" id="file" name="file" onchange="ajaxFileUpload()">
										<!-- <img alt="" src="" id="showPic" name="showPic" /> -->
										<!-- <input type="image" id="showPic" name="showPic" src="" /> -->
										<span id="showPic" ></span>
									</div>
								</div>
								<input type="hidden" name="pic" id="pic" value="" />`
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">首页显示顺序</label>
									<div class="col-md-9">
										<input id="sort" name="sort" type="text" placeholder="默认为0,则不在首页显示" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">url</label>
									<div class="col-md-9">
										<input id="url" name="url" type="text" value="" placeholder="访问地址" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-12 widget-right">
										<button type="submit" class="btn btn-default btn-md pull-right" style="margin:10px;">提交</button>
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