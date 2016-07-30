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
    
    <title>创建患友会小组</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen">
    <script type="text/javascript" src="hyh/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<c:url value='/js/newcommon.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/my.js' />"></script>
    <link rel="stylesheet" type="text/css" href="hyh/css/apply.css" />
    <link rel="stylesheet" type="text/css" href="hyh/css/share.css" />
    <script type="text/javascript"  src="plus-in/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
      
      function xiugai(){
      
        var title=document.getElementById("groupname").value;
         if(title==""  || CKEDITOR.instances.description.getData()==""){
            alert("标题和标题不能为空！");
		      return false;
		   }else{
		   return true;
		   }
        
      }
         
        
           
    </script>
  </head>
  
  <body>
  <div>
  <%@ include file="/common/newhead.jsp"%>
</div>
   <!--小组申请-->
   <div class="apply">
        <div class="list">
            <form id="form1" name="form1" method="post" action="">
            </form>
            <ul>
            <i></i>
            <li><a href="#">首页 ＞</a></li>
            <li><a href="#">群组 ＞</a></li>
            <li><a href="#">创建群组</a></li>
            </ul>
         </div>
         <h2>创建一个小组</h2>
     <form class="form-horizontal" action="<c:url value='/patientGroup/AddPatientGroup.do' />" method="post">  
         <div class="apply-in">
             <div class="apply-in_left">
                 <div class="name">
                 <label>小组名称：</label><input id="groupname" name="groupname" type="text"/>
                 </div>
                 <div class="fication">
                 </div>
       
                <div class="jane">
                <label >小组简介：</label>
          
                   <div class="janes">
                        <textarea  id="description" rows="20" name="description"></textarea>
					    <script type="text/javascript">CKEDITOR.replace('description',{height:250});</script>
                   </div>
              </div>
           </div>
        <div class="apply-in_right"></div>
     </div>
     <input type="submit" value="提　交" class="btn"  onclick="return  xiugai(this)"/>
   </form>
 </div>
<div id="foot_1"  style="clear:both;">
  <%@ include file="/common/newfooter.jsp"%>
  </div>
</body>
</html>
