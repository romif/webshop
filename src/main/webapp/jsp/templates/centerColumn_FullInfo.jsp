<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="servlet.*"%>
<%@ page import="util.*"%>
<%@ page import="util.sql.*"%>



  <ul id="sectionsTree">
    <li class="firstSectionTree">
      <a href="/index" alt="Главная">Главная</a>&#160;»&#160;
    </li>

    <li>
      <a href="/24/">Apple</a>&#160;»&#160;
    </li>

    <li id="treeTitle"></li>
  </ul>
  
  <div class="itemsRow" id="itemsRow" style="display:none">
    <div class="itemBlock">
      <h3 id="title" class="itemPage" ></h3>

      <div class="wrapper">
        <div id="wrapper-img">
          <div id="img_item"><img id="item_img" src="http://tomcat7-romif.rhcloud.com/picture?pic=${param.phone}"/></div>
        </div>

        <div id="vlightbox">
          <a class="vlightbox" id="ico0" href="http://tomcat7-romif.rhcloud.com/picture?pic=${param.phone}">
            <img id="img_ico0" src="http://tomcat7-romif.rhcloud.com/picture?pic=${param.phone}">
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
                      <td>
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
                        <div>Процессор</div>
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
                      <td>
                        <div>Количество ядер</div>
                      </td>

                      <td id="textProperty10"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>
                          Графический ускоритель
                        </div>
                      </td>

                      <td id="textProperty11"></td>
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
                        <div>Гироскоп </div>
                      </td>

                      <td id="Checkbox6"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Датчик приближения</div>
                      </td>

                      <td id="Checkbox7"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Датчик освещенности</div>
                      </td>

                      <td id="Checkbox8"></td>
                    </tr>

                    <tr>
                      <td>
                        <div>Варианты цвета корпуса</div>
                      </td>

                      <td id="textProperty18"></td>
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
                        <div>Поддержка двух SIM-карт <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Поддержка двух SIM-карт»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Сканер отпечатков пальцев <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Сканер отпечатков пальцев»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Телефонная книга и органайзер</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Номера в памяти телефона <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Номера в памяти телефона»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Расширенная телефонная книга <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Расширенная телефонная книга»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Поддержка групп абонентов <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Поддержка групп абонентов»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Календарь <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Календарь»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Напоминания <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Напоминания»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Короткие сообщения</td>
                    </tr>

                    <tr>
                      <td>
                        <div>MMS <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «MMS»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Экран</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Технология экрана <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Технология экрана»"></div>
                      </td>

                      <td>IPS&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Тип экрана <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Тип экрана»"></div>
                      </td>

                      <td>16 млн. цветов&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Разрешение экрана <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Разрешение экрана»"></div>
                      </td>

                      <td>640&#160;x&#160;960&#160;(326 ppi)</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Размер экрана <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Размер экрана»"></div>
                      </td>

                      <td>3.5&#160;&#39;&#39;&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Сенсорный экран <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Сенсорный экран»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> емкостный, мультитач&#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Работа с изображением</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Встроенная камера <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Встроенная камера»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Дополнительная камера <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Дополнительная камера»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;(VGA)</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Количество активных пикселей <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Количество активных пикселей»"></div>
                      </td>

                      <td>5&#160;Мп&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Максимальное разрешение снимка <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Максимальное разрешение снимка»"></div>
                      </td>

                      <td>2592&#160;x&#160;1944&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Цифровой zoom <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Цифровой zoom»"></div>
                      </td>

                      <td>5&#160;X&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Запись видео <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Запись видео»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Максимальное разрешение видео <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Максимальное разрешение видео»"></div>
                      </td>

                      <td>1280&#160;x&#160;720&#160;(HD)</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Макс. кол-во кадров в секунду <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Макс. кол-во кадров в секунду»"></div>
                      </td>

                      <td>30&#160;&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>
                          Встроенный проектор
                        </div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>
                          ТВ-тюнер
                        </div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Объектив</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Автоматическая фокусировка <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Автоматическая фокусировка»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Оптическая стабилизация <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Оптическая стабилизация»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Вспышка</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Встроенная вспышка <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Встроенная вспышка»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> светодиодная&#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Работа со звуком</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Голосовой набор <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Голосовой набор»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Голосовое управление <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Голосовое управление»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Громкая связь <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Громкая связь»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Диктофон / Запись звука <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Диктофон / Запись звука»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Аудио проигрыватель <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Аудио проигрыватель»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>FM-приёмник <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «FM-приёмник»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>FM-трансмиттер <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «FM-трансмиттер»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Память</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Объем оперативной памяти <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Объем оперативной памяти»"></div>
                      </td>

                      <td>512&#160;Мб&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Объем энергонезависимой памяти <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Объем энергонезависимой памяти»"></div>
                      </td>

                      <td>8&#160;Гб&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Поддержка карт памяти <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Поддержка карт памяти»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Навигация</td>
                    </tr>

                    <tr>
                      <td>
                        <div>GPS <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «GPS»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Geotagging <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Geotagging»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Функции вызова и персонализация</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Светодиодный индикатор <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Светодиодный индикатор»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Вибровызов <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Вибровызов»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Тип мелодии <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Тип мелодии»"></div>
                      </td>

                      <td>полифонический&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>MP3-звонок <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «MP3-звонок»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Стереозвонок <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Стереозвонок»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Поддержка Java <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Поддержка Java»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Интернет</td>
                    </tr>

                    <tr>
                      <td>
                        <div>GPRS <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «GPRS»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> сlass 10 (4down + 2up, 5max)&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>EDGE <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «EDGE»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>HSDPA <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «HSDPA»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>HSUPA <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «HSUPA»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>
                          HSPA
                        </div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>
                          HSPA+
                        </div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>LTE <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «LTE»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>HTML-браузер <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «HTML-браузер»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>E-mail клиент <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «E-mail клиент»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Интерфейсы</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Bluetooth <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Bluetooth»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> 2.1&#160;(EDR)</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Стерео Bluetooth (A2DP) <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Стерео Bluetooth (A2DP)»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>AVRCP <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «AVRCP»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>
                          Аудиовыход
                        </div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> 3.5мм&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>IrDA <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «IrDA»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>UMA <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «UMA»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Wi-Fi <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «Wi-Fi»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> 802.11b, 802.11g, 802.11n&#160;(802.11n только 2.4ГГЦ)</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Wi-Fi Hotspot <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Wi-Fi Hotspot»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Wi-Fi Direct <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Wi-Fi Direct»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>
                          WiMAX
                        </div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>DLNA <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «DLNA»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>USB <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt="Что такое «USB»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>USB On-The-Go <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «USB On-The-Go»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Разъем для подключения к PC <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Разъем для подключения к PC»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Тип разъёма для подключения к PC <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Тип разъёма для подключения к PC»"></div>
                      </td>

                      <td>original&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>HDMI-выход <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «HDMI-выход»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>TV-выход <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «TV-выход»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Да" title="Да" src=
                      "http://catalog.onliner.by/pic/ico_yes.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Аккумулятор</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Тип аккумулятора <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Тип аккумулятора»"></div>
                      </td>

                      <td>Li-pol&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Емкость аккумулятора <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Емкость аккумулятора»"></div>
                      </td>

                      <td>1 420&#160;мАч&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Время разговора <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Время разговора»"></div>
                      </td>

                      <td>7&#160;часов - 14&#160;часов&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Время ожидания <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Время ожидания»"></div>
                      </td>

                      <td>300&#160;часов&#160;</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Cолнечная батарея <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Cолнечная батарея»"></div>
                      </td>

                      <td><img width="12" border="0" height="12" alt="Нет" title="Нет" src=
                      "http://catalog.onliner.by/pic/ico_no.gif"> &#160;</td>
                    </tr>

                    <tr>
                      <td colspan="2">Комплектация</td>
                    </tr>

                    <tr>
                      <td>
                        <div>Совместимые чехлы <img border="0" src="http://catalog.onliner.by/pic/ico_que.gif" alt=
                        "Что такое «Совместимые чехлы»"></div>
                      </td>

                      <td>подобрать в каталоге&#160;</td>
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
 fillTable(QueryString.phone);
</script>
