var feedbackSubmit = function() {
	
	if(!CheckFeedBack())
		return false;

	var d = {
		'model'		: 'FeedbackForm',
		'name'		: $('#name').val(),
		'email'		: $('#email').val(),
		'message'	: $('#msg').val(),
		'captcha'	: $('#captcha').val()	
	};
	
	$.getJSON('lib/forms/form.php/index/check', d, function(data) {
		if(data == 'success') {
			alert('Сообщение успешно отправлено!\nПостараемся ответить Вам как можно скорее.');
		} else if(data == 'fail') {
			alert('К сожалению, сообщение не может быть отправлено.\nВ ходе выполнения работы произошла ошибка!\n.');
		}
        CheckFeedBack(data);
		$('#captcha_img').attr('src', '/captcha/captcha.php?mode=new&'+(new Date).getTime());
    });
	return false;
}



function CheckFeedBack(errors) {
	var param = 'no';
	var errorArr = [];
	var summ = $('.feedbackParam').size();	
	if(errors == undefined) {
		if ($('#name').val()=="")	{
			errorArr.push(['name', '1']);
		}
			
		if ($('#email').val()=="") {
			errorArr.push(['email', '1']);
		}

		if ($('#msg').val()=="") {
			errorArr.push(['msg', '1']);
		}
		
		if ($('captcha').val()=="") {
			errorArr.push(['captcha', '1']);
		}
	} else {
		if (errors.name != undefined)	{
			errorArr.push(['name', '2']);
		}
			
		if (errors.email != undefined) {
			errorArr.push(['email', '2']);
		}

		if (errors.message != undefined) {
			errorArr.push(['msg', '2']);
		}
		
		if (errors.captcha != undefined) {
			errorArr.push(['captcha', '2']);
		}
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
				if (errorNomer == 2) {
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
			var idName = $('.feedbackParam').eq(j).attr('id');
			$('#'+idName).removeClass('borderError');
			$('#'+idName+'_error').hide();
			if(errors == 'success') 
				$('#'+idName).val('');
		}
	}
	return true;
}