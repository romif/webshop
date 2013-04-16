function find_form(id) {	
	var find_form	=	$('#f'+id);
	
	var main_course	=	find_form.find('#main_course').val(); 	//���� �������� ������
	var course		=	find_form.find('#course').val();		//���� ������ ������
	
	var error 		=	[]; 									//��������� �� �������
	
	//��������� � �������� ������
	var checkBefore = find_form.find('#price_before_new').val();
	var checkAfter = find_form.find('#price_after_new').val();
	//�������� �� �����
	if ((!checkBefore.match(/^[0-9\,\.\(\)]*$/))||(!checkAfter.match(/^[0-9\,\.\(\)]*$/))) {
		error.push(0);
	}
	//�������� �� "," � ������
	if (checkBefore.indexOf(',')!=-1) {
		checkBefore = checkBefore.replace(",",".");
		find_form.find('#price_before_new').val(checkBefore);
	}
	if (checkAfter.indexOf(',')!=-1) {
		checkAfter=checkAfter.replace(",",".");
		find_form.find('#price_after_new').val(checkAfter);
	}
	//���� �� ����
	for (var i=0;i<find_form.find('.minNumber').length;i++) {
		//�������� ����� �� ���� �� ',' � ������
		if (find_form.find('.minNumber')[i].value.indexOf(',')!=-1) {
			find_form.find('.minNumber')[i].value = find_form.find('.minNumber')[i].value.replace(",",".");			
		}
		if (find_form.find('.maxNumber')[i].value.indexOf(',')!=-1) {
			find_form.find('.maxNumber')[i].value = find_form.find('.maxNumber')[i].value.replace(",",".");
		}
		//�������� ����� �� ���� �� �����
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
	
		//������� ������
		if (typeof(console)=='object') {
			
			console.group ("find error");
			console.log ('����������� ��������� ���� ������.');
			console.groupEnd();			
		}
		alert('����������� ��������� ���� ������.');
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
