$(function(){
		
		$("#btnSearch").click(function(){
			var groupId = $(".groupId").val();
			var userName = $("#userName").val();
			$.ajax({
				url:'GroupUser/finduser.do',
				type:"POST",
				async: true,
				dataType:'JSON',
				data:"groupid="+groupId+"&user="+userName,
				success:function(data,status){
					$(".photo").remove();
					var div = " <div class='photo'><ul></ul></div>";
					$(".change").append(div);
					 $.each(data,function(i,value){
						 var userId = value.id;
						 var realName = value.realName;
						 var header = value.header;
						 alert( header );
						 var li = "<li > <img id='showPic' name='showPic' width='64px' height='64px'  src='<c:url value='/"+header+"' />' /><span id='right'><h6>"+
						 realName+"</h6><p id='p1'>提升管理员</p><input  class='dan'  type='checkbox'  value="+userId+"/></span></li>";
						 $(".photo>ul").append(li);
					 });
					 
				},
				error:function(data,status){
					alert("error");
				}
			});
		});
		
	})
