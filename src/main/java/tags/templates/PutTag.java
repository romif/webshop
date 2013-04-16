package tags.templates;

 import java.util.Hashtable;
 import java.util.Stack;
 import javax.servlet.jsp.JspException;
 import javax.servlet.jsp.tagext.TagSupport;
 import beans.templates.PageParameter;

 public class PutTag extends TagSupport {
    private String name, content, direct="false";

    // методы настройки атрибутов тега Put
    public void setName(String s) { name = s; }
    public void setContent(String s) {content = s; }
    public void setDirect(String s) { direct = s; }

    public int doStartTag() throws JspException {
       // получаем ссылку на объемлющий тег insert
       InsertTag parent = (InsertTag)getAncestor(
                               "tags.templates.InsertTag");

       // теги put должны включаться в тег insert
       if(parent == null)
          throw new JspException("PutTag.doStartTag(): " +
                                 "No InsertTag ancestor");

       // получить стек шаблонов из тега insert
       Stack template_stack = parent.getStack();

       // стек шаблона не должен быть пустым
       if(template_stack == null)
          throw new JspException("PutTag: no template stack");

       // прочитать хеш-таблицу на вершине стека
       Hashtable params = (Hashtable)template_stack.peek();

       // хеш-таблица тоже не должна быть пустой
       if(params == null)
          throw new JspException("PutTag: no hashtable");

       // положить новый PageParameter в хэш-таблицу
      params.put(name, new PageParameter(content, direct));

      return SKIP_BODY; // не нужно тело тега, [даже] если есть
   }
   // обработчики тегов всегда должны реализовать release(), потому что
    // обработчики могут повторно использоваться JSP контейнерами
   public void release() {
      name = content = direct = null;
   }
   // удобный метод для поиска имен предшественников (ancestor)
    // для заданного имени класса
   private TagSupport getAncestor(String className)
                                 throws JspException {
      Class klass = null; // нет переменных с именем "class"
      try {
         klass = Class.forName(className);
      }
      catch(ClassNotFoundException ex) {
         throw new JspException(ex.getMessage());
      }
      return (TagSupport)findAncestorWithClass(this, klass);
   }
}