<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>小组列表测试用的</title>
    
	<link rel="stylesheet" type="text/css" href="hyh/css/index.css" />
    <link rel="stylesheet" type="text/css" href="hyh/css/share.css" />
    <script type="text/javascript" src="hyh/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="hyh/js/my.js"></script>
	<link href="<c:url value='/managers/css/bootstrap-table.css' />" rel="stylesheet">

  </head>
  
  <body>
   
   <div class="uestions">
       <table width="800"  border-bottom="1"  >
	   
	   <thead>
		  <tr>
		    <th width="200" align="left"  data-field="id" data-sortable="true">小组编号</th>
		    <th width="400" data-field="groupname" data-sortable="true">小组名称</th>
		  </tr>
	   </thead>
	   <c:forEach items="${groups }" var="groups">
	   <thead>
		  <tr>
		    <th width="200" align="left"  data-field="id" data-sortable="true"><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${groups.id }'/>">${groups.id }</th>
		    <th width="400" data-field="groupname" data-sortable="true">${groups.groupname }</th>
		  </tr>
	   </thead>
	   </c:forEach>
     </table>
    </div>
        
  </body>
</html>
