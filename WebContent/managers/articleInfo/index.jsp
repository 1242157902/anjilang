<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>安吉朗 文章</TITLE>
<META content="text/html;charset=UTF-8">
<META name="description" content="">
<LINK rel="stylesheet" type="text/css" href="../css/reset.css" media="screen">
<LINK rel="stylesheet" type="text/css" href="../css/common.css" media="screen">
<LINK rel="stylesheet" type="text/css" href="../css/secpage.css" media="screen">
<LINK rel="stylesheet" type="text/css" href="../css/index.css" media="screen">

<link rel="stylesheet" type="text/css" href='<c:url value="/css/pageCss/themes/default/easyui.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/css/pageCss/themes/icon.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/css/common.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/css/index_page.css"/>'>
<script type="text/javascript" src="<c:url value="../js/jquery.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="../js/jquery.easyui.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="../js/easyui-lang-zh_CN.js"/>"></script>

<SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js' />"></SCRIPT>
</HEAD>
<body>
<div id="content">
<%-- <%@ include file="/common/head.jsp"%> --%>
<div class="clear"></div>
<div class="contentBox">
	<div id="content">
		<table>
	    	<tr>
	    		<td>标题：</td>
	    		<td><input type="text" name="title" id="title" maxlength="64"/></td>
	    	</tr>
	    	<tr>
	    		<td colspan="2"  align="center">
	    		<input onclick="query();" type="button" id="search" value="查询" class="button gray">
				<input onClick="resetClear();" type="reset" id="reset" value="重置"
						class="button gray">
	    		</td>
	    	</tr>
   		</table>
	</div>
    <!-- 分页显示得内容 -->
	<div id="content"></div>
	<!-- 分页条 -->
	<div id="page" class="easyui-pagination"
		data-Options="pageList:[15,30,50,100],pageSize:15"
		style="background: #efefef; border: 1px solid #ccc;">
	</div>
</div>
</div>
<div class="clear"></div>
<div id="footer">
<%-- <%@ include file="/common/footer.jsp"%> --%>
</div>
<script type="text/javascript">
</script>
</body>
</html>