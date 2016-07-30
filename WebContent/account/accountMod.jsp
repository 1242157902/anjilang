<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>安吉朗修改资料</TITLE>
<META content="text/html; charset=UTF-8">
<META name="description" content="">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/reset.css' />" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/secpage.css' />" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/index.css' />" media="screen">
<link href="<c:url value='/plus-in/calendar/jquery.datetimepicker.css' />" type="text/css" rel=stylesheet>
<SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/plus-in/calendar/jquery.datetimepicker.js' />"></SCRIPT>
</HEAD>
<script type="text/javascript">
	function subForm(){
		$("#formId").submit();
	}
	
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
                  <a href="<c:url value='/user/setAccountMod.do' />"><li class="on">基本资料</li></a>
                  <a href="<c:url value='/user/setAccountHead.do' />"><li>我的头像</li></a>
                  <a href="<c:url value='/user/setAccountPwd.do' />"><li>修改密码</li></a>
                  <c:if test="${sessionScope['type'] == 1}">	
                  	<a href="<c:url value='/user/setAccountDocMod.do' />"><li>医生资料</li></a>
                  </c:if>
              </ul>
          </div>
          <div class="show">
          
          	<form action="<c:url value='/user/accountMod.do '/>" id="formId" name="formId" method="post">
	             <div>
	             	<font style="color: red">${message }</font>
	                <h3>修改个人资料</h3>
	                <ul>
	                   <li class="clearfix"><label>用户名称：</label><input type="text" 
	                   		<c:if test="${sessionScope['type'] == 1}">	
	                   			disabled="disabled" 
	                   		</c:if>
	                   id="realName" name="realName" class="txt" value="${user.realName }"></li>
	                   <li class="clearfix"><label>注册邮箱：</label>${user.userName }</li>
	                   <li class="clearfix"><label>性    别：</label>
	                   	<input type="radio" 
	                   		<c:if test="${user.sex=='1' }">
	                   			checked=""
	                   		</c:if>
	                   	 	value="1" class="rad" id="sex" name="sex"><span class="mar_r15">男</span>
	                   	<input type="radio"  
	                   		<c:if test="${user.sex=='2' }">
	                   			checked=""
	                   		</c:if>
	                   		value="2" class="rad" id="sex" name="sex"><span class="mar_r15">女</span>
	                   </li>
	                   <li class="clearfix"><label>生    日：</label>
	                   	<input type="text" id="birStr" name="birStr" class="txt" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${user.birthday}'/>">
	                   	
	                   </li>
	                   <li class="clearfix"><label>现居住地：</label><input type="text" id="addr" value="${user.addr}" name="addr" class="txt"></li>
	                   <li class="clearfix"><label>个性签名：</label><textarea name="signature" id="signature">${user.signature}</textarea></li>
	                   <li class="btn clearfix"><a href="#" onclick="subForm()">确定</a><a href="" class="cancl">取消</a></li>
	                </ul>
	             </div>
	             <input type="hidden" id="id" name="id" value="${user.id }">
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
<script type="text/javascript">
	    $('#birStr').datetimepicker({
			timepicker:false,
			format:'Y-m-d', //设置日期显示格式 自己发挥
			//step:5,	//需要添加时分秒则使用这个属性，间隔分钟数
			onChangeDateTime:function(dp,$input){ //选择之后的事件处理
			   //$("#InvalidTime").text($input.val());
			}
		});
    </script>
</body>
</html>