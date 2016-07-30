<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>内容页</title>
<link rel="stylesheet" type="text/css" href="css/content.css" />
<link rel="stylesheet" type="text/css" href="css/share.css" />

<META content="text/html; charset=UTF-8">
<META name="description" content="">
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/reset.css' />" media="screen">
<LINK rel="styleshheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/secpage.css' />" media="screen">
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/index.css' />" media="screen">
<SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js' />"></SCRIPT>
    <script src="<c:url value='/plus-in/layer/layer.js '/>"></script>
      <script src="<c:url value='/plus-in/ckeditor/ckeditor.js '/>"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".div").hide();
		$(".comment>ul>li").each(function(i){

			$(".answer_"+i).click(function(){
			 	var parentId = $("#parent_"+i).text();
				getReview(parentId,i);
				 $(".div_"+ i ).toggle();
				 $(".floor1" ).remove();
			});
			//引用
			$(".quote_"+i).click(function(){
				var id = $("#id_"+i).text();
				var content = $("#content_"+i).text();
				var inforId = $("#inforid_"+i).val();
				 
				$.ajax({
					url:'<c:url value="/comment/save.do" />',
					data:"content="+content+"&inforId="+inforId+"&quoteId="+id,
					type:"POST",
					async:true,
					success:function(data,status)
					{
						//layer.msg("引用成功！");
						location.reload() ;
					},
					error:function()
					{
						alert("出现错误！");
					}
					
				});
				
			});
			
			
			//举报
			$(".report_"+i).click(function(){
				var id = $("#id_"+i).text();
			 	layer.open({
    			    type: 1, //page层
    			    area: ['300px', '200px'],
    			    title: '举报原因',
    			    skin: 'layui-layer-molv', //墨绿风格
    			    shade: 0.6, //遮罩透明度
    			    shift: -1, //0-6的动画形式，-1不开启
    			    content: '<div style="padding:20px;">'
    			    +'<input type="radio" name="radiobutton" id="radio" value="广告" />广告<input type="radio" id="radio" name="radiobutton" value="灌水" />灌水<input type="radio" id="radio" name="radiobutton" value="色情污染" />色情污染<input type="radio"  id="radio" name="radiobutton" value="危害国家安全" />危害国家安全'+
    			    '</br><input type="text"  value="详细说明会帮助我们更快的处理举报原因" class="reportreason" size="35px" style="margin-top:20px;"/></div>',
    			    btn:['确定'],
    			    yes: function(index, layero){
    			    	
    			        //按钮【按钮一】的回调
				        var $radio = $("input[name='radiobutton']:checked");;
    			        var $input = $(".reportreason");
    			        var reason  = $radio.val();
    			        var reasondetail = $input.val();
    			        if(reasondetail == '详细说明会帮助我们更快的处理举报原因')
    			      	{
    			        	reasondetail = "";
    			      	}
 		 			 	$.ajax({
					    		 		 type: "POST",
					    		 		 url: "addReport.do",
					    		 		 data: 'repid='+id+'&reason='+reason+'&reasondetail='+reasondetail,
					    		 		 async:true,
					    		 		 success: function(data){
					    		 		 }
					    		 	});  
    			    	 layer.close(index); //一般设定yes回调，必须进行手工关闭
						layer.msg("举报成功！");
    			    },
    			});              
		 
				
				
				
				
			});
		})
	 
		
		
		
	function getReview(parentId,i)
	{
		$.ajax({
			url:'<c:url value="/comment/queryRepl.do" />',
			data:"parentId="+parentId,
			dataType:"json",
			type:"POST",
			async:true,
			success:function(data,status)
			{
				var json = eval(data);
				$.each(json, function (index, item) {  
	                 //循环获取数据    
	                 var content= json[index].content; 
	                 var crTime= json[index].crTime; 
	                 var nickname= json[index].nickname; 
	                 
	                 var $div =  $(" <div   class='floor1'><p>"+nickname+"　　回复:"+content+ "　　　　　　　　　"+crTime    + "</p></div>");
	                 var $parent =  $(".div_"+i);
	                $parent.append($div);
             });  
			},
			error:function()
			{
				alert("出现错误！");
			}
			
		});
	}
	 
});

</script>


<%@page import="com.anjilang.service.*"%>
<%@page import="com.anjilang.service.impl.*"%>
<%@page import="com.anjilang.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

</head>
<body>
	


  <!--头部-->
 <div>
  	<%@ include file="/common/newhead.jsp"%>
</div>
<!--banner开始-->

  
  
    <div class="xiaozu">
    <ul>
    <i></i>
         <li><a href="<c:url value='/infor/toInforChannel.do?typeId=0' />">资讯 ></a></li>
         <li><a href="<c:url value='/infor/toInforChannel.do?typeId=${informationType.id }' />">${informationType.title } ></a></li>
         <li><a href="">${informationType.detailTitle } </a></li>
    </ul>
    </div>
    



<!--主要内容-->
<div class="content">


     <div class="content-left">
        <h1>${information.title }</h1>
       
         <div class="by">
           <ul>
             <li class="one"><a href="#">by</a></li>
             <li class="one1"><a href="${author.url }">${author.name }</a></li>
             <li>${information.crTime }</li>
           </ul>
           <p><span>特食街营养师专栏</span>出品　已有<span>${information.num }</span>人阅读</p>
         </div>
         
         
         <div class="plain">
               ${information.content }
               
               
                           
                       
              <div class="share">
              <p>分享到</p>
                <ul>
                  <li class="one"><a href="#"></a></li>
                  <li class="one1"><a href="#"></a></li>
                  <li class="one2"><a href="#"></a></li>
                  <li class="one3"><a href="#"></a></li>
                  <li class="one4"><a href="#"></a></li>
                  <li class="one5"><a href="#"></a></li>
                  
                </ul>
              </div>
               
         </div>
         
         
         
         <div class="updown">
             <p class="up"><a href="#">上一篇：
             <span> 
             <c:choose>	
         		<c:when test="${informationPrev!=null }">
		         	<a href="<c:url value='/dietican/articleContent.do?id=${informationPrev.id }'/>">${informationPrev.title }</a>
         		</c:when>
         		<c:otherwise>
         			无
         		</c:otherwise>
         	</c:choose>	
             </span>
             </a>
             </p>
             <p class="down"><a href="#">下一篇：
             <span>
             <c:choose>	
         		<c:when test="${informationNext!=null }">
		         	<a href="<c:url value='/dietican/articleContent.do?id=${informationNext.id }'/>">${informationNext.title }</a>
         		</c:when>
         		<c:otherwise>
         			无
         		</c:otherwise>
         	</c:choose>	
             </span></a></p>    
         </div>
        
        
        
        
         <form action="<c:url value='/comment/save.do' />" method="post">
         
          <div class="com">
          		<input type="text"  name="inforId" value="${information.id }" style="display:none"></input>
            	<textarea id="content1" name="content" cols="90" rows="16" class="input" ></textarea>
            	
            	 <script type="text/javascript">
                     CKEDITOR.replace('content1',
                     {height:100,width:756,
                      toolbar :
                [
                 //加粗     斜体，下划线     穿过线    下标字      上标字
                /*  ['Bold','Italic','Underline','Strike','Subscript','Superscript'],
                //超链接  取消超链接 锚点
                 ['Link','Unlink','Anchor'],
                 //图片    flash   表格     水平线          表情      特殊字符      分页符
                 ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'] */

                  ]
                     });
                     </script>
            	
            	
            	<input type="submit" value="发表评论"  class="btn" />
         </div>
         
         </form>
         
          <div class="comment">
            
           <c:forEach items="${listSpec }" var="com" varStatus="status">
           <ul>
               <li>
                 <img src="${pageContext.request.contextPath}/${com.pic }" />
                <div class="floor"> 
                <p class="meng"><b>${com.nickname }</b><i></i> ${com.crTime }</p>
                <ol>
                  <li>${status.index+1 }F<span id="id_${status.index }" style="display: none;">${com.id }</span></li>
                  <li  class="answer_${status.index }"  style="cursor: pointer;"><a href="javascript:void(0);"  class="commentBtn" > 回复<span id="parent_${status.index }" style="display:none">${com.id}</span>  </a></li>
                  <li><a href="javascript:void(0);" class="quote_${status.index }">引用 </a></li>
                  <li><a href="javascript:void(0);" class="report_${status.index }">举报</a></li>
                </ol>
                </div>
                <div>
                 <c:choose>
                 	<c:when test="${com.isDelete }">
                 					<p class="jincai" id="content_${status.index }">该内容已被管理员删除！</p>
                 	</c:when>
                 	<c:otherwise>
                 			      <c:if test="${com.quoteId!=null}">
				                		<p class="jincai" id="content_${status.index }">引用他人的帖子：${com.content }</p>
					                </c:if>
					                <c:if test="${com.quoteId==null}">
					          	      <p class="jincai" id="content_${status.index }">${com.content }</p>
					                </c:if>
                 	</c:otherwise>
                 </c:choose>
          
                </div>
                <br/>
              <div class="div_${status.index }" style="display: none" onMouseout="hidden()" class="com">
                 
                  
                    <%--   	 <c:forEach items="${replyList }" var="comL">
                 			 	 <ul>
                 			 	 <li>
                 			 	 <div class="floor"> 
                 			 	 	<p class="jincai">
                 			 	 		回复${com.nickname}:${comL.content}
               						</p>
               					 </div>
               					 </li>
               					 </ul>
               		</c:forEach> 	  --%> 
                 	<form action="<c:url value='/comment/addAnswer.do' />" method="post">
                 		<input type="text"  name="parentId" value="${com.id }" style="display:none"></input>
                 		<input type="text" id="inforid_${status.index }" name="answerId" value="${com.inforId  }" style="display:none"></input>
                 		<input type="text"  name="nickname" value="${com.nickname  }" style="display:none"></input>
                 		<input type="hidden" id="quoteId" name="quoteId" value="" ></input>
            			<textarea id="content" name="content" cols="85" rows="3" class="input" ></textarea>
            			
            			
            			<input type="submit" value="回复" class="btn"  />
                 	</form>
                 		
               			
                 </div>
               </li>
                </ul>
               </c:forEach>
           
   <div id="main_pagination">
   
    <P>共${pageCount }页/${totalCount }条</P>
     
     	<a href="<c:url value='/dietican/articleContent.do?id=${information.id }' />" class="one">首页</a>
           		<c:if test="${pageNo!=1}">
           			<c:if test="${pageCount>3 }">
           				<strong>...</strong>
		    		</c:if>
			           <a href="<c:url value='/dietican/articleContent.do?id=${information.id }&pageNo=${pageNo-1 }' />" class="one">上一页</a>
			           <a href="<c:url value='/dietican/articleContent.do?id=${information.id }&pageNo=${pageNo-1 }' />">${pageNo-1 }</a>
			       </c:if>
			       <a href="<c:url value='/dietican/articleContent.do?id=${information.id }&pageNo=${pageNo }' />" class="one">${pageNo }</a>
	           	   <c:if test="${pageNo!=pageCount }">
	           		   <a href="<c:url value='/dietican/articleContent.do?id=${information.id }&pageNo=${pageNo+1 }' />">${pageNo+1 }</a>
	           		   <c:if test="${pageNo+1<pageCount }">
           				<strong>...</strong>
           				</c:if>
	           		    <a href="<c:url value='/dietican/articleContent.do?id=${information.id }&pageNo=${pageNo+1 }' />" class="one">下一页</a>
	           		    <a href="<c:url value='/dietican/articleContent.do?id=${information.id }&pageNo=${pageCount }' />" class="one">末页</a>
	           	   </c:if>
       </div>
  </div> <!--end of comment   -->
  
  
</div><!-- end of left -->
     
      <div class="content-right">
				       <div class="figure">
				         <dl>
				            <dt><img src="${pageContext.request.contextPath}/dietican/${author.pic }" /></dt>
				            <dd class="name"><a href="${author.url }">${author.name }</a></dd>
				            <dd class="evaluation"><a href="#">${author.profile }<span>${author.name }</span></a></dd>
				         </dl>
				       </div>
				       <div class="column">
				       <h2>专栏最热文章</h2>
				       <ul>
				       <c:forEach items="${specColList }" var="spec" begin="0" end="4">
				         <li><a href="${spec.url }">${spec.title }</a></li>
				        </c:forEach>
				       </ul>
				       </div>
				       
				       <div class="mittee">
				               <h2>专栏其他作者</h2>
				         <ul>
				         <c:forEach var="author" items="${authorList }">
				            <li class="first">
				              <img src="${pageContext.request.contextPath}/dietican/${author.pic }" />
				              <div class="voice">
				              <p><a href="${author.url }">${author.name }</a></p>
				              <span><a href="#">${author.profile }</a></span>
				              </div>
				              
				            </li>
				          </c:forEach>
				          </ul>
				          
				       </div>
     
     
     </div>
     
</div>

   


<%-- <div class="nutritionists">
   <c:forEach items="${docpic }" var="docp" varStatus="myV" begin="1" end="4" >
	<li>
   	<div class="nutritionists-1">
	<span></span><h3><a href="#">${docp.name}</a></h3>
    <p>${docp.hospital}</p>
   
   </div>
   </li>
    </c:forEach>
 </div> 
<!--底部-->
<div class="bottom">
  <div class="bottom-in">
   <dl class="logo">
     <dd>
      <img src="images/logo_footer.png" />
     </dd>
   </dl>
   <dl>
     <dt>关于我们</dt>
     <dd><a href="#">公司简介</a></dd>
     <dd><a href="#">公司简介</a></dd>
     <dd><a href="#">公司简介</a></dd>
     <dd><a href="#">公司简介</a></dd>
     <dd><a href="#">公司简介</a></dd>
   </dl>
   <dl>
     <dt>关于我们</dt>
     <dd><a href="#">公司简介</a></dd>
    
   </dl>
   <dl>
     <dt>关于我们</dt>
     <dd><a href="#">公司简介</a></dd>
     <dd><a href="#">公司简介</a></dd>
    
   </dl>
   <dl class="last">
     <div class="last-btn">
       <ul>
         <li><a href="#"></a></li>
         <li><a href="#"></a></li>
         <li><a href="#"></a></li>
       </ul>
     </div>
   </dl>
  </div>
</div>

<div class="link">
  <span>友情链接：</span>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">苏州恒润达</a>
  <a href="#">[更多...]</a>
</div>

<div class="sm">
 <p>本站声明：任何信息都不能替代执业营养师面对面的诊断和治疗，网站内容仅供用户参考，本站不承担由此引起的法律责任。</p>
</div>
--%>


<div style="clear:both;">
<br/>

<%@ include file="/common/newfooter.jsp"%>
</div>

</body>
</html>
