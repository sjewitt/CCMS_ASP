<%
var renderUtils = new Object();
//TODO - bring all called render methods here

//return the connection string:
renderUtils.getConnectionString = function(){
  try{
    var connStr     = "Driver="     + DBDRIVER; //{SQL Server}
    connStr         += ";Server="   + DBSERVER;
    connStr         += ";Database=" + DBNAME;
    connStr         += ";Uid="      + DBUSER;
    connStr         += ";Pwd="      + DBPASSWORD;
    return connStr;
  }
  catch(e){
    return(false);
  }
}

//TODO: possibly separate core from non-core? IE optional author etc.
renderUtils.replaceCoreProperties = function(inStr,page,contentMap){
  var out = inStr;
  try{
    for(var a=0;a<CORE_METATEXT_MAPPING.length;a++){
      switch(CORE_METATEXT_MAPPING[a].pageProperty){
        case "updatedUser":
          out = out.replace(CORE_METATEXT_MAPPING[a].tag,(new User(page[CORE_METATEXT_MAPPING[a].pageProperty])).fullName); //this needs to be the content author not the page author
        break;
        
        case "updatedDate": //TODO: Hand this off to a 
          var updatedDate = dateUtils.getShortDateTime(page[CORE_METATEXT_MAPPING[a].pageProperty]);
          var content;
          //is there a Content object in the first slot?
          //showObject(contentMap); //contentMap is only populated if a slot actually has content. Therefore, the below will work:
          
          //Add detector for news as well if needed, or perhaps include a pointer to a custom method
          
          for(var b=0;b<contentMap.mapping.length;b++){
            if(contentMap.mapping[b].slotId == 1){
              content = new Content(contentMap.mapping[b].contentId);
              updatedDate = dateUtils.getShortDateTime((content.getActiveInstance()).updatedDate);
              //exit loop:
              b = contentMap.mapping.length + 1;
            }
          }
        
          out = out.replace(CORE_METATEXT_MAPPING[a].tag,updatedDate);
        break;
        
        default:
          out = out.replace(CORE_METATEXT_MAPPING[a].tag,page[CORE_METATEXT_MAPPING[a].pageProperty]);
      }
    }
    return out;
  }
  catch(e){
    Response.Write(e.message);
    return out;
  }
}

//return an array of all Page objects (TODO: destination );move to editUtils)
renderUtils.getAllPages = function(){
  try{
      var connection    = Server.CreateObject("ADODB.Connection");
      connection.open(renderUtils.getConnectionString());
      var recordset     = Server.CreateObject("ADODB.Recordset");
      //retrieve content array:
      var pageListSql = "select id from page order by name;";
    
      //set the properties:
      cmd                   = Server.CreateObject("ADODB.Command");
      cmd.CommandType       = 1;                    //adCmdText - sql query
      cmd.Name              = "renderutils_getallpages";   //note naming convention...
      cmd.CommandText       = pageListSql;             //Parameterised SQL
      cmd.ActiveConnection  = connection;           //set the active connection
      cmd.Prepared          = true;                 //set the statement to prepared.
      
      //retrieve the record:
      recordset   = cmd.execute();
      var out = new Array();
      while(!recordset.EOF){
        out.push(new Page(recordset("id")));
        recordset.MoveNext();
      }
      
      recordset.close();
      recordset = null;
      connection.close(); 
      connection = null;
      
      return out; 
  }
  catch(e){
      recordset = null;
      connection = null;
      var err = "";
      for(p in e){
        err += p +"="+e[p]+"<br>"; 
      }
    Response.Write(err);
    return false;
  }
}

%>
