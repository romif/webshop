var QueryString = function () {
  // This function is anonymous, is executed immediately and 
  // the return value is assigned to QueryString!
  var query_string = {};
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
    var pair = vars[i].split("=");
    	// If first entry with this name
    if (typeof query_string[pair[0]] === "undefined") {
      query_string[pair[0]] = pair[1];
    	// If second entry with this name
    } else if (typeof query_string[pair[0]] === "string") {
      var arr = [ query_string[pair[0]], pair[1] ];
      query_string[pair[0]] = arr;
    	// If third or later entry with this name
    } else {
      query_string[pair[0]].push(pair[1]);
    }
  } 
    return query_string;
} ();

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
			'getPhone'		: phoneId	
		};
	$.getJSON('/index', d, function(data) {
		document.getElementById('editTable').style.visibility='visible';
		$.each(data, function(key, val) {
			if ((key==0)&&(val=='error')) {
				document.location = '/index';
				return false;
			}
			var elem=document.getElementsByName(key);
			//if (elem.length>0) {
				if (key=='Description'){
					 a = document.body.getElementsByTagName('TEXTAREA');
					 b = document.createElement('TEXTAREA');
					 b.innerHTML = val;
					 a[0].value += b.value;
				}
				else if (key.substring(0,8)=='Checkbox'){
					elem[0].checked='checked';
				}
				else elem[0].value=val;
			//}
		  });
		
		document.getElementById('preload').style.display='none';
		
		var img = document.createElement('img');
		img.src = 'http://tomcat7-romif.rhcloud.com/picture?pic='+phoneId;
		var picture=document.getElementById('picture');
		var child=picture.firstChild;
		if (child!=null) picture.removeChild(child);
		picture.appendChild(img);
		
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
				else alert('Ошибка! Телефон не существует в базе данных');
				document.getElementById('preload').style.display='none';
				document.location = '/index';
			});
		
	  }

}

function fillTable(phoneId){
	var div=document.createElement('div');
	div.setAttribute('id','showLoadingPicture');
	document.getElementById('main').appendChild(div);
	var d = {
			'getPhone'		: phoneId	
		};
	var checkboxes = new Array(68);
	$.getJSON('/index', d, function(data) {
		$.each(data, function(key, val) {
			if ((key==0)&&(val=='error')) {
				document.location = '/index';
				return false;
			}
			if (key=='Title'){
				document.getElementById('treeTitle').innerHTML=val;
				document.getElementById('title').innerHTML=val;
			}
			else if (key=='PriceUSD'){
				document.getElementById('firstPrice').innerHTML=val+' $';
			}
			else if (key=='PriceBY'){
				document.getElementById('secondPrice').innerHTML='| '+val+' руб.';
			}else if (key=='Manufactor'){
				var elem=document.getElementById('Manufactor');
				elem.href="/index?mode="+val;
				elem.innerHTML=val;
			}
			else if (key.substring(0,8)=='Checkbox'){
				checkboxes[key.substring(8)-1]=1;
			}
			else {
				var elem=document.getElementById(key);
				if (elem!=null)elem.innerHTML=val;
			}
		  });
		for (var i = 1; i < checkboxes.length+1; i++) {
			var checkbox =document.getElementById('Checkbox'+i);
			if (checkboxes[i-1]==1){
			    if (checkbox!=null) {
			    	checkbox.innerHTML=
			    		'<img width="12" border="0" height="12" alt="Да" title="Да" src="/pics/ico_yes.gif">';
			    }
			}else{
				if (checkbox!=null) {
			    	checkbox.innerHTML=
			    		'<img width="12" border="0" height="12" alt="Нет" title="Нет" src="/pics/ico_no.gif">';
			    }
			}
		    
		}
		document.getElementById('centerColumn').style.display = '';
		document.getElementById('main').removeChild(div);
		hideLoading();
	});
}

function hideLoading(){
	if (document.getElementById('showLoadingPicture')==null)
		document.getElementById('preload').style.display='none';
	return false;
}




