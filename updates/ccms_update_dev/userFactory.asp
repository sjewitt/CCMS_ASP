<%
var userFactory = new Object();

//return a user, or false;
userFactory.login = function(login,password){
  try{
    var user = false;
    //login a user:
    var connection    = Server.CreateObject("ADODB.Connection");
    connection.open("Data Source=" + DBNAME + "; User ID=" + DBUSER + "; Password=" + DBPASSWORD);
    var recordset     = Server.CreateObject("ADODB.Recordset");
    
    var count = 0;
    var countSql = "select count (*) as count from users where active=" + State.ACTIVE + " and login='" + login + "' and password='" + password + "'";
    recordset = connection.execute(countSql);
    count         = parseInt(recordset("count"));

    if(count == 1){
      var sql = "select id from users where active=" + State.ACTIVE + " and login='" + login + "' and password='" + password + "'"; 
      //Response.Write(sql+"<br />");
      var recordset = connection.execute(sql);
      user = new User(parseInt(recordset("id")));
    }
    recordset.close();
    recordset = null;
    connection.close();
    connection = null;
    
    /*
    TODO:
    Sort out stuff around user and session:
    */
    Session("id")           = user.id;
    Session("login")        = user.login;
    Session("email")        = user.email;
    Session("fullName")     = user.fullName;
    Session("permissions")  = user.permissions;
    
    return user;
    
  }
  catch(e){
    if(connection) connection.close();
    connection = null;
    //error trap
    Response.Write(e.message);
    return false;
  }
}



%>
