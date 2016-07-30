<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>合作伙伴_安吉朗官网_angelaround.com</TITLE>
<META content="text/html; charset=UTF-8">
<META name="description" content="">
<link rel="icon" href="<c:url value='/image/favicon.ico' /> "
	type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> "
	type="image/x-icon" />
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/reset.css '/>" media="screen">
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/common.css '/>" media="screen">
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/secpage.css '/>" media="screen">
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/index.css '/>" media="screen">
<SCRIPT type="text/javascript"
	src="<c:url value='/js/jquery-1.7.2.min.js '/>"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js '/>"></SCRIPT>
</HEAD>
<body>
	<div id="content">
		<%@ include file="/common/head.jsp"%>
		<div class="clear"></div>
		<div class="contentBox">
			<div class="SideBar clearfix">
				<ul>
					<li class="Curr"><a
						href="<c:url value='/statics/about.jsp' />">关于我们</a></li>
				</ul>
				<ul class="bullet">
					<li><a href="<c:url value='/statics/partners.jsp'/>">合作伙伴</a></li>
					<li><a href="<c:url value='/statics/contact.jsp' />">联系我们</a></li>
					<li><a href="<c:url value='/statics/talent.jsp' />">人才招聘</a></li>
				</ul>
			</div>
			<div class="jrcon">
				<h2 style="color: red">日本产品提供商</h2>
				<p>
					<img alt="" width="130" height="60"
						src="<c:url value='/image/jk1.png' />">
				</p>
				<p>日本健康食品有限公司</p>
				<p>日本健康食品有公司自1959年成立以来，致力于开发和销售面向医疗机构和养老院的食品。 Healthy
					Food集团开展批发业务（医疗机构和养老院的直销）、厂家业务、居家病患的邮购业务，满足客户多样化的需求。Healthy
					Food集团是在集思广益过程中不断发展的。今后还将继续努力让更多的人吃得开心，吃得放心。</p>
				<p>Healthy
					Food株式会社拥有3000项产品，为东京、神奈川、埼玉、千叶的大约4000家医疗机构、养老院、福利院等直接配送勾芡食品等面向吞咽障碍人士的食品，高密度流质食品，低蛋白质食品等调整营养成分的食品等。</p>
				<h3 class="cl_f53">技术与售后提供商</h3>
				<p>苏州和喜福食品有限公司</p>
				<p>苏州和喜福食品有限公司是日本健康食品有限公司在中国地区全资子公司，全面负责其在中国地区的产品推广、技术支持与售后工作。</p>
				<p>
					苏州和喜福食品有限公司以在日本长久积累的饮食疗法的高技术，先进的医疗、护理知识，以及实际上在日本使用的食品，根据这些在对中国不断增加的为各种疾病烦恼的患者们的饮食环境尽力进行改善。
				</p>
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<%@ include file="/common/footer.jsp"%>
	</div>
</body>
</html>