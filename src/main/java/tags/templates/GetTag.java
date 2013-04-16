package tags.templates;

 import java.util.Hashtable;
 import java.util.Stack;
 import javax.servlet.jsp.JspException;
 import javax.servlet.jsp.PageContext;
 import javax.servlet.jsp.tagext.TagSupport;

 import beans.templates.PageParameter;

 public class GetTag extends TagSupport {
    private String name;

    // метод для установки значения атибута name
    public void setName(String name) {
       this.name = name;
    }
    public int doStartTag() throws JspException {
       // получаем ссылку на стек шаблона
       Stack stack = (Stack)pageContext.getAttribute(
                "template-stack", PageContext.REQUEST_SCOPE);

       // стек не должен быть null
       if(stack == null)
          throw new JspException("GetTag.doStartTag(): " +
                                  "NO STACK");

       // считать(peek) в хеш-таблицу
       Hashtable params = (Hashtable)stack.peek();

       // хеш-таблица не должна быть null
       if(params == null)
          throw new JspException("GetTag.doStartTag(): " +
                                  "NO HASHTABLE");

       // берем параметр страницы из хеш-таблицы
       PageParameter param = (PageParameter)params.get(name);

       if(param != null) {
          String content = param.getContent();

          if(param.isDirect()) {
             // печатаем содержимое (content), если атрибут direct == true
             try {
                pageContext.getOut().print(content);
             }
             catch(java.io.IOException ex) {
                throw new JspException(ex.getMessage());
             }
          }
          else {
             // включить содержимое (include content), если атрибут direct == false
             try {
                pageContext.getOut().flush();
                pageContext.include(content);
             }
             catch(Exception ex) {
                throw new JspException(ex.getMessage());
             }
          }
       }
       return SKIP_BODY; // пропустить тело тега
    }
    // обработчики тегов всегда должны реализовать release(), потому что
    // обработчики могут повторно использоваться JSP контейнерами
    public void release() {
       name = null;
    }
 }