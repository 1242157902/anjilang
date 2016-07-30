<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html >
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="安吉朗,治疗膳食,营养师,公共营养师,">
<meta name="description"
	content="安吉朗（angelaround.com），最专业的治疗膳食专家.由最专业的营养师提供为肾病、糖尿病、老年病等患者提供最合理的治疗膳食方案！" />
<meta property="qc:admins" content="245624377761675412756463757" />
<meta property="wb:webmaster" content="68029bccc5747e2d" />
<title>安吉朗</title>
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/common.css' />" media="screen">
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/newindex.css' />" media="screen">
<SCRIPT type="text/javascript" src="<c:url value='/js/newcommon.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/my.js' />"></SCRIPT>
<%--   <SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.11.1.min.js' />"></SCRIPT>  --%>
</head>
<body>
	<!--头部banner-->
	<div class="indexminba">
		<div class="indexmax" style="display:none;">
			<div class="mian">
				<div class="btn"></div>
			</div>
		</div>

		<div class="indexmin" style="display:block;">
			<div class="mian">
				<div class="btn"></div>
			</div>
		</div>


	</div>


	<!--头部-->
	<div class="top">
		<div class="top-in">
			<div class="top-in-l">
				<p>特食街欢迎您的光临...</p>
			</div>


			<div class="erweima">
				<div class="erweima-x">
				
				
				
				</div>
			</div>
			<c:choose>
				<c:when test="${sessionScope['userId'] != null}">
					<div class="b-fr">
						<div class="login">
							<ul id="af-log">
								<c:if test="${sessionScope['userId'] != null}">
									<c:if test="${sessionScope['audit'] == null}">
										<li class="num1">
											<p>
												<a href="<c:url value='/regist/init.do' />">营养师注册 </a>
											</p></li>
									</c:if>
								</c:if>
								<li><c:if test="${sessionScope['type'] == 1}">
										<a
											href="<c:url value='/personPage/toPersonPageIndex.do?userId=${sessionScope["userId"]}' />">${sessionScope['realName']}<i
											class="down"></i>
										</a>
									</c:if> <c:if test="${sessionScope['type'] != 1}">
										<a href="#">${sessionScope['realName']}<i class="down"></i>
										</a>
									</c:if>

									<div class="userinfo">
										<em></em>
										<dl>
											<dd class="title">
												<a href="<c:url value='/user/setAccountHead.do' />"><img
													src="<c:url value="/${sessionScope['header']}  "/>" />
												</a>
												<p>
													<a href="<c:url value='/user/setAccountMod.do' />">${sessionScope['realName']}</a>
													<br />
													<c:if test="${sessionScope['type'] == 1}">
                   				会员组别：${sessionScope['docType'] }
                   			</c:if>
													<c:if test="${sessionScope['type'] == 2}">
                   				会员组别：普通用户
                   			</c:if>
													<c:if test="${sessionScope['type'] == 3}">
                   				会员组别：管理员
                   			</c:if>
												</p>
											</dd>
											<dd class="bottom">
												<a href="<c:url value='/login/logout.do' />">退出</a><a
													href="<c:url value='/user/setAccountMod.do' />" class="fr">帐号设置</a>
											</dd>
										</dl>
									</div></li>
								<li><a href="">消息<i class="news">${sessionScope['msgTotalSize']
											}</i>
								</a>
									<div class="userinfo dope">
										<em></em>
										<dl>
											<dd class="title">通知</dd>
											<c:forEach var="msg" items="${sessionScope['msgList'] }">
												<dd>${msg.content }</dd>
											</c:forEach>
										</dl>
									</div></li>
							</ul>
						</div>
					</div>
				</c:when>
				<c:otherwise>

					<div class="qq">
						<a href="<c:url value='/login/qqLogin.do '/>"><img
							src="<c:url value='/images/qq.png'/> " />
						</a>
					</div>
					<div class="xlweb">
						<a href="<c:url value='/login/weiboLogin.do '/>"><img
							src="<c:url value='/images/xlweb.png '/> " />
						</a>
					</div>
					<div class="top-in-r">
						<ul>
							<%-- <c:if test="${sessionScope['userId'] != null}">
			      		<li class="num1">
			         	 <p><a href="<c:url value='/regist/init.do' />">营养师注册丨</a></p>
			     	   </li>
			      	</c:if> --%>

							<li class="num2">

								<p>
									<a href="<c:url value='/login/login.jsp' />">登录丨</a>
								</p></li>

							<li class="num2">

								<p>
									<a href="<c:url value='/regist/userreg.jsp' />">用户注册</a>
								</p> <%-- <p><a href="<c:url value='/login/qqLogin.do '/>"><img src ="images/qq.png "/></a></p> --%>
							</li>
						</ul>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<!--logo开始-->
	<div class="logo">
		<a href="#" class="img"> <img
			src="<c:url value='/images/logo.png' />" /> </a>
		<div class="logo-bg"></div>
		<div class="input">
			<input id="text" type="text" /> <span></span> <i></i>
		</div>
		<div class="logo-r">
			<img src="<c:url value='/images/tel.png' />" />
		</div>
	</div>
	<!--导航栏开始-->
	<div class="nav">
		<div class="nav-in">
			<div class="nav_l">
				<p>最专业的特殊医用食品服务平台</p>
				<span></span>
			</div>
			<div class="nav_t">
				<a href="<c:url value='/' />" class="center">首页</a> <%-- <a
					href="<c:url value='/ask/'/>">医生问答</a> <a
					href="<c:url value="/doc/" />">找医生</a> --%> <a
					href="http://10.5.113.226/jmshop/flow.php?step=login&username=jingdutaizi&password=111111&act=signin" target="_blank">膳食商城</a> <span></span>
				<a href="<c:url value='/patientGroup/groupdetail.do?groupid=23'/>">患友会</a>
			</div>
	
</body>
</html>
