<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<% String[] userid=request.getParameterValues("userid"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>成员管理</title>
    
    <link rel="stylesheet" type="text/css" href="<c:url value='hyh/css/members.css' />">	
    <link rel="stylesheet" type="text/css" href="<c:url value='hyh/css/share.css' />" >
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen">
    <script type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/newcommon.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/my.js' />"></script>

	<script type="text/javascript">
$(function(){
		
		$("#btnSearch").click(function(){
			var groupId = $(".groupId").val();
			var userName = $("#userName").val();
			$.ajax({
				url:'GroupUser/finduser.do',
				type:"POST",
				async: true,
				dataType:'JSON',
				data:"groupid="+groupId+"&user="+userName,
				success:function(data,status){
					$(".photo").remove();
					var div = " <div class='photo'><ul></ul></div>";
					$(".change").append(div);
					 $.each(data,function(i,value){
						 var userId = value.id;
						 var realName = value.realName;
						 var header = value.header;
						 var li = "<li > <img id='showPic' name='showPic' width='48px' height='48px'  src='<c:url value='/"+header+"' />' /><div style='float:left;padding-left:5px;'><h6>"+
						 realName+"</h6><span><a href='<c:url value='/GroupUser/promote.do?groupid=${patientGroup.id }&userid=${user1.id }'/>' >提升管理员</a></span><input  class='dan'  type='checkbox'  value="+userId+"/></div></li>";
						 $(".photo>ul").append(li);
					 });
					 
				},
				error:function(data,status){
					alert("error");
				}
			});
		});
		
	})

	</script>
  </head>
  
  <body>
  
  <div>
  <%@ include file="/common/newhead.jsp"%>
</div>	
  
  <!--banner开始-->
  <div class="banners" style="background : url(<c:url value='/hyh/images/banner.jpg'/>)">
       <div class="banner-in">
            <ul>
               <i></i>
               <li><a href="index.jsp">首页 ></a> </li>
               <li><a href="javascript:void(0)">群组 ></a> </li>
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
   
   <!-- 成员列表 -->
   <div class="apply">
     <div class="list">
     </div>
   
      <div class="tube" >
         <ul>
              <li ><a href="<c:url value='/patientGroup/magroup.do?groupid=${patientGroup.id } '/>">小组设置</a></li>
              <li ><a href="<c:url value='/patientGroup/picture.do?groupid=${patientGroup.id } '/>" >小组图片</a></li>
              <li class="first"><a href="<c:url value='/GroupUser/remember.do?groupid=${patientGroup.id } '/>">成员管理</a></li>
              <li ><a href="<c:url value='/GroupTopic/Artical.do?groupid=${patientGroup.id }'/> ">帖子管理</a></li>
              <li><a href="<c:url value='/patientGroup/branch.do?groupid=${patientGroup.id } '/> ">分类管理</a></li>
              <li><a href="<c:url value='/GroupMessage/tosend.do?groupid=${patientGroup.id } '/>">群发消息</a></li>
          </ul>
      </div>
      
      
      
      <div class="apply-in">
      
           <div class="apply-in_left">
              <div class="id">
                 <form id="mysearch" >
                     <input type="hidden" value="${patientGroup.id }"  class="groupId"/>
                     <input type="text" value="请输入用户名" style="color:#CCCCCC;" name="user"  class="inputs" id="userName" />
                     <input type="button" value="查 找"  id="btnSearch"   class="btn">
                   </form>
                </div>
                
                
                
             <form action="<c:url value='/GroupUser/delect.do?groupid=${patientGroup.id }' />"   id="body" name="body"   method="post">
              <div class="change" > 
                <div class="photo">
                   <ul>
                     <c:forEach var="user1"  items="${uList }"  >
                       <li >
                         
                         <img   src="<c:url value='/${user1.header }' />" id="showPic" name="showPic" width="48px" height="48px">
                         
                            <div style="float:left;padding-left:5px;">
		                        <h6>${user1.realName }</h6>
		                        <span>
		                        <a href="<c:url value='/GroupUser/promote.do?groupid=${patientGroup.id }&userid=${user1.id }'/>" >提升管理员</a></span>
		                        <input class="dan" type="checkbox" name="userid" checkbox="true"  value="${user1.id }">
		                        
		                        
		                    </div>
		                  
                        </li>
                     </c:forEach>
                   </ul> 
                </div>
                
                <div style="clear:both;"></div>
                <div id="main_pagination"  >
                
                   <c:if test="${pageNo>1}">
			           <a href="<c:url value='/GroupUser/remember.do?groupid=${patientGroup.id }&pageNo=${pageNo-1 }' />" class="one">上一页</a>
			           <a href="<c:url value='/GroupUser/remember.do?groupid=${patientGroup.id }&pageNo=${pageNo-1 }' />">${pageNo-1 }</a>
			       </c:if>
			       <a href="<c:url value='/GroupUser/remember.do?groupid=${patientGroup.id }&pageNo=${pageNo }' />" class="one">${pageNo }</a>
	           	   <c:if test="${pageNo<totalPage }">
	           		   <a href="<c:url value='/GroupUser/remember.do?groupid=${patientGroup.id }&pageNo=${pageNo+1 }' />">${pageNo+1 }</a>
	           		   <c:if test="${pageNo+1<totalPage }">
	           		        <strong>...</strong>
	           			</c:if>
	           		    <a href="<c:url value='/GroupUser/remember.do?groupid=${patientGroup.id }&pageNo=${pageNo+1 }' />" class="one">下一页</a>
	           	   </c:if>
               </div>
             </div>
                
                <div style="clear:both;"></div>
                <div>
                <input class="btns" type="submit" value="删除选中用户">
                <p>用户被删除后，失去组员资格。但是其发布的老贴子还会留在小组中</p>
                </div>
                
            </form>
                 
                          
                         
           
           
           </div>
           
             <div class="apply-in_right"></div>
     </div>
   
   
   
   
   
   
   
   
   
   </div>
   
  
   

  
 
   <div id="foot_1"  style="clear:both;">
  <%@ include file="/common/newfooter.jsp"%>
  </div>
  </body>
</html>
