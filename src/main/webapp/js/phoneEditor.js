function getTitles(ManufId) {
	var select = document.getElementById('phonesTitles');
	document.getElementById('editTable').style.visibility='hidden';
	document.getElementById('delBut').style.visibility='hidden';
	select.options.length = 0;
	select.options[select.options.length] = new Option();
	select.options[0].style.display='none';
	document.getElementById('preload').style.display='block';
	var d = {
			'mode'			: 'edit',
			'GetTitles'		: ManufId	
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
		var picture=document.getElementById('picture');
		var child=picture.firstChild;
		if (child!=null) picture.removeChild(child);
		picture.appendChild(img);
		document.getElementById('editTable').style.visibility='visible';
		document.getElementById('delBut').style.visibility='visible';
		//document.getElementById('picture').innerHTML = "<img src='http://tomcat7-romif.rhcloud.com/picture?pic="+phoneId+"/>";
		

    });
	return false;		
}


function editPhoneRadio(){
	if (document.getElementById('phonesTitles').selectedIndex==0){
		document.getElementById('editTable').style.visibility='hidden';
		document.getElementById('delBut').style.visibility='hidden';
		document.getElementById('preload').style.display='block';
		var select = document.getElementById('phonesManuf');
		select.options.length = 0;
		select.options[select.options.length] = new Option();
		select.options[0].style.display='none';
		var d = {
				'mode'			: 'edit',
				'getManuf'		: 'getManuf'	
			};
		$.getJSON('/index', d, function(data) {
			$.each(data, function(key, val) {
				if ((key==0)&&(val=='error')) {
					document.location = '/index';
					return false;
				}
				select.options[select.options.length] = new Option(val, key);
			  });
			document.getElementById('preload').style.display='none';
		});
	}
	else 
		document.getElementById('delBut').style.visibility='visible';
	document.getElementById('selectPhone').style.visibility='visible';
	return false;
}

function deletePhone(){
	var select = document.getElementById("phonesTitles");
	var title=select.options[select.selectedIndex].text;
	var r=confirm("Вы действительно хотите удалить телефон "+title+" ?");
	if (r==true){
		document.getElementById('preload').style.display='block';
		var phoneId=select.options[select.selectedIndex].value;
		$.post('/index', {
			mode : 'edit',
			deletePhone : phoneId
			},
			function(data) {
				if (data==1)alert('Телефон удален');
				else alert('Ошибка! Телефоне не существует в базе данных');
				document.getElementById('preload').style.display='none';
				document.location = '/index';
			});
		
	  }

}




