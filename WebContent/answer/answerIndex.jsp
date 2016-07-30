<%@page import="com.anjilang.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String disId = request.getParameter("disId");
char[] numbers = (char[])request.getAttribute("numbers");
String num = "";
String placeNum="";
int size = numbers.length;
for(int i=size-1;i>=0;i--){
	num = num +"<li>" + numbers[i]+ "</li>";
}
if(size<8){
	for(int j=7-size;j>=0;j--){
		placeNum = placeNum + "<li>0</li>";
	}
}
String totalNum = num + placeNum;
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>肾病（老年病、糖尿病）问答-安吉朗健康营养问答</TITLE>
<meta name="keywords" content="安吉朗, 肾病（老年病、糖尿病）问答,公共营养师,">
<meta name="description" content="肾病（老年病、糖尿病）问答，最专业的治疗膳食专家为您解答肾病（老年病、糖尿病）问题，这里有公共营养师和临床营养师为您护航"/>
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
 <LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/reset.css' />" media="screen"> 
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/common.css' />" media="screen"> 
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/secpage.css' />" media="screen"> 
 <LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/index.css' />" media="screen"> 
	
	
<SCRIPT type="text/javascript"
	src="<c:url value='/js/jquery-1.7.2.min.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/util.js' />"></SCRIPT>
<SCRIPT type="text/javascript">

$(function(){
	$(".loadmore").click(function(){
		var loadBtn = $(this);
		var type = $(this).attr("type");
		var pageno = $(this).attr("pageIndex");
		pageno = parseInt(pageno);
		$.ajax({
			type : 'POST',
			url : '<c:url value="/answer/queryAjax.do" />',
			data:{"queryType":type,"pageNo":pageno,"disId":"<%=StringUtil.null2String(disId)%>"},
			cache:false,    
		    dataType:'json',    
		    success:function(data) {
		    	//pageno = data[0].pageCount;
		    	var items = data[0].items;
		    	if(items.length>0){
		    	var templ = ['<ul>',
		    	             '<li class="tit"><a href="<c:url value="/ask/"/>{0}.html">{1}</a></li>',
		    	             '<li class="dels clearfix"><span><img src="<c:url value="/{8}"/>"><p>{2}</p></span>',
							 '<div class="fr_con"><p>{3}</p><p><a href="javascript:void(0);">{4}</a>',
							 '</p></div></li>',	
							 '<li class="bottm clearfix"><span><i></i>发布时间：{5} </span><span>回答（{6}）</span><span>浏览（{7}）</span>',
							 '</li>',
		    	             '</ul>'].join('');
		    	$(items).each(function(){ 
		    		var t = new Date(this.crTime.time);
		    		var formatted = t.Format("yyyy-MM-dd hh:mm:ss");
		    		var titles=this.content;
		    		var tit="";
		    		if(titles<10){
		    			tit=titles;
		    		}else{
		    			tit=titles.substr(0,9);
		    		}
		            var htmlContent = String.format(templ,this.id,tit,this.user.realName,this.content,this.disease.diseaseName,formatted,this.answerNum,this.num,this.user.header);
		            $(loadBtn).parent("h4").before(htmlContent);
		    		}); 
		    	$(loadBtn).attr("pageIndex",pageno + 1);
		    	}
		    	else{
		    		$(loadBtn).html("没有更多");
		    	}
		    	   
		     },    
		     error : function() {    
		          alert("异常！");    
		     }
		});
	})
})

function queryDis(disId){
	console.log("id:" + disId);
	$("#disId").val(disId);
	$("#queryForm").submit();
}


</SCRIPT>

</HEAD>
<body>
<form id="queryForm">
<input type="hidden" id="disId" name="disId"/>
</form>
	<div id="content">
	
		 <%@ include file="/common/newhead.jsp"%> 
		
		<div class="clear"></div>
		<div class="contentBox">
			<div class="hot-site">
				<div class="fl">
					<a href=""><img src="<c:url value='/image/banners.jpg' />"></a>
				</div>
				<div class="fr">
					<div class="ques_total">
						<p>
							今日已解决<i>${ansNumbers}</i>个问题
						</p>
						<p>安吉朗问答已收录问题</p>
						<ul class="clearfix">
						<%=totalNum%>
						</ul>
						<p>现在提问，10分钟内免费解答</p>
					</div>
					
					<div class="btnBox">
					
						<a href="<c:url value="/answer/addQuestion.do" />?disId=<%=disId%>">
						<i>
						</i>
						我要提问
						</a>
					</div>
					
					<div class="label">
						<c:forEach items="${disList }" var="dis">
							<a href="javascript:void(0);" onclick="queryDis(${dis.id})">${dis.diseaseName }</a>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="contentBox">
			<div class="leftBox">
				<div class="nav-title">
					<ul>
						<li class="on">热门问题</li>
						<li>最新问题</li>
						<li>待解答问题</li>
					</ul>
				</div>
				<div class="tab-cont">
					<div id="hotList">
						<c:forEach items="${hotQuestionList}" var="hotQuestion"> 
							<ul>
								<li class="tit"><a href="<c:url value='/ask/'/>${hotQuestion.id}.html">${hotQuestion.title} </a></li>
								<li class="dels clearfix"><span> 
							       <img src="<c:url value='/${hotQuestion.user.header }'/>">
										<p>${hotQuestion.user.realName }</p>
								</span>
									<div class="fr_con">
										<p>${hotQuestion.content }</p>
										<p>
											<a href="javascript:void(0);">${hotQuestion.disease.diseaseName }</a>
										</p>
									</div></li>
								<li class="bottm clearfix"><span><i></i>发布时间：<fmt:formatDate value="${hotQuestion.crTime}" pattern="yyyy-MM-dd HH:mm:ss" /> </span><span>回答（${hotQuestion.answerNum }）</span><span>浏览（${hotQuestion.num }）</span>
								</li>
							</ul>
						</c:forEach>
						
						<h4 id="loadHot">
							<a class="loadmore" type="hotest" pageIndex="2" href="javascript:void(0);">加载更多...</a>
						</h4>
					</div>
					<div style="display: none">
						<c:forEach items="${newQuestionList }" var="newQuestion"> 
							<ul>
							<li class="tit"><a href="<c:url value='/ask/'/>${newQuestion.id}.html">${newQuestion.title}</a></li>
								<li class="dels clearfix"><span> 
								<img src="<c:url value='/${newQuestion.user.header }'/>">
										<p>${newQuestion.user.realName }</p>
								</span>
									<div class="fr_con">
										<p>${newQuestion.content }</p>
										<p>
											<a href="javascript:void(0);">${newQuestion.disease.diseaseName }</a>
										</p>
									</div></li>
								<li class="bottm clearfix"><span><i></i>发布时间：<fmt:formatDate value="${newQuestion.crTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span><span>回答（${newQuestion.answerNum }）</span><span>浏览（${newQuestion.num }）</span>
								</li>
							</ul>
						</c:forEach>
						<h4 id="loadLatest">
							<a class="loadmore" type="latest" pageIndex="2" href="javascript:void(0);">加载更多...</a>
						</h4>
					</div>
					<div style="display: none">
						<c:forEach items="${unQuestionList }" var="unQuestion"> 
							<ul>
							<li class="tit"><a href="<c:url value='/ask/'/>${unQuestion.id}.html">${unQuestion.title}</a></li>
								<li class="dels clearfix"><span> 
									<img src="<c:url value='/${unQuestion.user.header }'/>">
										<p>${unQuestion.user.realName }</p>
								</span>
									<div class="fr_con">
										<p>${unQuestion.content }</p>
										<p>
											<a href="javascript:void(0);">${unQuestion.disease.diseaseName }</a>
										</p>
									</div></li>
								<li class="bottm clearfix"><span><i></i>发布时间：<fmt:formatDate value="${unQuestion.crTime}" pattern="yyyy-MM-dd HH:mm:ss" /> </span><span>回答（${unQuestion.answerNum }）</span><span>浏览（${unQuestion.num }）</span>
								</li>
							</ul>
						</c:forEach>
						<h4 id="loadUnQuestion">
							<a class="loadmore" type="unAnswerd" pageIndex="2" href="javascript:void(0);">加载更多...</a>
						</h4>
					</div>
				</div>
			</div>
			<div class="rightBox">
				<div class="side_r_ad" style="padding-top: 30px;">
					<a href=""><img src="<c:url value='/image/phb.jpg' />"></a>
				</div>
				<h2>
					<span>营养师</span>问答排行榜
				</h2>
				<div class="fig-list">
					<dl class="clearfix">
					</dl>
					<div id="rank">
						<div>
							<ul>
							<c:forEach items="${topUserList}" var="user"> 
								<li><a href=""><img src="<c:url value='/${user.header}'/>"></a>
								<p>
										<a href="">${user.realName}</a>
									</p>
									<p class="det">
										<a href="">${user.hospital} ${user.title}</a>
									</p></li>
									</c:forEach>
									
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
			<div class="clear"></div>
	<%@ include file="/common/newfooter.jsp"%>
	</div>

</body>
</html>