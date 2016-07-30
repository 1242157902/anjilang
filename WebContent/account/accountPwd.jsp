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
<SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js' />"></SCRIPT>
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
                  <a href="<c:url value='/user/setAccountMod.do' />"><li>基本资料</li></a>
                  <a href="<c:url value='/user/setAccountHead.do' />"><li>我的头像</li></a>
                  <a href="<c:url value='/user/setAccountPwd.do' />"><li class="on">修改密码</li></a>
                  <c:if test="${sessionScope['type'] == 1}">	
                  	<a href="<c:url value='/user/setAccountDocMod.do' />"><li>医生资料</li></a>
                  </c:if>
              </ul>
          </div>
          <div class="show">
          	<form action="<c:url value='/user/accountPwd.do '/>" id="formId" name="formId" method="post">
	           <div>
	           	<font style="color: red">${message }</font>
                <h3>修改密码</h3>
                <ul>
                   <li class="clearfix"><label>当前密码：</label><input type="password" id="nowPwd" name="nowPwd" class="txt"></li>
                   <li class="clearfix"><label>新设密码：</label><input type="password" id="newPwd" name="newPwd" class="txt"></li>
                   <li class="clearfix"><label>重复密码：</label><input type="password" id="retPwd" name="retPwd" class="txt"></li>
                   <li class="btn clearfix"><a href="#" onclick="subForm()">确定</a><a href="" class="cancl">取消</a></li>
                </ul>
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