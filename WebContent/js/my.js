// JavaScript Document
$(function() {
	var $key = 0;
	var $circle = 0;
	var $k = 0;
	var $kes = 0;
	var $ke = 0;
	$(".pic1 ul li:first").clone().appendTo($(".pic1 ul"));
	$(".pic1 ul li").width($(window).width()); /*li 的宽度是 屏幕的宽度*/
	$(".right").click(function(event) {
		autoplay()
	});
	$(window).resize(function(event) {
		$(".pic1 ul li").width($(window).width());
	});
	var timer = setInterval(autoplay, 3000);
	function autoplay() {
		$key++;
		/*留下*/
		if ($key > $(".pic1 ul li").length - 1) {
			$key = 1;
			$(".pic1 ul").css("left", 0);
		}
		$(".pic1 ul").stop().animate({
			"left" : -$key * $(window).width()
		}, 1000);
		$circle++;
		if ($circle > 3) /*因为是4个点，最大的索引号是3  当大于3 就返回 0*/
		{
			$circle = 0;
		}
		$(".pic1 ol li").eq($circle).addClass('current').siblings()
				.removeClass('current');
	}
	/*鼠标经过停止定时器*/
	$(".pic1").hover(function() {
		clearInterval(timer);
		timer = null;
	}, function() {/* 鼠标离开 开启定时器*/
		clearInterval(timer);
		timer = setInterval(autoplay, 5000);
	});

	$(".pic1 ol li").click(function(event) {
		$key = $(this).index();
		$circle = $(this).index();
		$(this).addClass('current').siblings().removeClass("current");
		$(".pic1 ul").stop().animate({
			"left" : -$key * $(window).width()
		}, 1000); /*缓缓滑动*/
	});

	$(function() {

		var $key = 0;

		$(".rt").click(function(event) {
			autoplay();
		});

		$(".lt").click(
				function(event) {
					$(".major1 ul li").eq($key).fadeOut(600);
					$key--;

					$key = $key % $(".major1 ul li").length;

					$(".major1 ul li").eq($key).fadeIn(600);

					console.log($key);
					$(".major1 ol li").eq($key).addClass('current').siblings()
							.removeClass('current');

				});

		/*定时器开始*/

		var timer = setInterval(autoplay, 3000); /*开启定时器*/
		function autoplay() {
			$(".major1 ul li").eq($key).fadeOut(600);
			$key++;

			$key = $key % $(".major1 ul li").length;

			$(".major1 ul li").eq($key).fadeIn(600);

			//console.log($key);
			$(".major1 ol li").eq($key).addClass('current').siblings()
					.removeClass('current');
		}

		$(".major1").hover(function() {
			$(".lt,.rt").show();
			clearInterval(timer);
			timer = null; /*节省内存*/
		}, function() {
			$(".lt,.rt").hide();

			clearInterval(timer);
			timer = setInterval(autoplay, 2000);
		});

		$(".major1 ol li").click(function(event) {
			$(".major1 ul li").eq($key).fadeOut(600); /*因为 我们不知道当前播放了第几张 当我们点击了这个ol li 的时候，把当前的那个隐藏起来*/
			/*console.log($key);*/
			$key = $(this).index();/* 把当前的索引号给$key 更该图片xuhao*/
			$(this).addClass('current').siblings().removeClass("current");
			/*console.log($key);*/
			$(".major1 ul li").eq($key).fadeIn(600); /*显示出你点击的那个*/

		});
	});

	$(function() {

		var $key = 0;

		$(".right").click(function(event) {
			autoplay();
		});

		$(".left").click(
				function(event) {
					$(".top-min ul li").eq($key).fadeOut(600);
					$key--;

					$key = $key % $(".top-min ul li").length;

					$(".top-min ul li").eq($key).fadeIn(600);

					console.log($key);
					$(".top-min ol li").eq($key).addClass('current').siblings()
							.removeClass('current');

				});

		/*定时器开始*/

		var timer = setInterval(autoplay, 4000);
		function autoplay() {
			$(".top-min ul li").eq($key).fadeOut(600);
			$key++;

			$key = $key % $(".top-min ul li").length;

			$(".top-min ul li").eq($key).fadeIn(600);

			//console.log($key);
			$(".top-min ol li").eq($key).addClass('current').siblings()
					.removeClass('current');
		}

		$(".top-min").hover(function() {
			$(".left,.right").show();
			clearInterval(timer);
			timer = null; /*节省内存*/
		}, function() {
			$(".left,.right").hide();

			clearInterval(timer);
			timer = setInterval(autoplay, 2000);
		});

		$(".top-min ol li").click(function(event) {
			$(".top-min ul li").eq($key).fadeOut(600); /*因为 我们不知道当前播放了第几张 当我们点击了这个ol li 的时候，把当前的那个隐藏起来*/
			/*console.log($key);*/
			$key = $(this).index();/* 把当前的索引号给$key 更该图片xuhao*/
			$(this).addClass('current').siblings().removeClass("current");
			/*console.log($key);*/
			$(".top-min ul li").eq($key).fadeIn(600); /*显示出你点击的那个*/

		});
	});

	$(function() {

		var $key = 0;

		$(".rit").click(function(event) {
			autoplay();
		});

		$(".let").click(
				function(event) {
					$(".hotspot1 ul li").eq($key).fadeOut(600);
					$key--;

					$key = $key % $(".hotspot1 ul li").length;

					$(".hotspot1 ul li").eq($key).fadeIn(600);

					console.log($key);
					$(".hotspot1 ol li").eq($key).addClass('current')
							.siblings().removeClass('current');

				});

		/*定时器开始*/

		var timer = setInterval(autoplay, 5000);
		function autoplay() {
			$(".hotspot1 ul li").eq($key).fadeOut(600);
			$key++;

			$key = $key % $(".hotspot1 ul li").length;

			$(".hotspot1 ul li").eq($key).fadeIn(600);

			//console.log($key);
			$(".hotspot1 ol li").eq($key).addClass('current').siblings()
					.removeClass('current');
		}

		$(".hotspot1").hover(function() {
			$(".let,.rit").show();
			clearInterval(timer);
			timer = null; /*节省内存*/
		}, function() {
			$(".let,.rit").hide();

			clearInterval(timer);
			timer = setInterval(autoplay, 2000);
		});

		$(".hotspot1 ol li").click(function(event) {
			$(".hotspot1 ul li").eq($key).fadeOut(600); /*因为 我们不知道当前播放了第几张 当我们点击了这个ol li 的时候，把当前的那个隐藏起来*/
			/*console.log($key);*/
			$key = $(this).index();/* 把当前的索引号给$key 更该图片xuhao*/
			$(this).addClass('current').siblings().removeClass("current");
			/*console.log($key);*/
			$(".hotspot1 ul li").eq($key).fadeIn(600); /*显示出你点击的那个*/

		});
	});

	$(function() {
		$(".mall-top-r ul li").hover(
				function() {
					$(".mall-bottom ul").eq($(this).index()).css("display",
							"block").siblings().css("display", "none");
				})
	});

	$(function() {
		$(".hotspot3-top ol li").hover(
				function() {
					$(".hotspot3-in ul").eq($(this).index()).css("display",
							"block").siblings().css("display", "none");
				})
	});
	$(document).ready(function() {
		jQuery(function() {
			jQuery(".indexmax .btn").click(function() {
				jQuery('.indexmax').slideUp(500);
				jQuery('.indexmin').slideDown(500);
			});
			jQuery(".indexmin .btn").click(function() {
				jQuery('.indexmin').slideUp(500);
				jQuery('.indexmax').slideDown(500);
			});
		});
		setTimeout(function() {
			jQuery('.indexmin').slideUp(500);
			jQuery('.indexmax').slideDown(500);
		}, 500);
		setTimeout(function() {
			jQuery('.indexmax').slideUp(500);
			jQuery('.indexmin').slideDown(500);
		}, 3500);
	});
	$(function() {
		$(".fresh-one .btn,.fresh-one1 .btn,.fresh-one2 .btn").click(
				function() {
					$(this).parent("li").slideUp(500);//500
					if ($(".fresh ul li:hidden").length > 1) {
						//alert("11");
						$(".close").hide();
					}
					$(this).parent("li").slideUp(500);//500
				});

		$(".close").click(function() {
			$(this).siblings("ul").slideUp(800);//800
			$(this).hide();
		});

	})
	/*var i=5;
	 var t=setInterval(a,3000);
	 function a(){
	 i--;
	 if (i<2) {
	 $(".fresh").hide(3000);
	 i=3;  
	 i++;
	 console.log(i)
	 }
	 }*/

});