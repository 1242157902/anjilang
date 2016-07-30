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

<script type="text/javascript">
	function deleteObj(){
		if(confirm("删除是不可恢复的，您确认要删除吗？")) {
			$("#body").submit();
		}
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
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">医生列表
						<a href="<c:url value='/managers/audit/doctorlist.jsp?flg=1' />" class="btn btn-primary" style="position: relative;float: right;margin:10px;">查询未审核医生</a>
						<a href="<c:url value='/managers/audit/doctorlist.jsp?flg=2' />" class="btn btn-primary" style="position: relative;float: right;margin:10px;">查询已审核医生</a>
						<a href="<c:url value='/managers/audit/doctorlist.jsp' />" class="btn btn-primary" style="position: relative;float: right;margin:10px;">查询所有医生</a>
						<a href="#" onclick="deleteObj();" class="btn btn-primary" style="position: relative;float: right;margin:10px;">删除</a>
					</div>
					
					<form action="<c:url value='/user/delete.do' />" id="body" name="body" method="post">
					<div class="panel-body">
					    <input type="hidden" name="type" value="1" />
						<table data-toggle="table" data-url="<c:url value='/user/doctor.do?audit=${param.flg}' />"  
						data-show-refresh="true" data-show-toggle="true" 
						data-show-columns="true" data-search="true" 
						data-select-item-name="id" data-pagination="true" 
						data-sort-name="name" data-sort-order="desc"  data-id-field="id">
						    <thead>
						    <tr>
						        <th data-field="ids" data-checkbox="true" ></th>
							    <th data-field="id" data-visible="false"></th>
						        <th data-field="realName" data-sortable="true">真实姓名</th>
						        <th data-field="province" data-sortable="true">城市信息</th>
						        <th data-field="city" data-sortable="true">城市信息</th>
						        <!-- <th data-field="birthday" data-sortable="true">生日</th> -->
						        <th data-field="hospital" data-sortable="true">工作医院</th>
						        <th data-field="title" data-sortable="true">职称</th>
						        <th data-field="project" data-sortable="true">擅长项目</th>
						        <th data-field="phone" data-sortable="true">电话号码</th>
						        <th data-field="userName" data-sortable="true">用户名</th>
						        <th data-field="header" data-formatter="picUrlmatter" data-sortable="true">头像地址</th>
						        <th data-field="sex" data-sortable="true">性别</th>
						        <th data-field="audit" data-sortable="true">审核状态</th>
						        <th data-field="certificateNo" data-sortable="true">职业号</th>
						         <th data-field="doctorType" data-sortable="true">医生分类</th>
						        <th data-field="operate" data-formatter="operateFormatter" data-events="operateEvents">操作</th>
						    </tr>
						    </thead>
						</table>
					</div>
					</form>
				</div>
			</div>
		</div><!--/.row-->	
	</div>
	
	
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
	
	<script>
	function picUrlmatter(value, row, index) {
		  var header=row["header"];
		return [
	            '<img src="<c:url value="/'+header+'" />" height="60px;"  width="60px;" />'
	        ].join('');
	}
	
    function operateFormatter(value, row, index) {
        return [
            '<a class="edit ml10" href="javascript:void(0)" title="审核">',
                '<i class="glyphicon glyphicon-edit" style="margin:10px;"></i>',
            '</a>'/* ,
            '<a class="like" href="javascript:void(0)" title="查询所有">',
            	'<i class="glyphicon glyphicon-heart" style="margin:10px;">查询医生</i>',
        	'</a>' */
        ].join('');
    }

    window.operateEvents = {
        'click .edit': function (e, value, row, index) {
            var id=row["id"];
            //window.location.href="<c:url value='/user/audit.do?id="+id+"&audit="+2+"'  />";
            window.location.href="<c:url value='/user/toaudit.do?id="+id+"' />";
        }/* ,
        'click .like': function (e, value, row, index) {
            var id=row["id"];
            window.location.href="<c:url value='/managers/audit/doctorlist.jsp' />";
        } */
    };
</script>
	
</body>
</html>