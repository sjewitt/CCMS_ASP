<%@ language="javascript" %>
<!--#include virtual="/ccms_asp/engine/api.asp"-->
<%
//evaluate user session:
var currentUser = userFactory.getCurrentUser();
//only render edit form if user has rights:
if(currentUser){
  var currpage = new Page(Request.QueryString("pageid"));


%><?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

  <%=EDITOR_CSS%>
  <%=EDITOR_JAVASCRIPTS%>

  <title>Create new page</title>
</head>
<body>
  <div id="container">
      <div id="editor_content">
        <div style="height:130px;">
          <img style="float:left;padding-right:20px;" src="/ccms_asp/editor/images/page100x130.jpg" alt="Create page" />
           <h1>Create new page</h1>
          <p>Enter the appropriate properties for the new page. These may be altered later if needed. Optionally, the new
          page may be added to the viewtree after creation.</p>
        </div>
<%

  
  //update the properties:
  if(Request.Form("action") == "createpage"){
    
    //Response.Write("creating with " + Request.Form);
    var newPageId = editUtils.createNewPage(
      currentUser,
      Request.Form("name"),  
      Request.Form("title"),  
      Request.Form("linktext"),  
      Request.Form("description"), 
      Request.Form("keywords")
    );                              
    //TODO: ESCAPE THE INCOMING DATA
    
    //Response.Redirect(Request.ServerVariables("HTTP_REFERER") + "&reload=true");
    if(newPageId){
%>  
  <p>Page created OK</p>
  <p>Click <a href="#" onclick="popup('/ccms_asp/editor/addtoviewtree.asp?pageid=<%=newPageId%>',<%=SIZE_ADD_TO_VT%>);">HERE</a> to add page to viewtree.</p>
  
<%
    }
    else{
%>
   An error occurred creating the new page.<br />
<%
    }
  }
  else{
%>

  <form name="page" action="<%=Request.ServerVariables("SCRIPT_NAME")%>" method="post">
  <input type="hidden" name="action" value="createpage" />
  <table>
    <tr>
      <td>Name</td>
      <td><input type="text" name="name" value="" /></td>
    </tr>
    <tr>
      <td>Page Title</td>
      <td><input type="text" name="title" value="" /></td>
    </tr>
    <tr>
      <td>Link text</td>
      <td><input type="text" name="linktext" value="" /></td>
    </tr>
    <tr>
      <td>Description</td>
      <td><input type="text" name="description" value="" /></td>
    </tr>
    <tr>
      <td>Keywords</td>
      <td><input type="text" name="keywords" value="" /></td>
    </tr>
    <tr>
      <td></td>
      <td><input type="submit" value="Create" /></td>
    </tr>
  </table>
  </form>

<%
  }
%>
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
