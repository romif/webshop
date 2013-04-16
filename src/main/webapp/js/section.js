$(document).ready (function()
{
	loadAjaxContent('/user/?mode=login&'+Math.round(Math.random()*10000000), 'loginPlace');
});

$(window).load (function()
		{
			  if($('#vlightbox').css('display')=='block') {
					// отображение лупы, если картинка больше заданной в макете
					if ($('#img_ico0').width() > 294 ){
						$("#view_big").addClass("lups");
						$("#view_big").click(function() {
						ShowGallery()});
					}
						//инициализация плагина галереи
						  	 window.Lightbox = new jQuery().visualLightbox({
						        borderSize: 57,
						        classNames: 'vlightbox',
						        closeLocation: 'top',
						        descSliding: false,
						        enableRightClick: false,
						        enableSlideshow: false,
						        overlayOpacity: 0.5,
						        resizeSpeed: 7,
						        slideTime: 4,
						        startZoom: false
						    })
					}
		});

//Функция показывает в блоке изображение связанное с иконкой 
function show_image(url_img, id) {
	$("#item_img").attr( {src : url_img});
	$("#view_big").unbind("click");
	$("#view_big").attr('temp_id',id);
	if ($('#img_'+id).width() > 294 ){
		$("#view_big").addClass("lups");
		$("#view_big").click(function() {
		ShowGallery()});
		
	}else {
		$("#view_big").removeClass("lups");
	}
	$("#icon_gallerey a").removeClass("sel");
	$("a." + id).addClass("sel");
};

// Функция вызывает показ галереи
function ShowGallery() {
	var click_id=$('#view_big').attr('temp_id');
	$('a#'+click_id).click();
}

function _chactionpg()
{
	formoptiopn = document.getElementById('oppg');
	if (formoptiopn.options[formoptiopn.selectedIndex].value)
	{
		if (formoptiopn.options[formoptiopn.selectedIndex].value != '')
			document.location = formoptiopn.options[formoptiopn.selectedIndex].value
	}
}

function _chactionpg2()
{
	formoptiopn2 = document.getElementById('oppg2');
	if (formoptiopn2.options[formoptiopn2.selectedIndex].value)
	{
		if (formoptiopn2.options[formoptiopn2.selectedIndex].value != '')
			document.location = formoptiopn2.options[formoptiopn2.selectedIndex].value
	}
}

function _chaction()
{
	formoptiopn = document.getElementById('optd');
	if (formoptiopn.options[formoptiopn.selectedIndex].value)
	{
		if (formoptiopn.options[formoptiopn.selectedIndex].value != '')
			document.location = formoptiopn.options[formoptiopn.selectedIndex].value
	}
}
function chactionpg(elem)
{
	document.location.href = elem.options[elem.selectedIndex].value;
}
/*проверка формы обратной связи*/
function CkeckFeedBack() {
	var param = 'no';
	var errorArr = [];
	var summ = $('.feedbackParam').size();						
	if (document.getElementById('name').value=="")	{
		errorArr.push(['name', '1']);
	}
		
	if (document.getElementById('email').value=="") {
		errorArr.push(['email', '1']);
	}

	if (document.getElementById('msg').value=="") {
		errorArr.push(['msg', '1']);
	}
	
	if (document.getElementById('captcha').value=="") {
		errorArr.push(['captcha', '1']);
	}
	
	if (errorArr.length != 0) {
		for (var j=0;j<summ; j++) {
			var idName = $('.feedbackParam').eq(j).attr('id');
			for (var i=0;i<errorArr.length; i++) {
				errorArr[i][0];
				var id = errorArr[i][0];
				if (id==idName) {
					param = i;		
				}
			}
			if (param!='no') {
				errorNomer = errorArr[param][1];
				id = errorArr[param][0];
				if (errorNomer == 1) {
					$('#'+id+'_error').html('Заполните поле');
				} else {
					$('#'+id+'_error').html('Исправьте данные в поле');
				}
				$('#'+id+'_error').show();
				$('#'+id).addClass('borderError');
				param = 'no';
			} else {
				$('#'+idName).removeClass('borderError');
				$('#'+idName+'_error').hide();
			}
		}
		alert('К сожалению, сообщение не может быть отправлено.\nПожалуйста, исправьте неточности в заполнении формы.');
		return false;
	} else {
	
		$.post("/captcha/captcha.php", {captcha: document.getElementById('captcha').value, mode: "check"} , function(data, status){
			if(data==1){
				alert('Сообщение успешно отправлено!\nПостараемся ответить Вам как можно скорее.');
				$("#form1").submit();
			}else{
				alert("Число с картинки введено неверно!");
			}
		});
	
	}
}

function reloadCaptchafeedback() {
	$('#captcha_img').attr('src','/captcha/captcha.php?mode=new&'+Math.round(Math.random()*10000000));
}