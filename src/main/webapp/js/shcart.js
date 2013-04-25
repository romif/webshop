toMesHide = null;
tmSh = null;
function add_item(data_id)
{
	var url_1='/shcart/?data_id='+data_id+'&step=0&mode=add';
	window.top.frames["win_basket"].location = url_1;

	/*var url_1='/shcart/?data_id='+data_id+'&step=2&nstep=2&mode=add';
	document.location=url_1;*/

	CreateShMess();
}


var toMesHide = null;
var tmSh = null;



function CreateShMess()
{
	removeShMess();
	var message = "Товар добавлен в корзину.";
	var message2 = "Выбирайте следующий товар или ";
	var text = document.createTextNode(message);
	var text2 = document.createTextNode(message2);

	var elem = document.createElement("div");

	elem.setAttribute('id', 'fixme');
	elem.onclick=function(){removeShMess();};

	elem.appendChild(text);
	var bre = document.createElement("br");
	elem.appendChild(bre);
	
	elem.appendChild(text2);

//
//  document.write('<a href="#" onclick="auto_hide();return false;"><img src="/pics/cr.gif" title="Закрыть" alt="Закрыть" width=20 height=22 border=0></a>');



//
	var brelem = document.createElement("br");
	elem.appendChild(brelem);

	var elemlink = document.createElement("a");
	message = "переходите к оформлению заказа.";
	var textlink = document.createTextNode(message);
	elemlink.appendChild(textlink);
	elemlink.setAttribute('href', '/shcart/?step=2&nstep=2&url=/');
	elem.appendChild(elemlink);


	document.getElementsByTagName("body")[0].appendChild(elem);

	toMesHide = elem;

	tmSh = window.setTimeout(removeShMess, 6000);

}



function removeShMess()
{
	if (tmSh)	clearTimeout(tmSh);
	if (toMesHide)
	{
		document.getElementsByTagName("body")[0].removeChild(toMesHide);
		toMesHide = null;
	}
}

function ChangeSendParam()
{
	
	if($('#send_checkbox').is(":checked"))
		$('#send_checkbox_hidden').val(1)
	else
		$('#send_checkbox_hidden').val(0)
}