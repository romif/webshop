package tags.templates;

 import java.util.Hashtable;
 import java.util.Stack;
 import javax.servlet.jsp.JspException;
 import javax.servlet.jsp.PageContext;
 import javax.servlet.jsp.tagext.TagSupport;

 public class InsertTag extends TagSupport {
    private String template;
    private Stack stack;

    // метод для настройки атрибута template
    public void setTemplate(String template) {
       this.template = template;
    }
    public int doStartTag() throws JspException {
       stack = getStack(); // получаем ссылку на стек шаблона
       stack.push(new Hashtable()); // помещаем новую хеш-таблицу в стек
       return EVAL_BODY_INCLUDE; // передаем тело тега без изменений
    }
    public int doEndTag() throws JspException {
       try {
          pageContext.include(template); // включаем шаблон
       }
       catch(Exception ex) { // IOException or ServletException
          throw new JspException(ex.getMessage()); // вызываем исключение другого типа (recast exception)
       }
       stack.pop(); // выталкиваем хеш-таблицу из стека
       return EVAL_PAGE; // вычислить остаток страницы после тега
    }
    // обработчики тегов всегда реализуют release(), потому что
    // обработчики могут повторно использоваться JSP контейнерами
    public void release() {
       template = null;
       stack = null;
    }
    public Stack getStack() {
       // попытаемся получить стек из области запроса
       Stack s = (Stack)pageContext.getAttribute(
                         "template-stack",
                         PageContext.REQUEST_SCOPE);

       // если нет стека — создать новый
       // и положить его в область действия запроса
       if(s == null) {
          s = new Stack();
          pageContext.setAttribute("template-stack", s,
                         PageContext.REQUEST_SCOPE);
       }
       return s;
    }
 }