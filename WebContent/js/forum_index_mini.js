﻿jQuery.easing['jswing']=jQuery.easing['swing'];jQuery.extend(jQuery.easing,{def:'easeOutQuad',easeOutCubic:function(x,t,b,c,d){return c*((t=t/d-1)*t*t+1)+b;}});snclickScroll=function(id,btnL,btnR,w){var i=0;var speed=300;var obj=$(id).find("ul");var oli=obj.find("li");var len=obj.find("li").length;$(btnL).click(function(){if(len==1||obj.is(":animated")){return false;};if(i==0){oli.eq(len-1).css({"position":"relative","left":-len*w+"px"})};i--;obj.stop().animate({"marginLeft":-w*i},speed,function(){if(i==-1){i=len-1;oli.eq(len-1).removeAttr("style");obj.css("marginLeft",-i*w);};});var v=obj.find("img[src3]");v.each(function(){$(this).attr("src",$(this).attr("src3")).removeAttr("src3");});});$(btnR).click(function(){if(len==1||obj.is(":animated")){return false;};if(i==len-1){oli.eq(0).css({"position":"relative","left":len*w+"px"})};i++;obj.stop().animate({"marginLeft":-w*i},speed,function(){if(i==len){i=0;oli.eq(0).removeAttr("style");obj.css("marginLeft",i*w);};});var v=obj.find("img[src3]");v.each(function(){$(this).attr("src",$(this).attr("src3")).removeAttr("src3");});});};snNavMneu=function(){var timer=0;$(".navlist").mouseover(function(){var ref=$(this);ref.find("h3").addClass("hover");ref.find(".navmore").show();$(this).css("z-index",5);}).mouseout(function(){var ref=$(this);ref.find("h3").removeClass("hover");ref.find(".navmore").hide();$(this).css("z-index",3);});};snmouseoverSroll=function(btn,id,w){var speed=300;$(btn).find("span").mouseover(function(){index=$(this).text()-1;$(this).addClass("on").siblings().removeClass("on");$(id).stop().animate({left:[-w*index,'easeOutCubic']},speed);var v=$(id).find("img[src3]");v.each(function(){$(this).attr("src",$(this).attr("src3")).removeAttr("src3");});});};snadTabfive=function(btn,id,w){var speed=300;$(btn).find("li").mouseover(function(){index=$(btn).find("li").index(this);$(this).addClass("hover").siblings().removeClass("hover");$(id).stop().animate({marginTop:[-w*index,'easeOutCubic']},speed);var v=$(id).find("img[src3]");v.each(function(){$(this).attr("src",$(this).attr("src3")).removeAttr("src3");});});};snBuyToplist=function(id){$(id).find("li").mouseover(function(){$(this).addClass("hover").siblings().removeClass("hover");$(this).find("p").addClass("hide").parent().siblings().find("p").removeClass("hide");$(this).find(".prolist").show().parent().siblings().find(".prolist").hide();var v=$(this).find("img[src3]");v.each(function(){$(this).attr("src",$(this).attr("src3")).removeAttr("src3");});});};LoadSNTabFlash=function(){$("#snflashlist").append($("#fcs").html());}
snAutoFlash=function(id,btnId,w){LoadSNTabFlash();var index=0;var timer;var obj=$("#"+id).find("ul");var len=obj.find("li").length;var btn=$("#"+btnId).find("dt");var speed=300;var child=obj.find("li").eq(0).html();obj.append("<li>"+child+"</li>");btn.mouseover(function(){index=btn.index(this);$(this).addClass("on").siblings().removeClass('on');auto(index);});$("#"+id).hover(function(){clearInterval(timer);},function(){timer=setInterval(function(){if(index==len){index=0;obj.css({left:-w*index});};index++;if(index==len){btn.eq(0).addClass("on").siblings().removeClass('on');}else{btn.eq(index).addClass("on").siblings().removeClass('on');}auto(index);},4000);}).trigger("mouseleave");function auto(index){obj.stop().animate({"top":[-w*index,'easeOutCubic']},speed);};}
var catMouseCount=0;function setCatNum(catN){catMouseCount=catN;};function addhover(o){if(catMouseCount==0){invokeMiniCart();catMouseCount++;}
$(o).find(".menuHd").eq(0).addClass("hover");$(o).find("div").show();$(o).css("z-index",5);};function delhover(o){$(o).find(".menuHd").eq(0).removeClass("hover");$(o).find("div").hide();$(o).css("z-index",4);};function mobleChangeHtml(o,id){$(o).hide();$("#"+id).css("display","block");};snTabclick=function(id,showId){$(id).find("dt").mouseover(function(){index=$(id).find("dt").index(this);var ref=$(this);time=setTimeout(function(){ref.addClass("on").siblings().removeClass("on");$(showId).addClass("hide").eq(index).removeClass("hide");},200);var v=$(id).find("dd").eq(index).find("img[src3]");v.each(function(){$(this).attr("src",$(this).attr("src3")).removeAttr("src3");});}).mouseout(function(){clearTimeout(time);});$("#storeAll dt a").mouseover(function(){index=$("#storeAll dt a").index(this);$(this).addClass("on").siblings().removeClass("on");$("#storeAll dd").addClass("hide").eq(index).removeClass("hide");var v=$("#storeAll dd").eq(index).find("img[src3]");v.each(function(){$(this).attr("src",$(this).attr("src3")).removeAttr("src3");});})};snTopBablist=function(id){$(id).find("dt").mouseover(function(){index=$(id).find("dt").index(this);var ref=$(this);time=setTimeout(function(){ref.addClass("on").siblings().removeClass("on");ref.parent().find("dd").addClass("hide").eq(index).removeClass("hide");},200);var v=$(id).find("dd").eq(index).find("img[src3]");v.each(function(){$(this).attr("src",$(this).attr("src3")).removeAttr("src3");});}).mouseout(function(){clearTimeout(time);});};snInputhover=function(id){$(id).focus(function(){$(this).addClass("focus");if($(this).val()==$(this)[0].defaultValue){$(this).val("");};});$(id).blur(function(){$(this).removeClass("focus");if($(this).val()==''){$(this).val($(this)[0].defaultValue);}});};spiketTime=function(id,startTime,endTime){if(endTime<=0)
return;var base=$("#"+id).find('span');var s1=base.eq(0);var s2=base.eq(1);var s3=base.eq(2);var s4=base.eq(3);var type=1;var mm=10;var interval;function formatTime(t){if(t>0){var totalSecond=t/1000;var minute=Math.floor(totalSecond/60);var hour=Math.floor(minute/60);minute=minute%60;var second=Math.floor(totalSecond%60);return[hour,minute,second];}else{clearInterval(interval);return[0,0,0,0];}}
var timerLeft=function(t,e){var start=(new Date()).getTime();return{getLeft:function(){var now=(new Date()).getTime();var s=t-(now-start);if(s<=0&&type==1){this.getLeft=function(){var now=(new Date()).getTime();var s=e-(now-start);return s;}
return this.getLeft();}
return s;},render:function(){var arr=formatTime(this.getLeft());s1.html(arr[0]);s2.html(arr[1]);s3.html(arr[2]);}}};var tl=timerLeft(startTime,endTime);tl.render();interval=setInterval(function(){mm--;s4.html(mm);if(mm==0){tl.render();mm=10;}},100);}
randomTabclick=function(){var len=$("#storeAll dt a").length;if(len>0){var cout=Math.floor(Math.random()*len);var btn=document.getElementById("storeAll").getElementsByTagName("a");var obj=document.getElementById("storeAll").getElementsByTagName("dd");for(var i=0;i<len;i++){btn[i].className="";obj[i].className="hide";};btn[cout].className="on";obj[cout].className="";var v=$("#storeAll dd").eq(cout).find("img[src3]");v.each(function(){$(this).attr("src", $(this).attr("src3")).removeAttr("src3");});}}
function onlineserver(o){var w=$(window).width();if(w>1024){o.show();$(window).scroll(function(){var isIE=!!window.ActiveXObject;var isIE6=isIE&&!window.XMLHttpRequest;if(isIE6){o.css({position:"absolute",top:$(window).scrollTop()+$(window).height()/2})}})}}

var snTabiframecout = 0 ;function snTabiframe(i,o){snTabiframecout++;var iframe = $("#snTabiframe").text();$("#snTabiframe").css("display","none");if(snTabiframecout<=1){$("#snTabiframe").after(iframe);}};

snProductCategory = function(sLink,sInput){var link = $("#" + sLink);var input = $("#" + sInput);var data = link.next();link.parent().mouseleave(function(e){data.addClass("datanone");link.removeClass("hover");e.preventDefault();	});	data.find("a").click(function(e){e.preventDefault();link.html($(this).parent().html()+"<b></b>");input.value = this.innerHTML;data.addClass("datanone");});link.mouseover(function(e){data.removeClass("datanone");link.addClass("hover");	e.preventDefault();}).click(function(e){link.removeClass("hover");e.preventDefault();	});}

$(function(){snAutoFlash('snflash','snflashBtn',180);snInputhover("#sn_TelInput");snInputhover("#sn_TelInputall");snInputhover("#searchKeywords");snmouseoverSroll("#snproHot .proAlltab","#snproHot ul","528");snmouseoverSroll("#snproNew .proAlltab","#snproNew ul","528");snclickScroll('#snhotlist','.snprev','.snnext','493');snNavMneu();snadTabfive("#snadlistBtn","#snadlistMain","110");$("#seachSumit,.telSubmit,#snweiboSubmit").hover(function(){$(this).addClass("hover");},function(){$(this).removeClass("hover");});snBuyToplist(".snBuyToplist");snTopBablist("#snTopTablist00");snTopBablist("#snTopTablist01");snTopBablist("#snTopTablist02");snTopBablist("#snTopTablist03");snTopBablist("#snTopTablist04");snTabclick("#snnoice","#snnoice dd");snTabclick("#snproAll","#snproAll dd");snTabclick("#snexpressway","#snexpressway .snexpressMain");onlineserver($("#onlinefloat"));var lazyloadRegions="#snfoor00, #snfoor01 , #snfoor02 , #snfoor03 , #snfoor04 , #snfoor05 ,#snfoor06 , .snad110 ,#snweibo ";var isIPad=navigator.userAgent.toLowerCase().match(/iPad/i)=="ipad";var userH=document.documentElement.clientHeight;var pageScrollTop=function(){return isIPad?window.pageYOffset:Math.max(document.documentElement.scrollTop,document.body.scrollTop);};var imgLoad=function(rate){var defObj=$(lazyloadRegions).find("img[src2]");rate=rate||1.5;var clientHeight=document.body.clientHeight;var pt=pageScrollTop();defObj.each(function(){var vTop=$(this).offset().top;if(vTop<=(pt+parseInt(userH*rate))){var src2=$(this).attr("src2");if(src2){$(this).attr("src",src2).removeAttr("src2");defObj=defObj.not($(this)[0]);}}});};var imgLoadall=function(){imgLoad(100);$(window).unbind("scroll",imgLoad);randomTabclick();};$(window).bind("scroll",imgLoad);$(window).bind("load",function(){setTimeout(imgLoadall,800);});new snProductCategory("sn_category", "product_category");});