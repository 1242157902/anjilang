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
    
    <title>患友会小组列表</title>
    <link href="<c:url value='/managers/css/bootstrap.min.css' />" rel="stylesheet">
    <link href="<c:url value='/managers/css/datepicker3.css' />" rel="stylesheet">
    <link href="<c:url value='/managers/css/bootstrap-table.css' />" rel="stylesheet">
    <link href="<c:url value='/managers/css/styles.css' />" rel="stylesheet">
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
					<div class="panel-heading">患友会小组列表
						<a href="<c:url value='/managers/audit/grouplist.jsp?flg=1' />" class="btn btn-primary" style="position: relative;float: right;margin:10px;">查询未审核小组</a>
						<a href="<c:url value='/managers/audit/grouplist.jsp?flg=2' />" class="btn btn-primary" style="position: relative;float: right;margin:10px;">查询已审核小组</a>
						<a href="<c:url value='/managers/audit/grouplist.jsp' />" class="btn btn-primary" style="position: relative;float: right;margin:10px;">查询所有小组</a>
						<a href="<c:url value='/managers/audit/grouplist.jsp' />" onclick="deleteObj();" class="btn btn-primary" style="position: relative;float: right;margin:10px;">删除</a>
						<a href="<c:url value='/patientGroup/toAdd.do'/>"  class="btn btn-primary" style="position: relative;float: right;margin:10px;">创建小组</a>
					</div>
					
					<form action="<c:url value='/patientGroup/delect.do' />" id="body" name="body" method="post">
					<div class="panel-body">
					    <input type="hidden" name="type" value="1" />
						<table data-toggle="table" data-url="<c:url value='/patientGroup/group.do?audit=${param.flg}' />"  
						data-show-refresh="true" data-show-toggle="true" 
						data-show-columns="true" data-search="true" 
						data-select-item-name="id" data-pagination="true" 
						data-sort-name="name" data-sort-order="desc"  data-id-field="id">
						    <thead>
						    <tr>
						        <th data-field="ids" data-checkbox="true" ></th>
							    <th data-field="id" data-visible="false"></th>
						        <th data-field="groupname" data-sortable="true">小组名称</th>
						        <th data-field="description" data-sortable="true">小组描述</th>
						        <th data-field="audit" data-sortable="true">审核状态</th>
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
            '</a>'
        ].join('');
    }

    window.operateEvents = {
        'click .edit': function (e, value, row, index) {
            var id=row["id"];

            window.location.href="<c:url value='/patientGroup/toaudit.do?id="+id+"' />";
        }
    };
</script>
	
  </body>
</html>
