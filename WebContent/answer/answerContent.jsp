<%@page import="com.anjilang.util.StringUtil"%>
<%@page import="com.anjilang.entity.Question"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
Question question = (Question)request.getAttribute("question");
String image = question.getPicture();
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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>${question.title}-安吉朗健康营养问答</TITLE>
<META content="text/html; charset=UTF-8">
<meta name="keywords" content="${question.disease.diseaseName}">
<meta name="description" content="${question.content}"/>
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

<script src="<c:url value='/plus-in/ckeditor/ckeditor.js '/>"></script>

<script type="text/javascript">
$(function(){
	
	//提交问题回答
	$("#submitAnswer").click(function(){
		var content=CKEDITOR.instances.answerinput.getData();
		$.ajax({
			type : 'POST',
			url : '<c:url value="/answer/addAnswer.do" />',
			data:{"questionId":$("#questionId").val(),"content":content},
		    dataType:'json',    
		    success:function(data) {
		    	var questionNum = data.questionNum;
		    	$("#questionNum").html("共"+questionNum +"个医生解答");
		    	data = eval("("+data.answer+")");
		    	// 提交回答成功，更新页面
		    	var templ=['<ul><li class="dels clearfix"><span><img src="<c:url value="/{0}"/>"><p>{1}</p></span>',
		    		'<div class="fr_con">',
		    		'<p class="name"><strong>{1}<em></em></strong>{2}&nbsp;&nbsp;&nbsp;&nbsp;{3}</p>',
		    	'<p class="honor"><a href=""><i></i>TA的主页</a><a href=""><i class="wh"></i>向TA提问</a><a href=""><i class="dh"></i>免费预约</a></p>',
       '<p>{4}</p></div></li><li class="bottm clearfix">',
   '<span><i></i>发布时间：{5} </span><span><a href="javascript:void(0);" answerId="{6}" class="commentBtn">评论</a>（{7}）</span><span><a href="javascript:void(0);">有用</a>（{7}）</span>',
   '<c:if test="${sessionScope[\'type\'] eq 3}"><span><a class="deleteAnsBtn" aid="${6}" href="javascript:void(0);">删除</a></span></c:if>',
   '</li></ul>'].join('');	
		    	var t = new Date(data.crTime);
	    		var formatted = t.Format("yyyy-MM-dd hh:mm:ss");
	    		var usrTitle = data.user.title || "";
	    		var usrhospital = data.user.hospital || "";
		    	var htmlContent = String.format(templ,data.user.header,data.user.realName,usrTitle,usrhospital,data.content,formatted,data.id,data.agreeNum);
		    	$("#answerBox").before(htmlContent);
		    }
		    });
	})
	
	//查询回复
	$(".commentBtn").live("click",function(){
		var answerId = $(this).attr("answerId");
		var replyBox = $(".reply[answerId='" + answerId + "']");
		if($(replyBox).css("display") == "none"){
			$(replyBox).show();
			$.ajax({
				type : 'GET',
				url : '<c:url value="/answer/queryComment.do" />',
				data:{"answerId":answerId},
			    dataType:'json',    
			    success:function(data) {
			    	$(".replyList[answerId='" + answerId + "']").show();
			    	$(".replyList[answerId='" + answerId + "']").empty();
			    
			    	$(data).each(function(){ 
			   var templ = ['<ul id="{5}"><li class="dels clearfix"><span> <img src="<c:url value="/{0}"/>"></span>',
				'<div class="fr_con" style="border: none">',
				'<p class="name">',
				'<strong>{1}</strong>{2}<c:if test="${sessionScope[\'type\'] eq 3}"><a class="fr deleteBtn" id="{5}" href="javascript:void(0);">删除</a></c:if>',
				'</p>',
				'<p>{3}&nbsp;&nbsp;&nbsp;&nbsp;<a class="replyBtn" userName="{1}" answerId="{4}" id="{5}" href="javascript:void(0);">回复</a></p>',
				'</div></li></ul>'].join('');
			   var t = new Date(this.crTime.time);
	    		var formatted = t.Format("yyyy-MM-dd hh:mm");
			    var htmlcontent = String.format(templ,this.user.header,this.user.realName,formatted,this.content,answerId,this.id);
			    $(".replyList[answerId='" + answerId + "']").append(htmlcontent);
			    })
			    }
			    });
		}else{
			$(replyBox).hide();
			if($(".replyList[answerId='" + answerId + "']").length>0){
				$(".replyList[answerId='" + answerId + "']").hide();
			}
			
		}

	})
	//触发回复
	$(".replyBtn").live("click",function(){
		var answerId = $(this).attr("answerId");
		var id = $(this).attr("id");
		var replyForm = $(".replForm[answerId='" + answerId + "']");
		$(replyForm).attr("parentId",id);
		$("html,body").animate({scrollTop: $(replyForm).offset().top}, 500);
		$(replyForm).focus();
	})
	//提交回复
	$(".replySubmit").live("click",function(){
		var answerId = $(this).attr("answerId");
		var parentId = $(".replForm[answerId='" + answerId + "']").attr("parentId");
		var content = $(".replForm[answerId='" + answerId + "']").val();
		
		$.ajax({
			type : 'POST',
			url : '<c:url value="/answer/addAnswerComment.do" />',
			data:{"answerId":answerId,"content":content,"parentId":parentId},
		    dataType:'json',    
		    success:function(data) {
		    	var answerObj =  eval("("+data.answer+")");
		    	var replyHtml = "<a href='javascript:void(0);' answerId='" + answerId + "' class='commentBtn'>评论</a>（"+ answerObj.commentNum+"）";
		    	 $(".replyNumSpan[answerId='" + answerId + "']").html(replyHtml);
		    	
		    	var commentObj =  eval("("+data.comment+")");
		    		   var templ = ['<ul id="{5}"><li class="dels clearfix"><span><img src="<c:url value="/{0}"/>"></span>',
		    						'<div class="fr_con" style="border: none">',
		    						'<p class="name">',
		    						'<strong>{1}</strong>{2}<c:if test="${sessionScope[\'type\'] eq 3}"><a class="fr deleteBtn" id="{5}" href="javascript:void(0);">删除</a></c:if>',
		    						'</p>',
		    						'<p>{3}&nbsp;&nbsp;&nbsp;&nbsp;<a class="replyBtn" answerId="{4}" href="javascript:void(0);">回复</a></p>',
		    						'</div></li></ul>'].join('');
		    					   var t = new Date(commentObj.crTime);
		    			    		var formatted = t.Format("yyyy-MM-dd hh:mm");
		    					    var htmlcontent = String.format(templ,commentObj.user.header,commentObj.user.realName,formatted,commentObj.content,answerId,commentObj.id);
		    					    $(".replyList[answerId='" + answerId + "']").append(htmlcontent);
		    }
		    });
		
	})
	//点赞
	$(".agreeBtn").live("click",function(){
		var answerId = $(this).attr("answerId");
		$.ajax({
			type : 'POST',
			url : '<c:url value="/answer/addAnswerAgreeNum.do" />',
			data:{"answerId":answerId},
		    dataType:'json',    
		    success:function(data) {
		    	var replyHtml = "<a href='javascript:void(0);' answerId='" + answerId + "' class='agreeBtn'>有用</a>（"+ data.answerNum+"）";
		    	 $(".agreeNumSpan[answerId='" + answerId + "']").html(replyHtml);
		    	}
		    })
		
	})
	
	//删除回复
	$(".deleteBtn").live("click",function(){
		var id = $(this).attr("id");
		$.ajax({
			type : 'POST',
			url : '<c:url value="/answer/deleteAnswerComment.do" />',
			data:{"id":id},
		    dataType:'json',    
		    success:function(data) {
		    	console.log("data:" + data);
		    	if(data.result === "1"){
		    		$("ul[id='" + id + "']").remove();
		    	}
		    	}
		    })
		
	})
	
	//删除问题
	$("#deleteAnsBtn").live("click",function(){
		var id = $(this).attr("aid");

		$.ajax({
			type : 'POST',
			url : '<c:url value="/answer/deleteQuestion.do" />',
			data:{"id":id},
		    dataType:'json',    
		    success:function(data) {
                window.location = "<c:url value='/answer/index.do'/>";
		    	}
		    })
	})
	
	//删除回答
	$(".deleteAnsBtn").live("click",function(){
		var id = $(this).attr("aid");

		$.ajax({
			type : 'POST',
			url : '<c:url value="/answer/deleteAnswer.do" />',
			data:{"id":id},
		    dataType:'json',    
		    success:function(data) {
                window.location.reload();
		    	}
		    })
	})
	
	// 字数限制
	/* var limitNum = 300; 
	var pattern = '还可以输入' + limitNum + '字'; 
	$('#answerTips').html(pattern); 
	$('#answerinput').keyup( 
	function() { 
	var remain = $(this).val().length; 
	if (remain > limitNum) { 
	pattern = "<font color='red'>字数超过限制，请适当删除部分内容</font>";
	} 
	else { 
	var result = limitNum - remain; 
	pattern = '还可以输入' + result + '字'; 
	} 
	$('#answerTips').html(pattern); 
	} 
	); 
	
	$('.replForm').keyup( 
			function() { 
			var remain = $(this).val().length;
			var answerId = $(this).attr("answerId");
			var commentTip = $(".commentTip[answerId='" + answerId + "']");
			if (remain > limitNum) { 
			pattern = "<font color='red'>字数超过限制，请适当删除部分内容</font>";
			} 
			else { 
			var result = limitNum - remain; 
			pattern = '还可以输入' + result + '字'; 
			} 
			$(commentTip).html(pattern); 
			} 
			); */ 
})
</script>
</HEAD>
<body>
<input id="questionId" type="hidden" value="${question.id}"/>
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
						<a href="<c:url value="/answer/addQuestion.do" />"><i></i>我要提问</a>
					</div>
					<div class="label">
						<c:forEach items="${disList}" var="dis">
							<a href="javascript:void(0);" onclick="queryDis(${dis.id})">${dis.diseaseName }</a>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
<div class="contentBox">
   <div class="leftBox">
        <div class="tab-cont">
            <ul>
           <li class="tit qus">${question.title}</li>
<li class="dels clearfix">
    <span>
       <img src="<c:url value='/${question.user.header }'/>">
       <p>${question.user.realName}</p>
    </span>
    <div class="fr_con">
       <p>${question.content}</p>
      <div class="showimg">
         <a href="#answerinput" class="btn">回答</a>
         <%
         if(!StringUtil.isEmpty(image)){
        	 String[] images = image.split(",");
         for(int i=0;i<images.length;i++){ %>
         <a href=""><img src="<%=request.getContextPath()+"/"+images[i]%>"></a>
         <%}} %>
         </div>
      </div> 
</li>
<li class="bottm note clearfix">
   <em>${question.disease.diseaseName}</em><span><i></i>发布时间：<fmt:formatDate value="${question.crTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span><span>回答（${question.answerNum}）</span><span>浏览（${question.num}）</span>
   <c:if test="${sessionScope['userId'] eq question.user.id}">
   <span><a id="deleteAnsBtn" aid="${question.id}" href="javascript:void(0);">删除</a></span>
   </c:if>
    <c:if test="${sessionScope['userId'] eq question.user.id}">
   <span><a target="_blank" href="<c:url value="/answer/toModifyQuetion.do?id=${question.id}"/>">修改</a></span>
   </c:if> 
</li>
        </ul>
        <div class="ask clearfix">
           <span class="fl" id="questionNum">共${question.answerNum}个医生解答</span>
          <!--  <span class="fr">分享到： </span> -->
           <span class="fr bdsharebuttonbox"> <a href="#" class="bds_more" data-cmd="more" style="background:none!important;">分享到：</a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></span>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"16"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
        </div>
        
        <c:forEach items="${question.answers}" var="answer">
         <ul>
		<li class="dels clearfix">
    	<span>
       <img src="<c:url value='/${answer.user.header }'/>">
       <p>${answer.user.realName}</p>
    </span>
    <div class="fr_con">
       <p class="name"><strong>${answer.user.realName}<em></em></strong>${answer.user.title}&nbsp;&nbsp;&nbsp;&nbsp;${answer.user.hospital}</p>
       <p class="honor"><a target="_blank" href="<c:url value='/personPage/toPersonPageIndex.do?userId=${answer.user.id}' />"><i></i>TA的主页</a><a target="_blank" href="<c:url value="/answer/addQuestion.do?doctorUserId=${answer.user.id}" />"><i class="wh"></i>向TA提问</a><a href=""><i class="dh"></i>免费预约</a></p>
       <p>${answer.content}</p>      
      </div> 
</li>
<li class="bottm clearfix">
   <span><i></i>发布时间：<fmt:formatDate value="${answer.crTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span><span class="replyNumSpan" answerId="${answer.id}"><a href="javascript:void(0);" answerId="${answer.id}" class="commentBtn">评论</a>（${answer.commentNum}）</span><span class="agreeNumSpan" answerId="${answer.id}"><a class="agreeBtn" answerId="${answer.id}" href="javascript:void(0);">有用</a>（${answer.agreeNum}）</span>   
   <c:if test="${sessionScope['type'] eq 3}">
   <span><a class="deleteAnsBtn" aid="${answer.id}" href="javascript:void(0);">删除</a></span>
   </c:if>
</li>						
							<div answerId="${answer.id}" class="writeBox reply" style="display:none;">
								<textarea class="replForm" answerId="${answer.id}"></textarea>
								<span answerId="${answer.id}" class="commentTip">0/300字</span><a answerId="${answer.id}" href="javascript:void(0);" class="btn replySubmit">回复</a>
							</div>
							<div class="replyList" answerId="${answer.id}"></div>
						</ul>
        </c:forEach>
	<c:if test="${sessionScope['type'] eq 1}">
        <h2 id="answerBox">我要回答</h2>
        <div class="writeBox big">
           <textarea id="answerinput" placeholder="做为一名营养师，请您用您的专业认真对待每一位患者..."></textarea>
           <script type="text/javascript">
           
           CKEDITOR.replace('answerinput');
           
           
           </script>
           <span id="answerTips" style="display: none">0/300字</span><a href="javascript:void(0);" id="submitAnswer" class="btn">提交回答</a>
        </div>
       </c:if>
        </div>
   </div>
   <div class="rightBox">
      <div style="padding-top:15px;" class="side_r_ad">
          <a href=""><img src="<c:url value='/image/inforlist.jpg '/>"></a>
       </div>
       <h2><span>相关</span>问题</h2>
       <div class="infor_list">
          <ul>
          
          <c:forEach items="${questionList}" var="relateQuest">
             <li><a style="text-overflow: ellipsis;overflow:hidden;white-space:nowrap;" href="<c:url value='/ask/'/>${relateQuest.id}.html" title="${relateQuest.title}">${relateQuest.title}</a></li>
          </c:forEach>
          </ul>
       </div>
   </div>
</div>
<div class="clear">
</div>
<%@ include file="/common/newfooter.jsp"%>
</div>

</body>
</html>