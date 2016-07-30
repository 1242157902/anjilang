$(function(){
	$("#emailreg").click(function(){
		$(".loginBox").css("height","320px");
		$(".signup-box").show();
		$(".signup-phone-box").hide();
		
	});
	$("#phonereg").click(function(){
		$(".signup-box").hide();
		$(".loginBox").css("height","400px");
		$(".signup-phone-box").show();
	});
	
	
	/*发送手机验证*/
	var InterValObj; //timer变量，控制时间
	var count = 30; //间隔函数，1秒执行
	var curCount;//当前剩余秒数
	$("#btnSendCode").click(function(){
		var phone=document.getElementById("phone").value;
		var ex=/^13(\d{9})$|^15(\d{9})$|^17(\d{9})$|^18(\d{9})$/;
		if(phone==""){
			document.getElementById("s_phone").innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 手机号不能为空";
		}else if(ex.test(phone)==true){
			$("#btnSendCode").css("width","105px");
			curCount = count;
			
			//设置button效果，开始计时
		     $("#btnSendCode").attr("disabled", "true");
		     $("#btnSendCode").val("正在发送" + curCount + "秒");
		     InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
		     //向后台发送处理数据
		     $.ajax({
		     	type: "POST", //用POST方式传输
		     	dataType: "text", //数据格式:JSON
		     	url: 'sendMessage.do', //目标地址
		     	data: "phone=" + phone,
		     	error: function (XMLHttpRequest, textStatus, errorThrown) {
		     	 },
		     	success: function (msg){  
	/*	     		alert(eval(msg));*/
		     		if(msg=="success"){
		     			 $("#btnSendCode").attr("disabled", "false");
		     		}
		     		else if(msg=="err_phone"){
		     			document.getElementById("s_phone").innerHTML="手机号错误！";
		     			 $("#btnSendCode").attr("disabled", "false");
		     		}else if(msg=="err_message"){
		     			document.getElementById("s_phone").innerHTML="短信发送失败，请重新获取！";
		     			 $("#btnSendCode").attr("disabled", "false");
		     		}
		     	}
		     });
		}else{
			document.getElementById("s_phone").innerHTML="手机号格式不正确";
			}
	});
		//timer处理函数
		function SetRemainTime() {
		            if (curCount == 0) {                
		                window.clearInterval(InterValObj);//停止计时器
		                $("#btnSendCode").removeAttr("disabled");//启用按钮
		                $("#btnSendCode").val("重新发送");
		            }
		            else {
		                curCount--;
		                $("#btnSendCode").val("正在发送" + curCount + "秒");
		            }
		 }
		
		$("#submit").click(function(){
			var verifycode = $("#message").val();
			 if(verifycode =="")
			 {
				 	document.getElementById("s_verifycode").innerHTML="验证码不能为空！";
				 	return false ;
			 }
			 else
			 {
				 $("#submit").submit();
			}
			
		});
		 
})