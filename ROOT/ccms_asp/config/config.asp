<%
/*********************************************************************
basic database connection:
*********************************************************************/
var DBDRIVER    = "{SQL Server}";
var DBSERVER    = "localhost\\SQLEXPRESS";
var DBNAME      = "ccms";
var DBUSER      = "ccms";
var DBPASSWORD  = "password";


/*********************************************************************
logger settings
logging: on,off
loglevel: fatal, warn, error, info, trace
*********************************************************************/
var LOGGING = 'ON';
var LOGLEVEL = "TRACE";

/*********************************************************************
path to images/binaries:
*********************************************************************/
var UPLOADFILEPATH = "images";

/*********************************************************************
configured insertable types:
 - read by TinyMCE integration code
 The lists are structured this way, as objects whose values are
 explicit 'true' values, because this makes the decision code much
 simpler - and therefore faster...
*********************************************************************/
var IMAGETYPES = {PNG:true,JPG:true,JPEG:true,GIF:true};
var INSERTABLEDOWNLOADTYPES = {DOC:true,PDF:true,XLS:true};

/*********************************************************************
cache default time in seconds:
*********************************************************************/
var USECACHE = true;
var CACHETIMEOUT = 30;  //1 hour = 3600

/*********************************************************************
Type of session management to use. This switch is here to account for 
shared hosting where the ASP Session object is unreliable.

values:
SESSIONTYPE="asp"
or
SESSIONTYPE="internal"
*********************************************************************/
SESSIONTYPE="internal";

/*********************************************************************
ASP Session object timeout value:
*********************************************************************/
Session.Timeout=10;

/*********************************************************************
CUSTOMISATIONS: BESPOKE TAGS FOR E.G. NAVIGATIONS.
The engine makes a call to a stub method, insertCustomisedLayout(), which is where
the mapping between these tags and the appropriate custom method is made.
?
*********************************************************************/

/*********************************************************************
SYSTEM ATTRIBUTES: SHOULD NOT NORMALLY NEED TO BE ALTERED.
*********************************************************************/

/*********************************************************************
Core HTML page metatext value slots. Add here any standard/bespoke metatext schema defs as needed.
For most cases, the standard HTML description, keywords and title will suffice.

Structure:
[
  {ccmsTagName:pagePropertyName}
]
*********************************************************************/
var CORE_METATEXT_MAPPING = [
{tag:/{CMS_CORE_DESCRIPTION}/g, pageProperty:"description"},
{tag:/{CMS_CORE_KEYWORDS}/g,    pageProperty:"keywords"},
{tag:/{CMS_CORE_TITLE}/g,       pageProperty:"title"},        //TODO: Modify to be title property. 060709 - was linkText
{tag:/{CMS_CORE_DATE}/g,        pageProperty:"updatedDate"},  //this assumes that the first content slot takes precidence
{tag:/{CMS_CORE_AUTHOR}/g,      pageProperty:"updatedUser"},
{tag:/{CMS_CORE_LINKTEXT}/g,    pageProperty:"linkText"}
];


/*********************************************************************
editor popup page sizes. These are basically x,y dimensions that get rendered as 
javascript parameters passed to a 'popup' function: 
*********************************************************************/
var SIZE_ADMIN_HOME           = "400,320";
var SIZE_ADMIN_CONTENT_TYPES  = "500,450";
var SIZE_ADMIN_USERS          = "500,600";
var SIZE_ADMIN_TEMPLATES      = "x,y";
var SIZE_ADD_TO_VT            = "700,620";
var SIZE_ASSIGN_CONTENT       = "700,650";
var SIZE_ASSIGN_LAYOUT        = "540,500";
var SIZE_PROPS_CONTENT        = "x,y";
var SIZE_PROPS_PAGE           = "400,390";
var SIZE_CREATE_CONTENT       = "400,420";
var SIZE_CREATE_PAGE          = "400,440";
var SIZE_EDIT_CONTENT         = "820,670";
var SIZE_MANAGE_CONTENT       = "450,520";
var SIZE_MANAGE_PAGES         = "600,500";
var SIZE_REMOVE_PAGE          = "450,350";
var SIZE_REMOVE_CONTENT       = "x,y";
var SIZE_UPLOAD_BINARY        = "400,360";

/*********************************************************************
Editor location of CSS and javascript files. HTML include files:
*********************************************************************/
var EDITOR_JAVASCRIPTS        = "<script type=\"text/javascript\" src=\"/ccms_asp/editor/scripts/editscripts.js\"></script>\n";
var EDITOR_DOM_MANAGENAV      = "<script type=\"text/javascript\" src=\"/ccms_asp/editor/scripts/dom_managenav.asp\"></script>\n";
var EDITOR_DOM_MANAGELAYOUTS  = "<script type=\"text/javascript\" src=\"/ccms_asp/editor/scripts/dom_managelayout.asp\"></script>\n";
var EDITOR_DOM_MOVENODE       = "<script type=\"text/javascript\" src=\"/ccms_asp/editor/scripts/dom_movenode.asp\"></script>\n";
var EDITOR_CSS                = "<link rel=\"stylesheet\" href=\"/ccms_asp/editor/styles/editstyles.css\" type=\"text/css\" />\n";


/*********************************************************************
TODO: Check for return links in the popups themselves:
managecontent
managepages

//ADMIN PAGES:
manageusers
managecontenttypes

//SLOT ACTIONS:
editcontent           820,670
contentprops          400,420
assigncontent         700,600
createcontent         400,420
removecontent         400,420
assigncontent         700,600
editcontentproperties 400,460

//editor bar:
admin                 400,320
uploadbinary          400,360
createpage            400,440
managepages           600,500
assignlayouts         600,500
createcontent         400,420
managecontent         500,520
pageproperties        400,390
removeviewtreebranch  450,350
*********************************************************************/

%>

