<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>提示页</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='hyh/css/prompt.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen">
    <script type="text/javascript" src="hyh/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<c:url value='/js/newcommon.js' />"></script>
     <script type="text/javascript" src="<c:url value='/js/my.js' />"></script>
	  
	  
  </head>
  
  <body>
  <div>
  <%@ include file="/common/newhead.jsp"%>
</div>	
  
  
    <!--小组申请-->
<div class="apply">
    <div class="apply-in">
      <dl>
         <dt></dt>
         <dd>小组已进入审核状态～</dd>
         <dd>正常内容将会在24小时内显示出来，请耐心等待！</dd>
      </dl>
      <span class="return"><a href="javascript:history.go(-1);">返回上一页</a></span>
      <span class="indexs"><a href="index.jsp">返回首页</a></span>
    </div>
</div>


<div id="foot_1"  style="clear:both;">
  <%@ include file="/common/newfooter.jsp"%>
  </div>
</body>
</html>
