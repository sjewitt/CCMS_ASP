<%@ language="javascript" %>
<!--#include virtual="/engine/api.asp"-->

<html>
<head>
  <title></title>
</head>
<body>

<%
  if( ( new String(Request.Form("login") ) ) != "undefined" && (new String(Request.Form("password"))) != "undefined"){
  //do login stuff
  var user = userFactory.login(Request.Form("login"),Request.Form("password"));
  if(user){
    Response.Write("Logged in OK<br>")
  }
  else{
%>


Not logged in! try again...<br />
<form name="login" action="<%=Request.ServerVariables("SCRIPT_NAME")%>" method="post">
Username: <input type="text" name="login" value="" /><br />
Password: <input type="password" name="password" value="" /><br />
<input type="submit" value="login" />
</form>

<%
  }
%>

<a href="/anotherpage.asp">OK</a>

<%
  }
  else{
%>
Login<br>
<form name="login" action="<%=Request.ServerVariables("SCRIPT_NAME")%>" method="post">
Username: <input type="text" name="login" value="" /><br />
Password: <input type="password" name="password" value="" /><br />
<input type="submit" value="login" />
</form>
<%
  }
%>
