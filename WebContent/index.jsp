<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html  >
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="安吉朗,治疗膳食,营养师,公共营养师,">
<meta name="description" content="安吉朗（angelaround.com），最专业的治疗膳食专家.由最专业的营养师提供为肾病、糖尿病、老年病等患者提供最合理的治疗膳食方案！"/>
<meta property="qc:admins" content="245624377761675412756463757" />
<meta property="wb:webmaster" content="68029bccc5747e2d" />
<title>安吉朗</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newindex.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/my.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/newcommon.js"></script>
<style type="text/css">
   br{
   display:none;
   }
</style>
</head>
<body>
<%@ include file="/common/indexhead.jsp"%>
       <div class="xq">
       <div class="xq-bg"></div>
         <ul>
             <li class="first">
                 <span></span>
                  <h3><a href="#">商品特价</a></h3>
                 <p><a href="#">真粒米&nbsp;   透罗咪 &nbsp;  加钙饼干</a></p>
                 <div class="first-r"></div>
             </li>
             <li class="second">
                 <span></span>
                  <h3><a href="<c:url value='/patientGroup/groupdetail.do?groupid=23'/>">患友会</a></h3>
                 <p><a href="">患友会　肾友会　老友会</a></p>
                 <div class="second-r"></div>
             </li>
             <li class="third">
                 <span></span>
                <h3><a href="#">最新活动</a></h3>
                 <p><a href="#">最新的线上线下活动</a></p>
                 <div class="third-r"></div>
             </li>
             <li class="four">
                 <span></span>
                  <h3><a href="#">私人订制</a></h3>
                 <p><a href="#">您营养健康的私人订制</a></p>
                 <div class="four-r"></div>
             </li>
             <li class="fifth">
                 <span></span>
                  <h3><a href="#">每日食谱</a></h3>
                 <p><a href="#">健康营养食谱</a></p>
                 <div class="fifth-r"></div>
             </li>
             <li class="sixth">
                 <span></span>
                  <h3><a href="#">全球合作伙伴</a></h3>
                 <p><a href="#">全球多达132家合作企业</a></p>
                 <div class="sixth-r"></div>
             </li>
             
         </ul>
       </div>
     </div>
     
</div>
<!--banner-->



<div class="banner">
     <div class="pic1">
       <!--<a href="javascript:void(0);" class="left"></a>-->
		<a href="javascript:;" class="right"></a>
		<ul>
		
		 <c:forEach items="${tablepic}" var="pic" >
		
		
			<li class="hero">
			<a href="${pageContext.request.contextPath}/${pic.accessUrl}"><img src="${pageContext.request.contextPath}/${pic.picUrl}"    /></a>
			
			</li>
			
			</c:forEach>
			
			
			
		</ul> 
        <ol>
         <li class="current"></li>
         <li></li>
         <li></li>
         <li></li>
        </ol>  
		
	 </div>
	 
	 
	 
	 
      
   <div class="fresh">
	<ul>
		<li class="fresh-one">
			<img src="${pageContext.request.contextPath}/images/sign.png" class="btn" />
			<h3>新鲜事：</h3>
			<p>刚刚21位安安加入肾友会</p>
			<p class="cdff">肾病患者应该注意如何日常饮食？是遵循低蛋白</p>
		</li>
		<li class="fresh-one1">
			<img src="${pageContext.request.contextPath}/images/sign.png" class="btn" />
			<h3>新鲜事：</h3>
			<p>刚刚21位安安加入肾友会</p>
			<p class="cdff">肾病患者应该注意如何日常饮</p>
		</li>
		<li class="fresh-one2">
			<img src="${pageContext.request.contextPath}/images/sign.png" class="btn" />
			<h3>新鲜事：</h3>
			<p>刚刚21位安安加入肾友会</p>
			<p class="cdff">肾病患者应该注意如何日常饮</p>
		</li>
	</ul>
	<p class="close">[ 关闭 ]</p>
</div> 
</div>   
<!--焦点下部导航-->
<div class="friends">
          <div class="friends-in">
          <ul>
          <li class="tu1">
                 <h3><a href="#">肾病通道</a></h3>
                <p>肾病专家/患者研讨<br />患者交流及饮食健康</p>
             </li>
             <li class="tu2">
                <h3><a href="#">老年病通道</a></h3>
                <p>肾病专家/患者研讨<br />患者交流及饮食健康</p>
             </li>
             <li class="tu3">
                <h3><a href="#">糖尿病通道</a></h3>
                <p>肾病专家/患者研讨<br />患者交流及饮食健康</p>
             </li>
             <li class="tu4">
               <h3><a href="#">孕妇通道</a></h3>
                <p>肾病专家/患者研讨<br />患者交流及饮食健康</p>
             </li>
          </ul>
          </div>
     </div>
<!--精选商城-->
<div id="the main">
<div class="mall">
 <div class="mall-top">
  <h2>精选商城</h2>
  <!-- <div class="mall-top-r">
   <ul>
     <li><a href="#">肾病　丨　</a></li>
     <li><a href="#">糖尿病　丨　</a></li>
     <li><a href="#">老年病　丨　</a></li>
     <li><a href="#">全部 ></a></li>
   </ul>
   
   </div> -->
  </div>
  
   <div class="mall-bottom">
   
   <ul style="display:block;">
   
   	 <c:forEach items="${shoppic}" var="spic" begin="0" end="4" >
     <li class="first">
       <img src="${pageContext.request.contextPath}/${spic.picUrl}" />
       <p>${spic.productname }</p>
       <div class="mall-jg">
     <div class="mall-jg-l"> 
        <p> <span>¥${spic.nowprice}</span></p>
         <del>¥${spic.pastprice}</del>
     </div>
    <div class="mall-jg-r">
       <p><a href="${spic.accessUrl}">去抢 ></a></p>
    </div>
    
    </div>
    <div class="mall-jg-sy">
      <span>剩余${spic.overplus}件</span>
      <span class="agent">${spic.typename }</span>
    </div>
     </li>
    </c:forEach>
  
   </ul>
   
   
   
   
   
   
</div>
</div>
    <!--患友会-->

 <div class="patients">
     <!--  <div class="patients-top">
        
      </div> -->
      <div class="patients-bottom">
      <div class="patients-bottom-top">
        <h2>患友会</h2>
        <img src="${pageContext.request.contextPath}/images/patients-b.png" />
      </div>
      <div class="patients-bottom-b">
       <div class="major1">
		<a href="javascript:void(0);" class="lt"></a>
		<a href="javascript:;" class="rt"></a>
		<ul>
		<c:forEach   var="picTopics"  items="${picTopics }"  begin="0"  end="2">
			<li style="display:block;"><a href="<c:url value='/GroupTopic/detail.do?id=${picTopics.id }&groupid=${picTopics.patientGroup.id }'/>"><img src="${pageContext.request.contextPath}/${picTopics.articlepic}"  alt="" /></a></li>
		</c:forEach>	
		</ul>
		<ol>
		<c:forEach   var="picTopics"  items="${picTopics }"   begin="0"  end="2">
			<li class="current"></li>
			
		</c:forEach>		
		</ol>
	</div>

	
       
      
        <div class="major2">
         <div class="major2-top">
         <c:forEach  var="artTopics"  items="${artTopics }"  begin="0"  end="0">
         <h2><c:set var="string" value="${fn:substring(artTopics.title, 0, 20)}" />${string }</h2>
         <p ><c:set var="string1" value="${fn:substring(artTopics.content, 0, 75)}" />${string1 } <a href="<c:url value='/GroupTopic/detail.do?id=${artTopics.id }&groupid=${artTopics.patientGroup.id }'/>">  <span>详情</span></a></p>
         </c:forEach>
         </div>
         <ul>
         <c:forEach  var="newTopics"  items="${newTopics }"  begin="0"  end="7">
           <li><a href="<c:url value='/GroupTopic/detail.do?id=${newTopics.id }&groupid=${newTopics.patientGroup.id }'/>"><span>${newTopics.patientGroup.groupname }丨</span><c:set var="string" value="${fn:substring(newTopics.title, 0, 15)}" />${string }</a></li>
           
        </c:forEach>   
         </ul>
         <ol>
         <c:forEach  var="newTopics"  items="${newTopics }"  begin="0"  end="7">
           <li><fmt:formatDate value="${newTopics.createtime }" pattern="yyyy"/>年走起</li>
        </c:forEach>
         </ol>
        </div>
        <div class="major3">
          <div class="major3-top">
          <h2>活跃小组</h2>
        <!--   <p>更多>></p> -->
         
          </div>
          <ul>
           <c:forEach  var="groups"  items="${patientGroups }"  varStatus="loop"   begin="0"    end="2"  >
            <li>
              <img src="<c:url value='/${groups.picurl }'/>" />
              <h3>${groups.groupname }</h3>
              <p> <c:set var="string" value="${fn:substring(groups.description, 0, 15)}" />${string }...</p><br/>
              <span >发布人：${groupuser[loop.count-1].realName}</span>
           
             
            </li>
            </c:forEach>
          </ul>
        </div>
      </div>
        
   </div>     
 </div>

<!--营养师问答-->
 <%-- <div class="dietitian">
   <div class="dietitian-top">
   <h2>营养师问答</h2>
   <img src="${pageContext.request.contextPath}/images/dietitian-top-r.png" />
   </div>
   <div class="dietitian-bottom">
    <div class="dietitian-bottom-main1">
     <div class="top-min">
		<a href="javascript:void(0);" class="left"></a>
		<a href="javascript:;" class="right"></a>
		<ul>
			<li style="display:block;"><a href="#"><img src="${pageContext.request.contextPath}/images/spot.jpg"  alt="" /></a></li>
			<li><a href="#"><img src="${pageContext.request.contextPath}/images/major1.jpg"  alt="" /></a></li>
			<li><a href="#"><img src="${pageContext.request.contextPath}/images/spot.jpg"  alt="" /></a></li>
			
		</ul>
		<ol>
			<li class="current"></li>
			<li></li>
			<li></li>
			
		</ol>
	</div>
     <h2>网友热问</h2>
     
   <div class="shb"  id="show">
   <ul>
  	 <c:forEach items="${diseaseList }" var="disease" varStatus="status">
		<li 
			<c:if test="${status.index==0 }">
						class="one1"
					</c:if>
		>
			<c:if test="${status.index==0 }">
				<span></span>
			</c:if>
          	  ${disease.diseaseName }  </li>
	</c:forEach>
 <!--      <li class="one4"> 其他综合征</li> -->
    </ul>
    </div>
    <br/>
    <br/>
    <br/>
    <div style="white-space: nowrap;">
    	<p><span></span><a href="#">关注：老年人的营养膳食怎么搭配</a></p>
    </div>
    </div>
    <div class="dietitian-bottom-main2"   id="wds" >
        <c:forEach var="questlists" items="${lists }" varStatus="questStatus">
      	<c:choose>	
      		<c:when test="${questStatus.index  ==0 }">
      		<div class="ii">
      			<ul>
      			     <c:forEach var="quest" items="${questlists }" varStatus="qStatus">
					      	<c:choose>	
					      		<c:when test="${qStatus.index ==0 }">
					      			<h3 style="color:#039BF1;"><a href="<c:url value='/answer/answer.do?questionId=${quest.id }' />">${fn:substring(quest.content, 0, 18)}...</a></h3>
					      		</c:when>
					      		<c:otherwise>
					      				<li><span><p>${qStatus.index  }</p></span><a href="<c:url value='/answer/answer.do?questionId=${quest.id }' />">${fn:substring(quest.content, 0, 18)}.....</a></li> 
					      		</c:otherwise>
					      	</c:choose>
					 </c:forEach>
					</ul>
					<ol>
							     <c:forEach var="quest" items="${questlists }" varStatus="qStatus">
							      	<c:choose>	
							      		<c:when test="${qStatus.index ==0 }">
							      			 <li></li><br/>
							      		</c:when>
							      		<c:otherwise>
							      			<li><span></span>${quest.crTime }</li>
							      		</c:otherwise>
							      	</c:choose>
							 </c:forEach>
					</ol>
				</div>
      		</c:when>
      		<c:otherwise>
      		<div  class="clearfirx" style="display: none">
      			<ul>
							 <c:forEach var="quest" items="${questlists }" varStatus="qStatus">
												      	<c:choose>	
												      		<c:when test="${qStatus.index ==0 }">
												      			<h3><a href="<c:url value='/answer/answer.do?questionId=${quest.id }' />">${fn:substring(quest.content, 0, 18)}...</a></h3>
												      		</c:when>
												      		<c:otherwise>
												      			<li><span><p>${qStatus.index  }</p></span><a href="<c:url value='/answer/answer.do?questionId=${quest.id }' />">${fn:substring(quest.content, 0, 18)}.....</a></li> 
												      		</c:otherwise>
												      	</c:choose>
												 </c:forEach>
					</ul>
					<ol>
							     <c:forEach var="quest" items="${questlists }" varStatus="qStatus">
							      	<c:choose>	
							      		<c:when test="${qStatus.index ==0 }">
							      			 <li></li><br/>
							      		</c:when>
							      		<c:otherwise>
							      			<li><span></span>${quest.crTime }</li>
							      		</c:otherwise>
							      	</c:choose>
							 </c:forEach>
					</ol>
      		</div>
      		</c:otherwise>
      	</c:choose>
      </c:forEach>
       <ol>
      		 <c:forEach var="questlists" items="${lists }" varStatus="questStatus">
		    <c:if test="${questStatus.index  ==0 }">
					 <c:forEach var="quest" items="${questlists }" varStatus="qStatus">
							<li><span></span>${quest.crTime }</li> 
					</c:forEach>
		    </c:if>
	</c:forEach>
	 </ol>    
      <div class="dietitian-bottom-wade">
        <dl>
           <dt class="first"><img src="${pageContext.request.contextPath}/images/wade1.jpg" /></dt>
           <dd class="firsts">人民日报</dd>
        </dl>
        <dl>
           <dt><img src="${pageContext.request.contextPath}/images/wade1.jpg" /></dt>
           <dd>人民日报</dd>
        </dl>
        <dl>
           <dt><img src="${pageContext.request.contextPath}/images/wade1.jpg" /></dt>
           <dd>人民日报</dd>
        </dl>
        <dl>
           <dt><img src="${pageContext.request.contextPath}/images/wade1.jpg" /></dt>
           <dd>人民日报</dd>
        </dl>
      </div>
    </div>
    <div class="dietitian-bottom-main3">
      <div class="ietitian">
      <h2>营养师专栏</h2>
      <p><a href='<c:url value="/dietican/index.do"/> '>专栏首页>></a></p>
      </div>
      <img src="${pageContext.request.contextPath}/images/cp10.jpg" />
      <p id="expert">和专家一起面对面</p>
      <p>我们带给您的不仅仅是食品，是健康，是您合理的膳食安排，帮助您跟各种疾病做斗争，让您在治疗的同事，依然感到快乐。</p>
    </div>
   </div>
</div> --%>
<!--最新资讯-->
<div class="consultation">
<div class="consultation-top">
<h2>最新资讯</h2>
<img src="${pageContext.request.contextPath}/images/contion.png" />
</div>
<div class="consultation-bottom">
  <div class="hotspot1">
    
     <a href="javascript:void(0);" class="let"></a>
		<a href="javascript:;" class="rit"></a>
		<ul>
		
		 <c:forEach items="${inforTypeList}" var="zixun"  begin="0" end="2">
		
			<li><a href="${pageContext.request.contextPath}/${zixun.url}"><img src="${pageContext.request.contextPath}/${zixun.picture}"  alt="${zixun.detailTitle}" /></a></li>
			
		</c:forEach>	
		</ul>
		<ol>
			<li class="current"></li>
			<li></li>
			<li></li>
			
		</ol>
  </div>
  <div class="hotspot2">
    <div class="hotspot2-top">
      <c:forEach items="${inforTypeList }" var="inforType"  begin="0" end="0">
       <h2>${inforType.title}</h2>
       <c:choose>
				<c:when test="${fn:length(inforType.detailContent) > 60}">
							<p style="text-indent:2em;"><c:out value="${fn:substring(inforType.detailContent, 0, 60)}......" /> <span><a  href="http://localhost:8080/anjilang/infor/toInforDetail.do?id=51">详情</a></span></p>
				</c:when>
				<c:otherwise>
							<p style="text-indent:2em;">${inforType.detailContent }<span><a  href="${inforType.url}">详情</a></span></p>
				</c:otherwise>
		</c:choose>
		        
    </c:forEach>
		
    </div>
    <ul>
   <c:forEach items="${inforTypeList }" var="inforType" >
    <li><a href="${pageContext.request.contextPath}/${inforType.url}"><span>${inforType.title}丨</span> ${inforType.detailTitle }</a></li>
    </c:forEach>
    </ul>
      <ol>
	    <c:forEach items="${inforTypeList }" var="inforType"  varStatus="s">
	    <li>2015年 ${s.index+1 }月</li>
	    </c:forEach>
    </ol>
  </div>
  <div class="hotspot3">
   <!--  <div class="hotspot3-top"> -->
    <%-- <h2>最新热点</h2>
<!--     <ol>
      <li><a href="#">日</a></li>
      <li><a href="#">周</a></li>
      <li><a href="#">月</a></li>
    </ol> -->
     <p style="float:right;"><a href='<c:url value="/dietican/index.do"/> '>专栏>></a></p>
    </div>
    
    
    <div class="hotspot3-in"> --%>
    
    	<%-- <c:forEach items="${inforList }" var="infor"  varStatus="status"  >
    			<c:choose>
					<c:when test="${fn:length(infor.title) > 15}">
								<li><span><p>${status.index+1 }</p></span><a href="<c:url value='/infor/toInforDetail.do?id=${infor.id }'/>"><c:out value="${fn:substring(infor.title, 0, 15)}......" /></a></li>
					</c:when>
				<c:otherwise>
								<li><span><p>${status.index+1 }</p></span><a href="<c:url value='/infor/toInforDetail.do?id=${infor.id }'/>">${infor.title }</a></li>
				</c:otherwise>
			</c:choose>
    	</c:forEach> --%>
    
  <%-- <ul>
    <c:forEach var="questlists" items="${lists}" begin="0" end="0">
           <c:forEach var="quest" items="${questlists}" varStatus="qStatus" begin="0" end="9" >
					 
					      	
	 <li>
	 <span><p>${qStatus.index+1}</p></span>
	  <a href="<c:url value='/answer/answer.do?questionId=${quest.id }' />">
	       ${fn:substring(quest.content, 0, 15)}.....
	  </a>
	</li>		      		
					      
           </c:forEach>
	  </c:forEach>
    	
  </ul> --%>
    
    
    <div class="dietitian-bottom-main3">
      <div class="ietitian">
      <h2>营养师专栏</h2>
      <p><a href='<c:url value="/dietican/index.do"/> '>专栏首页>></a></p>
      </div>
      <a href="${spec.url}"><img src="${pageContext.request.contextPath}/${spec.pic}" /></a>
      <a href="${spec.url}"><p id="expert">${spec.title }</p></a>
      <a href="${spec.url}"><p>${spec.content }</p></a>
    </div>
    
    
    
    
    
    
    
   
    </div>
  </div>
</div>
</div>

</div>
<!-- 找营养师 -->
<%-- <div class="nutritionists">
   <c:forEach items="${userList }" var="user"    >
   	 <div class="nutritionists-1">
   		 <span><a href="${dpic.accessUrl }"  target="_blank" ><img src="<c:url value='/${dpic.picUrl } '/>"></a></span>
   		  <h3><a href="<c:url value='/personPage/toPersonPageIndex.do?userId=${user.id}' />">${user.realName }</a></h3>
    	 <p>${user.hospital } </p>
	   </div>
   	</c:forEach>
 </div> --%>
<%@ include file="/common/newfooter.jsp"%>
</body>
</html>
