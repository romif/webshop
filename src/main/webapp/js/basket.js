var shcart_summ1=0;
var shcart_summ2=0;
var shcart_summ3=0;
var main_summ;
var cur_koef=1;
var cur_round=1;
var cur_id=0;
var temp_line=0;
var main_timeout;
var last_br_id=0;
var debug = 1;


function normalizePrice (bNumber) {
	var bNumber = bNumber.toString();
	var normalNumber;

	if (bNumber.indexOf(".") == -1)
	{
		normalNumber = bNumber;
	}
	else
	{
		normalNumber = bNumber.substring(0, bNumber.indexOf(".")+3);
	}

	return Number(normalNumber);
}
/* ------------------------------------------------------------------------------- */


function select_payment (br_id, p_id) {
	if (last_br_id!=br_id) {
		if (br_id!=0) {
			if (document.getElementById(br_id)!=null) {
			document.getElementById(br_id).style.display='';
			}
			
			if (document.getElementById('payment_r_'+p_id+'_'+br_id)!=null) {
			document.getElementById('payment_r_'+p_id+'_'+br_id).checked=true;
			}
			
			document.shcart.payment_id.value = p_id; 			
		}

		if (last_br_id!=0) {
			if (document.getElementById(last_br_id)!=null) {
			document.getElementById(last_br_id).style.display='none';
			}
			
		}

		last_br_id=br_id;
		bring_id=br_id;
	}
	
return true;	
}

function error_log (o) {
	if (typeof(console)=='object') {
		if (debug==1) {
			console.log (o);
		}
	}
	return true;
}

function trace_log () {
	if (typeof(console)=='object') {
		if (debug==1) {
			console.trace ();
		}
	}
	return true;
}





function count_all(id){
	main_summ1=Number(shcart_summ1)+Number(shcart_summ2)+Number(shcart_summ3);

	//if (!document.shcart._t_summ_main_i) {return false;}

	
	document.shcart._t_summ_main_i.value=main_summ1;
	

	if (id==1){
		prepare_shcart_step1();
		//document.shcart.submit();
		return true;
	} else {
		return false;
	}
}

var check=0;//Переменная означающая требуется ли выполнять проверку функцией check_form()


function go_to_shop()
{
	window.location=document.shcart.url.value;
}

function nextBtnClick () {
	document.shcart.currency_id.disabled=false;
	if(check==1) {
		if (check_form(document.shcart)) {
			return count_all(1); 
		} else	{	
			return false;	
		}
	} else {
	return count_all(1); 
	} 
}
