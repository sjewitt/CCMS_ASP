<%
/*
wrap this around ASP Session() object.
*/
function User(id){
  this.id                = null;
  this.login             = null;
  this.fullName          = null;
  this.email             = null;
  this.permissions       = null;
  
  try{
    /*
    'constructor'.
    If an ID is passed, set the property and retrieve the instancelist:
    */
    
    if(id){
      var connection    = Server.CreateObject("ADODB.Connection");
      connection.open("Data Source=" + DBNAME + "; User ID=" + DBUSER + "; Password=" + DBPASSWORD);
      var recordset     = Server.CreateObject("ADODB.Recordset");
      
      var count = 0;
      var countSql = "select count (*) as count from users where id=" + id;
      recordset = connection.execute(countSql);
      count         = parseInt(recordset("count"));

      if(count == 1){
        this.id   = id;
        var dataSql = "select login,fullname,email,active,permissions from users where id=" + id;
        recordset = connection.execute(dataSql);
        
        this.login        = new String(recordset("login"));
        this.fullName     = new String(recordset("fullname"));
        this.email        = new String(recordset("email"));
        this.permissions  = parseInt(recordset("permissions"));
      }
      
      recordset.close();
      recordset = null;
      connection.close(); 
      connection = null
    }
    else{
      //no user ID
    }
  }
  catch(e){
  Response.Write(e.message);
  }
  //user methods:
}
%>
