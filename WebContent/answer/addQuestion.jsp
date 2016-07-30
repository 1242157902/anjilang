<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String disId = request.getParameter("disId");
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>安吉朗健康问答-安吉朗网</TITLE>
<META content="text/html; charset=UTF-8">
<meta name="keywords" content="糖尿病问答,肾病问答,营养师问答,老年病问答,">
<meta name="description" content="安吉朗健康问答，最专业的治疗膳食专家为您解答糖尿病问题、肾病问题、老年病问题，我们的营养师有问必答！"/>
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/reset.css' />" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/common.css'/>" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/secpage.css'/>" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/index.css'/>" media="screen">
<SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js'/>"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js'/>"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/util.js' />"></SCRIPT>
<script type="text/javascript" src="<c:url value='/js/ajaxfileupload.js' />"></script>
<script type="text/javascript">


function ajaxFileUpload() {
	var picNum = parseInt($("#picNum").html(),10);
	var total = parseInt($("#total").html(),10);
	if(picNum == 5){
		alert("您插入的图片数量已达到上限！");
		return false;
	}
    $.ajaxFileUpload({
        url: '<c:url value="/upload/image.do?path=head&contentType=text/html" />', 
        type: 'post',
        secureuri: false, //一般设置为false
        fileElementId: 'file', // 上传文件的id、name属性名
        dataType: 'text', //返回值类型，一般设置为json、application/json
        success: function(data, status){  
        	data = jQuery.parseJSON(jQuery(data).text());
            if(data!=null && data.code=='0') {
            	
            	var templ = ['<li><img width="78" height="78" src="<c:url value="/{0}"/>"><i class="delimg"></i></li>'].join('');
            	var htmlContent = String.format(templ,data.path);
            	$(".add_pic").before(htmlContent);
            	var picture = $("#picture").val();
            	picture = picture + data.path + ",";
            	$("#picture").val(picture);
            	$("#picNum").html(picNum + 1);
            	$("#total").html(total-1);
            	if(picNum == 4){
            		$(".pic_ismore").show();
            	}
            }
        },
        error: function(data, status, e){ 
            alert(e);
        }
    });
}

$(function(){
$("#submit").click(function(){
	var picture = $("#picture").val();
	if(picture != "" && picture.length>0){
		picture = picture.substring(0,picture.length-1);
	}
	$("#picture").val(picture);
	$("#subForm").submit();
})

$(".delimg").live("click",function(){
	var picNum = parseInt($("#picNum").html(),10);
	var total = parseInt($("#total").html(),10);
	$(this).parent().remove();
	$("#picNum").html(picNum -1);
	$("#total").html(total+1);
	$(".pic_ismore").hide();

})
})
</script>

</HEAD>
<body>
<div id="content">
<%@ include file="/common/newhead.jsp"%>
<div class="clear"></div>
<div class="tool_ask_tit">
   <h3>向营养师提问</h3>
</div>
<div class="contentBox">
<form id="subForm" action="addNewQuestion.do" method="post">
<div class="leftBox">
<h2><span>问题</span>分组</h2>
<select id="disId" name="disId" style="height: 30px;">
	<c:forEach items="${diseaseList }" var="disease">
		<option value="${disease.id }">
			${disease.diseaseName }
		</option>
	</c:forEach>
</select>

<h2><span>问题</span>标题</h2>
<input type="text" class="txt" name="title" style="height: 32px;width:768px;"/>
   <h2><span>问题</span>详细内容</h2>
   
   <div class="tool_ask_box">
   <div class="tool_ask_textarea">
       <textarea name="content"></textarea>
       <div class="tool_ask_uploadbar">
          <span class="fr">(0/1000字)</span><a  href="javascript:;"><em></em>上传照片</a>
       </div>
       <div class="tool_upload_box">
          <i class="jt_up"></i>
          <a class="x_close" href="javascript:;">X</a>
          <p class="pic_count">共 <span id="picNum">0</span> 张，还能上传 <span id="total">5</span> 张</p>
          <p class="pic_ismore" style="display:none;">您插入的图片数量已达到上限</p>
          <ul class="pic_list clearfix">
            <li class="add_pic add_pic_tool">
            <form id="uploadTool">
               <input type="file" onchange="ajaxFileUpload()" hidefocus="true" accept="image/*" name="file" id="file" >
               <input type="hidden" id="YII_TOKEN" name="YII_CSRF_TOKEN">
            </form>
            </li>
          </ul>
       </div>
   </div>
   <input type="hidden" id="picture" name="picture"/>
   <input type="hidden" id="doctorUserId" name="doctorUserId" value="${doctorUserId }"/>
   <div class="tool_ask_message"><a id="submit" href="#">发布问题</a></div>
   </div>
</div>
</form>
<div class="rightBox">
   <div class="aside_r_doc">
        <h2><span>${totelDoc }名</span>认证医生在线</h2>
        <p class="mar_t15">执业医生在线解答，<span class="cl_f53">${totelQuestion }</span>个问题，<span class="cl_f53">${totelDoc }</span>名认证医生，<span class="cl_f53">100%</span>回答率，为您提供整形美容专业咨询。</p>
        <ul class="aside_r_doclist clearfix">
	        <c:forEach items="${userList }" var="usert">
	            <li>
	                 <div class="item_doc" >
	                      <a href="" target="_blank"><img src="<c:url value='/${usert.header }' />"></a>
	                      <div class="doc_intro"><span>${usert.realName }</span><em>${usert.hospital }</em><a href="<c:url value='/personPage/toPersonPageIndex.do?userId=${usert.id}' />"></a></div>
	                 </div>
	            </li>
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