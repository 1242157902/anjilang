$(function() {
	var $tit = $("#show ul li");
	var $tit2 = $(".nav-title ul li")
	var $tits = $("#shows ul li");
	var $tit3 = $(".fig-list dl dd");
	var $cont = $(".showBox > div"); //得到显示隐藏的内容
	var $cont_wds = $("#wds > div"); //得到显示隐藏的内容
	var $cont_nav = $(".tab-cont> div"); //得到显示隐藏的内容
	var $cont_pm = $("#rank> div"); //得到显示隐藏的内容
	var $cont_nav_xg = $(".show> div"); //得到显示隐藏的内容
	var $tit_xg = $("#edit ul li");
	var $tit_user = $(".user_nav a");
	var $cont_user = $("#persindex > div"); //得到显示隐藏的内容

	var $a = $(".on").index(); //
	$tits.click(function() {
		var $tit_index = $(this).index(); //得到标题索引
		$(this).addClass("on").siblings().removeClass("on"); //切换背景
		$cont.eq($tit_index).show().siblings().hide();
	});
	$tit.click(function() {
		var $tit_index = $(this).index(); //得到标题索引
		$(this).addClass("on").siblings().removeClass("on"); //切换背景
		$cont_wds.eq($tit_index).show().siblings().hide();
	});
	$tit2.click(function() {
		var $tit_index = $(this).index(); //得到标题索引
		$(this).addClass("on").siblings().removeClass("on"); //切换背景
		$cont_nav.eq($tit_index).show().siblings().hide();
	});
	$tit3.click(function() {
		var $tit_index = $(this).index(); //得到标题索引
		$(this).addClass("on").siblings().removeClass("on"); //切换背景
		$cont_pm.eq($tit_index).show().siblings().hide();
	});
	$tit_xg.click(function() {
		var $tit_index = $(this).index(); //得到标题索引
		$(this).addClass("on").siblings().removeClass("on"); //切换背景
		$cont_nav_xg.eq($tit_index).show().siblings().hide();
	});

	$tit_user.click(function() {
		var $tit_index = $(this).index(); //得到标题索引
		$(this).addClass("on").siblings().removeClass("on"); //切换背景
		$cont_user.eq($tit_index).show().siblings().hide();
		return false
	});

	//
	$("#af-log li").hover(function() {
		$(this).children(".userinfo").show()
	}, function() {
		$(this).children(".userinfo").hide()
	})
	$("#news dt strong").click(function() {
		var $cont = $(".noteCon > dl");
		var inde = $(this).index();
		$(this).addClass("on").siblings().removeClass("on");
		$cont.eq(inde).show().siblings().hide()
	})

	$(".tool_ask_uploadbar a").click(function() {
		$(".tool_upload_box").show()
	})
	$(".x_close").click(function() {
		$(".tool_upload_box").hide()
	})
	$(".delimg").click(function() {
		$(this).parents("li").remove()
	})

});