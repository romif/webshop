package tags.templates;

 import java.util.Hashtable;
 import java.util.Stack;
 import javax.servlet.jsp.JspException;
 import javax.servlet.jsp.tagext.TagSupport;
 import beans.templates.PageParameter;

 public class PutTag extends TagSupport {
    private String name, content, direct="false";

    // ������ ��������� ��������� ���� Put
    public void setName(String s) { name = s; }
    public void setContent(String s) {content = s; }
    public void setDirect(String s) { direct = s; }

    public int doStartTag() throws JspException {
       // �������� ������ �� ���������� ��� insert
       InsertTag parent = (InsertTag)getAncestor(
                               "tags.templates.InsertTag");

       // ���� put ������ ���������� � ��� insert
       if(parent == null)
          throw new JspException("PutTag.doStartTag(): " +
                                 "No InsertTag ancestor");

       // �������� ���� �������� �� ���� insert
       Stack template_stack = parent.getStack();

       // ���� ������� �� ������ ���� ������
       if(template_stack == null)
          throw new JspException("PutTag: no template stack");

       // ��������� ���-������� �� ������� �����
       Hashtable params = (Hashtable)template_stack.peek();

       // ���-������� ���� �� ������ ���� ������
       if(params == null)
          throw new JspException("PutTag: no hashtable");

       // �������� ����� PageParameter � ���-�������
      params.put(name, new PageParameter(content, direct));

      return SKIP_BODY; // �� ����� ���� ����, [����] ���� ����
   }
   // ����������� ����� ������ ������ ����������� release(), ������ ���
    // ����������� ����� �������� �������������� JSP ������������
   public void release() {
      name = content = direct = null;
   }
   // ������� ����� ��� ������ ���� ���������������� (ancestor)
    // ��� ��������� ����� ������
   private TagSupport getAncestor(String className)
                                 throws JspException {
      Class klass = null; // ��� ���������� � ������ "class"
      try {
         klass = Class.forName(className);
      }
      catch(ClassNotFoundException ex) {
         throw new JspException(ex.getMessage());
      }
      return (TagSupport)findAncestorWithClass(this, klass);
   }
}