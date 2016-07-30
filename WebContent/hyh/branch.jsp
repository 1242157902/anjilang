<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%String grouptabid=request.getParameter("grouptabid"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>分类管理</title>
    
     <link rel="stylesheet" type="text/css" href="hyh/css/branch.css" />
     <link rel="stylesheet" type="text/css" href="hyh/css/share.css" />
     <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
     <link rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen">
      <script type="text/javascript" src="hyh/js/jquery-1.11.1.min.js"></script>
     <script type="text/javascript" src="<c:url value='/js/newcommon.js' />"></script>
     <script type="text/javascript" src="<c:url value='/js/my.js' />"></script>
     
     <script  type="text/javascript">
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
                  <li ><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }&grouptabid=${tab.id }'/>">${tab.tabname }</a></li> 
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
                        <li style="display:block;" class="first">
                        <a href="<c:url value='/patientGroup/magroup.do?groupid=${patientGroup.id } ' />">管理小组</a>
                        </li>
                    </c:if>
                    
                </ol>
            </div>
       </div>
   </div>
  
  
   

<!--小组申请-->
<div class="apply">
   <div class="list">
     
  <%--  <ul>
      <i></i>
      <li><a href="#">首页 ＞</a></li>
      <li><a href="#">群组 ＞</a></li>
      <li><a href="#">${patientGroup.groupname }</a></li>
   </ul> --%>
   </div>
  <div class="tube">
    <ul>
     <ul>
      <li ><a href="<c:url value='/patientGroup/magroup.do?groupid=${patientGroup.id } '/>">小组设置</a></li>
      <li ><a href="<c:url value='/patientGroup/picture.do?groupid=${patientGroup.id } '/>" >小组图片</a></li>
      <li><a href="<c:url value='/GroupUser/remember.do?groupid=${patientGroup.id } '/>">成员管理</a></li>
      <li><a href="<c:url value='/GroupTopic/Artical.do?groupid=${patientGroup.id } '/> ">帖子管理</a></li>
      <li class="first"><a href="<c:url value='/patientGroup/branch.do?groupid=${patientGroup.id } '/> ">分类管理</a></li>
      <li><a href="<c:url value='/GroupMessage/tosend.do?groupid=${patientGroup.id } '/>">群发消息</a></li>
      
    </ul>
    </ul>
  </div>
  
  <div class="apply-in">
      <div class="apply-in_left">
        <h3>分类说明：</h3> 
         <p>成员超过30人时可再增加3个分类;</p>
         <p>在最开始的时候可以从设置最重要的3个关键词开始</p>  
        <div class="fenlei">
           <div class="fl1">
             <P>分类</P>
             <P class="tow">顺序</P>
           </div>
           
           <div class="newest">
           <c:forEach var="list" items="${tabs }"  varStatus="status" >
              <ul>
              
                 <li class="one"><a href="">${list.tabname }</a></li>
                  <li class="one1"><a href="">${list.sortorder }</a></li>
                   <li class="one2"><a style="cursor:pointer;"  onclick="ShowDiv('MyDiv_${status.index}','fade_${status.index}' )" >编辑</a>
                   </li>
                   <li class="one3"><a href="<c:url value='/GroupTab/cancel.do?groupid=${patientGroup.id }&id=${list.id }' />">删除</a></li>
             
               </ul>
                <form class="form-horizontal"     action="<c:url value='/GroupTab/edit.do?groupid=${patientGroup.id }&grouptabid=${list.id }' />"  method="post">
             <div id="fade_${status.index}" class="black_overlay">
            </div>
             <div id="MyDiv_${status.index}" class="white_content">
                <div style="cursor: default; ">
                  <span  onclick="CloseDiv('MyDiv_${status.index}','fade_${status.index}')">关闭</span>
                   <p class="caij">编辑分类${grouptabid }</p>
                   <div class="white_content_l"></div>
             
                      <div class="form-group">
				       <label class="col-md-3 control-label" for="message">分类</label>
				        <div class="col-md-9">
				         <input id="tabname" name="tabname" type="text"   class="form-control">
				       </div>
		           </div>
                   <div class="form-group" >
				      <label class="col-md-3 control-label" for="message">首页显示顺序</label>
				        <div class="col-md-9">
				          <input id="sortorder" name="sortorder" type="text"  class="form-control">
				       </div>
				    </div>
                       <input type="submit" value="提　交" class="btnt"  />
                      
                  </div>

            </div>
               </form>  
              
            </c:forEach>
            </div>
            
              
           
           <form class="form-horizontal"   style="padding-top:30px;"   action="<c:url value='/GroupTab/AddTab.do?groupid=${patientGroup.id }' />"  method="post">  
             <div class="form-group">
				<label class="col-md-3 control-label" for="message">分类</label>
				<div class="col-md-9">
				<input id="tabname" name="tabname" type="text"  placeholder="例如：最新资讯" class="form-control">
				</div>
		  </div>
           <div class="form-group" >
				<label class="col-md-3 control-label" for="message">首页显示顺序</label>
				<div class="col-md-9">
				<input id="sortorder" name="sortorder" type="text"  placeholder="默认为0,则不在首页显示" class="form-control">
				</div>
		  </div>
		  
            <input type="submit" value="提 交 修 改" class="btn"  />
            </form>
        </div>
    </div>
        <div class="apply-in_right"></div>
        
      </div>
     
  </div>
<div id="foot_1"  style="clear:both;">
 <%@ include file="/common/newfooter.jsp"%>
</div>

</body>
</html>
