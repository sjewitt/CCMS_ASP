<%@ language="javascript" %>
<!--#include virtual="/ccms_asp/engine/api.asp"-->
<%
var currentUser = userFactory.getCurrentUser();

//only render edit form if user has rights:
if(currentUser){
  var contentId   = parseInt(Request.QueryString("contentid"));
  var content     = new Content(contentId);
  var instList    = content.getInstanceList();  //this should return an array of ContentInstance objects...
  var currInst    = instList[instList.length-1]; //TODO
  
  //retrieve the change state options for the current user:
  var stateOptions = editUtils.getInstanceActionOptions(currentUser,instList);
  
  /*
  HANDLE UPDATE REQUEST:
  */
  if(new String(Request.Form("action")) == "update"){
    currInst.setContent(Request.Form("content"));
    currInst.update();  //this method should create an ATWORK instance unless over-ridden:
    Response.Redirect(Request.ServerVariables("SCRIPT_NAME") + "?contentid=" + Request.QueryString("contentid"));// + "&reload=true");
  }
  
  /*
  SET THE VERSION TO DISPLAY:
  */
  if(parseInt(Request.QueryString("versionid"))){
    currInst = new ContentInstance(parseInt(Request.QueryString("versionid")));
  }
  else{
    Response.Redirect(Request.ServerVariables("SCRIPT_NAME") + "?contentid=" + Request.QueryString("contentid") + "&versionid=" + currInst.id);
  }  
   
  /*
  SET THE STATE:
  */
  Response.Write(Request.QueryString("action"));
  if(new String(Request.QueryString("action")) == "setstate"){
    
    Response.Write(Request.QueryString("action"));
    Response.Write(Request.QueryString("state"));
    
    if(Request.QueryString("state") == "delete"){
      editUtils.deleteInstance(currInst);
      //Response.Write("TODO: Delete instance " + Request.QueryString("versionid") + ", " + Request.QueryString("contentid"));
      //reload: Show the most recent instance:
      Response.Redirect(Request.ServerVariables("SCRIPT_NAME") + "?contentid=" + Request.QueryString("contentid"));// + "&reload=true");
    }
    else{
      currInst.state = State.ATWORK;
      if(parseInt(Request.QueryString("state"))){
        currInst.state = parseInt(Request.QueryString("state"));
      }
      currInst.update(true);  //pass updateCurrentInstance flag
      //I DO want the version ID here:
      Response.Redirect(Request.ServerVariables("SCRIPT_NAME") + "?contentid=" + Request.QueryString("contentid") + "&versionid=" + Request.QueryString("versionid"));// + "&reload=true");
    }
  }
  
  var refresher = "";
  //see above... Trigger opener refresh:
  if(new String(Request.QueryString("reload")) == "true"){
    refresher = editUtils.getOpenerReloadJavascript();
  }


%><?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=windows-1250" />
  <meta name="generator" content="PSPad editor, www.pspad.com" />
  
  <%=EDITOR_CSS%>
  <%=EDITOR_JAVASCRIPTS%>
  
  <!-- TinyMCE main .js path -->
  <script type="text/javascript" src="/ccms_asp/editor/tiny_mce/tiny_mce.js"></script>
  <!-- and initialise TinyMCE to use ANY textarea (there is only one...) -->
  <script type="text/javascript">
  
  tinyMCE.init(
    {
      mode : "textareas",
      theme : "advanced",
      theme_advanced_toolbar_location : "top",
      theme_advanced_toolbar_align : "left",
      theme_advanced_statusbar_location : "bottom",
      theme_advanced_resizing : true,
      external_image_list_url : "/ccms_asp/editor/imagelist_JSON.asp",
      external_link_list_url : "/ccms_asp/editor/linklist_JSON.asp",
      style_formats : [
                {title : 'Shadowbox Block', block : 'div', classes : 'shadowbox_wrapper'}
        ]

    }
  );
  
  //handler for version options:
  function manageVersion(frm){
    if(frm.state.value == "delete"){
      if(confirm("You are about to delete a version.\nAre you sure?")){
        frm.submit();
      }
    }
    else{
      frm.submit();
    }
  }
  
  </script>

  
  <title>Edit content</title>
  </head>
  <body>
    <%=refresher%>
    <div id="container">
    <div id="editor_content">
    <h1>Edit content</h1>
    
    
    
    <table style="width:100%;">
      <tr>
        <td style="vertical-align:top;">
          <img style="float:left;padding-right:20px;" src="/ccms_asp/editor/images/contentedit100x130.jpg" alt="Edit content" />
          <h2 style="margin-bottom:5px;">Instance list</h2>
          <%
          var front = "";
          var back = "";
          var instanceListInfo = "";
          for(var a=0;a<instList.length;a++){
            front = "";
            back = "";
            instanceListInfo += "<div";
            switch(instList[a].state){
              case State.ACTIVE:
                instanceListInfo += " class=\"active\">";
              break;
             case State.ATWORK:
                instanceListInfo += " class=\"atwork\">";
              break;
              case State.PENDING:
              instanceListInfo += " class=\"pending\">";
              break;
              case State.REJECTED:
              instanceListInfo += " class=\"rejected\">";
              break; 
            }
            if((instList[a].id) == Request.QueryString("versionid")){
              front = "<strong>";
              back = "</strong>";
            }
            
            //manage cases where the instance state requires CHANGESTATE perms:
            if(instList[a].state == State.ACTIVE || instList[a].state == State.REJECTED){
              //if user has changestate rights, offer the link:
              if(currentUser.permissions & Permissions.CHANGESTATE || currentUser.permissions & Permissions.ADMINISTRATOR){
                instanceListInfo += front + "<a href=\"" + Request.ServerVariables("SCRIPT_NAME") + "?contentid=" + Request.QueryString("contentid") + "&amp;versionid="+instList[a].id + "\"> " + dateUtils.getShortDateTime(instList[a].updatedDate) + "</a>";
              }
              else{
                instanceListInfo += dateUtils.getShortDateTime(instList[a].updatedDate)
              }
            }
            else{
              instanceListInfo += front + "<a href=\"" + Request.ServerVariables("SCRIPT_NAME") + "?contentid=" + Request.QueryString("contentid") + "&amp;versionid="+instList[a].id + "\"> " + dateUtils.getShortDateTime(instList[a].updatedDate) + "</a>";
            }
            
            //othewise, just render the text:
            instanceListInfo += back + "</div>\n";
          }
          %>
          <%=instanceListInfo%>
          <form name="manageversion" action="">
          <input type="hidden" name="action" value="setstate" />
          <input type="hidden" name="contentid" value="<%=Request.QueryString("contentid")%>" />
          <input type="hidden" name="versionid" value="<%=Request.QueryString("versionid")%>" />
          <!-- select name="state" onchange="javascript:document.setstate.submit();" -->
          <select name="state" onchange="manageVersion(document.manageversion);">
            <option value="">Instance Actions:</option>
            <%=stateOptions%>
          </select>
          </form>
        <p>
        [<a href="#" onclick="javascript:window.close();">close</a>]
        </p>
        </td>
        <td>
          <form name="updatecontent" action="<%=Request.ServerVariables("SCRIPT_NAME")%>?contentid=<%=contentId%>&amp;versionid=<%=Request.QueryString("versionid")%>" method="post">
          <input type="hidden" name="action" value="update" />
          <textarea name="content" rows="28" cols="72"><%=currInst.content%></textarea>
          <input type="submit" name="submit" value="Save changes" title="Save current changes into a new ATWORK instance" />
          </form>
        </td>
      </tr>
    </table>
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
