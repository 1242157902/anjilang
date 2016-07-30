<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>安吉朗-后台管理系统</title>

<link href="<c:url value='/managers/css/bootstrap.min.css' />"
	rel="stylesheet">
<link href="<c:url value='/managers/css/styles.css' />" rel="stylesheet">
<script src="<c:url value='/managers/js/jquery-1.11.1.min.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/managers/js/ajaxfileupload.js' />"></script>
<script type="text/javascript">
	function ajaxFileUpload() {
		$
				.ajaxFileUpload({
					url : '<c:url value="/upload/image.do?path=indexshop" />',
					type : 'post',
					secureuri : false, //一般设置为false
					fileElementId : 'file', // 上传文件的id、name属性名
					dataType : 'text', //返回值类型，一般设置为json、application/json
					success : function(data, status) {
						if (data != null && data != "" && data != "undefined") {
							data = jQuery.parseJSON(jQuery(data).text());
							if (data != null && data.code == '0') {
								//$("#showPic").html("<img src='"+data.url+"'>");;
								$("#showPic")
										.html(
												"<img style=\"width: 500px;height: 304px;\" src=\"<c:url value='/"+data.path+"' />\">");
								$("#picUrl").val(data.path);
							}
						}
					},
					error : function(data, status, e) {
						alert(data);
						alert(e);
					}
				});
	}
	
	function getProject() {
		$.ajax({
			type : 'POST',
			url : '<c:url value="/disease/queryAjax.do" />',
			cache:false,    
		    dataType:'json',    
		    success:function(data) {
		    	var arr = eval(data);
		    	 //删除原有Select  
	            $("select[name=diseaseId]").remove();
	            var d = $("<select>");  
                $(d).attr("name", "diseaseId");
                $(d).css({"display" : "block", "width" : "120px", "margin-top" : "3px"});
                $(d)[0].options.add(new Option("- 请选择 -", ""));
		    	for(var i=0; i<arr.length; i++) {
		    		var id   = arr[i].id;  
                    var name = arr[i].diseaseName;
                   // alert(id + name);
                    //创建options  
                   $(d)[0].options.add(new Option(name, id)); 
		    	}
		    	$("#dis").html(d); 
		    	   
		     },    
		     error : function() {    
		          alert("异常！");    
		     }
		});
	}
</script>

</head>
<body>
	<!-- start head -->
	<%@ include file="../common/head.jsp"%>
	<!-- end head -->

	<!-- start head -->
	<%@ include file="../common/left.jsp"%>
	<!-- end head -->

	<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
		<div class="row">
			<div class="col-md-8" style="width: 100%">
				<div class="panel panel-default">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-envelope"></span>首页table页
					</div>
					<div class="panel-body">
						<form class="form-horizontal"
							action="<c:url value='/index/savepic.do' />" method="post" onload="getProject()">
							<fieldset>
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">上传图片</label>
									<div class="col-md-9">
										<input type="file" id="file" name="file"
											onchange="ajaxFileUpload()">
										<!-- <img alt="" src="" id="showPic" name="showPic" /> -->
										<!-- <input type="image" id="showPic" name="showPic" src="" /> -->
										<span id="showPic"></span>
									</div>
								</div>
								<input type="hidden" name="picUrl" id="picUrl" value="" />`
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">首页显示顺序</label>
									<div class="col-md-9">
										<input id="sortNum" name="sortNum" type="text"
											placeholder="默认为0,则不在首页显示" class="form-control">
									</div>
								</div>
								
								
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">原价</label>
									<div class="col-md-9">
										<input id=pastprice name="pastprice" type="text"
											 class="form-control">
									</div>
								</div>
								
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">现价</label>
									<div class="col-md-9">
										<input id=nowprice name="nowprice" type="text"
											 class="form-control">
									</div>
								</div>
								
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">产品分类</label>
									<div class="col-md-9">
										<input id=typename name="typename" type="text"
											 class="form-control">
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">产品名称</label>
									<div class="col-md-9">
										<input id=productname name="productname" type="text"
											 class="form-control">
									</div>
								</div>
								
								
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">产品剩余</label>
									<div class="col-md-9">
										<input id=overplus name="overplus" type="text"
											 class="form-control">
									</div>
								</div>
								
								
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">商城访问地址</label>
									<div class="col-md-9">
										<input id=accessUrl name="accessUrl" type="text"
											placeholder="例如:http://www.baidu.com" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-3 control-label" for="message">疾病</label>
									<div class="col-md-9" id="dis">
										<select name="diseaseId">
											<option>- 请选择 -</option>
										</select>
										<script type="text/javascript">
											window.onload = function(){
												getProject();
											};
										</script>
									</div>
								</div>
								<input id="type" name="type" type="hidden" value="2">
								<div class="form-group">
									<div class="col-md-12 widget-right">
										<button type="submit"
											class="btn btn-default btn-md pull-right"
											style="margin: 10px;">提交</button>
										<button type="button" onclick="javascript:history.back()"
											class="btn btn-default btn-md pull-right"
											style="margin: 10px;">返回</button>
									</div>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/.main-->



	<script>
		!function($) {
			$(document)
					.on(
							"click",
							"ul.nav li.parent > a > span.icon",
							function() {
								$(this).find('em:first').toggleClass(
										"glyphicon-minus");
							});
			$(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function() {
			if ($(window).width() > 768)
				$('#sidebar-collapse').collapse('show')
		})
		$(window).on('resize', function() {
			if ($(window).width() <= 767)
				$('#sidebar-collapse').collapse('hide')
		})
	</script>

</body>
</html>