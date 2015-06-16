<?php
/***********************************************************************************
 * Migration script from vTiger 5.4 to 6.2
 ************************************************************************************/

global $php_max_execution_time;
set_time_limit($php_max_execution_time);

echo "Setting the application up\n";


// Getting the required vTiger libraries
echo "Loading the libraries\n";
require_once('libraries/adodb/adodb.inc.php');
require_once('include/utils/CommonUtils.php');
require_once('includes/Loader.php');
require_once('modules/Install/models/ConfigFileUtils.php');
require_once('modules/Install/models/InitSchema.php');
require_once('modules/Install/models/Utils.php');
require_once('includes/Loader.php');
require_once('includes/runtime/Controller.php');
require_once('includes/runtime/BaseModel.php');
require_once('includes/runtime/Globals.php');
require_once('modules/Migration/views/Index.php');
require_once('vtigerversion.php');

include_once 'vtlib/Vtiger/Module.php';
include_once 'includes/main/WebUI.php';
require_once 'modules/Users/Users.php';
require_once 'modules/Users/models/Module.php';

// Load the setup config file
echo "Loading the vTiger setup configuration\n";
require_once('config.php');

// Check the database connection
echo "Check database connection\n";
$dbCheckResult = Install_Utils_Model::checkDbConnection($dbconfig['db_type'], $dbconfig['db_hostname'], $dbconfig['db_username'], $dbconfig['db_password'], $dbconfig['db_name'], false, true, null, null);

$next = $dbCheckResult['flag'];
$error_msg = $dbCheckResult['error_msg'];
$error_msg_info = $dbCheckResult['error_msg_info'];
$db_utf8_support = $dbCheckResult['db_utf8_support'];

if ($next == true) {
  // Initialize and set up tables
  echo "Creating the tables and populating with configuration data\n";
  Install_InitSchema_Model::initialize();

  // Install all the available modules
  echo "Installing the vTiger modules\n";
  Install_Utils_Model::installModules();

  // Migrate database to latest version
  echo "Migrating vTiger database\n";
  Install_InitSchema_Model::upgrade();

  echo "Application has been setup\n";

  exit(0);
} else {
  // Something is wrong with the database
  echo "The database is not setup properly\n";
  echo "$error_msg\n";
  echo "$error_msg_info\n";

  echo "Application is NOT setup\n";

  exit(1);
}
echo "SCRIPT END\n";
?>