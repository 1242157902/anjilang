<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>找医生_临床营养师_公共营养师-安吉朗健康营养问答</TITLE>
<META content="text/html; charset=utf-8">
<meta name="keywords" content="家庭营养师,临床营养师,公共营养师,找医生">
<meta name="description"
	content="安吉朗营养师：帮助用户在线寻找适合自己的营养师，为其提供家庭营养师远程在线帮助。临床营养师、公共营养师总有一款适合您的营养师！  " />
	
<link rel="icon" href="<c:url value='/image/favicon.ico' /> "
	type="image/x-icon" />
	
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> "
	type="image/x-icon" />


 <LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/reset.css' />" media="screen">
	
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/common.css' />" media="screen"> 
	
<LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/login_ys.css' />" media="screen">
	

<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen"> 

 <LINK rel="stylesheet" type="text/css"
	href="<c:url value='/css/secpage.css' />" media="screen">





<SCRIPT type="text/javascript"
	src="<c:url value='/js/jquery-1.7.2.min.js' />"></SCRIPT>
	
<SCRIPT type="text/javascript"
	src="<c:url value='/js/ajaxfileupload.js' />"></SCRIPT>
	
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js' />"></SCRIPT>

<SCRIPT type="text/javascript"
	src="<c:url value='/plus-in/calendar/jquery.ui.datepicker.js' />"></SCRIPT>
	
<script type="text/javascript"
	src="<c:url value='/plus-in/calendar/jquery.datetimepicker.js' />"></script>
	
<link
	href="<c:url value='/plus-in/calendar/jquery.datetimepicker.css' />"
	
	
	type="text/css" rel=stylesheet />
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js' />"></SCRIPT>

<SCRIPT type="text/javascript"
	src="<c:url value='/js/forum_index_mini.js' />"></SCRIPT>
	
<script type="text/javascript">
$(function() {
	var sWidth = $("#focus").width(); //获取焦点图的宽度（显示面积）
	var len = $("#focus ul li").length; //获取焦点图个数
	var index = 0;
	var picTimer;
	$("#focus .btn span").css("opacity", 0.4).mouseover(function() {
		index = $("#focus .btn span").index(this);
		showPics(index);
	}).eq(0).trigger("mouseover");

	$("#focus .preNext").css("opacity", 0.2).hover(function() {
		$(this).stop(true, false).animate({
			"opacity" : "0.5"
		}, 300);
	}, function() {
		$(this).stop(true, false).animate({
			"opacity" : "0.2"
		}, 300);
	});

	$("#focus .pre").click(function() {
		index -= 1;
		if (index == -1) {
			index = len - 1;
		}
		showPics(index);
	});

	$("#focus .next").click(function() {
		index += 1;
		if (index == len) {
			index = 0;
		}
		showPics(index);
	});

	$("#focus ul").css("width", sWidth * (len));
	$("#focus ul li").css("width", sWidth);

	$("#focus").hover(function() {
		clearInterval(picTimer);
	}, function() {
		picTimer = setInterval(function() {
			showPics(index);
			index++;
			if (index == len) {
				index = 0;
			}
		}, 5000);
	}).trigger("mouseleave");

	function showPics(index) {
		var nowLeft = -index * sWidth;
		$("#focus ul").stop(true, false).animate({
			"left" : nowLeft
		}, 300);
		$("#focus ul li").stop(true, false).animate({
			"opacity" : "0.6"
		}, 600).eq(index).stop(true, false).animate({
			"opacity" : "1"
		}, 600);
		$("#focus .btn span").stop(true, false).animate({
			"opacity" : "0.4"
		}, 300).eq(index).stop(true, false).animate({
			"opacity" : "1"
		}, 300);
	}
});
function dis(id, flg) {
	if(flg == 1) {
		$("#"+id).css("display","block");
		var idT="showTT"+id;
		$("#"+idT).attr("style","display: inline-block;height: 22px;margin-left: 10px;padding-left: 45px;position: relative;vertical-align: middle;width: 119px;background: url(../image/common/legalize.png) no-repeat -61px -19px;");
	} else {
		$("#"+id).css("display","none"); 
		var idT="showTT"+id;
		$("#"+idT).attr("style","display: inline-none;height: 22px;margin-left: 10px;padding-left: 45px;position: relative;vertical-align: middle;width: 119px;");
	} 
}
</script>

</HEAD>
<body>
	<div id="content">
	
	
		<%@ include file="/common/newhead.jsp"%>

		<div class="clear"></div>
		<div class="doc_hos_banner">
			<div class="contentBox">
				<h1>
					已有<i>${totalSize }</i>名认证营养师入驻
				</h1>
				<h3>为您的健康，保驾护航！</h3>
				<a href="<c:url value='/regist/init.do' />">+我要入驻</a>
			</div>
		</div>
		<div class="breadcrumb" style="border:none; padding:10px 0;">
			<div class="contentBox">
				<h1>金牌营养师</h1>
			</div>
		</div>
		<div class="contentBox">
			<div class="property_select">
				<div class="bor_gray">
					<div class="select-result clearfix">
						<div class="gray">您选择：</div>
						<div class="total">
							共有<strong class="cl_f53">${totalSize }</strong>位医生
						</div>
					</div>
					<div class="select-list sp_line clearfix">
						<h2>省&nbsp;&nbsp;份：</h2>
						<div class="part_right tab1">
							<ul class="clearfix tab_title" id="select1">
								<c:choose>
									<c:when test="${provinceId == null }">
										<li class="select-all"><a
											href="<c:url value='/doctor/finddoctor.do?provinceId=&projectId=${projectId }'/>">不限</a>
										</li>
									</c:when>
									<c:otherwise>
										<li><a
											href="<c:url value='/doctor/finddoctor.do?provinceId=&projectId=${projectId }'/>">不限</a>
										</li>
									</c:otherwise>
								</c:choose>

								<c:forEach var="pri" items="${pList }">
									<c:choose>
										<c:when test="${provinceId == pri.id }">
											<li class="select-all"><a
												href="<c:url value='/doctor/finddoctor.do?provinceId=${pri.id }&projectId=${projectId }'/>">${pri.cityName
													}</a>
											</li>
										</c:when>
										<c:otherwise>
											<li><a
												href="<c:url value='/doctor/finddoctor.do?provinceId=${pri.id }&projectId=${projectId }'/>">${pri.cityName
													}</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ul>
							<ul class="tab_cont1">
							</ul>
						</div>
					</div>
					<div class="select-list clearfix">
						<h2>项&nbsp;&nbsp;目：</h2>
						<div class="part_right tab1">
							<ul class="clearfix tab_title" id="select2">

								<c:choose>
									<c:when test="${projectId == null }">
										<li class="select-all"><a
											href="<c:url value='/doctor/finddoctor.do?provinceId=${provinceId }&projectId='/>">不限</a>
										</li>
									</c:when>
									<c:otherwise>
										<li><a
											href="<c:url value='/doctor/finddoctor.do?provinceId=${provinceId }&projectId='/>">不限</a>
										</li>
									</c:otherwise>
								</c:choose>

								<c:forEach var="dl" items="${dlist }">
									<c:choose>
										<c:when test="${projectId == dl.id }">
											<li class="select-all"><a
												href="<c:url value='/doctor/finddoctor.do?provinceId=${provinceId }&projectId=${dl.id }'/>">${dl.diseaseName
													}</a>
											</li>
										</c:when>
										<c:otherwise>
											<li><a
												href="<c:url value='/doctor/finddoctor.do?provinceId=${provinceId }&projectId=${dl.id }'/>">${dl.diseaseName
													}</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<div class="fl sort_left">
				<div class="sort_bar clearfix">
					<dl class="fl sort_btn1">
						<dl>排序：
						</dl>
						<dd class="active">
							<a>默认排序</a>
						</dd>
					</dl>
				</div>
				<ul class="list_t1 doc_list">
					<c:forEach var="user" items="${uList }" varStatus="idx">
						<li>
							<div class="pic_box fl">
								<a target="_blank"
									href="<c:url value='/personPage/toPersonPageIndex.do?userId=${user.id}' />"><img
									width="100" height="100"
									src="<c:url value='/${user.header }' />" alt="pic">
								</a>
							</div>
							<div class="arc fl">
								<div class="block_title doc_title">
									<a class="block_name" target="_blank"
										href="<c:url value='/personPage/toPersonPageIndex.do?userId=${user.id}' />">${user.realName
										}</a> <span class="vip"><img
										src="<c:url value='/image/v.gif' />" alt="pic">
									</span> <span class="c999 jobtitle">${user.title }</span>
								</div>
								<div class="arc_item">
									<span class="c999">解答：</span><span class="num">${answerList[idx.index]
										}</span>&nbsp;&nbsp; <span class="c999">被赞：</span><span class="num">${agreeList[idx.index]
										}</span>
								</div>
								<div class="arc_item">
									<span class="c999">机构：</span> <span class="num">${user.hospital
										}</span> <span id="showTTdt${idx.index }"
										style="display: inline-block;height: 22px;margin-left: 10px;padding-left: 45px;position: relative;vertical-align: middle;width: 119px;"
										onmouseover="dis('dt${idx.index }', 1)"
										onmouseout="dis('dt${idx.index }', 2)"> <c:choose>
											<c:when test="${doctorTypeList[idx.index].id==2 }">
												<em class="red"></em>
											</c:when>
											<c:otherwise>
												<em></em>
											</c:otherwise>
										</c:choose> <span id="dt${idx.index }" style="display:none">${doctorTypeList[idx.index].name
											}</span> </span>
								</div>
								<div class="arc_item">
									<span class="c999">擅长：</span> ${projectList[idx.index] }
								</div>
							</div>

							<div class="btn_group_right fr">
								<a class="btn_page" target="_blank"
									href="<c:url value='/personPage/toPersonPageIndex.do?userId=${user.id}' />">查看医生主页</a>
								<a class="ico_btn ico_ask" target="_blank"
									href="<c:url value="/answer/addQuestion.do?doctorUserId=${user.id}" />">向他提问</a>
								<a class="ico_btn ico_ask_bubble" target="_blank" href="">挂号预约</a>
								<a class="ico_btn ico_phone" target="_blank" href="">电话预约</a>
							</div></li>
					</c:forEach>
				</ul>
				<div class="pageNav">
					<c:if test="${pageNo>1}">
						<a
							href="<c:url value='/doctor/finddoctor.do?pageNo=${pageNo-1 }&provinceId=${provinceId }&projectId=${projectId }' />"
							class="next">上一页</a>
						<c:if test="${pageCount>3 }">
							<strong>...</strong>
						</c:if>
						<a
							href="<c:url value='/doctor/finddoctor.do?pageNo=${pageNo-1 }&provinceId=${provinceId }&projectId=${projectId }' />">${pageNo-1
							}</a>
					</c:if>
					<a
						href="<c:url value='/doctor/finddoctor.do?pageNo=${pageNo }&provinceId=${provinceId }&projectId=${projectId }' />"
						class="on">${pageNo }</a>
					<c:if test="${pageNo<pageCount }">
						<a
							href="<c:url value='/doctor/finddoctor.do?pageNo=${pageNo+1 }&provinceId=${provinceId }&projectId=${projectId }' />">${pageNo+1
							}</a>
						<c:if test="${pageNo+1<pageCount }">
							<strong>...</strong>
						</c:if>
						<a
							href="<c:url value='/doctor/finddoctor.do?pageNo=${pageNo+1 }&provinceId=${provinceId }&projectId=${projectId }' />"
							class="next">下一页</a>
					</c:if>
				</div>
			</div>

			<div class="rightBox">
				<div class="info-side-reg">
					<p>
						找到最靠谱的营养专家<br />快来向TA提问吧，TA已恭候你多时啦
					</p>
					<a target="_blank" href="<c:url value="/answer/addQuestion.do" />">向医生提问</a>
				</div>
			</div>
		</div>
	</div>
	<div class="clear"></div>

	<%@ include file="/common/newfooter.jsp"%>
</body>
</html>