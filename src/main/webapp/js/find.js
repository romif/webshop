function find_form(id) {	
	var find_form	=	$('#f'+id);
	
	var main_course	=	find_form.find('#main_course').val(); 	//курс основной валюты
	var course		=	find_form.find('#course').val();		//курс первой валюты
	
	var error 		=	[]; 									//сообщения об ошибках
	
	//Переводим в оснавную валюту
	var checkBefore = find_form.find('#price_before_new').val();
	var checkAfter = find_form.find('#price_after_new').val();
	//проверка на число
	if ((!checkBefore.match(/^[0-9\,\.\(\)]*$/))||(!checkAfter.match(/^[0-9\,\.\(\)]*$/))) {
		error.push(0);
	}
	//проверка на "," и замена
	if (checkBefore.indexOf(',')!=-1) {
		checkBefore = checkBefore.replace(",",".");
		find_form.find('#price_before_new').val(checkBefore);
	}
	if (checkAfter.indexOf(',')!=-1) {
		checkAfter=checkAfter.replace(",",".");
		find_form.find('#price_after_new').val(checkAfter);
	}
	//поля из базы
	for (var i=0;i<find_form.find('.minNumber').length;i++) {
		//проверка полей из базы на ',' и замена
		if (find_form.find('.minNumber')[i].value.indexOf(',')!=-1) {
			find_form.find('.minNumber')[i].value = find_form.find('.minNumber')[i].value.replace(",",".");			
		}
		if (find_form.find('.maxNumber')[i].value.indexOf(',')!=-1) {
			find_form.find('.maxNumber')[i].value = find_form.find('.maxNumber')[i].value.replace(",",".");
		}
		//проверка полей из базы на число
		if (!find_form.find('.maxNumber')[i].value.match(/^[0-9\,\.\(\)]*$/)||!find_form.find('.minNumber')[i].value.match(/^[0-9\,\.\(\)]*$/)) {
			error.push(i+2);
		}
	}
	price_before = find_form.find('#price_before_new').val() * course / main_course;
	price_after = find_form.find('#price_after_new').val() * course / main_course;
	
	if ( (price_after!='') & (price_before>price_after) ) {	 
		error.push(1);
	}

	
	if (!error.length) {
		
		var price_before = find_form.find('#price_before_new').val()!=""?price_before:'';
		find_form.find('#price_before').attr('value',price_before);
		
		var price_after = find_form.find('#price_after_new').val()!=""?price_after:'';
		find_form.find('#price_after').attr('value',price_after);
		
		$('#f'+id).submit();	
	} else {
	
		//выводим ошибки
		if (typeof(console)=='object') {
			
			console.group ("find error");
			console.log ('Неправильно заполнены поля поиска.');
			console.groupEnd();			
		}
		alert('Неправильно заполнены поля поиска.');
	}	
	return false;
}


function shSB(i)
{
	if (document.getElementById('sb'+i))
	{
		if ( !document.getElementById('sb'+i).style.display)
		{
			var mstr = document.getElementById('si'+i).src.toString();
			var re = /(.)?plus(.)?/i;
			if (mstr.match(re) )
			{
				document.getElementById('sb'+i).style.display = 'none';
			}
			else
			{
				document.getElementById('sb'+i).style.display = 'block';
			}
		}
		if (document.getElementById('sb'+i).style.display == 'none')
		{
			document.getElementById('sb'+i).style.display = 'block';
		}
		else
		{
			document.getElementById('sb'+i).style.display = 'none';
		}
	}
	
}

function CheckFind()
{
	if (document.getElementById('findtext').value == '')
		return false;
	return true;
}


function getTitles(phoneMan) {
	var select = document.getElementById('phonesTitles');
	document.getElementById('editTable').style.visibility='hidden';
	select.options.length = 0;
	select.options[select.options.length] = new Option();
	select.options[0].style.display='none';
	document.getElementById('preload').style.display='block';
	var d = {
			'mode'			: 'edit',
			'manufacture'		: phoneMan	
		};
	$.getJSON('/index', d, function(data) {
		$.each(data, function(key, val) {
			if ((key==0)&&(val=='error')) {
				document.location = '/index';
				return false;
			}
			select.options[select.options.length] = new Option(val, key);
		  });
		select.disabled=false;
		document.getElementById('preload').style.display='none';

    });
	return false;		
}

function getPhone(phoneId) {
	document.getElementById('preload').style.display='block';
	var d = {
			'mode'			: 'edit',
			'phoneId'		: phoneId	
		};
	$.getJSON('/index', d, function(data) {
		$.each(data, function(key, val) {
			if ((key==0)&&(val=='error')) {
				document.location = '/index';
				return false;
			}
			document.getElementsByName(key)[0].value=val;
		  });

		document.getElementById('preload').style.display='none';
		
		var img = document.createElement('img');
		img.src = 'http://tomcat7-romif.rhcloud.com/picture?pic='+phoneId;
		document.getElementById('picture').appendChild(img);
		document.getElementById('editTable').style.visibility='visible';
		//document.getElementById('picture').innerHTML = "<img src='http://tomcat7-romif.rhcloud.com/picture?pic="+phoneId+"/>";
		

    });
	return false;		
}







