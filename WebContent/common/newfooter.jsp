<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 
 
<!--底部-->
<div class="bottom">
  <div class="bottom-in">
   <dl class="logo">
     <dd>
      <img src="<c:url value='/images/logo_footer.png '/>" />
     </dd>
   </dl>
   <dl>
     <dt>关于我们</dt>
      <dd><a href="<c:url value='/statics/about.jsp' />">公司简介</a></dd>
         <dd><a href="<c:url value='/statics/partners.jsp'/>">合作伙伴</a></dd>
         <dd><a href="<c:url value='/statics/contact.jsp' />">联系我们</a></dd>
         <dd><a href="<c:url value='/statics/talent.jsp' />">加入我们</a></dd>
   </dl>
   <dl>
      <dt>网站条款</dt>
         <dd><a href="">会员条款</a></dd>
    
   </dl>
   <dl>
     <dt>帮助中心</dt>
         <dd><a href="">使用帮助</a></dd>
         <dd><a href="">建议投诉</a></dd>
    
   </dl>
   <dl class="last">
     <div class="last-btn">
     <ul>
               <li><a href="http://wpa.qq.com/msgrd?v=3&uin=2064696853&site=qq&menu=yes" target="_blank"></a></li>
               				
               
               <li><a href="http://weibo.com/anjilang" target="_blank" class="k_sina"></a></li>
               <li><a href="" class="k_weixin_li">
                 <div class="link_weixin_ewm">
                    <img src="<c:url value='/image/ewm.jpg' />" width="129" height="129">
                 </div>
               </a> 
               </li>
            </ul>
     </div>
   </dl>
  </div>
</div>

<div class="link">
  <span>友情链接：</span>
  <c:forEach var="friendLink" items="${friendList}"> 
  <a href=${friendLink.url }>${friendLink.title }</a>
  </c:forEach>
  <!-- <a href="#">[更多...]</a> -->
</div>

<div class="sm">
 <p>本站声明：任何信息都不能替代执业营养师面对面的诊断和治疗，网站内容仅供用户参考，本站不承担由此引起的法律责任。</p>
  <p>@2015 Angelaround.com 京ICP备14051378号-2 安吉朗总机400 010 1166  工作时间 9：00-18：00<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1254132242'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1254132242%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script></p>
</div>