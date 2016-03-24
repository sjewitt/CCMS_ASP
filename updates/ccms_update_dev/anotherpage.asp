<%@ language="javascript" %>
<!--#include virtual="/engine/api.asp"-->
<%
if(Request.QueryString("logout") == "true"){
  Session("login") = null;
  Session("fullName") = null;
  Session("email") = null;
  Session("permissions") = null;
  Session("id") = null;
}
if(Session("id") == null){
  Response.Redirect("/logintest.asp");
}

%>
<html>
<head>
  <title></title>
</head>
<body>
id: <%=Session("id")%><br />
login: <%=Session("login")%><br />
name: <%=Session("fullName")%><br />
email: <%=Session("email")%><br />
perms: <%=Session("permissions")%><br />
</body>
</html>
