// JavaScript Document
 
    $(function(){

	$('body').click(function(){
		$('.bd').addClass('undis');
	});
	
	$('[name="choose"] .hd').on('click',function(){
		$('.bd').addClass('undis');
		$(this).siblings('.bd').removeClass('undis');
		return false;
	});

	$(document).on('click','[name="choose"] .bd li',function(){
		var txt = $(this).html();
		$(this).parent().addClass('undis');
		$(this).parent().siblings('.hd').children('.text').text(txt);
		return false;
	});
});
