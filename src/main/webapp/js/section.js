$(document).ready (function()
{
	loadAjaxContent('/user/?mode=login&'+Math.round(Math.random()*10000000), 'loginPlace');
});

$(window).load (function()
		{
			  if($('#vlightbox').css('display')=='block') {
					// ����������� ����, ���� �������� ������ �������� � ������
					if ($('#img_ico0').width() > 294 ){
						$("#view_big").addClass("lups");
						$("#view_big").click(function() {
						ShowGallery()});
					}
						//������������� ������� �������
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

//������� ���������� � ����� ����������� ��������� � ������� 
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

// ������� �������� ����� �������
function ShowGallery() {
	var click_id=$('#view_big').attr('temp_id');
	$('a#'+click_id).click();
}

function _chactionpg()
{
	formoptiopn = document.getElementById('oppg');
	if (formoptiopn.options[formoptiopn.selectedIndex].value)
	{
		if (formoptiopn.options[formoptiopn.selectedIndex].value != ''){
			var url=window.location.search.substring(1).split("&");
			var bool=true;
			for (i=0;i<url.length;i++){
				if (url[i].split("=")[0]=='page_size'){
					url[i]='page_size='+formoptiopn.options[formoptiopn.selectedIndex].value;
					bool=false;
				}
				if (url[i].split("=")[0]=='page_id'){
					url[i]='page_id=1';
				}
			}
			var url1='?';
			for (i=0;i<url.length;i++){
				url1+=url[i];
				if (i<url.length-1)url1+='&';
			}
			if (bool)url1+='&page_size='+formoptiopn.options[formoptiopn.selectedIndex].value;
			document.location = url1;
		}
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
		if (formoptiopn.options[formoptiopn.selectedIndex].value != ''){
			var url=window.location.search.substring(1).split("&");
			var bool=true;
			for (i=0;i<url.length;i++){
				if (url[i].split("=")[0]=='sort'){
					url[i]='sort='+formoptiopn.options[formoptiopn.selectedIndex].value;
					bool=false;
					break;
				}
			}
			var url1='?';
			for (i=0;i<url.length;i++){
				url1+=url[i];
				if (i<url.length-1)url1+='&';
			}
			if (bool)url1+='&sort='+formoptiopn.options[formoptiopn.selectedIndex].value;
			document.location = url1;
			//document.location = '?'+phone+formoptiopn.options[formoptiopn.selectedIndex].value;
		}
	}
}
function chactionpg(elem)
{
	document.location.href = elem.options[elem.selectedIndex].value;
}
/*�������� ����� �������� �����*/
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
					$('#'+id+'_error').html('��������� ����');
				} else {
					$('#'+id+'_error').html('��������� ������ � ����');
				}
				$('#'+id+'_error').show();
				$('#'+id).addClass('borderError');
				param = 'no';
			} else {
				$('#'+idName).removeClass('borderError');
				$('#'+idName+'_error').hide();
			}
		}
		alert('� ���������, ��������� �� ����� ���� ����������.\n����������, ��������� ���������� � ���������� �����.');
		return false;
	} else {
	
		$.post("/captcha/captcha.php", {captcha: document.getElementById('captcha').value, mode: "check"} , function(data, status){
			if(data==1){
				alert('��������� ������� ����������!\n����������� �������� ��� ��� ����� ������.');
				$("#form1").submit();
			}else{
				alert("����� � �������� ������� �������!");
			}
		});
	
	}
}

function reloadCaptchafeedback() {
	$('#captcha_img').attr('src','/captcha/captcha.php?mode=new&'+Math.round(Math.random()*10000000));
}