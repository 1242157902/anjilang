<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<title>群发消息</title>

<script src="<c:url value='/hyh/js/jquery-1.11.1.min.js '/>"></script>
<script src="<c:url value='/plus-in/ckeditor/ckeditor.js '/>"></script>
<link href="<c:url value='../hyh/css/thenews.css' />" rel="stylesheet"> 
<link href="<c:url value='../hyh/css/share.css' />" rel="stylesheet"> 
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen">
<script type="text/javascript" src="<c:url value='/js/newcommon.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/my.js' />"></script> 
</head>
<body>

<div>
  <%@ include file="/common/newhead.jsp"%>
</div>	

<!--banner开始-->
   <div class="banners" style="background:url(<c:url value='/${patientGroup.bgpicUrl }'/>)"  >
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
      <li ><a href="<c:url value='/patientGroup/picture.do?groupid=${patientGroup.id } '/>" >小组图片</a></li>
      <li><a href="<c:url value='/GroupUser/remember.do?groupid=${patientGroup.id } '/>">成员管理</a></li>
      <li><a href="<c:url value='/GroupTopic/Artical.do?groupid=${patientGroup.id } '/> ">帖子管理</a></li>
      <li><a href="<c:url value='/patientGroup/branch.do?groupid=${patientGroup.id } '/> ">分类管理</a></li>
      <li class="first"><a href="<c:url value='/GroupMessage/tosend.do?groupid=${patientGroup.id } '/>">群发消息</a></li>
      
    </ul>
  </div>
 <form  action="<c:url value='/GroupMessage/send.do?groupid=${patientGroup.id }' />" method="post">   
  <div class="apply-in">
      <div class="apply-in_left">
           <p>向所有小组成员发送消息</p>
           <div class="janes">
           <textarea  id="description" rows="20" name="content"></textarea>
					<script type="text/javascript">CKEDITOR.replace('description',{height:250});</script>
         </div>
         <div class="btn">
        <input type="submit" value="提　交"/>
      </div>
        </div>
        <div class="apply-in_right"></div>
        
      </div>
      </form>
     
  </div>


<div id="foot_1"  style="clear:both;">
  <%@ include file="/common/newfooter.jsp"%>
  </div>
</body>
</html>
