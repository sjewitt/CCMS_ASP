<%@ language="javascript" %>
<!--#include virtual="/ccms_asp/engine/api.asp"-->
<%

//evaluate user session:
var currentUser = userFactory.getCurrentUser();

//only render edit form if user has rights:
if(currentUser){

%><?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
  
  <%=EDITOR_CSS%>
  <%=EDITOR_JAVASCRIPTS%>
  
  <title>Upload an image or document</title>
  <script type="text/javascript">
  function submitfrm(frm){
    try{
      if(frm.file.value != ""){
    
        if(confirm("Upload this file?")){
          frm.submit();  
        }
      }
      else{
        alert("Please select a file to upload.")
      }
    }
    catch(e){
      alert(e)
    }
  }
  
  function checkfrm(frm){
    alert(frm.file.value);
  }
  </script>
  </head>
  <body>
    <div id="container">
      <div id="editor_content">
        <div style="height:130px;">
          <img style="float:left;padding-right:20px;" src="/ccms_asp/editor/images/bin100x130.jpg" alt="Upload a binary" />
          <h1>Upload an image or document</h1>
          <p>
            Select a file from your desktop and select the type.
          </p>
        </div>
        
        <form name="upload" action="/ccms_asp/editor/upload_handler.asp" method="post" enctype="multipart/form-data">
          <table>
            <tr>
              <td style="vertical-align:top;">Select file:</td>
              <td>
                <input type="file" name="file" value="" />
              </td>
            </tr>
            <!-- tr>
              <td>Select type:</td>
              <td>
                <!-- select name="filetype">
                  <option value="image">Image</option>
                  <option value="document">Document</option>
                </select -->   
              </td>
            </tr -->
          </table>
          <input type="button" value="Upload file" onclick="submitfrm(document.upload);return false;" />
        </form>
        <p>
        [<a href="#" onclick="javascript:window.close();">close</a>]
        </p>
        </div>
      </div>
  </body>
</html>
<%
}
//otherwise, error:
else{
  Response.Write("INSUFFICIENT PRIVILEGES OR NOT LOGGED IN.<br />PLEASE CLOSE THIS WINDOW AND LOG IN AGAIN.");
}
%>
