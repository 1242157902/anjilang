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
    
    <title>发布页</title>
	<link rel="stylesheet" type="text/css" href="hyh/css/release.css" />
    <script type="text/javascript" src="hyh/js/jquery-1.11.1.min.js"></script>
	<script src="<c:url value='/plus-in/ckeditor/ckeditor.js '/>"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen">
    <script type="text/javascript" src="<c:url value='/js/newcommon.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/my.js' />"></script>
    
    <script type="text/javascript">
                    
     function Panduan(param)
     {  
     
     var title=document.getElementById("title").value;
     
     
     if(CKEDITOR.instances.content.getData()==""  || title==""){
            alert("标题内容不能为空！");
		      return false;
         }else{
         if(param==null){
          alert("请先加入小组！")
          return false;
            
          }else{
          return true;
         }
         }
          
     }
           
     
       
                  
    </script>
    


	
  </head>
  
  <body>
  <c:set var= "puid"   value="${patientGroup.userid }"  />
  <c:set var= "uid"   value="${user.id }"  />
  
  <c:forEach  var="users" items="${users }">
    <c:set var= "uids"   value="${users.id }"  /> 
      <c:if test="${uid==uids }">
        <c:set var= "a"   value="${1 }"  />
      </c:if>
  </c:forEach>
 
 
  <c:if test="${uid==puid }">
   <c:set var= "a"   value="${1 }"  />
  </c:if>
 
  
  
   <div>
      <%@ include file="/common/newhead.jsp"%>
   </div>	
  
   <div class="apply">
       <div class="list">
           <ul>
              <i></i>
              <li><a href="#">首页＞ </a></li>
              <li><a href="#">群组 ＞ </a></li>
              <li><a href="#">创建群组</a></li>
           </ul>
       </div>
       <h2>发布新话题/文章</h2>
        <form  class="form-horizontal"  action="<c:url value='/GroupTopic/publish.do?groupid=${patientGroup.id }' />"  method="post"> 
           <div class="apply-in">
          
               <div class="apply-in_left">
                  
                   <div class="fication" >
                       <div class="choose-form">
                           <div class="choose" name="choose">
                               <select  class="hd" name="tabid">
                                   <c:forEach var="tab"  items="${tabs }">
                                        <option value="${tab.id }">
                                             ${tab.tabname }
                                        </option>
                                   </c:forEach>
                               </select>
                           </div>
                       </div>
                       <input id="title"  name="title"   type="text"  />
            
    
                   </div>
                   <div class="jane">
                     <textarea  id="content" rows="20" name="content"></textarea>
			         <script type="text/javascript">CKEDITOR.replace('content',{height:280,width:850});</script>
                 </div>
               </div>
               
              
               <div class="apply-in_right"></div>
               
               
           </div> 
           <div class="btn">
             <input type="submit" value="提　交"   onClick="return Panduan(${a})"   />
          </div>
         </form>             
   </div>
  
  
   
 <div id="foot_1"  style="clear:both;">
  <%@ include file="/common/newfooter.jsp"%>
  </div>
  </body>
</html>
