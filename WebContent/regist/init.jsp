<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>安吉朗营养师注册</TITLE>
<META content="text/html; charset=utf-8">
<META name="description" content="">
<link rel="icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<link rel="shortcut icon" href="<c:url value='/image/favicon.ico' /> " type="image/x-icon" />
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/reset.css' />" media="screen"/>
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" media="screen"/>
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/login.css'/>" media="screen"/>
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/login_ys.css' />" media="screen"/>
<LINK rel="stylesheet" type="text/css" href="<c:url value='/css/index.css' />" media="screen"/>
<LINK rel="stylesheet" type="text/css" href="<c:url value='/plus-in/calendar/jquery-ui.css' />" media="screen"/>
  <SCRIPT type="text/javascript" src="<c:url value='/js/jquery-1.7.2.min.js' />"></SCRIPT>   
 <SCRIPT type="text/javascript" src="<c:url value='/plus-in/calendar/jquery-ui-datepicker.js' />"></SCRIPT>  
<SCRIPT type="text/javascript" src="<c:url value='/js/ajaxfileupload.js' />"></SCRIPT>
<SCRIPT type="text/javascript" src="<c:url value='/js/common.js' />"></SCRIPT> 
<link href="<c:url value='/css/upload.css' />" type="text/css"	rel="stylesheet"  media="screen"/>
<style type="text/css">
</style>

<script type="text/javascript">
$(function(){
	$("#birStr").datepicker({
		maxDate:new Date(),
	});	
})
function projectStr() {
		  $("#project").val("");
		  var chk_value =[];    
		  $('input[name="p"]:checked').each(function(){    
		    chk_value.push($(this).val());
		  });
		  if(chk_value.length>0) {
			  var str = ",";
			  chk_value.forEach(function(e){  
				    str += e + ",";
				});
			  $("#project").val(str);
		  }
		}
		
		function getCity(obj) {
			$.ajax({
				type : 'POST',
				url : '<c:url value="/city/queryChild.do" />',
				cache:false,
				data:{parentId:obj.value},
			    dataType:'json',
			    success:function(data) {
			    	var arr = eval(data);
			    	//删除原有Select  
		            //$("select[name=city]").remove();
			    	// 创建
		            //var d = $("<select>");  
	               // $(d).attr("name", "city");
	                //$(d).css({"display" : "block", "width" : "120px", "margin-top" : "3px"});
	               // $(d)[0].options.add(new Option("- 请选择 -", ""));
	               	// 清空列表
	                jQuery("#city").empty();
	                var d = $("#city");
			    	for(var i=0; i<arr.length; i++) {
			    		var id   = arr[i].id;  
	                    var name = arr[i].cityName;
	                    //alert(id + name);
	                    //创建options  
	                   $(d)[0].options.add(new Option(name, id)); 
			    	}
			    	//$("#dis").html(d);
			    	//$("#dis").append(d);
			    	   
			     },    
			     error : function() {    
			          alert("异常！");    
			     }
			});
		}



function ajaxFileUpload() {
				$.ajaxFileUpload({
						url : '<c:url value="/upload/imageNew.do?path=head" />',
						type : 'post',
						secureuri : false, //一般设置为false
						fileElementId : 'file', // 上传文件的id、name属性名
						dataType : 'text', //返回值类型，一般设置为json、application/json
						success : function(data, status) {
	                       			
		                     		if (data != null && data != "" && data != "undefined") {
		                     			var data = $.parseJSON(data);
										if (data != null && data.code == '0') {
											//$("#showPic").html("<img src='"+data.url+"'>");;
											$("#showPic")
													.html(
															"<img style=\"width: 500px;height: 304px;\" src=\"<c:url value='/"+data.path+"' />\">");
											//alert(data.path);
											$("#header").val(data.path);
										}
									}  
/* 		                     		if (data != null && data != "" && data != "undefined") {
										data = jQuery.parseJSON(jQuery(data).text());
										if (data != null && data.code == '0') {
											//$("#showPic").html("<img src='"+data.url+"'>");;
											$("#showPic")
													.html(
															"<img style=\"width: 500px;height: 304px;\" src=\"<c:url value='/"+data.path+"' />\">");
											//alert(data.path);
											$("#header").val(data.path);
										}
									}   */
						}
					});  
		}
		
		function deleteObj(){
			projectStr();
			$("#reg").submit();
		}	
	
</script>

</HEAD>
<body>
<div id="content">
<%@ include file="/common/newhead.jsp"%>

<div class="clear"></div>
<div class="res_banner_box">
   <div class="contentBox">
     <div class="sum">
          <div class="paim">
             已注册营养师 <span>1</span><span>2</span><span>2</span><span>2</span><span>3</span> 名
          </div>
          <div class="fig-list">
          <ul>
          <c:forEach items="${docList }" var="doc" begin="0" end="1">
          	<li>
          		<a href="<c:url value='/personPage/toPersonPageIndex.do?userId=${doc.id}' />"><img src="<c:url value='/${doc.header }' />"></a>
          		<p><a href="<c:url value='/personPage/toPersonPageIndex.do?userId=${doc.id}' />">${doc.realName }<i></i></a></p>
          		<p class="det"><a href="<c:url value='/personPage/toPersonPageIndex.do?userId=${doc.id}' />">${doc.hospital }</a></p>
          	</li>
          </c:forEach>
             
          </ul>
      </div>
     </div>
   </div>
</div>
<div class="resig_info">
    <div class="leftBox">
        <h1>立即注册成为安吉朗认证营养师</h1>
         <ul class="signup-common">
	      	<c:if test="${code != null && code != '' && code != '0' }">
	      		<li class="tishi"><em></em>${msg }</li>
	      	</c:if>
	      </ul>
        <form action="<c:url value='/regist/regist.do' />" id="reg" name="reg" method="post">
        <ul>
           <li><label>真实姓名：</label><input class="txt" type="text" value="${regVo.realName }" name="realName"  placeholder="${sessionScope['realName'] }"/><!-- <span><i></i>请输入您的姓名</span> -->
           <p class="note">真实姓名会代替昵称显示在个人首页最明显的位置，请填写身份证上的姓名</p></li>
           <li id="dis"><label>注册职业地：</label>
              <select name="province" onchange="getCity(this)" style=" height: 30px;"><c:forEach var="p" items="${provinceList}">
					<option value="${p.id }">${p.cityName }</option>
				</c:forEach></select>
	
				<select name="city" id="city" style=" height: 30px;"><c:forEach var="c" items="${cityList}">
					<option value="${c.id }">${c.cityName }</option>
				</c:forEach></select>
              <!-- <span><i class="ok"></i>请输入您的姓名</span> -->
           </li>
           <li><label>营养师职业号：</label><input type="text" class="txt" name="certificateNo" value="${regVo.certificateNo }"/></li>
           <li><label>生日：</label><input type="text" class="txt" id="birStr" name="birStr" style="width:276px;" value="${regVo.birStr }"  readonly="readonly" /></li>
           
           <li>
           <label>性别：</label>
           <c:choose>
           <c:when test="${regVo.sex == '1' }">
           <input type="radio" name="sex" value="1" checked="checked" style=" vertical-align:middle" />男 &nbsp;&nbsp;<input type="radio" name="sex" value="2" style=" vertical-align:middle" />女
           </c:when>
           <c:when test="${regVo.sex == '2' }">
           <input type="radio" name="sex" value="1" style=" vertical-align:middle" />男 &nbsp;&nbsp;<input type="radio" name="sex" value="2" checked="checked" style=" vertical-align:middle" />女
           </c:when>
           <c:otherwise>
           <input type="radio" name="sex" value="1" style=" vertical-align:middle" />男 &nbsp;&nbsp;<input type="radio" name="sex" value="2" style=" vertical-align:middle" />女
           </c:otherwise>
           </c:choose>
           </li>
           <li><label>现工作医院：</label><input type="text" class="txt" name="hospital" value="${regVo.hospital }"  /></li>
           <li><label>职称：</label><input type="text" class="txt" name="title" value="${regVo.title }" /></li>
           <li><label>擅长项目：</label>
           <c:forEach items="${projectList }" var="pl" >
           		<c:choose>
           		<c:when test="${regVo.project!=null && fn:contains(regVo.project, pl.id)}">
           		<input type="checkbox" name="p" value="${pl.id }" checked="checked" style=" vertical-align:middle" />${pl.diseaseName }&nbsp;&nbsp;
           		</c:when>
           		<c:otherwise>
           		<input type="checkbox" name="p" value="${pl.id }"/ style=" vertical-align:middle" >${pl.diseaseName }&nbsp;&nbsp;
           		</c:otherwise>
           		</c:choose>
		   </c:forEach>
			<input type="hidden" name="project" id="project" value="${regVo.project }"/>
           </li>
           <li><label>手机：</label><input type="text" class="txt" name="phone" value="${sessionScope['phone'] }" placeholder="${sessionScope['phone'] }" maxlength="11" readonly/>
            <p class="note">请填写医生自己的手机号码</p>
           </li>
           <li><label>修改头像：</label>
           	<!-- <input type="file" name="file" id="file" onchange="ajaxFileUpload()" /> --><!-- <a href="" class="header">上传头像</a> -->
            <a class="btn_addPic" href="javascript:void(0);"><span><em>+</em>设置头像</span> <input class="filePrew" title="支持jpg、jpeg、gif、png格式，文件小于5M" tabIndex="3" type="file" size="3" name="file" id="file" onchange="ajaxFileUpload()"/></a>
            
            <input type="hidden" name="header" id="header" value="${regVo.header }" />
            <div id="showPic">
            <c:if test="${regVo.header!=null && regVo.header!='' }">
            	<img style="width: 500px;height: 304px;" src="<c:url value='/${regVo.header }' />"/>
            </c:if>
            </div>
            <p class="note">营养师必须使用能够清晰展示个人的真人头像，不得带有宣传性字样，图片请小于2M。</p>
           </li>
           <li><label>用户名(邮箱)：</label><input type="text" class="txt" name="userName" value="${sessionScope['userName'] }"  placeholder="${sessionScope['userName'] }"readonly/></li>
          <%-- <li> <input type="hidden" class="txt" name="password" value="${sessionScope['password'] }" placeholder="${sessionScope['password'] }"/></li>
		     <li><input type="hidden" class="txt" name="id" value=""/></li>   --%>
           <li class="btn">
               <a href="#" onclick="deleteObj()">立即注册</a>
               <p>安吉朗的营养师注册认证是 <strong>完全免费</strong> 的，任何收费的注册认证行为都是虚假欺骗。</p>
           </li>
        </ul>
        </form>
    </div>
    <script type="text/javascript">
    $(function(){
    /* 	 $('#birStr').datetimepicker({
 			timepicker:true,
 			format:'Y-m-d', //设置日期显示格式 自己发挥
 			//step:5,	//需要添加时分秒则使用这个属性，间隔分钟数
 			onChangeDateTime:function(dp,$input){ //选择之后的事件处理
 			   //$("#InvalidTime").text($input.val());
 			}
 		}); */
    })
    </script>
    <div class="rightBox" >
       <h2>注册流程：</h2>
       <div class="step" style="height:900px;">
          <dl>
             <dd class="on"><em></em>1.填写注册资料</dd>
             <dd>2.等待安吉朗审核</dd>
             <dd>3.通过认证</dd>
          </dl>
          <p>
             帮助：<br/>
注册中遇到任何问题可联系我们<br/>
座机：010-68809699-8033<br/>
邮箱：xlxu@angelaround.com<br/>
QQ号：2064696853<br/>
<a href="">如何注册安吉朗营养师？</a>
          </p>
       </div>
    </div>
</div>

<div class="clear"></div>
<%@ include file="/common/newfooter.jsp"%>
</div>

</body>
</html>