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


function select_currency(value){


	switch (value) {
		
		
		case '1000196':
			{
			cur_koef = 8650 / 8650;
			cur_round = 1.00;
			cur_id = value;
			cur_suffix = "$";
			
			
			
			
			}
			break;
		
		
		case '1000198': 
			{
			cur_koef = 8650 / 1;
			cur_round = 1.00;
			cur_id = value;
			cur_suffix = "руб.";
			
			
			
			
			}
			break;
		
		
		case '1000197': 
			{
			cur_koef = 8650 / 12000;
			cur_round = 1.00;
			cur_id = value;
			cur_suffix = "E";
			
			
			
			
			}
			break;
		
		
		case '1000199': 
			{
			cur_koef = 8650 / 97;
			cur_round = 1.00;
			cur_id = value;
			cur_suffix = "р.руб.";
			
			
			
			
			}
			break;
		
		default : {
			trace_log ();
		}
	}	
	
	
	shcart_step1();
	
	count_all(0);
	
	
	return (true);
}


function count_all(id){
	main_summ1=Number(shcart_summ1)+Number(shcart_summ2)+Number(shcart_summ3);

	//if (!document.shcart._t_summ_main_i) {return false;}

	
	document.shcart._t_summ_main_i.value=main_summ1;
	

	if (id==1){
		prepare_shcart_step1();
		document.shcart.submit();
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
