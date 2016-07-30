<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%String tabid = request.getParameter("grouptabid");
 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>帖子管理</title>
    <link rel="stylesheet" type="text/css" href="hyh/css/post.css" />
    <link rel="stylesheet" type="text/css" href="hyh/css/share.css" />
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen">
    <script type="text/javascript" src="hyh/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<c:url value='/js/newcommon.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/my.js' />"></script>
    
    
    <script type="text/javascript">
     $(function() {
         var $tit_li = $("div.kel ul li");
         var $cont_nav = $("div.tab-con > div"); //得到显示隐藏的内容
		 $tit_li.click(function() {
		   $(this).addClass("one").siblings().removeClass("one");
		   var index=$tit_li.index(this);
		    $cont_nav.eq(index).show().siblings().hide();
	    });
	});
	
	</script>
	<script type="text/javascript">
	function queryTis(grouptabid){
	console.log("id:" + grouptabid);
	$("#grouptabid").val(grouptabid);
	$("#queryForm").submit();
	}
	</script>
	
     
  </head>
  
  <body>
  <form id="queryForm">
   <input type="hidden" id="grouptabid" name="grouptabid"/>
  
   <input type="hidden" id="groupid" name="groupid" value="${patientGroup.id }"/>
  </form>
  
  <div>
  <%@ include file="/common/newhead.jsp"%>
</div>	
  
  <!--banner开始-->
   <div class="banners"  style="background : url(<c:url value='/${patientGroup.bgpicUrl }'/>)">
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
  
  
  
  
  
  
  
  
  
  
  <div class="apply">
     
         <div class="list">
             <!-- <ul>
                <i></i>
                <li><a href="#">首页 ＞</a></li>
                <li><a href="#">群组 ＞</a></li>
                <li><a href="#">老友会</a></li>
             </ul>
          -->
         </div>
         
          <div class="tube">
              <ul>
                 <li ><a href="<c:url value='/patientGroup/magroup.do?groupid=${patientGroup.id } '/>">小组设置</a></li>
                 <li ><a href="<c:url value='/patientGroup/picture.do?groupid=${patientGroup.id } '/>" >小组图片</a></li>
                 <li><a href="<c:url value='/GroupUser/remember.do?groupid=${patientGroup.id } '/>">成员管理</a></li>
                 <li class="first"><a href="<c:url value='/GroupTopic/Artical.do?groupid=${patientGroup.id }'/> ">帖子管理</a></li>
                 <li><a href="<c:url value='/patientGroup/branch.do?groupid=${patientGroup.id } '/> ">分类管理</a></li>
                 <li><a href="<c:url value='/GroupMessage/tosend.do?groupid=${patientGroup.id } '/>">群发消息</a></li>
      
      
             </ul>
          </div>
          
          
     <div class="apply-in">
        <div class="apply-in_left">
           <div class="kel">
              <ul>
              <c:choose>
                 <c:when test="${empty tabid }">
                 <li onclick="queryTis()"  class="one" ><a >全部话题</a></li>
                 </c:when>
                 <c:otherwise>
                 <li onclick="queryTis()"   ><a >全部话题</a></li>
                </c:otherwise>
                </c:choose>
                <c:forEach  var="tab" items="${tabs }"  >
                <c:choose>
                <c:when test="${tabid==tab.id}">
                  <li  class="one" ><a onclick="queryTis(${tab.id})"  >${tab.tabname }</a></li>
                </c:when>
                <c:otherwise>
                 <li   ><a onclick="queryTis(${tab.id})"  >${tab.tabname }</a></li>
                </c:otherwise>
                 </c:choose>
                  </c:forEach>
               </ul>
             </div>
       
              
               <form action="<c:url value='/GroupTopic/delect.do?groupid=${patientGroup.id }' />"   id="body" name="body"   method="post">  
                  
                       <div class="tiezi">
                          <table  width="857" border="0">
                            <tr >
                               <td width="400">话题</td>
                               <td width="153">作者</td>
                               <td width="137">时间</td>
                               <td width="139">分类</td>
                             </tr>
                                     
                                     
                             <c:forEach  var="groupTopic"  items="${newTopics }">    
                               <tr>
                                  <td><input type="checkbox" name="topicid" class="dan" value="${groupTopic.id }"> ${groupTopic.title }</td>
                                  <td style="color:red;font-size:12px;"><b><img width="20px" height="20px" src="<c:url value='/${groupTopic.user.header }'/>"   /></b>${groupTopic.user.realName }</td>
                                  <td><fmt:formatDate value="${groupTopic.createtime }" pattern="yyyy-MM-dd HH:mm"/></td>
                                  <td > 
                                     <div class="choose" name="choose">
		                                <div class="hd" ><select  class="hd" name="tabid">
                                           <c:forEach var="tab"  items="${tabs }">
                                              <option value="${tab.id }">
                                                 ${tab.tabname }
                                              </option>
                                          </c:forEach>
                                          </select>
	                                   </div>
	                                  </div>
                                    </td>
                                  </tr>
                             </c:forEach> 
                         </table>
                       </div>
         
                     <div id="main_pagination">
                       <P>共${totalPage }页/${totalCount }条</P>
                       <c:if test="${pageNo>1}">
			           <a href="<c:url value='/GroupTopic/Artical.do?groupid=${patientGroup.id }&pageNo=${pageNo-1 }&grouptabid=${tabid }' />" class="one1">上一页</a>
			           <a href="<c:url value='/GroupTopic/Artical.do?groupid=${patientGroup.id }&pageNo=${pageNo-1 }&grouptabid=${tabid }' />">${pageNo-1 }</a>
		               </c:if>
			           <a href="<c:url value='/GroupTopic/Artical.do?groupid=${patientGroup.id }&pageNo=${pageNo }&grouptabid=${tabid }' />" class="one1">${pageNo }</a>
	                   <c:if test="${pageNo<totalPage }">
	           	       <a href="<c:url value='/GroupTopic/Artical.do?groupid=${patientGroup.id }&pageNo=${pageNo+1 }&grouptabid=${tabid }' />">${pageNo+1 }</a>
	                   <c:if test="${pageNo+1<ntotalPage }">
	           		   <strong>...</strong>
	           	       </c:if>
	                   <a href="<c:url value='/GroupTopic/Artical.do?groupid=${patientGroup.id }&pageNo=${pageNo+1 }&grouptabid=${tabid }' />" class="one1">下一页</a>
	                  </c:if>
                    </div>
                    
               
      
     
                
      <input class="btns" type="submit" value="删除选中文章" > 
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
