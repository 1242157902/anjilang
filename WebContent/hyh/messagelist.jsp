<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>小组消息首页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen">
    <script type="text/javascript" src="hyh/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<c:url value='/js/newcommon.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/my.js' />"></script>
    <link  rel="stylesheet" type="text/css" href="<c:url value='hyh/css/messagelist.css' />" >
	

  </head>
  
  <body>
   <div id="head_1">
  <%@ include file="/common/newhead.jsp"%>
  </div>
  
  
  <div class="relea">
     <div class="relea-t" >
        <p style="font-size:18px;"><strong>小组消息</strong></p>
     </div>
     
     <div class="uestions">
        <table width="855"  border-bottom="1px #ccc solid" >
        <c:forEach  var="messages"  items="${userGroupMessages }">
           <tr  >
             <td>
               <ul  >
                 <li  id="newhead">小组消息</li>
                 <li style="font-size:12px;">${messages.content }</li>
                 
               </ul>
             </td>
           </tr>
           </c:forEach>
        </table>
     </div>
  </div>
  
  
  
   <div id="foot_1"  style="clear:both;">
  <%@ include file="/common/newfooter.jsp"%>
  </div>
  </body>
</html>
