function checkaddress(id) {
	
	var errorArr = [];
	
	if($('#attr_street_185_'+id).val()=='') {
		errorArr.push('street_185');
	}
	if($('#attr_house_175_'+id).val()=='') {
		errorArr.push('house_175');
	}
	if (errorArr.length != 0) {
		/*обнуляем предыдущий результат*/
		$('#attr_house_175_'+id).removeClass('borderError');
		$('#house_175_'+id).hide();
		$('#attr_street_185_'+id).removeClass('borderError');
		$('#street_185_'+id).hide();
		/*---*/
		for (var i=0;i<errorArr.length; i++) {			
			$('#'+errorArr[i]+'_'+id).show();
			$('#'+errorArr[i]+'_'+id).html('Заполните поле');
			$('#attr_'+errorArr[i]+'_'+id).addClass('borderError');
		}
		alert('К сожалению, адрес не может быть добавлен.\nПожалуйста, исправьте неточности в заполнении формы.');
		return false;
	} else {
		return true;
	}
}

function log_out()
{
	ht = document.getElementsByTagName("html");
	//ht[0].style.filter = "progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)"; 
	ht[0].style.filter = "progid:DXImageTransform.Microsoft.BasicImage(grayscale=1)";
	if (confirm('Вы действительно хотите выйти?'))
	{
		return true;
	}
	else
	{
		ht[0].style.filter = "";
		return false;
	}
}

/*
---------------------------------------------------------
--------------- Авторизация пользователя ----------------
---------------------------------------------------------
*/


/* загрузка блока пользователя ajax */
function loadAjaxContent (content, place) {
	if($('#'+place).length) {
		$.ajax({
			url: content,
			dataType : "html",
			success: function (data) {
				$('#loginPlace').css('background','none');
				$(data).appendTo($('#'+place));
			}
		})
	}
}

/* Авторизация пользователя через блок входа */
function shopLogin() {
	
	//document.getElementById('preload').style.display='inline';
	$('<div id="loading"></div>').appendTo($('.newLine'));
	$.post('/index', {
		mode : $('#log_mode').val(),
		type : $('#log_type').val(),
		email : $('#log_email').val(),
		password : $('#log_password').val()
		},
		function(data) {
			$('#loginPlace').html(data);
		}
	)
	document.getElementById('preload').style.display='none';
	
	var row = document.getElementById('topMenuRow');
	var cell=row.insertCell();
	cell.innerHTML="<a href='/index?mode=edit' alt='Редактор товаров'>Редактор</a>";
	
}

/* функции показывающие label для полей ввода в форме авторизации */
function hideTitle(elem) {
	$(elem).hide();
	$(elem).next().focus();
}

function clean(elem) {
	$(elem).prev().hide();
}

function showTitle(elem) {
	if ($(elem).val() == '')
	{
		$(elem).prev().show();
	}
}


/* Регистрация */
/*function shopReg(data) {

	var email2 = $('#reg_email').val();
	var pass = $('#reg_password').val();
	var pass2 = $('#reg_password2').val();
	var param = 'no';
	var errorArr = []; //массив ошибок
	var summ = $('.regParam').size();
	var elem = document.createElement("br");
	
	emailTest = "^[_\\.0-9a-z-]+@([0-9a-z][0-9a-z_-]+\\.)+[a-z]{2,4}$";
	passTest = "^.{4,}";

	var regex_email = new RegExp(emailTest, 'i');
	var regex_pass = new RegExp(passTest);

	if (email2=='') {
		errorArr.push(['reg_email', '1']);
	} else if (regex_email.test(email2) == false) {
		errorArr.push(['reg_email', '2']);
	}
	if (pass == '') {
		errorArr.push(['reg_password', '1']);
	} else if (regex_pass.test(pass) == false) {
		errorArr.push(['reg_password', '2']);
	}
	if (pass2=='') {
		errorArr.push(['reg_password2', '1']);
	} else if (pass != pass2) {
		errorArr.push(['reg_password2', '2']);
	}
	if (data != 1)
	{
		errorArr.push(['captcha', '2']);
	}
	if (errorArr.length != 0) {
		for (var j=0;j<summ; j++) {
			var idName = $('.regParam').eq(j).attr('id');
			for (var i=0;i<errorArr.length; i++) {
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

		$.post('/user/', {
			mode : 'reg',
			email : email2,
			password : pass
			},
			function(data) {
				if (data == 0)
				{
					alert('Ошибка при отправке запроса: такой логин уже существует.');
					return false;
				}
				else {					
					document.location = '/user/?mode=reg&klwfjfwehfjkwjhef';
					alert('Регистрация прошла успешно!');
				}
			}
		)
	}
}

/* Проверка капчи */
function checkCaptcha() {
	$.post('/captcha/captcha.php', {
		captcha : $('#captcha').val(),
		mode : 'check'
		}, shopReg
	)
	return false;
}

/* Востановление пароля */
function restorePass() {
	document.getElementById('preload').style.display='inline';
	$('#b-restButton').css('background','url(/pics/loading_white.gif) 118px center no-repeat');
	$.post('/index', {
		mode : 'restore',
		email : $('#res_email').val()
		},
		function(data) {
			if (data == 0)
			{
				$('#res_email_error').html('Исправьте данные в поле.');
				$('#res_email_error').show();
				$('#res_email').addClass('borderError');
				document.getElementById('preload').style.display='none';
				alert('Такого адреса не существует.');
				
			}
			else {				
				$('#res_email').removeClass('borderError');
				$('#res_email').val('');
				$('#res_email_error').hide();
				document.getElementById('preload').style.display='none';
				alert('На указанный e-mail выслана инструкция восстановления пароля.');
				
			}
			$('#b-restButton').css('background','none');
		}
	)
	return false;
}

/* Установка выбранного адреса в качестве основного */
function saveaddr() {
	$.post('/profile/', {
		mode : 'address',
		data_id : $('.radioBut:checked').attr('value'),
		action : 'update',
		attr_active : '1'
	},
	function(data) {
		document.location = '/profile/?mode=address';
	}
	)
}

/* Удаление адреса */
function deleteaddr(d_id) {
	$.post('/profile/', {
		mode : 'address',
		essense_name : 'address',
		data_id : d_id,
		action : 'delete'
	},
	function(data) {
		document.location = '/profile/?mode=address';
	}
	)
}

/* ПоказатьСкрыть блок */
function toggleBlock(elem) {
	$('#'+elem).toggleClass('hideRow');
	return false;
}


function getQueryParameter ( parameterName ) {
	  var queryString = window.top.location.search.substring(1);
	  var parameterName = parameterName + "=";
	  if ( queryString.length > 0 ) {
	    begin = queryString.indexOf ( parameterName );
	    if ( begin != -1 ) {
	      begin += parameterName.length;
	      end = queryString.indexOf ( "&" , begin );
	        if ( end == -1 ) {
	        end = queryString.length
	      }
	      return unescape ( queryString.substring ( begin, end ) );
	    }
	  }
	  return 'main';
	}