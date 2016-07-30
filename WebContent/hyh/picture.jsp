<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>患友会小组图片</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen">
    <script type="text/javascript" src="hyh/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<c:url value='/js/newcommon.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/my.js' />"></script>
	<link rel="stylesheet" type="text/css" href="hyh/css/picture.css" />
    <link rel="stylesheet" type="text/css" href="hyh/css/share.css" />
    <script type="text/javascript">
       function ShowDiv(show_div,bg_div){
       document.getElementById(show_div).style.display='block';
       document.getElementById(bg_div).style.display='block' ;
       var bgdiv = document.getElementById(bg_div);
       bgdiv.style.width = document.body.scrollWidth;
      // bgdiv.style.height = $(document).height();
       $("#"+bg_div).height($(document).height());
       };
      //关闭弹出层
      function CloseDiv(show_div,bg_div)
      {
          document.getElementById(show_div).style.display='none';
          document.getElementById(bg_div).style.display='none';
      };

   
	</script>
	

	
	
	
	
	
	

  </head>
  
  <body>
  
   <div>
  <%@ include file="/common/newhead.jsp"%>
</div>	
  
  <!--banner开始-->
   <div class="banners" style="background : url(<c:url value='/${patientGroup.bgpicUrl }'/>)">
       <div class="banner-in">
            <ul>
               <i></i>
               <li><a href="#">首页${tabid } ></a> </li>
               <li><a href="#">群组 ></a> </li>
               <li><a >${patientGroup.groupname } > </a></li>
            </ul>
            <div class="lad">
               <img src="<c:url value='/${patientGroup.picurl }'/>" />
               <h2>${patientGroup.groupname }</h2>
               <p>创建于<fmt:formatDate value="${patientGroup.createtime }" pattern="yyyy-MM-dd"/> 成员${count+1 }人</p>  
            </div>
            <div class="tab_menu">
                <ol>
                <c:choose>
                 <c:when test="${empty tabid }">
                  <li ><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }'/>">小组首页</a></li> 
                 </c:when>
                 <c:otherwise>
                  <li ><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }'/>">小组首页</a></li>
                  
                </c:otherwise>
                </c:choose>
                <c:forEach  var="tab" items="${tabs }"  varStatus="status">
                <c:choose>
                <c:when test="${tabid==tab.id}">
                  <li class="first"><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }&grouptabid=${tab.id }'/>">${tab.tabname }</a></li> 
                </c:when>
                <c:otherwise>
                 <li ><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }&grouptabid=${tab.id }'/>">${tab.tabname }</a></li> 
                </c:otherwise>
                 </c:choose>
                  </c:forEach>
                <li style="display:none;"><a href="#">管理小组</a></li>
              
                    <c:set var= "userid"   value="${patientGroup.userid}"  />
                    <c:set var= "id"   value="${user.id }"/>
                    <c:if test="${userid==id }">
                        <li style="display:block;"  class="first">
                        <a href="<c:url value='/patientGroup/magroup.do?groupid=${patientGroup.id } ' />">管理小组</a>
                        </li>
                    </c:if>
                    
                </ol>
            </div>
       </div>
   </div>
  
  
  
  
  <div class="apply">
   <div class="list">
     
   <%-- <ul>
      <i></i>
      <li><a href="#">首页 ＞</a></li>
      <li><a href="#">群组 ＞</a></li>
      <li><a href="#">${patientGroup.groupname }</a></li>
   </ul> --%>
   </div>
  <div class="tube">
    <ul>
      <li ><a href="<c:url value='/patientGroup/magroup.do?groupid=${patientGroup.id } '/>">小组设置</a></li>
      <li class="first"><a href="<c:url value='/patientGroup/picture.do?groupid=${patientGroup.id } '/>" >小组图片</a></li>
      <li><a href="<c:url value='/GroupUser/remember.do?groupid=${patientGroup.id } '/>">成员管理</a></li>
      <li><a href="<c:url value='/GroupTopic/Artical.do?groupid=${patientGroup.id }'/> ">帖子管理</a></li>
      <li><a href="<c:url value='/patientGroup/branch.do?groupid=${patientGroup.id } '/> ">分类管理</a></li>
      <li><a href="<c:url value='/GroupMessage/tosend.do?groupid=${patientGroup.id } '/>">群发消息</a></li>
      
    </ul>
  </div>
  
  
  
  <div class="apply-in">
  <form action="<c:url value='/patientGroup/mopic.do?groupid=${patientGroup.id }'/>"  method="post"  enctype="multipart/form-data">
      <div class="apply-in_left">
          
           <h3>小组图标</h3>
           <p>支持 JPG、JPEG、GIF、BMP 和 PNG 文件格式，固定大小100X100像素。</p>
           <div  style="padding:20px;">
            <input type="file" id="file" name="file" >
			<span id ="showPic"><img style="width: 80px;height: 80px;" src="<c:url value="/${patientGroup.picurl }"/>"/></span>
			<input type="hidden" id="pic" name="pic" value="${patientGroup.picurl }">
			
			
            </div>
            <input class="btns" type="submit" value="确定" ">
            </form>
            
            <form action="<c:url value='/patientGroup/mobgpic.do?groupid=${patientGroup.id }'/>"  method="post"  enctype="multipart/form-data">
           
              <h3 class="bg">小组背景图</h3>
              <P class="gaoq">支持 JPG、JPEG、GIF、BMP 和 PNG 文件格式，宽度2000像素，高度根据小组简介内容自适应。</P>
            <div style="padding:20px;">
                <input type="file" value="浏览上传"  name="file"   id="file" /><br/> 
               <span id ="showPic"><img style="width: 80px;height: 80px;" src="<c:url value="/${patientGroup.bgpicUrl }"/>"/></span>
               
            </div>
               <input class="btns" type="submit" value="确定" ">
           </div>
          </form>
      </div>
      
      
  </div>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


<div id="foot_1"  style="clear:both;">
  <%@ include file="/common/newfooter.jsp"%>
  </div>






  </body>
</html>
