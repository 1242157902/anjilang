<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>安吉朗资讯-${information.title }</TITLE>
<META content="text/html; charset=UTF-8">
<META name="description" content="">
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
<div class="contentBox">
	<div class="route">
         <em></em>
         <a href="<c:url value='/infor/toInforChannel.do?typeId=0' />">资讯</a>&gt;
         <a href="<c:url value='/infor/toInforChannel.do?typeId=${informationType.id }' />">${informationType.title }</a>&gt;
         <a href="">${information.title }</a>
    </div>
    
    <div class="route">
      </div>
      <div class="article">
          <div class="titBox">
              <em></em>${information.title }
          </div>
          <div class="time">
             <span class="sj">更新时间：${information.crTime }</span>
            <span class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></span>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
          </div>
      </div>
</div>
<div class="contentBox">
   <div class="leftBox">
      <div class="detail_con">
         ${information.content }
      </div>
      <div class="prompt_Box">
          <p>免责申明：</p>
          <p>文章内容摘自互联网，该文内容的刊登出于更多信息和学习之目的，并不意味着我们对此内容的证实或赞同。如转载稿涉及版权等问题，请立即联系管理员，我们会更改或删除相关文章，保证您的权利。</p>
      </div>
      <div class="art_lrnt">
         <span class="fl">上一篇：
         	<c:choose>	
         		<c:when test="${informationPrev!=null }">
		         	<a href="<c:url value='/infor/toInforDetail.do?id=${informationPrev.id }'/>">${informationPrev.title }</a>
         		</c:when>
         		<c:otherwise>
         			无
         		</c:otherwise>
         	</c:choose>	
         </span>
         <span class="fr">下一篇：
         	<c:choose>	
         		<c:when test="${informationNext!=null }">
		         	<a href="<c:url value='/infor/toInforDetail.do?id=${informationNext.id }'/>">${informationNext.title }</a>
         		</c:when>
         		<c:otherwise>
         			无
         		</c:otherwise>
         	</c:choose>	
         
         </span>
      </div>
   </div>
   <div class="rightBox">
       <div class="side_r_ad" style="padding-top:30px;">
          <a href=""><img src="<c:url value='/image/inforlist.jpg ' />"></a>
       </div>
       <h2><span>最新</span>热点</h2>
       <div class="paihang">
          <ul>
             <c:forEach items="${listInforHot }" var="inforHot" varStatus="status">
          		<li><i 
          			<c:if test="${status.index<3 }">
          				class="top"	
          			</c:if>
          		>${status.index+1 }</i><a href="<c:url value='/infor/toInforDetail.do?id=${inforHot.id }'/>">${inforHot.title }</a></li>
          	</c:forEach>
          </ul>
       </div>
   </div>
</div>
</div>
<div class="clear"></div>
<div id="footer">
<%@ include file="/common/newfooter.jsp"%>
</div>
</body>
</html>