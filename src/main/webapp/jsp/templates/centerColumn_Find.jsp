<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="util.sql.SqlManager"%>
<%@ page import="util.Phone"%>



    <div style="width:1010px;height:1px;">  
    </div>

    <h2>Поиск товара</h2>

    <div id="si0" class="adSearchHeader" onclick="shSB(0)">
      <div class="adSearchHeaderRight">
        <div id="" class="adSearchHeaderContent">
          Поиск по названию и описанию
        </div>
      </div>
    </div>

    <div class="searchbody" id="sb0" style="display:block">
      <form method="get" action="/index" id="f0" name="f0">
        <div class="fcatalogBox">
          <table class="fcatalog" cellspacing="0" cellpadding="0">
            <tbody>
              <tr>
                <td class="in">Найти:</td>

                <td class="inpSearch">
                  <input type="text" name="findtext" id="findtext2" 
                  value="<%=new String(request.getParameter("findtext").getBytes("iso-8859-1"), "UTF-8")%>">
                </td>
              </tr>

              <tr>
                <td class="in">Цена($):</td>

                <td class="inpSearch">
                  <input type="hidden" id="main_course" value="8650">
                  <input type="hidden" id="course" value="8650">
                    <label>от
                      <input type="text" id="price_before_new" name="price_before_new" class="fprice" 
                      maxlength="9" max-size="9" 
                      value="<%if (request.getParameter("price_before_new")!=null) out.print(request.getParameter("price_before_new"));%>">
                     </label>
                     <label>до
                       <input type="text" id="price_after_new" name="price_after_new" class="fprice" 
                       maxlengthh="9" max-size="9" 
                       value="<%if (request.getParameter("price_after_new")!=null)out.print(request.getParameter("price_after_new"));%>">
                     </label>
                   </td>
              </tr>

              <tr>
                <td></td>

                <td>
                  <input type="submit" name="search"  class="hiddenc" id="fbuttbut">
                  <a class="fbutt" id="fbutt" onclick="if (find_form(0)) javascript:document.getElementById('fbuttbut').click();return false" 
                  href="javascript:click()"></a>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </form>
    </div>


<%if (((request.getParameter("findtext")!=null)&&((!request.getParameter("findtext").equals(""))))||
	(request.getParameter("price_before_new")!=null)){%>
<jsp:include page='/jsp/templates/centerColumn_ShowPhones.jsp'/>
<%}%>

