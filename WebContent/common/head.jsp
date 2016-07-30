<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   

<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />

<div class="topBox">
   <div class="contentBox">
           安吉朗欢迎您光临！
    <c:choose>
	<c:when test="${sessionScope['userId'] != null}">
	<div class="b-fr">
	<div class="login">
             <ul id="af-log">
                 <%-- <li>
                   <a href="">营养师注册<i class="down"></i></a>
                    <div class="userinfo">
                      <em></em>
                      <dl>
                         <dd class="title"><a href=""><img src="/image/b1.jpg"></a><p><a href="">${sessionScope['userName']}</a><br/>会员组别  5451金币</p></dd>
                         <dd><a href="">我的首页</a></dd>
                         <dd><a href="">我的回答</a></dd>
                         <dd class="bottom"><a href="">退出</a><a href="" class="fr">帐号设置</a></dd>
                      </dl>
                    </div>
                 </li> --%>
                 <li>
                 	<c:if test="${sessionScope['type'] == 1}">
                   		<a href="<c:url value='/personPage/toPersonPageIndex.do?userId=${sessionScope["userId"]}' />">${sessionScope['realName']}<i class="down"></i></a>
                   </c:if>
                   <c:if test="${sessionScope['type'] != 1}">
                   		<a href="#">${sessionScope['realName']}<i class="down"></i></a>
                   </c:if>
                   
                    <div class="userinfo">
                      <em></em>
                      <dl>
                         <dd class="title"><a href=""><img src="<c:url value="/${sessionScope['header']}  "/>" /></a><p><a href="">${sessionScope['realName']}</a>
                         <br/>
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
                         <!-- <dd><a href="">我的首页</a></dd>
                         <dd><a href="">我的回答</a></dd> -->
                         <dd class="bottom"><a href="<c:url value='/login/logout.do' />">退出</a><a href="<c:url value='/user/setAccountMod.do' />" class="fr">帐号设置</a></dd>
                      </dl>
                    </div>
                 </li>
                 
                <!-- <li>
                   <a href="">消息<i class="news">2</i></a>
                   <div class="userinfo dope" >
            <em></em>
             <dl>
               <dd class="title">通知2</dd>
               <dd><a href="">折扣提醒折扣提醒折扣提醒折扣提醒折扣提醒折扣提醒折扣提醒折扣提醒折扣提醒折扣提醒</a></dd>
               <dd><a href="">折扣提醒折扣提醒折扣提醒折扣提醒折扣提醒折扣提醒折扣提醒折扣提醒</a></dd>
               <dd class="bottom clearfix"><a href="" class="fr">全部通知</a></dd>
            </dl> 
          </div>
                 </li>-->
                 
                 <li>
                   <a href="">消息<i class="news">${sessionScope['msgTotalSize'] }</i></a>
                   <div class="userinfo dope" >
		            <em></em>
		             <dl>
		               <dd class="title">通知</dd>
		               <c:forEach var="msg" items="${sessionScope['msgList'] }" >
		               <dd>${msg.content }</dd>
		               </c:forEach>
		              <!--  <dd class="bottom clearfix"><a href="" class="fr">全部通知</a></dd> -->
		            </dl> 
		          </div>
                 </li>
             </ul>
          </div>
	</div>
	</c:when>
	<c:otherwise>
	<div class="b-fr">
	  
	<a href="<c:url value='/regist/init.do' />"><i></i>营养师注册</a>|<a href="<c:url value='/regist/userreg.jsp' />"><i class="user"></i>用户注册</a>|<a href="<c:url value='/login/login.jsp' />">登录</a>
	</div>
	</c:otherwise>
	</c:choose>
       
   </div>
</div>
<div class="fixed_rt" style="display: none"><a href="">意见建议</a></div>
<div class="head-main">
   <div class="fl"><a href="<c:url value='/index/index.do' />"><img src="<c:url value='/image/logo.png' />"></a></div>
   <div class="fr"><img src="<c:url value='/image/tel.png' />"></div>
</div>
<div class="navBox">
  <div class="contentBox">
    <a href="<c:url value='/' />">首页</a>
    <a href="<c:url value='/ask/'/>">医生问答</a>
    <a href="<c:url value="/doc/" />">找医生</a>
    <a href="http://www.angelaround.com/shop" target="_blank">膳食商城</a>
    <a href="<c:url value='/news/' />">资讯</a>
  </div>
</div>