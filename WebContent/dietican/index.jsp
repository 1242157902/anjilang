<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>营养师首页</title>
<link rel="stylesheet" type="text/css" href="./css/index.css" />
<link rel="stylesheet" type="text/css" href="./css/share.css" />

<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="js/my.js"></script>

</head>
<body>


	<div id="container">


		<!--头部-->
		 <div >
  		<%@ include file="/common/newhead.jsp"%>
         </div> 

		<!--banner-->
		<div class="banner">

			<div class="lan">
				<i></i> <a href="#">首页> </a> <a href="#">营养师专栏</a>
			</div>

			<div class="pic1">
				<!--<a href="javascript:void(0);" class="left"></a>-->
				<a href="javascript:;" class="right"></a>
				<ul>
					<li class="hero1"></li>
					<li class="hero2"></li>
					<li class="hero3"></li>
					<li class="hero4"></li>
				</ul>
				<ol>
					<li class="current"></li>
					<li></li>
					<li></li>
					<li></li>
				</ol>

			</div>
		</div>


		<!--主要内容-->
		<div class="content">
			<div class="content-left">
				<div class="relea-t">
					<p class="releas">
						<a href="#">最新专栏</a>
					</p>
					<p>
						<a href="#">热门话题</a>
					</p>
					<span><i></i><a
						href="<c:url value='/dietican/addArticle.jsp' />">发表文章</a><b></b>
					</span>
				</div>
				<div class="releat">

					<ul style="display:block;">
						<c:forEach var="spec" items="${specColList }">
							<li>
								<div class="bt">
									<h2>${spec.title }</h2>
								</div> <img src="${spec.pic }" class="img" />
								<p>
									<a href="${spec.url }">${spec.content } </a>
								</p>

								<div class="yuming">
									<a href="#" class="one">by</a> <a href="#" class="one1">${spec.author
										}</a> <span class="one2">${spec.updateTime }</span>
								</div>
							</li>
						</c:forEach>
					</ul>

					<ul>
						<c:forEach var="spec" items="${specColList }">
							<li>
								<div class="bt">
									<h2>${spec.title }aaa</h2>
								</div> <img src="${spec.pic }" class="img" />
								<p>
									<a href="${spec.url }">${spec.content } </a>
								</p>

								<div class="yuming">
									<a href="#" class="one">by</a> <a href="#" class="one1">${spec.author
										}</a> <span class="one2">${spec.updateTime }</span>
								</div>
							</li>
						</c:forEach>
					</ul>

				</div>
				<div id="main_pagination">
					<P>共${pageCount }页/${totalCount }条</P>

					<a href="<c:url value='/dietican/index.do' />" class="one">首页</a>
					<c:if test="${pageNo!=1}">
						<c:if test="${pageCount>3 }">
							<strong>...</strong>
						</c:if>
						<a
							href="<c:url value='/dietican/index.do?typeId=${typeId }&pageNo=${pageNo-1 }' />">${pageNo-1
							}</a>
					</c:if>
					<a
						href="<c:url value='/dietican/index.do?typeId=${typeId }&pageNo=${pageNo }' />"
						class="on">${pageNo }</a>
					<c:if test="${pageNo!=pageCount }">
						<a
							href="<c:url value='/dietican/index.do?typeId=${typeId }&pageNo=${pageNo+1 }' />">${pageNo+1
							}</a>
						<c:if test="${pageNo+1<pageCount }">
							<strong>...</strong>
						</c:if>
						<a
							href="<c:url value='/dietican/index.do?typeId=${typeId }&pageNo=${pageNo+1 }' />"
							class="one">下一页</a>
						<a
							href="<c:url value='/dietican/index.do?typeId=${typeId }&pageNo=${pageCount }' />"
							class="one">末页</a>
					</c:if>
				</div>
			</div>



			<div class="content-right">
				<div class="mends">
					<h2>推荐书籍</h2>
					<div class="mend">

						<!-- <a href="javascript:void(0);" class="lt"></a>
		<a href="javascript:;" class="rt"></a>-->
						<ul>
							<c:forEach var="book" items="${bookList }">
								<li style="display:block;"><a href="${book.bookURL }"><img
										src="${book.pic }" alt="" /> </a>
									<div class="book">
										<h3>
											<a href="${book.bookURL }">${book.bookname }</a>
										</h3>
										<p class="introduction">
											<a href="${book.bookURL }">${book.content }</a>
										</p>
										<p class="author">
											作者<a href="${book.authorURL }">：${book.authorname }</a>
										</p>
									</div>
								</li>
							</c:forEach>
						</ul>
						<ol>
							<li class="current"></li>
							<li></li>
							<li></li>


						</ol>

					</div>
				</div>
				<!--组委会-->
				<div class="mittee">
					<h2>推荐作者</h2>
					<ul>
						<c:forEach var="author" items="${authorList }">
							<li class="first"><img src="${author.pic }" />
								<div class="voice">
									<p>
										<a href="${author.url }">${author.name }</a>
									</p>
									<span>${author.profile } </span>
								</div>
							</li>
						</c:forEach>

					</ul>
					<c:if test="${pageNo1!=PageCount }">
						<a
							href="<c:url value='/dietican/index.do?TypeId=${TypeId }&PageNo=${PageNo+2 }' />"
							class="change" style="text-decoration:underline">换一批</a>
					</c:if>
				</div>


				<!-- <div class="protuct"></div> -->
			</div>
		</div>

	<%--  <div class="nutritionists">
			
				<c:forEach items="${docpic }" var="docp" varStatus="myV" begin="1"
					end="4"  >
				
						<div class="nutritionists-1">
							<span></span>
							<h3>
								<a href="#">${docp.name}</a>
							</h3>
							<p>${docp.hospital}</p>

						</div>
					
				</c:forEach>
			

		</div>  --%>

		<div class="footer">
			<%@ include file="/common/newfooter.jsp"%>
		</div> 

	</div>

</body>
</html>
