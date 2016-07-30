// JavaScript Document
$(document).ready(function() {
	var $key=0;
	var $circle=0;
	var $ke=0
	$(".pic1 ul li:first").clone().appendTo($(".pic1 ul"));
		$(".pic1 ul li").width($(window).width()); 
		/*$(".right").click(function(event) 
		{
			autoplay()
        });
		$(window).resize(function(event) 
		{
			$(".pic1 ul li").width($(window).width());
		});*/
		var timer=setInterval(autoplay,3000);
		    function autoplay()
		    {  
			     $ke++;
			/*留下*/
			     if($ke>$(".pic1 ul li").length-1)
			{
				$ke=1;
				$(".pic1 ul").css("left",0);
			}
			$(".pic1 ul").stop().animate({"left":-$ke*$(window).width()},1000);
			    $circle++;
		       if($circle>3)  /*因为是4个点，最大的索引号是3  当大于3 就返回 0*/
		    {
			   $circle=0;  
		    }
		       $(".pic1 ol li").eq($circle).addClass('current').siblings().removeClass('current');
			}
			/*鼠标经过停止定时器*/
	$(".pic1").hover(function() {
		clearInterval(timer);
		timer=null;
	}, function() {/* 鼠标离开 开启定时器*/
		clearInterval(timer);
		timer=setInterval(autoplay, 5000);
	});
		  
	    $(".pic1 ol li").click(function(event) {
		$ke=$(this).index();
		$circle=$(this).index();
		$(this).addClass('current').siblings().removeClass("current");
		$(".pic1 ul").stop().animate({"left":-$ke*$(window).width()},1000);  /*缓缓滑动*/
		})


		$(function()
		{
			$(".rt").click(function(event) {
         autoplay();  
    });
    

      $(".lt").click(function(event) {
    	$(".mend ul li").eq($key).fadeOut(600);  
    	$key--; 
    	
		$key=$key%$(".mend ul li").length; 
		
    	$(".mend ul li").eq($key).fadeIn(600);   
    	
        console.log($key);
        $(".mend ol li").eq($key).addClass('current').siblings().removeClass('current');

    });

      /*定时器开始*/

      
       var timer=setInterval(autoplay, 3000);  /*开启定时器*/
       function autoplay(){
	       	$(".mend ul li").eq($key).fadeOut(600); 
	    	$key++;  
	    	
			$key=$key%$(".mend ul li").length;  
			
	    	$(".mend ul li").eq($key).fadeIn(600);   
	    	
	        console.log($key);
	        $(".mend ol li").eq($key).addClass('current').siblings().removeClass('current');
       }
      

       $(".mend").hover(function() {
          $(".lt,.rt").show();
          clearInterval(timer);
          timer=null;   /*节省内存*/
       }, function() {
         $(".lt,.rt").hide();
       
         clearInterval(timer);  
         timer=setInterval(autoplay, 2000);  
       });

     

     

      $(".mend ol li").click(function(event) {
      	$(".mend ul li").eq($key).fadeOut(600);  /*因为 我们不知道当前播放了第几张 当我们点击了这个ol li 的时候，把当前的那个隐藏起来*/
      	/*console.log($key);*/
      	$key=$(this).index();/* 把当前的索引号给$key 更该图片xuhao*/
      	$(this).addClass('current').siblings().removeClass("current");
      	/*console.log($key);*/
      	$(".mend ul li").eq($key).fadeIn(600); /*显示出你点击的那个*/

        });
		})
		
		
$(function(){
  $(".relea-t p").hover(function(){
    $(".content-left .releat ul").eq($(this).index()).css("display","block").siblings().css("display","none");
  })
 });

});

