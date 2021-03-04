<div>
  <%
    String resourcePath = "/e_jsp/j04/eclass_notice.txt";
    out.print("자원의 실제 경로: " + application.getRealPath(resourcePath) + "<br/>");
    char[] buff = new char[128];
    int len = -1;
    InputStreamReader br = null;
    try{
      br = new InputStreamReader(application.getResourceAsStream(resourcePath),"UTF-8");
      while((len = br.read(buff)) != -1){
        out.print(new String(buff,0,len));
      }
      
    } catch(IOException e){
      e.printStackTrace();
    } finally{
      if(null != br){
        try{
          br.close();
        } catch(IOException e){
          e.printStackTrace();
        }
        
      }
    }
  %>
</div>