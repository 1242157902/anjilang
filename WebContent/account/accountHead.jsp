<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.anjilang.entity.User"%>

<%
	User user=(User)request.getSession().getAttribute("user");
	if(user==null){
		response.sendRedirect("/index/index.do");
	}
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>安吉朗修改资料</TITLE>
<META content="text/html; charset=UTF-8">
<META name="description" content="">
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
</HEAD>
</HEAD>
<script type="text/javascript">
	function subForm(){
		  if ($("#file").val().length > 0) {
	            $("#formId").submit();
	        }
	        else {
	            alert("请选择图片"); 
	        }
		
	}
 
/*  	function ajaxFileUpload() {
     $.ajaxFileUpload ({
			       url: '<c:url value="/upload/image.do?path=head&contentType=text/html" />',   
			        type: 'post',
			        secureuri: false, //一般设置为false
			        fileElementId: 'file', // 上传文件的id、name属性名
			        dataType: 'text', //返回值类型，一般设置为json、application/json
			        success: function(data, status){  
			     		alert("###########"+data);
			        	data = jQuery.parseJSON(jQuery(data).text());
			            if(data!=null && data.code=='0') {
			            	$("#showPic").attr("src","<c:url value='/"+data.path+"' />");
			            	$("#picture").val(data.path);
			            }
			        },
			        error: function(data, status, e){ 
			            alert(e);
			        }
	  		  });   
	}  */
</script>
<body>
	<div id="content">
		<%@ include file="/common/newhead.jsp"%>
		<div class="clear"></div>
		<div class="contentBox">
			<div class="leftBox">
				<div class="editBox">
					<div class="title" id="edit">
						<ul>
							<a href="<c:url value='/user/setAccountMod.do' />"><li>基本资料</li></a>
							<a href="<c:url value='/user/setAccountHead.do' />"><li
								class="on">我的头像</li></a>
							<a href="<c:url value='/user/setAccountPwd.do' />"><li>修改密码</li></a>
							<c:if test="${sessionScope['type'] == 1}">
								<a href="<c:url value='/user/setAccountDocMod.do' />"><li>医生资料</li></a>
							</c:if>
						</ul>
					</div>
					<div class="show">
						<form action="<c:url value='/user/accountHeadNew.do '/>" id="formId"
							name="formId" method="post" enctype="multipart/form-data">
							<div>
								<font style="color: red">${message }</font>
								<h3>修改头像</h3>
								<div class="img_head">
									<img src="<c:url value='/${user.header }' />" id="showPic"
										name="showPic" width="120px" height="120px">
								</div>
								<div class="clearfix" style="height:30px; padding-top:20px">
									<div class="con_up clearfix">
										<input type="button" value="上传头像" id="uploadphoto" name=""
											class="but_up"> 
											<input type="file" name="file" id="file" class="file" value="上传头像"> 
											 <input type="hidden"
											value="7504e57b34181dd9d6dc84b7282f0f0c8c55dbdb"
											name="YII_CSRF_TOKEN">
									</div>
									<p style="line-height:25px;">建议您使用真人头像，图片请小于2M</p>
								</div>
								<ul>
									<li class="btn clearfix"><a href="#" onclick="subForm()">确定</a><a
										href="" class="cancl">取消</a></li>
								</ul>
								<input type="hidden" id="picture" name="picture"
									value="${headPath }">
							</div>
						</form>
					</div>
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