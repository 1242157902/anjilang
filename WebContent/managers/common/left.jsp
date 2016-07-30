<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
		<form role="search">
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Search">
			</div>
		</form>
		<ul class="nav menu">
			<li class="active"><a href="#"><span class="glyphicon glyphicon-dashboard"></span> ANJILANG(安吉朗)</a></li>
			<li class="parent ">
				<a href="#">
					<span class="glyphicon glyphicon-list"></span> 首页管理 <span data-toggle="collapse" href="#sub-item-1" class="icon pull-right"><em class="glyphicon glyphicon-s glyphicon-plus glyphicon-minus"></em></span> 
				</a>
				<ul class="children collapse in" id="sub-item-1">
					<li>
						<a class="" href="<c:url value='/managers/indexpic/indexTableList.jsp' />">
							<span class="glyphicon glyphicon-share-alt"></span> 首页table页管理
						</a>
					</li>
					<li>
						<a class="" href="<c:url value='/managers/indexpic/indexShopList.jsp' />">
							<span class="glyphicon glyphicon-share-alt"></span> 首页商城管理
						</a>
					</li>
					<li>
						<a class="" href="<c:url value='/managers/indexpic/indexDoctorList.jsp' />">
							<span class="glyphicon glyphicon-share-alt"></span> 首页特约医生管理
						</a>
					</li>
					<li>
						<a class="" href="<c:url value='/managers/friendlink/list.jsp' />">
							<span class="glyphicon glyphicon-share-alt"></span> 友情链接管理
						</a>
					</li>
					<li>
						<a class="" href="<c:url value='/managers/seniordoctor/list.jsp' />">
							<span class="glyphicon glyphicon-share-alt"></span> 知名专家管理
						</a>
					</li>
					<li>
						<a class="" href="<c:url value='/managers/speccol/list.jsp' />">
							<span class="glyphicon glyphicon-share-alt"></span> 安吉郎专栏管理
						</a>
					</li>
				</ul>
			</li>
			<li><a href="<c:url value='/managers/information/listType.jsp '/>"><span class="glyphicon glyphicon-list-alt"></span> 资讯管理</a></li>
			<li><a href="<c:url value='/managers/disease/list.jsp '/>"><span class="glyphicon glyphicon-list-alt"></span> 疾病项目管理</a></li>
			<li><a href="<c:url value='/managers/audit/doctorlist.jsp'/>"><span class="glyphicon glyphicon-list-alt"></span> 医生列表管理</a></li>
			<li><a href="<c:url value='/managers/user/list.jsp'/>"><span class="glyphicon glyphicon-list-alt"></span> 用户列表管理</a></li>
			<li><a href="<c:url value='/managers/audit/grouplist.jsp'/>"><span class="glyphicon glyphicon-list-alt"></span>患友会管理</a></li>
			<li><a href="<c:url value='/managers/report/reportlist.jsp'/>"><span class="glyphicon glyphicon-list-alt"></span>举报内容管理</a></li>
			<li class="parent ">
				<a href="#">
					<span class="glyphicon glyphicon-list"></span> 个人中心 <span data-toggle="collapse" href="#sub-item-1" class="icon pull-right"><em class="glyphicon glyphicon-s glyphicon-plus glyphicon-minus"></em></span> 
				</a>
				<ul class="children collapse in" id="sub-item-1">
					<li>
						<a class="" href="<c:url value='/managers/personPage/listTopPic.jsp' />">
							<span class="glyphicon glyphicon-share-alt"></span> 个人中心顶部图片管理
						</a>
					</li>
				</ul>
			</li>
			
			<li class="parent ">
				<a href="#">
					<span class="glyphicon glyphicon-list"></span> 营养师专栏管理 <span data-toggle="collapse" href="#sub-item-1" class="icon pull-right"><em class="glyphicon glyphicon-s glyphicon-plus glyphicon-minus"></em></span> 
				</a>
				<ul class="children collapse in" id="sub-item-1">
				
					<li>
						<a class="" href="<c:url value='/managers/indexpic/indexTableList.jsp' />">
							<span class="glyphicon glyphicon-share-alt"></span> 首页table页管理
						</a>
					</li>
					
					<li>
						<a class="" href="<c:url value='/managers/bookrecommendation/list.jsp' />">
							<span class="glyphicon glyphicon-share-alt"></span> 推荐书籍管理
						</a>
					</li>
					
					<li>
						<a class="" href="<c:url value='/managers/author/list.jsp' />">
							<span class="glyphicon glyphicon-share-alt"></span> 推荐作者管理
						</a>
					</li>
					
				</ul>
			</li>
			<li role="presentation" class="divider"></li>
			<li><a href="login.html"><span class="glyphicon glyphicon-user"></span> Login Page</a></li>
		</ul>
		
	</div><!--/.sidebar-->