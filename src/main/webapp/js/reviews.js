$(document).ready (function()
{
	countWords("rf_positive", 500);
	countWords("rf_negative", 500);
	helpBox('helpReview', 'whatWrite');
	setVote();
	commentReview();
	helpful();

	clickRemove();
});

function clickRemove() {
	$('#reviewForm input, #reviewForm textarea, #reviewForm img').click(function() {
		if ($('#formErrors').length)
		{
			$('#formErrors').remove();
		}
	});
}

var commentIdGlobal;

/* Вычисление колличества оставшихся слов */
function countWords(field,limit){
	field = '#'+field;
	$(field).keyup(function(e){
		var str = $(field).val();
		var c = words(str);
			c = limit - c;
			if(c < 0) {
				$(field).val(str.substring(0,str.length-1));
				//c = '0';
			}
			//$(field+'_count').html(String(c));
	})
}

function words(str) {
	var r = 0;
	a = str.replace(/\s/g," ");
	a = a.split(" ");
	for (z=0; z<a.length; z++) {if (a[z].length > 0) r++;}
	return r;
}
/* ------------------------------------------- */

/* Проверка на заполненность полей формы */

/* Убрать из-за возможной ненадобности errorFields */

function checkReviewForm(data) {
	var email = $('#rf_email').val(); 
	emailTest = "^[_\\.0-9a-z-]+@([0-9a-z][0-9a-z_-]+\\.)+[a-z]{2,4}$";
	var regex = new RegExp(emailTest, 'i'); 
	var param = 'no';
	var errorArr = []; //массив ошибок
	var summ = $('.reviewParam').size();

	if ($('#rf_name').val() == '') {
		errorArr.push(['rf_name', '1']);
	}
	if ($('#rf_email').val() == '') {
		errorArr.push(['rf_email', '1']);
	} else if (regex.test(email) == false) {
		errorArr.push(['rf_email', '2']);
	}
	if ($('#rf_positive').val() == '') {
		errorArr.push(['rf_positive', '1']);
	}
	if ($('#rf_negative').val() == '') {
		errorArr.push(['rf_negative', '1']);
	}
	if ($('#rf_comment').val() == '') {
		errorArr.push(['rf_comment', '1']);
	}
	if ($('#rf_captcha').val() == '') {
		errorArr.push(['rf_captcha', '1']);
	} else if (data == 0) {
		errorArr.push(['rf_captcha', '2']);
	}
	if ($('#rf_mark').val() == '0') {
		errorArr.push(['rf_mark', '3']);		
	}
	if (errorArr.length != 0)	{
		for (var j=0;j<summ; j++) {
			var idName = $('.reviewParam').eq(j).attr('id');
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
					} else if (errorNomer == 3) {
						$('#'+id+'_error').html('Поставьте пожалуйста оценку');
						
					} else {
						$('#'+id+'_error').html('Исправьте данные в поле');						
						
					}
					if (id=='rf_mark') {
						$('#'+id+'_error').show();
					} else {
						$('#'+id+'_error').css('display','block');						
					}
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
		ReviewSubmit();
	}
}

function textareachange(name)
{
var count=500;
 a=document.getElementById(name).value.length;
 if (a>count) {
	 document.getElementById(name).value=document.getElementById(name).value.substring(0,count);
 }
 a=document.getElementById(name).value.length;
 num=count-a;
 document.getElementById(name+'_message').innerHTML='Oсталось '+num+' символов';
}

function CheckCaptchaRev()
{
	$('#createReview .buttons').css('background','url(/pics/form_loader.gif) 150px center no-repeat');
	$.post("/captcha/captcha.php", 
		{captcha: $('#rf_captcha').val(), mode: "check"}, checkReviewForm
	)
	return false;
}

function CheckCaptchaCom()
{
	$('#commentForm .buttons').css('background','url(/pics/form_loader.gif) 150px center no-repeat');
	$.post("/remark/kcaptcha/form_example.php", 
		{keystring: $('#cf_captcha').val()}, checkCommentForm
	)
	return false;
}

function ReviewSubmit()
{
	$.post("/lib/reviews.php", 
		{
			mode: $('#rf_mode').val(), 
			item_id: $('#rf_item_id').val(), 
			service_id: $('#rf_service_id').val(), 
			mark: $('#rf_mark').val(), 
			name: $('#rf_name').val(), 
			email: $('#rf_email').val(), 
			positive: $('#rf_positive').val(), 
			negative: $('#rf_negative').val(), 
			comment: $('#rf_comment').val(),
			  captcha: $('#rf_captcha').val()
		},
		function(data) {
			$('.setRaiting a').removeClass('cur');
			for (var i=1;i<$('.reviewParam').size();i++) {
				var id = $('.reviewParam').eq(i).attr('id');
				$('#'+id).removeClass('borderError');
				$('#'+id+'_error').hide();
				$('#'+id).val('');				
			}
			reloadCaptcha();
			if (data == 0) {
				$('#createReview .buttons').css('background','none');
				alert('Благодарим Вас за Ваше мнение!\nОтзыв успешно отправлен и будет опубликован с некоторой задержкой, необходимой модератору для его проверки');
			
			}
			else {
				$('#createReview .buttons').css('background','none');
				alert('Ошибка при отправке сообщения.\nПожалуйста, проверьте заполнение формы и нажмите на кнопку «Отправить»');
			}		

		}
	)
}

function helpBox(helpLink, helpBlock) {
	var link = $('#'+helpLink);
	var block = $('#'+helpBlock);

	link.bind("mouseenter", function(kmouse){
		if (block.css('display') == 'none') {
		t = setTimeout(function() {
		
			$('#TB_overlay2').show();
			block
				.css({opacity:1, display:"none"})
				.fadeIn(200)

		},2000)
		}
	})
	.click(function(){
		clearTimeout(t);
		if (block.css('display') == 'none') {
			$('#TB_overlay2').show();
			block
				.css({opacity:1, display :"none"})
				.fadeIn(200);
		}
		else {
			$('#TB_overlay2').hide();
			block.fadeOut(200);
		}
		return false;
	})
	.mouseout(function(){
		clearTimeout(t);
	})
	$('#closeHelp, #TB_overlay2').click(function(){
		clearTimeout(t);
		$('#TB_overlay2').hide();
		block.fadeOut(200);
		return false;
	})
}
/* ------------------------------------------ */

/* Выставление рейтинга модели */
var ltIE7 = false
/*@cc_on @if (@_jscript_version < 5.7) ltIE7 = true @end @*/

function setVote()
{
	var markField = $('#rf_mark');
	var voting = $('.voting');
	var as = $('.voting a');

	as
	.click(function() {
		as.removeAttr('class');
		$(this).addClass('cur');
		markField.val($(this).text());
		return false
	})
	.mouseover(function() {
		$('#mark_text').html($(this).attr('title'))
	})
	.mouseout(function() {
		$('#mark_text').html('')
	})

	if(ltIE7)
	{
		voting
		.mouseover(function() {
			$(this).attr('class','voting phover')
		})
		.mouseout(function() {
			$(this).attr('class', $(this).attr('class').replace(/(^| )phover($| )/,''))
		})
	}
}
/* -------------------------------------- */

function removeComBlock(curBlock) {
	$('#'+curBlock).remove();
	$('.l-addCommentAct').attr('class','l-addComment');
}

function hideRevBlock(curBlock) {
	$('#'+curBlock).hide();
	document.location= '#headerReviews';

	$('#rf_name').val('');
	$('#rf_email').val('');
	$('#rf_positive').val('');
	$('#rf_negative').val('');
	$('#rf_comment').val('');
	$('#rf_captcha').val('');
	$('#rf_mark').val(0);
	$('.setRaiting a').removeClass('cur');
	if ($('#formErrors').length)
	{
		$('#formErrors').remove();
	}
}




/* Выставление полезности отзыву */
function voteSubmit(help, review_id)
{
	var container = $('#helpfulBlock_'+review_id);
	var countYes = $('#helpful_'+review_id).html();
	var countNo = $('#helpless_'+review_id).html();
	var staticYes = 'Отзыв полезен?  <strong style="color:#000">Да</strong> '+(Number(countYes)+1)+'<i>/</i>Нет '+countNo;
	var staticNo = 'Отзыв полезен?  Да '+countYes+'<i>/</i><strong style="color:#000">Нет</strong> '+(Number(countNo)+1);

	if (help == 'helpful')
	{
		$.post("/lib/reviews.php",
			{
				mode: "vote",
				review_id: review_id,
				helpful: ''
			},
			function(data) {
				if (data == 0) {
					var countBlock = $('#helpfulBlock_'+review_id);
					countBlock.html(staticYes);
				}
				if (data == 105)
				{
					alert('Вы уже голосовали!');
					return false;
				}
				else {
				}
			}
		)
	}
	else {
		$.post("/lib/reviews.php",
			{
				mode: "vote",
				review_id: review_id,
				helpless: ''
			},
			function test(data) {
				if (data == 0) {
					var countBlock = $('#helpfulBlock_'+review_id);
					countBlock.html(staticNo);
				}
				if (data == 105)
				{
					alert('Вы уже голосовали!');
					return false;
				}
				else {
				}
			}
		)
	}
	return false;
}

/* ----------------------------- */


/* открытие формы комментирования отзывов */

function commentReview() {
	$('.l-addComment').click(function() {
		var tempId = $(this).attr('id').split('_');
		var commentId = tempId[1];
		var reviewBlock = $('#review_'+commentId);
		
		commentIdGlobal = commentId;

		var formhtml = $('<div class="commentsContainer" id="b-addComment" rel="form_'+commentId+'" style="display:block"><div class="reviewComments"><form id="commentForm" name="comment" action="/" method="post" onsubmit="CheckCaptchaCom(); return false"><input type="hidden" name="mode" id="cf_mode" value="comment" /><input type="hidden" name="review_id" id="cf_review_id" value="'+commentId+'" /><p><label for="cf_name" id="cf-lab-name">Ваше имя</label><input type="text" name="name" id="cf_name" value="" /></p><p><label for="cf_comment" id="cf-lab-com">Комментарий</label><textarea name="comment" id="cf_comment"></textarea></p><p id="b-captchaImgCom"><a href="/remark/kcaptcha/form_example.php" onclick="reloadCaptchaCom();return false;" title="Кликните для смены изображения"><img id="captchaImg'+commentId+'" alt="" src="/remark/kcaptcha/form_example.php" /></a></p><p><label for="cf_captcha" id="cf-lab-captca">Введите изображенные символы. Для смены изображения, кликните по нему.</label><input type="text" id="cf_captcha" value="" /></p><p><input type="submit" class="submit" value="добавить" /><input type="reset" class="reset" onclick="removeComBlock(\'b-addComment\')" onkeypress="removeComBlock(\'b-addComment\')" value="отменить" /></p></form></div></div>');

		$('a[rel=comments_'+commentId+']').attr('class','l-allComments');
		$('#comments_'+commentId).hide();

		if (commentId == $('#cf_review_id').val())
		{
			$('#b-addComment').remove();
			$(this).attr('class','l-addComment');
		}
		else {
			$('#b-addComment').remove ();
			$('.l-addCommentAct').attr('class','l-addComment');
			$(this).attr('class','l-addCommentAct');
			reviewBlock.append(formhtml);

			var elem = $('#commentForm input, #commentForm textarea, #commentForm img');
			elem.click(function() {
				if ($('#commentErrors').length)
				{
					$('#commentErrors').remove();
				}
			});
		}
		return false;
	})

	$('.l-allComments').click(function() {

		var tempId = $(this).attr('rel').split('_');
		var commentId = tempId[1];
		var addBlock = $('div[rel=form_'+commentId+']');

		if (addBlock)
		{
			addBlock.remove();
			$('#addComment_'+commentId).attr('class','l-addComment');
		}

		$(this).toggleClass('l-allCommentsAct', $(this).attr('class') == 'l-allComments');
		$('#'+$(this).attr('rel')).toggle();

		return false;
	})
}
/* ---------------------------------- */


/* добавление комментария к отзыву */
function commentSubmit(rev_id) {
	$.post("/lib/reviews.php",
		{
			mode: $('#cf_mode').val(), 
			review_id: $('#cf_review_id').val(), 
			name: $('#cf_name').val(), 
			comment: $('#cf_comment').val()
		},
		function(data) {
			if (data == 0) {
				$('#commentForm .buttons').css('background','none');
				var successMessage = $('<div id="commentSuccess"><p>Спасибо. Ваш комментарий будет добавлен после проверки модератором портала shop.by.</p></div>');
				$('#b-addComment').remove();
				$('.l-addCommentAct').attr('class','l-addComment');
				$('#review_'+rev_id).append(successMessage);
				var t=setTimeout(function(){successMessage.remove()},5000);
				
			}
			else {
				$('#commentForm .buttons').css('background','none');
				var errorMessage = $('<div id="commentError"><p>Ошибка при добавлении комментария.</p></div>');
				$('#b-addComment').remove();
				$('#review_'+rev_id).append(errorMessage);
				var t=setTimeout(function(){errorMessage.remove()},5000);
			}
		}
	)
}
/* -------------------------------- */


function checkCommentForm(data) {
	var errorFields = '';

	if ($('#cf_name').val() == '') {
		errorFields = errorFields+'<li>Ваше имя</li>';
		$('#cf_name').addClass('borderError');
	}
	else {
		$('#cf_name').removeClass('borderError');
	}
	if ($('#cf_comment').val() == '') {
		errorFields = errorFields+'<li>Комментарий</li>';
		$('#cf_comment').addClass('borderError');
	}
	else {
		$('#cf_comment').removeClass('borderError');
	}
	if ($('#cf_captcha').val() == '' || data == 0) {
		errorFields = errorFields+'<li>Символы на изображении</li>';
		$('#cf_captcha').addClass('borderError');
	}
	else {
		$('#cf_captcha').removeClass('borderError');
	}
	if (errorFields != '')
	{
		var errorMessage = $('<div id="commentErrors" onclick="rem(this.id)">Для добавления комментария заполните, пожалуйста, все поля:<ul>'+errorFields+'</ul></div>');
		if ($('#commentErrors').length)
		{
			$('#commentErrors').remove()
		}
		$('#commentForm .buttons').css('background','none');
		$('#b-addComment .buttons').after(errorMessage);

		var t=setTimeout(function(){errorMessage.remove()},5000);

		return false;
	}
	else {
		commentSubmit(commentIdGlobal);
	}
}


/* Самые полезные отзывы */

function helpful() {
	$('#link_positive').click(function() {
		var cloneBlock = $('div[rel=fullPositive]').clone(true);
		var cloneBlockNeg = $('div[rel=fullNegative]').clone(true);

		$('#helpfulTable').remove();
		$('div[rel=fullPositive]').remove();
		cloneBlock.insertAfter($('.clearing')).show();
		cloneBlockNeg.insertAfter(cloneBlock).show();

		return false;
	});
	$('#link_negative').click(function() {
		var cloneBlock = $('div[rel=fullNegative]').clone(true);
		var cloneBlockPos = $('div[rel=fullPositive]').clone(true);

		$('#helpfulTable').remove();
		$('div[rel=fullNegative]').remove();
		cloneBlock.insertAfter($('.clearing')).show();
		cloneBlockPos.insertAfter(cloneBlock).show();

		return false;
	});
}



function reloadCaptcha() {
	$('#b-captchaImg').css('background','url(/pics/form_loader.gif) 130px center no-repeat');
	$('#captchaImg').attr('src','/captcha/captcha.php?mode=new&'+Math.round(Math.random()*10000000));
	$('#b-captchaImg').css('background','none');
}

function reloadCaptchaCom() {
	$('#b-captchaImgCom').css('background','url(/pics/form_loader.gif) 130px center no-repeat');
	$('#captchaImg'+commentIdGlobal).attr('src','/captcha/captcha.php?mode=new&'+Math.round(Math.random()*10000000));
	$('#b-captchaImgCom').css('background','none');
}

function rem(block) {
	$('#'+block).remove();
}