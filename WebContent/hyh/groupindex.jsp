<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>

<base href="<%=basePath%>">

<title>患友会小组主页</title>
<link rel="stylesheet" type="text/css"  href="<c:url value='/css/common.css' />" media="screen">
<link rel="stylesheet" type="text/css"  href="<c:url value='/css/newindex.css' />" media="screen">
<SCRIPT type="text/javascript"  src="<c:url value='/js/jquery-1.11.1.min.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/newcommon.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/my.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='hyh/js/my.js' />"></SCRIPT>
<link rel="stylesheet" type="text/css"  href="<c:url value='hyh/css/index.css' />" />
<link rel="stylesheet" type="text/css"   href="<c:url value='hyh/css/share.css' />" />

<script type="text/javascript">
	function queryTis(grouptabid){
	   console.log("id:" + grouptabid);
	   $("#grouptabid").val(grouptabid);
	   $("#queryForm").submit();
	
	}
	function queryType(host){
	  
	   $("#queryType").val(host);
	   $("#queryForm").submit();
	
	}
</script>


<body>

	<form id="queryForm">
		<input type="hidden" id="grouptabid" name="grouptabid" /> 
		<input type="hidden" id="queryType" name="queryType" /> 
		<input type="hidden" id="groupid" name="groupid" value="${patientGroup.id }" />
	</form>
	<input type="hidden" id="tabid" name="tabid" value="${tabid }" />
	

	<div>
		<%@ include file="/common/newhead.jsp"%>
	</div>
	
	
	<!--banner开始-->

     <div class="banners"  style="background : url(<c:url value='/${patientGroup.bgpicUrl }'/>);" >
     
     
       <div class="banner-in">
       
       
            <ul>
               <i></i>
               <li><a href="index.jsp">首页 ></a> </li>
               <li><a href="javascript:void(0)">群组 ></a> </li>
               <li><a >${patientGroup.groupname } > </a></li>
            </ul>
            
            
            <div class="lad" >
               <img src="<c:url value='/${patientGroup.picurl }'/>" />
               
               <h2 >${patientGroup.groupname }</h2>
               
               <p >创建于<fmt:formatDate value="${patientGroup.createtime }" pattern="yyyy-MM-dd"/> 成员${patientGroup.personcount }人</p>
               
                
            </div>
            
            
            <ol>
            
                <c:choose>
                  <c:when test="${empty tabid }">
                    <li class="first"><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }'/>">小组首页</a></li> 
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
               
    
                <c:if test="${patientGroup.userid==user.id }">
                   <li style="display:block;">
                     <a href="<c:url value='/patientGroup/magroup.do?groupid=${patientGroup.id } ' />">管理小组</a>
                    </li>
                 </c:if>
                    
                </ol>
            
            
           </div>
           
           
     </div>
     
     
     
     
     
     <!-- 內容 -->
     <div class="content"  >
     
       <div class="content-left">
         
          <div class="join">
          
              <div class="jinnh">
              
                 <p>${patientGroup.description }  </p>
                 
                 <c:forEach  var="users" items="${uList }"> 
                     <c:if test="${user.id==users.id }">
                        <c:set var= "panduan"   value="${1 }"  />
                     </c:if> 
                 </c:forEach>         
                 <c:choose>
                   <c:when test="${panduan==1 }">
                      <span style="display:none;"  class="btn"><i></i>
                        <a href="<c:url value='/GroupUser/JoinGroup.do?groupid=${patientGroup.id }' />">加入小组</a>
                      </span>
                   </c:when >
               
                   <c:when test="${user.id==patientGroup.userid }">
                      <span style="display:none;"  class="btn"><i></i>
                      <a   href="<c:url value='/GroupUser/JoinGroup.do?groupid=${patientGroup.id }' />">加入小组</a>
                       </span>
                   </c:when>
                   
                   <c:otherwise>
                    <span   class="btn"><i></i>
                     <a  href="<c:url value='/GroupUser/JoinGroup.do?groupid=${patientGroup.id }' />">加入小组</a>
                     </span>
                   </c:otherwise>
                   
                </c:choose>
           
             </div>
             
             
          
           
             
             <div class="jinnd"  style="clear:both;">
           
                  <c:choose>
               
                     <c:when test="${panduan==1 }">
                        <span class=quit" >
                        <a href="<c:url value='/GroupUser/QuitGroup.do?groupid=${patientGroup.id }' />">>退出小组</a>
                        </span>
                      </c:when >
                    
                      <c:when test="${user.id==patientGroup.userid }">
                         <span  style="display:none;" class=quit" >
                          <a href="<c:url value='/GroupUser/QuitGroup.do?groupid=${patientGroup.id }' />">>退出小组</a>
                          </span>
                      </c:when>
                   
                      <c:otherwise>
                        <span style="display:none;" class=quit" >
                         <a href="<c:url value='/GroupUser/QuitGroup.do?groupid=${patientGroup.id }' />">>退出小组</a>
                       </span>
                      </c:otherwise>
                   
                   </c:choose>
                </div>
          </div>
          
          
           <div class="relea">
               <div class="relea-t">
                   <c:choose>
                     <c:when test="${empty tabid && empty queryType  }">
                       <p style="display:block;color:#FD5370;" class="releas"  ><a style="color:#FD5370;"   onclick="queryTis()">最新发布 </a></p>
                       
                    </c:when>
                    <c:when test="${not empty tabid }">
                       <p style="display:block;color:#FD5370;" class="releas"  ><a style="color:#FD5370;" >最新发布 </a></p>
                    </c:when>
                    <c:otherwise>
                       <p style="display:block;"  class="releas"><a  onclick="queryTis()">最新发布 </a></p>
                   </c:otherwise>
                    </c:choose>
                   <c:choose>
                    <c:when test="${not empty tabid }">
                       <p style="display:none"   ><a  >热门话题</a></p>
                    </c:when>
                   <c:when test="${ not empty queryType }">
                       <p style="display:block"  class="releas"><a style="color:#FD5370;" onclick="queryType('hot')">热门话题</a></p>
                    </c:when>
                    <c:otherwise>
                      <p  class="releas"><a  onclick="queryType('hot')">热门话题</a></p>
                   </c:otherwise>
                </c:choose>
             
       
                   <span><i></i><a href="<c:url value='/GroupTopic/topublish.do?groupid=${patientGroup.id }' />">发新贴</a><b></b></span>
                  
               </div>
               
               <div class="uestions">
                  <table width="855"  border-bottom="1" >
                    <tr>
    
                      <td width="386" align="left" ><p>话题</p></td>
                      <td width="165" ><p class="zhe">作者</p></td>
                      <td width="165">回复/阅读</td>
                      <td width="119">最后回复</td>
                   </tr>
                   <c:forEach  var="newtopic"  items="${topics }">
                  <tr>
    
                    <td><i></i><a href="<c:url value='/GroupTopic/detail.do?id=${newtopic.id }&groupid=${patientGroup.id }'/>">${newtopic.title }</a> </td>
                    <td style="color:red;font-size:12px;"><b><img width="20px" height="20px" src="<c:url value='/${newtopic.user.header }'/>"   /></b><p>${newtopic.user.realName }</p></td>
                    <td style="font-size:12px;">${newtopic.rep }/${newtopic.hit }</td>
                    <td style="font-size:12px;"><fmt:formatDate value="${newtopic.createtime }" pattern="yyyy-MM-dd  HH:mm"/> </td>
                 </tr>
                 </c:forEach>
  
               </table>
               <div id="main_pagination">
                   <P>共${totalPage }页/${totalSize }条</P>
                   <c:if test="${pageNo>1}">
                   <a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }&pageNo=${pageNo-1 }&grouptabid=${tabid }&queryType=${queryType }' />" class="one1">上一页</a>
	               <a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }&pageNo=${pageNo-1 }&grouptabid=${tabid }&queryType=${queryType }' />"  >${pageNo-1 }</a>
	              </c:if>
	              <a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }&pageNo=${pageNo }&grouptabid=${tabid }&queryType=${queryType }' />" class="one1">${pageNo }</a>
	              <c:if test="${pageNo<totalPage }">
	              <a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }&pageNo=${pageNo+1 }&grouptabid=${tabid }&queryType=${queryType }' />">${pageNo+1 }</a>
	               <c:if test="${pageNo+1<totalPage }">
	                <strong>...</strong>
	               </c:if>
	              <a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }&pageNo=${pageNo+1 }&grouptabid=${tabid }&queryType=${queryType }' />" class="one1">下一页</a>
	             </c:if>
              </div>
            </div>
            
       </div>
     
    </div>
               
        
       <div class="content-right" >
          <!-- 推荐内容 -->
           <div class="mends">
              <div class="mend">
                <a href="javascript:void(0);" class="glt"></a>
		        <a href="javascript:;" class="grt"></a>
		        <ul>
			      <c:forEach   var="picTopics"  items="${picTopics }"  begin="0"  end="3">
			        <li style="display:block;"><a href="<c:url value='/GroupTopic/detail.do?id=${picTopics.id }&groupid=${picTopics.patientGroup.id }'/>"><img src="${pageContext.request.contextPath}/${picTopics.articlepic}"  alt="" /></a></li>
		          </c:forEach>	
		        </ul>
		        <ol>
		         <c:forEach   var="picTopics"  items="${picTopics }"   begin="0"  end="3">
			      <li class="current"></li>
			
		        </c:forEach>
		       </ol>
               
             </div>
            
           
           
           <!--组委会-->
           <div class="mittee">
               <h3 >组委会</h3>
           <ul>
             <li class="first">
                <img src="<c:url value='/${gUser.header }'/>" />
                <p><a href="javascript:void(0);">${gUser.realName }(${gUser.addr })</a></p>
                <span><a href="javascript:void(0);">+关注</a></span><br/>
                <i></i>
              </li>
             <c:forEach var="guser"  items="${gList }" begin="0" end="4"> 
             <li>
                <img src="<c:url value='/${guser.header }'/>" />
                <p><a href="javascript:void(0);">${guser.realName }(${guser.addr })</a></p>
                <span><a href="javascript:void(0);">+关注</a></span><br/>
             </li>
             </c:forEach>
           </ul> 
        
          </div>
      
          <!--最新加入-->
          <div class="newest">
             <h3>最新加入</h3>
             <div class="clear"></div>
             <c:forEach var="userlist" items="${uList }"   begin="0" end="9">
               <dl>
                 <dt ><a href="javascript:void(0)"><img  width="48px" height="49px"  src="<c:url value='/${userlist.header }' />"  /></a></dt>
                 <dd><a href="javascript:void(0)">
                 <c:set var="string" value="${fn:substring(userlist.realName, 0, 6)}" />${string }</a></dd>
               </dl>
           </c:forEach>
         </div>
         
         
      <div class="protuct"></div>     
      
      </div>
  </div>
  </div>
     
     
     
   <div style="clear:both;margin-top:20px;padding-bottom:20px;"></div>  
     
     
     
	
	
	<!--尾部-->
	
	
	<div id="foot_1"  style="clear:both;">
         <%@ include file="/common/newfooter.jsp"%>
    </div>
	
	
	

</body>
</html>