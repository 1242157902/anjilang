<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% String createrid=request.getParameter("createrid");  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>内容页</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/newindex.css' />" media="screen">
    <script type="text/javascript" src="<c:url value='/js/jquery-1.11.1.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/newcommon.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/my.js' />"></script>	
    <script type="text/javascript" src="<c:url value='hyh/js/my.js' />"></script>	
    <link rel="stylesheet" type="text/css" href="<c:url value='hyh/css/content.css' />" >	
    <link rel="stylesheet" type="text/css" href="<c:url value='hyh/css/share.css' />" >	
    <script src="<c:url value='/plus-in/ckeditor/ckeditor.js '/>"></script>
    <script src="<c:url value='/plus-in/layer/layer.js '/>"></script>
    <script type="text/javascript">
       function ShowDiv(show_div,bg_div){
          document.getElementById(show_div).style.display='block';
          document.getElementById(bg_div).style.display='block' ;
          var bgdiv = document.getElementById(bg_div);
          bgdiv.style.width = document.body.scrollWidth;
          // bgdiv.style.height = $(document).height();
         $("#"+bg_div).height($(document).height());
        
         };
        //关闭弹出层
         function CloseDiv(show_div,bg_div)
           {
               document.getElementById(show_div).style.display='none';
              document.getElementById(bg_div).style.display='none';
           };
           
    </script>
   <script type="text/javascript">
      
      function validate(param){
        
         if(CKEDITOR.instances.content.getData()==""){
            alert("回复内容不能为空！");
		      return false;
         }else{
		         if(param==null){
		          alert("请先加入小组！")
		          return false;
		            
		          }else{
		          return true;
		         }
	         }
         }
        
     $(function(){

    	 $(".comment>ul>li").each(function(i){
/*     	     	   $("#berelyid").val("");  
    			  $("#description").val("");  */
    			  var realName = $(".realName_"+i).text();
    			  var id = $(".id_"+i).text();
    		//回复
    		  $(".reply_"+i).click(function(){
    			 $("#berelyid").val(id);
    			$("#description").val("回复"+realName+":"); 
		    	 history.go(0); 
    /* 		 	$.ajax({
    		 		 type: "POST",
    		 		 url: "GroupTopic/getUserId.do",
    		 		 data: 'id='+id,
    		 		 async:true,
    		 		 success: function(data){
    		 			$("#description").val(data.realName);
    		 		 }
    		 	}); */
    		  });
    		//引用
    		$(".quote_"+i).click(function(){
  	    			 $("#quoteid").val(id);
  	    			$("#description").val("回复"+realName+":"); 
  	    			 history.go(0);
    		});
    			  
    		
    		//举报
    		$(".report_"+i).click(function(){
    			
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
					    		 		 url: "report/addReport.do",
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
    	 });
     })      
</script>
  
 <script type="text/javascript">
	function queryTis(createrid){
	console.log("createrid:" + createrid);
	$("#createrid").val(createrid);
	$("#queryForm").submit();
	}
	
</script>
	
	

  </head>
  
  <body>
  <form id="queryForm">
   <input type="hidden" id="createrid" name="createrid"  />
   <input type="hidden" id="id" name="id" value="${groupTopic.id }"/>
   <input type="hidden" id="groupid" name="groupid" value="${patientGroup.id }"/>
  </form>
  <div>
      <%@ include file="/common/newhead.jsp"%>
   </div>
   
   <c:set  var="id" value="${userSession.id }" />
   <c:forEach  var="users" items="${users }"> 
      <c:set var= "ids"   value="${users.id }"  />
        <c:if test="${id==ids }">
           <c:set var= "panduan"   value="${1 }"  />
        </c:if>
   </c:forEach> 
   <c:if test="${id==patientGroup.userid }" >
      <c:set var= "panduan"   value="${1 }"  />
   </c:if>
   
   <!--banner开始-->
    <div class="banners"  style="background : url(<c:url value='/${patientGroup.bgpicUrl }'/>);" >
     
     
       <div class="banner-in">
       
       
            <ul>
               <i></i>
               <li><a href="index.jsp">首页 ></a> </li>
               <li><a href="javascript:void(0)">群组 ></a> </li>
               <li><a >${patientGroup.groupname } > </a></li>
            </ul>
            
            
            <div class="lad" >
               <img src="<c:url value='/${patientGroup.picurl }'/>" />
               <h2 >${patientGroup.groupname }</h2>
               <p >创建于<fmt:formatDate value="${patientGroup.createtime }" pattern="yyyy-MM-dd"/> 成员${patientGroup.personcount }人</p> 
            </div>
            
            
            <ol>
            
                <c:choose>
                  <c:when test="${empty tabid }">
                    <li class="first"><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }'/>">小组首页</a></li> 
                  </c:when>
             
                  <c:otherwise>
                    <li ><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }'/>">小组首页</a></li> 
                   </c:otherwise>  
                </c:choose>
                
                
                <c:forEach  var="tab" items="${tabs }"  varStatus="status">
                  <c:choose>
                   <c:when test="${tabid==tab.id}">
                   <li class="first"><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }&grouptabid=${tab.id }'/>">${tab.tabname }</a></li> 
                   </c:when>
                   
                   <c:otherwise>
                   <li ><a href="<c:url value='/patientGroup/groupdetail.do?groupid=${patientGroup.id }&grouptabid=${tab.id }'/>">${tab.tabname }</a></li> 
                   </c:otherwise>
                   
                  </c:choose>
               </c:forEach>
               
    
                <c:if test="${patientGroup.userid==user.id }">
                   <li style="display:block;">
                     <a href="<c:url value='/patientGroup/magroup.do?groupid=${patientGroup.id } ' />">管理小组</a>
                    </li>
                 </c:if>
                    
                </ol>
            
            
           </div>
           
           
     </div>
   
   <!--主要内容-->
   
   <div class="content">
    <div class="content-left">
            <h1>${groupTopic.title }</h1>
            <span ><b>${groupTopic.topictop }</b><a href="<c:url value='/GroupTopic/ding.do?id=${groupTopic.id }&groupid=${patientGroup.id }' />"><img src="hyh/images/ding.png" /></a></span>
            <div class="name">
                <img src="hyh/images/hed.jpg" />
                <div class="nam">
                    <p ><a href="javascript:void(0);">${groupTopic.user.realName }</a></p>
                    
                    <p><fmt:formatDate value="${groupTopic.createtime }" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </p>
                    
                </div>
                
                <ul>
                
                <c:choose>
                   <c:when  test="${panduan==1 }" >
                       <li><a>已加入小组</a></li>
                   </c:when>
                   <c:when  test="${panduan2==1 }" >
                       <li><a>已加入小组</a></li>
                   </c:when>
                   <c:when  test="${panduan!=1 }">
                        <li><a href="<c:url value='/GroupUser/JoinGroup.do?groupid=${patientGroup.id }' />"  onClick="join()"  class="one">+加入小组</a></li>
                       
                   </c:when>
                   </c:choose>
                   
                   
                   <c:choose>
                   <c:when  test="${empty createrid }" >
                       <li ><a style="cursor:pointer;" onclick="queryTis(${groupTopic.user.id})" >只看楼主</a></li>
                   </c:when>
                   <c:when  test="${createrid==groupTopic.user.id}" >
                    <li ><a style="cursor:pointer;" onclick="queryTis()" >查看全部</a></li> 
                   </c:when>
                   </c:choose>
               
                    <li><a onclick="" style="cursor: pointer;">回复</a></li>
                <!--     <li><a href="javascript:void(0);">举报</a></li> -->
                    <c:choose>
                    <c:when test="${user.id==patientGroup.userid }">
                    <li style="cursor: pointer;display:block;"><a  onclick="ShowDiv('MyDiv','fade' )">推荐</a></li>
                    </c:when>
                    <c:otherwise>
                     <li style="display:none;">推荐</li>
                    </c:otherwise>
                    </c:choose>
                    
                </ul>
                 
            </div>
            <div class="plain">
                <p class="witten">${groupTopic.content }</p><br />
                 
            </div>
            <div class="guangao">
                <a href="javascript:void(0);"><img src="hyh/images/guangao.jpg" /></a>
            </div>
            
            
            
            
            
            
            <div class="comment">
            
                <ul>
                  <c:forEach items="${replys }" var="replys" varStatus="status">
                   <li>
                        <img src="${replys.user.header }" />
                        
                        <div class="floor"> 
                            <p class="meng"><b class="realName_${status.index }" >${replys.user.realName }(${replys.user.addr })</b><span  class="id_${status.index }" style="display: none;">${replys.id }</span><i></i> <fmt:formatDate value="${replys.reptime }" pattern="yyyy-MM-dd hh:mm:ss"/></p>
                              <ol>
                                 	<li>${replys.floor }F</li>
                                  	 <li  style="cursor: pointer;" ><a ><span onclick=""  class="reply_${status.index }">回复</span></a> </li>
                                	  <li style="cursor: pointer;"><a ><span onclick=""   class="quote_${status.index }">引用</span></a></li>
                                	   <li><a href="javascript:void(0);"  class="report_${status.index }">举报</a>
                                	   </li>
                                </ol>
                           </div>
                        	  <ul>
                           <c:if test="${replys.quoteTopicReply!=null }">
                           				<li>"引用"${replys.quoteTopicReply.floor }"楼"${replys.quoteTopicReply.user.realName }"发表于"${replys.quoteTopicReply.reptime }"的帖子："</li>
                           				<br/><li>${replys.quoteTopicReply.content}</li>
                           </c:if>
                                  </ul>    
                                  <c:choose>
                                  		<c:when test="${replys.isDelete }">
                                  								<div class="jincai"  style="clear:both;">该回复内容已被管理员删除！</div>
                                  		</c:when>
                                  		<c:otherwise>
            		                      		   				<div class="jincai"  style="clear:both;">${replys.content }</div>
                                  		</c:otherwise>
                                  </c:choose>
                     </li>
                     </c:forEach>                                                                                 
                </ul>
                      
                <div id="main_pagination">
                    <P>共${pageCount }页/${totalSize }条</P>
                     
                    <c:if test="${pageNo>1}">
                    <a href="<c:url value='/GroupTopic/detail.do?id=${groupTopic.id}&pageNo=${pageNo-1 }&groupid=${patientGroup.id }&createrid=${createrid}' />" class="one">上一页</a>
			       <a href="<c:url value='/GroupTopic/detail.do?id=${groupTopic.id}&pageNo=${pageNo-1 }&groupid=${patientGroup.id }&createrid=${createrid}' />">${pageNo-1 }</a>
			        </c:if>
			         <a href="<c:url value='/GroupTopic/detail.do?id=${groupTopic.id}&pageNo=${pageNo }&groupid=${patientGroup.id }&createrid=${createrid}' />" class="one">${pageNo }</a>
                    <c:if test="${pageNo<pageCount }">
                    <a href="<c:url value='/GroupTopic/detail.do?id=${groupTopic.id}&pageNo=${pageNo+1 }&groupid=${patientGroup.id }&createrid=${createrid}'/>" >${pageNo+1 }</a>
                    <c:if test="${pageNo+1<totalPage }">
	           				      <strong>...</strong>
	           		</c:if>
	           		 <a href="<c:url value='/GroupTopic/detail.do?id=${groupTopic.id}&pageNo=${pageNo+1 }&groupid=${patientGroup.id }&createrid=${createrid}'/>"  class="one">后一页</a>
	           		 </c:if>
	           		 
               </div>
          </div>
          
          
          
         <form action="<c:url value='/TopicReply/addReply.do?topicid=${groupTopic.id}&groupid=${patientGroup.id }'/>" method="post">
          <div class="janes" >
          		<input  type="hidden" id="berelyid"  name="berelyid" />
          		<input  type="hidden" id="quoteid"  name="quoteid"  />
             <p class="huiyin">回复主题：</p>
              <div class="textarea">
                     <textarea  id="description" rows="20" name="content"  > </textarea>
                 <script type="text/javascript">
                     CKEDITOR.replace('content',
                     {height:150,width:854,
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
                </div> 
         
         <input type="submit" value="提　交"   onClick="return validate(${panduan})"  class="iput"    />
          
          </div> 
         </form> 
         
         
         <form action="<c:url value='/GroupTopic/recommend.do?id=${groupTopic.id }&groupid=${patientGroup.id }'/>"  method="post"> 
         <div id="fade" class="black_overlay">
            </div>
           <div id="MyDiv" class="white_content">
           <div style="cursor: default; ">
           <span  onclick="CloseDiv('MyDiv','fade')">关闭</span>
            <p class="caij">推荐文章</p>
            
            <div class="white_content_l"></div>
             <ul style="padding-left:50px;">
             <c:forEach var="recom" items="${recoms }">
             <li style="padding:10px;font-size:16px;"><input name="recommend" type="radio" value="${recom.id }" />${recom.rectype }</li>
             </c:forEach>
             </ul>
             
              <input type="submit" value="提交" class="btnt"/>
              
            </div>
           </div>

           
           </form>
           
           </div>
         
      
      <div class="content-right">
      
         <div class="mends">
         
             <div class="mend">
                 <a href="javascript:void(0);" class="glt"></a>
                 
                 <a href="javascript:;" class="grt"></a>
                 
                 <ul>
			       <c:forEach   var="picTopics"  items="${picTopics }"  begin="0"  end="3">
			        <li style="display:block;"><a href="<c:url value='/GroupTopic/detail.do?id=${picTopics.id }&groupid=${picTopics.patientGroup.id }'/>"><img src="${pageContext.request.contextPath}/${picTopics.articlepic}"  alt="" /></a></li>
		          </c:forEach>	
		        </ul>
		        <ol>
		         <c:forEach   var="picTopics"  items="${picTopics }"   begin="0"  end="3">
			      <li class="current"></li>
			
		        </c:forEach>
			
		        </ol>
		        
		         </div>
             
         </div>
         
         
         <!--TA加入小组-->
          <div class="group">
              
              <h2>TA加入的小组</h2>
              <c:forEach  var="groups"  items="${patientGroups }">
              <dl class="group_one">
                 <dt ><img width="68px"  height="68px"  src="<c:url value='/${groups.picurl }'/>" /></dt>
                 <dd class="dney"><a href="javascript:void(0);">${groups.groupname }</a></dd>
                 <dd><a href="javascript:void(0);">${groups.topiccount }个帖子</a></dd>
              </dl>
              </c:forEach>
              
          </div>
      
      
      
         <!--推荐阅读-->
         <div class="read"  style="clear:both;padding-top:50px;">
              <h2>推荐阅读</h2>
        
              <ul>
              <c:forEach   var="artTopics"  items="${artTopics }"  begin="0"  end="1">
			  
                <li>
                <h3>${artTopics.title }</h3>
                <img src="${artTopics.articlepic}" />
                <p><a href="<c:url value='/GroupTopic/detail.do?id=${artTopics.id }&groupid=${artTopics.patientGroup.id }'/>"><c:set var="string1" value="${fn:substring(artTopics.content, 0, 50)}" />${string1 } [详细]</a></p>
                </li> 
                 </c:forEach>	
                
              </ul>
        </div>
      
       <div class="protuct"></div>
      
      </div>
      
      
    </div>
      
  
  <div id="foot_1" style="clear:both;padding-top:10px;">
    <%@ include file="/common/newfooter.jsp"%>
    
  </div>  
   
  </body>
</html>
