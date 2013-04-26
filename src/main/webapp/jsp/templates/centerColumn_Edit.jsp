<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="servlet.*"%>
<%@ page import="util.*"%>
<%@ page import="util.sql.*"%>


<ul id="sectionsTree">
	<li class="firstSectionTree">
		<a href="/" alt="Главная">Главная</a>&nbsp;»&nbsp;
	</li>
	<li>Phone Editor</li>
</ul>
<form name="login" action="index" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode" value="edit"/>
<div class="itemsRow">
	<div class="itemBlock">
		<h3 class="itemPage">Phone Editor</h3>
		<div style="clear:both;"></div>
		
		<h3>Выберите действие:</h3>
		<table><tbody>
			<tr>
				<td><div>Добавить новый телефон </div></td>
				<td><input name="Radio1" type="radio" align="right" 
				onclick="javascript:document.getElementById('selectPhone').style.visibility='hidden';javascript:document.getElementById('editTable').style.visibility='visible';"/></td>
			</tr>
			<tr>
				<td><div>Редактировать телефон </div></td>
				<td><input name="Radio1" type="radio" 
				onclick="javascript:document.getElementById('selectPhone').style.visibility='visible';javascript:document.getElementById('editTable').style.visibility='hidden';"/></td>
			</tr>
		</tbody></table>
		
		<table id="selectPhone"  style="visibility:hidden"><tbody>
			<tr>
				<td>
					<select name="Select1"  onchange="javascript:getTitles(this.options[this.selectedIndex].value);">
						<option style="display:none"></option>
						<option>Apple</option>
						<option>Fly</option>
					</select>
				</td>
				<td>
					<select id="phonesTitles" name="Select2" disabled="disabled"
					onchange="javascript:getPhone(this.options[this.selectedIndex].value)">
						<option style="display:none"></option>
					</select>
				</td>
			</tr>
		</tbody></table>
		
		
		<div class="descBig">
			<table id='editTable' style="visibility:hidden" width="100%" cellspacing="0" cellpadding="0" border="0" >
				<tbody>
					<tr>
						<td width="100%" valign="top">
							<table width="100%" cellspacing="0" cellpadding="0" border="0">
								<tbody>  
								
									
									
									<tr> 
										<td><div>Фото</div></td>
										<td id='picture'>
											<table><tbody>
											<tr>
												<input name="F1" size="20" type="file" required = "required" accept ="image/*"/>
											</tr>
											</tbody></table>
										</td>
									</tr>
								    <tr><td><div>Производитель</div></td><td><input type="text" name="textProperty0" value="input"></td></tr>
									<tr><td><div>Название</div></td><td><input type="text" name="textProperty1" value="input"></td></tr>
									<tr><td><div>Краткое описание</div></td><td><textarea cols="20" name="TextArea1" style="height: 85px">input</textarea></td></tr>
									<tr>
										<td><div>Цена, долл</div></td>
										<td><input class="editParam" id="firstPrice" type="text" name="firstPrice" value="0">
										<div class="error" id="firstPrice_error"></div></td>
									</tr>
									<tr>
										<td><div>Цена, руб</div></td>
										<td><input class="editParam" id="secondPrice" type="text" name="secondPrice" value="0">
										<div class="error" id="secondPrice_error"></div></td>
									</tr>
									              
									<tr><td colspan="2">Основные</td></tr>
									<tr><td><div>Дата выхода на рынок </div></td><td><input type="text" name="textProperty4" value="input"></td></tr>
									<tr><td><div>Стандарт </div></td><td><input type="text" name="textProperty5" value="input"></td></tr>
									<tr><td><div>Платформа</div></td><td><input type="text" name="textProperty6" value="input"></td></tr>
									<tr><td><div>Операционная система </div></td><td><input type="text" name="textProperty7" value="input"></td></tr>
									<tr><td><div>Процессор </div></td><td><input type="text" name="textProperty8" value="input"></td></tr>
									<tr><td><div>Тактовая частота </div></td><td><input type="text" name="textProperty9" value="input"></td></tr>
									<tr><td><div>Количество ядер </div></td><td><input type="text" name="textProperty10" value="input"></td></tr>
									<tr><td><div>Графический ускоритель</div></td><td><input type="text" name="textProperty11" value="input"></td></tr>
									<tr><td colspan="2">Размеры и вес</td></tr>
									<tr><td><div>Длина </div></td><td><input type="text" name="textProperty12" value="input"></td></tr>
									<tr><td><div>Ширина </div></td><td><input type="text" name="textProperty13" value="input"></td></tr>
									<tr><td><div>Толщина </div></td><td><input type="text" name="textProperty14" value="input"></td></tr>
									<tr><td><div>Вес </div></td><td><input type="text" name="textProperty15" value="input"></td></tr>
									<tr><td colspan="2">Конструкция</td></tr>
									<tr><td><div>Конструкция корпуса </div></td><td><input type="text" name="textProperty16" value="input"></td></tr>
									<tr><td><div>Встроенная антенна </div></td><td><input name="Checkbox1" type="checkbox" /></td></tr>
									<tr><td><div>Разъём для внешней антенны </div></td><td><input name="Checkbox2" type="checkbox"/></td></tr>
									<tr><td><div>Сменные панели </div></td><td><input name="Checkbox3" type="checkbox"/></td></tr>
									<tr><td><div>Пыле-, влаго-, ударопрочность </div></td><td><input name="Checkbox4" type="checkbox"/></td></tr>
									<tr><td><div>Материал корпуса </div></td><td><input type="text" name="textProperty17" value="input"></td></tr>
									<tr><td><div>Акселерометр </div></td><td><input name="Checkbox5" type="checkbox"/></td></tr>
									<tr><td><div>Гироскоп </div></td><td><input name="Checkbox6" type="checkbox"/></td></tr>
									<tr><td><div>Датчик приближения </div></td><td><input name="Checkbox7" type="checkbox"/></td></tr>
									<tr><td><div>Датчик освещенности </div></td><td><input name="Checkbox8" type="checkbox"/></td></tr>
									<tr><td><div>Варианты цвета корпуса </div></td><td><input type="text" name="textProperty18" value="input"/></td></tr>
									<tr><td><div>Сенсорная клавиатура </div></td><td><input name="Checkbox9" type="checkbox"/></td></tr>
									<tr><td><div>QWERTY-клавиатура </div></td><td><input name="Checkbox10" type="checkbox"/></td></tr>
									<tr><td><div>Поддержка двух SIM-карт </div></td><td><input name="Checkbox11" type="checkbox"/></td></tr>
									<tr><td><div>Сканер отпечатков пальцев </div></td><td><input name="Checkbox12" type="checkbox"/></td></tr>
									<tr><td colspan="2">Телефонная книга и органайзер</td></tr>
									<tr><td><div>Номера в памяти телефона </div></td><td><input name="Checkbox13" type="checkbox"/></td></tr>
									<tr><td><div>Расширенная телефонная книга </div></td><td><input name="Checkbox14" type="checkbox"/></td></tr>
									<tr><td><div>Поддержка групп абонентов </div></td><td><input name="Checkbox15" type="checkbox"/></td></tr>
									<tr><td><div>Календарь </div></td><td><input name="Checkbox16" type="checkbox"/></td></tr>
									<tr><td><div>Напоминания </div></td><td><input name="Checkbox17" type="checkbox"/></td></tr>
									<tr><td colspan="2">Короткие сообщения</td></tr>
									<tr><td><div>MMS </div></td><td><input name="Checkbox18" type="checkbox"/></td></tr>
									<tr><td colspan="2">Экран</td></tr>
									<tr><td><div>Технология экрана </div></td><td><input type="text" name="textProperty19" value="input"/></td></tr>
									<tr><td><div>Тип экрана </div></td><td><input type="text" name="textProperty20" value="input"/></td></tr>
									<tr><td><div>Разрешение экрана </div></td><td><input type="text" name="textProperty21" value="input"/></td></tr>
									<tr><td><div>Размер экрана </div></td><td><input type="text" name="textProperty22" value="input"/></td></tr>
									<tr><td><div>Сенсорный экран </div></td><td><input name="Checkbox19" type="checkbox"/></td></tr>
									<tr><td colspan="2">Работа с изображением</td></tr>
									<tr><td><div>Встроенная камера </div></td><td><input name="Checkbox20" type="checkbox"/></td></tr>
									<tr><td><div>Дополнительная камера </div></td><td><input name="Checkbox21" type="checkbox"/></td></tr>
									<tr><td><div>Количество активных пикселей </div></td><td><input type="text" name="textProperty23" value="input"/></td></tr>
									<tr><td><div>Максимальное разрешение снимка </div></td><td><input type="text" name="textProperty24" value="input"/></td></tr>
									<tr><td><div>Цифровой zoom </div></td><td><input type="text" name="textProperty25" value="input"/></td></tr>
									<tr><td><div>Запись видео </div></td><td><input name="Checkbox22" type="checkbox"/></td></tr>
									<tr><td><div>Максимальное разрешение видео </div></td><td><input type="text" name="textProperty26" value="input"/></td></tr>
									<tr><td><div>Макс. кол-во кадров в секунду </div></td><td><input type="text" name="textProperty27" value="input"/></td></tr>
									<tr><td><div>Встроенный проектор</div></td><td><input name="Checkbox23" type="checkbox"/></td></tr>
									<tr><td><div>ТВ-тюнер</div></td><td><input name="Checkbox24" type="checkbox"/></td></tr>
									<tr><td colspan="2">Объектив</td></tr>
									<tr><td><div>Автоматическая фокусировка </div></td><td><input name="Checkbox25" type="checkbox"/></td></tr>
									<tr><td><div>Оптическая стабилизация </div></td><td><input name="Checkbox26" type="checkbox"/></td></tr>
									<tr><td colspan="2">Вспышка</td></tr>
									<tr><td><div>Встроенная вспышка </div></td><td><input name="Checkbox27" type="checkbox"/></td></tr>
									<tr><td colspan="2">Работа со звуком</td></tr>
									<tr><td><div>Голосовой набор </div></td><td><input name="Checkbox28" type="checkbox"/></td></tr>
									<tr><td><div>Голосовое управление </div></td><td><input name="Checkbox29" type="checkbox"/></td></tr>
									<tr><td><div>Громкая связь </div></td><td><input name="Checkbox30" type="checkbox"/></td></tr>
									<tr><td><div>Диктофон / Запись звука </div></td><td><input name="Checkbox31" type="checkbox"/></td></tr>
									<tr><td><div>Аудио проигрыватель </div></td><td><input name="Checkbox32" type="checkbox"/></td></tr>
									<tr><td><div>FM-приёмник </div></td><td><input name="Checkbox33" type="checkbox"/></td></tr>
									<tr><td><div>FM-трансмиттер </div></td><td><input name="Checkbox34" type="checkbox"/></td></tr>
									<tr><td colspan="2">Память</td></tr>
									<tr><td><div>Объем оперативной памяти </div></td><td><input type="text" name="textProperty28" value="input"/></td></tr>
									<tr><td><div>Объем энергонезависимой памяти </div></td><td><input type="text" name="textProperty29" value="input"/></td></tr>
									<tr><td><div>Поддержка карт памяти </div></td><td><input name="Checkbox35" type="checkbox"/></td></tr>
									<tr><td colspan="2">Навигация</td></tr>
									<tr><td><div>GPS </div></td><td><input name="Checkbox36" type="checkbox"/></td></tr>
									<tr><td><div>Geotagging </div></td><td><input name="Checkbox37" type="checkbox"/></td></tr>
									<tr><td colspan="2">Функции вызова и персонализация</td></tr>
									<tr><td><div>Светодиодный индикатор </div></td><td><input name="Checkbox38" type="checkbox"/></td></tr>
									<tr><td><div>Вибровызов </div></td><td><input name="Checkbox39" type="checkbox"/></td></tr>
									<tr><td><div>Тип мелодии </div></td><td><input type="text" name="textProperty30" value="input"/></td></tr>
									<tr><td><div>MP3-звонок </div></td><td><input name="Checkbox40" type="checkbox"/></td></tr>
									<tr><td><div>Стереозвонок </div></td><td><input name="Checkbox41" type="checkbox"/></td></tr>
									<tr><td><div>Поддержка Java </div></td><td><input name="Checkbox42" type="checkbox"/></td></tr>
									<tr><td colspan="2">Интернет</td></tr>
									<tr><td><div>GPRS </div></td><td><input name="Checkbox43" type="checkbox"/></td></tr>
									<tr><td><div>EDGE </div></td><td><input name="Checkbox44" type="checkbox"/></td></tr>
									<tr><td><div>HSDPA </div></td><td><input name="Checkbox45" type="checkbox"/></td></tr>
									<tr><td><div>HSUPA </div></td><td><input name="Checkbox46" type="checkbox"/></td></tr>
									<tr><td><div>HSPA</div></td><td><input name="Checkbox47" type="checkbox"/></td></tr>
									<tr><td><div>HSPA+</div></td><td><input name="Checkbox48" type="checkbox"/></td></tr>
									<tr><td><div>LTE </div></td><td><input name="Checkbox49" type="checkbox"/></td></tr>
									<tr><td><div>HTML-браузер </div></td><td><input name="Checkbox50" type="checkbox"/></td></tr>
									<tr><td><div>E-mail клиент </div></td><td><input name="Checkbox51" type="checkbox"/></td></tr>
									<tr><td colspan="2">Интерфейсы</td></tr>
									<tr><td><div>Bluetooth </div></td><td><input name="Checkbox52" type="checkbox"/></td></tr>
									<tr><td><div>Стерео Bluetooth (A2DP) </div></td><td><input name="Checkbox53" type="checkbox"/></td></tr>
									<tr><td><div>AVRCP </div></td><td><input name="Checkbox54" type="checkbox"/></td></tr>
									<tr><td><div>Аудиовыход</div></td><td><input name="Checkbox55" type="checkbox"/></td></tr>
									<tr><td><div>IrDA </div></td><td><input name="Checkbox56" type="checkbox"/></td></tr>
									<tr><td><div>UMA </div></td><td><input name="Checkbox57" type="checkbox"/></td></tr>
									<tr><td><div>Wi-Fi </div></td><td><input name="Checkbox58" type="checkbox"/></td></tr>
									<tr><td><div>Wi-Fi Hotspot </div></td><td><input name="Checkbox59" type="checkbox"/></td></tr>
									<tr><td><div>Wi-Fi Direct </div></td><td><input name="Checkbox60" type="checkbox"/></td></tr>
									<tr><td><div>WiMAX</div></td><td><input name="Checkbox61" type="checkbox"/></td></tr>
									<tr><td><div>DLNA </div></td><td><input name="Checkbox62" type="checkbox"/></td></tr>
									<tr><td><div>USB </div></td><td><input name="Checkbox63" type="checkbox"/></td></tr>
									<tr><td><div>USB On-The-Go </div></td><td><input name="Checkbox64" type="checkbox"/></td></tr>
									<tr><td><div>Разъем для подключения к PC </div></td><td><input name="Checkbox65" type="checkbox"/></td></tr>
									<tr><td><div>Тип разъёма для подключения к PC </div></td><td><input type="text" name="textProperty31" value="input"/></td></tr>
									<tr><td><div>HDMI-выход </div></td><td><input name="Checkbox66" type="checkbox"/></td></tr>
									<tr><td><div>TV-выход </div></td><td><input name="Checkbox67" type="checkbox"/></td></tr>
									<tr><td colspan="2">Аккумулятор</td></tr>
									<tr><td><div>Тип аккумулятора </div></td><td><input type="text" name="textProperty32" value="input"/></td></tr>
									<tr><td><div>Емкость аккумулятора </div></td><td><input type="text" name="textProperty33" value="input"/></td></tr>
									<tr><td><div>Время разговора </div></td><td><input type="text" name="textProperty34" value="input"/></td></tr>
									<tr><td><div>Время ожидания </div></td><td><input type="text" name="textProperty35" value="input"/></td></tr>
									<tr><td><div>Cолнечная батарея </div></td><td></td></tr>           
								
								</tbody>
							</table>
						</td>        
					</tr>    
				</tbody>
			</table>
			<p>&nbsp;</p>
			<!-- <input name="Button1" type="submit" value="Создать" />-->
			<input type="submit" class="hiddenc" id="regBut" value="Добавить">
			<a href="${pageContext.request.contextPath}/index?mode=edit#" onclick="if (phoneEdit()) {document.getElementById('regBut').click();};return false" title="Добавить телефон">Добавить</a>
								
			
			<p class="reviLinks"></p>
			
		</div>
		
		
	</div>
</div>
</form>