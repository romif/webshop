var regSubmit = function(ids) {

	if(!shopReg())
		return false;
	var email2 = $('#reg_email').val();
	var pass = $('#reg_password').val();
	var d = {
		'model'			: 'RegShopForm',
		'reg_email'		: $('#reg_email').val(),
		'reg_password'	: $('#reg_password').val(),
		'reg_password2'	: $('#reg_password2').val(),
		'captcha'		: $('#reg_captcha').val()	
	};
	
	$.getJSON('http://' + location.host + '/WebShop/index', d, function(data) {

		if(data == 'succes') {
			alert('Регистрация прошла успешно!');
			$.post('http://localhost:8080/WebShop/index', {
				mode : 'login',
				type : 'email_password',
				email : email2,
				password : pass
				},
				function(data) {
					document.location = 'http://' + location.host + '/WebShop/index?mode=userinfo';
				});
		//	document.location = '/profile/?mode=userinfo';
		} else if(data == 'fail') {
			alert('Ошибка при отправке запроса: такой логин уже существует.');
			return false;
		}else alert(data);
        shopReg(data);
		//$('#captcha_img').attr('src', '/captcha/captcha.php?mode=new&'+(new Date).getTime());
    });
	return false;
}

function shopReg(errors) {

	var email2 = $('#reg_email').val();
	var pass = $('#reg_password').val();
	var pass2 = $('#reg_password2').val();
	var param = 'no';
	var errorArr = []; //массив ошибок
	var summ = $('.regParam').size();
	
	emailTest = "^[_\\.0-9a-z-]+@([0-9a-z][0-9a-z_-]+\\.)+[a-z]{2,4}$";
	passTest = "^.{4,}";

	var regex_email = new RegExp(emailTest, 'i');
	var regex_pass = new RegExp(passTest);
	
	if(errors == undefined) {
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

	} else {
		if (errors.reg_email != undefined)	{
			errorArr.push(['reg_email', '3']);
		}
			
		if (errors.reg_password != undefined) {
			errorArr.push(['reg_password', '3']);
		}

		if (errors.reg_password2 != undefined) {
			errorArr.push(['reg_password2', '3']);
		}
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
				if (errorNomer == 3) {
					$('#'+id+'_error').html(errors[id][0]);
				} else if (errorNomer == 1) {
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
		for (var j=0;j<summ; j++) {
			var idName = $('.regParam').eq(j).attr('id');
			$('#'+idName).removeClass('borderError');
			$('#'+idName+'_error').hide();
			if(errors == 'success') 
				$('#'+idName).val('');
		}
	}
	return true;
}

var newPassSubmit = function() {
	if (!newPassCheck())return false;
	document.getElementById('preload').style.display='inline';
	var email = $('#login').val();
	var pass = $('#reg_password').val();
	var d = {
		'mode'			: 'newPass',
		'email'		: $('#login').val(),
		'password'	: $('#reg_password').val(),
	};
	
	$.getJSON('http://' + location.host + '/WebShop/index', d, function(data) {
		
		if(data == 'succes') {
			alert('Пароль успешно изменен!');
			$.post('http://' + location.host + '/WebShop/index', {
				mode : 'login',
				type : 'email_password',
				email : email,
				password : pass
				},
				function(data) {
					document.location = 'http://' + location.host + '/WebShop/index?mode=userinfo';
				});
		} else if(data == 'fail') {
			alert('Ошибка при отправке запроса: такой логин не существует.');
			return false;
		};
		newPassCheck(errors);
    });
	document.getElementById('preload').style.display='none';
	return false;
};

function newPassCheck(errors) {

	var pass = $('#reg_password').val();
	var pass2 = $('#reg_password2').val();
	var param = 'no';
	var errorArr = []; //массив ошибок
	var summ = $('.regParam').size();
	passTest = "^.{4,}";
	var regex_pass = new RegExp(passTest);
	
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
				if (errorNomer == 3) {
					$('#'+id+'_error').html(errors[id][0]);
				} else if (errorNomer == 1) {
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
		for (var j=0;j<summ; j++) {
			var idName = $('.regParam').eq(j).attr('id');
			$('#'+idName).removeClass('borderError');
			$('#'+idName+'_error').hide();
			if(errors == 'success') 
				$('#'+idName).val('');
		}
	}
	return true;
}