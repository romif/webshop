<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="servlet.*"%>
<%@ page import="util.*"%>
<%@ page import="util.sql.*"%>

<script type="text/javascript">
document.getElementById('centerColumn').style.display = 'none';
</script>

  <ul id="sectionsTree">
    <li class="firstSectionTree">
      <a href="/index" alt="Главная">Главная</a>&#160;»&#160;
    </li>

    <li>
      <a id="Manufactor" href=""></a>&#160;»&#160;
    </li>

    <li id="treeTitle"></li>
  </ul>
  
  <div class="itemsRow" id="itemsRow">
    <div class="itemBlock">
      <h3 id="title" class="itemPage" ></h3>

      <div class="wrapper">
        <div id="wrapper-img">
          <div id="img_item"><img id="item_img" src="http://tomcat7-romif.rhcloud.com/picture?pic=${param.phoneID}"/></div>
        </div>

        <div id="vlightbox">
          <a class="vlightbox" id="ico0" href="http://tomcat7-romif.rhcloud.com/picture?pic=${param.phoneID}">
            <img id="img_ico0" src="http://tomcat7-romif.rhcloud.com/picture?pic=${param.phoneID}">
          </a>
        </div>

        <div class="itemOnePrice">
          <div class="priceContent">
            <div class="price">
              <span id="firstPrice" class="firstPrice"></span>
              <span id="secondPrice"></span>
            </div>
          </div>

          <div class="buttons">
            <a onclick="javascript:add_item(QueryString.phone)" class="buyButton" title="Купить" href="#"><img src="/pics/blank.gif" alt=""></a>
            <!--  <a href="?print=1" title="Версия для печати" target="_blank">Версия для печати&#160;»</a> -->
          </div>
        </div>
      </div>

      <div class="descBig">
        <table width="100%" cellspacing="0" cellpadding="0" border="0">
          <tbody>
            <tr>
              <td><img width="1" border="0" height="1" src="http://catalog.onliner.by/pic/s.gif" alt=""></td>

              <td width="100%" valign="top">
                <table width="100%" cellspacing="0" cellpadding="0" border="0">
                  <tbody>
                    <tr>
                      <td colspan="2">Основные</td>
                    </tr>

                    <tr>
                      <td width="347">
                        <div>Дата выхода на рынок</div>
                      </td>

                      <td id="textProperty4"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Стандарт</div>
                      </td>

                      <td id="textProperty5"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>
                          Платформа
                        </div>
                      </td>

                      <td id="textProperty6" ></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Операционная система</div>
                      </td>

                      <td id="textProperty7"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Тип процессора</div>
                      </td>

                      <td id="textProperty8"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Тактовая частота</div>
                      </td>

                      <td id="textProperty9"></td>
                    </tr>

                   
                    <tr>
                      <td colspan="2">Размеры и вес</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Длина</div>
                      </td>

                      <td id="textProperty12"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Ширина</div>
                      </td>

                      <td id="textProperty13"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Толщина </div>
                      </td>

                      <td id="textProperty14"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Вес</div>
                      </td>

                      <td id="textProperty15"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Конструкция</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Конструкция корпуса </div>
                      </td>

                      <td id="textProperty16"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Встроенная антенна</div>
                      </td>

                      <td id="Checkbox1"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Разъём для внешней антенны</div>
                      </td>

                      <td id="Checkbox2"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Сменные панели</div>
                      </td>

                      <td id="Checkbox3"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Пыле-, влаго-, ударопрочность</div>
                      </td>

                      <td id="Checkbox4"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Материал корпуса</div>
                      </td>

                      <td id="textProperty17"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Акселерометр</div>
                      </td>

                      <td id="Checkbox5"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Сенсорная клавиатура</div>
                      </td>

                      <td id="Checkbox9"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>QWERTY-клавиатура</div>
                      </td>

                      <td id="Checkbox10"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Поддержка двух SIM-карт</div>
                      </td>

                      <td id="Checkbox11"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Сканер отпечатков пальцев</div>
                      </td>

                      <td id="Checkbox12"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Телефонная книга и органайзер</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Номера в памяти телефона</div>
                      </td>

                      <td id="Checkbox13"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Расширенная телефонная книга</div>
                      </td>

                      <td id="Checkbox14"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Поддержка групп абонентов</div>
                      </td>

                      <td id="Checkbox15"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Календарь</div>
                      </td>

                      <td id="Checkbox16"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Напоминания</div>
                      </td>

                      <td id="Checkbox17"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Короткие сообщения</td>
                    </tr>

                    <tr>
                      <td>
                        <div>MMS </div>
                      </td>

                      <td id="Checkbox18"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Экран</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Технология экрана</div>
                      </td>

                      <td id="textProperty19"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Тип экрана</div>
                      </td>

                      <td id="textProperty20"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Разрешение экрана</div>
                      </td>

                      <td id="textProperty21"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Размер экрана</div>
                      </td>

                      <td id="textProperty22"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Сенсорный экран</div>
                      </td>

                      <td id="Checkbox19"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Работа с изображением</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Встроенная камера</div>
                      </td>

                      <td id="Checkbox20"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Дополнительная камера </div>
                      </td>

                      <td id="Checkbox21"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Количество активных пикселей</div>
                      </td>

                      <td id="textProperty23"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Максимальное разрешение снимка</div>
                      </td>

                      <td id="textProperty24"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Запись видео</div>
                      </td>

                      <td id="Checkbox22"></td>
                    </tr>
 
                    <tr>
                      <td>
                        <div>
                          Встроенный проектор
                        </div>
                      </td>

                      <td id="Checkbox23">;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Объектив</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Автоматическая фокусировка</div>
                      </td>

                      <td id="Checkbox25"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Опт. стабилизация изображения</div>
                      </td>

                      <td id="Checkbox26">;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Вспышка</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Встроенная вспышка</div>
                      </td>

                      <td id="Checkbox27"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Работа со звуком</td>
                    </tr>
                   
                    <tr>
                      <td>
                        <div>Громкая связь</div>
                      </td>

                      <td id="Checkbox30"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Диктофон / Запись звука</div>
                      </td>

                      <td id="Checkbox31"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Аудио проигрыватель</div>
                      </td>

                      <td id="Checkbox32"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>FM-приёмник</div>
                      </td>

                      <td id="Checkbox33"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>FM-трансмиттер</div>
                      </td>

                      <td id="Checkbox34"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Память</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Объем оперативной памяти</div>
                      </td>

                      <td id="textProperty28"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Объем энергонезависимой памяти</div>
                      </td>

                      <td id="textProperty29"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Поддержка карт памяти</div>
                      </td>

                      <td id="Checkbox35"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Навигация</td>
                    </tr>

                    <tr>
                      <td>
                        <div>GPS</div>
                      </td>

                      <td id="Checkbox36"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Geotagging</div>
                      </td>

                      <td id="Checkbox37"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Функции вызова и персонализация</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Вибровызов</div>
                      </td>

                      <td id="Checkbox39"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Тип мелодии</div>
                      </td>

                      <td id="textProperty30"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>MP3-звонок</div>
                      </td>

                      <td id="Checkbox40"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Интернет</td>
                    </tr>

                    <tr>
                      <td>
                        <div>GPRS</div>
                      </td>

                      <td id="Checkbox43"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>EDGE</div>
                      </td>

                      <td id="Checkbox44"></td>
                    </tr>
                    
                    
                    <tr>
                      <td>
                        <div>
                          HSPA+
                        </div>
                      </td>

                      <td id="Checkbox48"></td>
                    </tr>
                    
                    
                    <tr>
                      <td>
                        <div>
                          HSPA
                        </div>
                      </td>

                      <td id="Checkbox47"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>HSDPA</div>
                      </td>

                      <td id="Checkbox45"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>HSUPA</div>
                      </td>

                      <td id="Checkbox46"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>HTML-браузер</div>
                      </td>

                      <td id="Checkbox50"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>E-mail клиент</div>
                      </td>

                      <td id="Checkbox51"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Интерфейсы</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Bluetooth</div>
                      </td>

                      <td id="Checkbox52"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Стерео Bluetooth (A2DP)</div>
                      </td>

                      <td id="Checkbox53"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>AVRCP</div>
                      </td>

                      <td id="Checkbox54"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>
                          Аудиовыход
                        </div>
                      </td>

                      <td id="Checkbox55"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>IrDA</div>
                      </td>

                      <td id="Checkbox56"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>UMA</div>
                      </td>

                      <td id="Checkbox57"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Wi-Fi</div>
                      </td>

                      <td id="Checkbox58"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>
                          WiMAX
                        </div>
                      </td>

                      <td id="Checkbox61"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>DLNA</div>
                      </td>

                      <td id="Checkbox62"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>USB</div>
                      </td>

                      <td id="Checkbox63"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Разъем для подключения к PC</div>
                      </td>

                      <td id="Checkbox65"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Тип разъёма для подключения к PC</div>
                      </td>

                      <td id="textProperty31"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>HDMI-выход</div>
                      </td>

                      <td id="Checkbox65"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>TV-выход</div>
                      </td>

                      <td id="Checkbox66"></td>
                    </tr>

                    <tr>
                      <td colspan="2">Аккумулятор</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Тип аккумулятора</div>
                      </td>

                      <td id="textProperty32"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Емкость аккумулятора</div>
                      </td>

                      <td id="textProperty33"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Время разговора</div>
                      </td>

                      <td id="textProperty34"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Время ожидания</div>
                      </td>

                      <td id="textProperty35"></td>
                    </tr>

                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>

        <p>&#160;</p>
        <p class="reviLinks"></p>
      </div>
    </div>
  </div>
  
  
<script type="text/javascript">
 fillTable(QueryString.phoneID);
</script>
