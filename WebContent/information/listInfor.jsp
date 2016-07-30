<%@page import="com.anjilang.dao.base.impl.PaginationSupport"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>健康资讯_安吉朗新闻-安吉朗健康营养问答</TITLE>
<META content="text/html; charset=UTF-8">
<meta name="keywords" content="安吉朗新闻,营养膳食资讯,营养师,公共营养师">
<meta name="description" content="安吉朗资讯：为广大用户及营养师提供最专业的行业动态，会议安排。"/>
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/reset.css' />" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/secpage.css' />" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/index.css' />" media="screen">
<SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js' />"></SCRIPT>
</HEAD>
<body>
<div id="content">
<%@ include file="/common/newhead.jsp"%>
<div class="clear"></div>
<div class="breadcrumb">
   <div class="contentBox">
      <div class="route">
      </div>
      <h1>资讯频道</h1>
      <div class="zixun_title clearfix">
         <span class="fl"><em></em>最新健康资讯</span>
         <ul class="clearfix">
         	<li  <c:if test="${0==typeId}">
         		 		class="on"
         		 	</c:if>
         		 ><a href="<c:url value='/infor/toInforChannel.do?typeId=0' />">全部资讯</a></li>
         
         
         	<c:forEach items="${listType }" var="type" varStatus="status">
         		 <li 
         		 	<c:if test="${type.id==typeId}">
         		 		class="on"
         		 	</c:if>
         		 	
         		 	<c:if test="${status.last}">
         		 		class="last"
         		 	</c:if>
         		 ><a href="<c:url value='/infor/toInforChannel.do?typeId=${type.id }' />">${type.title }</a></li>
         	</c:forEach>
         </ul>
      </div>
   </div>
</div>
<div class="contentBox">
   <div class="leftBox">
      <div class="zixun_con">
         <ul>
         	<c:forEach items="${listInfor }" var="info">
         		<li>
	               <h3><em></em><a href="<c:url value='/infor/toInforDetail.do?id=${info.id }'/>">${info.title }</a><span class="fr">${info.crTime }</span></h3>
	               <p class="info">
	               		<c:if test="${fn:length(info.content) > 300}">
	               			<c:out value="${fn:substring(info.content, 0, 300)}......"/> 
	               		</c:if>
	               </p>
	            </li>
         	</c:forEach>
         </ul>
         
         <div class="pageNav">	
		    	<c:if test="${pageNo!=1}">
		    		<a href="<c:url value='/infor/toInforChannel.do?typeId=${typeId }&pageNo=${pageNo-1 }' />" class="next">上一页</a>
		    		<c:if test="${pageCount>3 }">
		    			<strong>...</strong>
		    		</c:if>
		    		<a href="<c:url value='/infor/toInforChannel.do?typeId=${typeId }&pageNo=${pageNo-1 }' />">${pageNo-1 }</a>
		    	</c:if>
		       <a href="<c:url value='/infor/toInforChannel.do?typeId=${typeId }&pageNo=${pageNo }' />" class="on">${pageNo }</a>
           		<c:if test="${pageNo!=pageCount }">
           			<a href="<c:url value='/infor/toInforChannel.do?typeId=${typeId }&pageNo=${pageNo+1 }' />">${pageNo+1 }</a>
           			<c:if test="${pageNo+1<pageCount }">
           				<strong>...</strong>
           			</c:if>
           			<a href="<c:url value='/infor/toInforChannel.do?typeId=${typeId }&pageNo=${pageNo+1 }' />" class="next">下一页</a>
           		</c:if>
         </div>
      </div>
   </div>
   <div class="rightBox">
       <div class="side_r_ad" style="padding-top:30px;">
          <a href=""><img src="<c:url value='/image/inforlist.jpg '/>"></a>
       </div>
       <h2><span>本月</span>热点</h2>
       <div class="paihang">
          <ul>
          	<c:forEach items="${listInforHot }" var="inforHot" varStatus="status">
          		<li><i 
          			<c:if test="${status.index<3 }">
          				class="top"	
          			</c:if>
          		>${status.index+1 }</i>
          		<a href="<c:url value='/infor/toInforDetail.do?id=${inforHot.id }'/>">${inforHot.title }</a></li>
          	</c:forEach>
          </ul>
       </div>
      
   </div>
</div>
</div>
<div class="clear"></div>
<%@ include file="/common/newfooter.jsp"%>
</body>
</html>