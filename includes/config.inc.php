<?php

if (!defined('LIVE')) {
		define('LIVE', false);
		define('CONTACT_EMAIL', 'you@example.com');
}
// define('LIVE', true);

define('BASE_URI', dirname(dirname(__FILE__)));
define('BASE_URL', 'http://localhost/cbt/');
define('EXCEL_DIR', BASE_URI . '\import-excel-file-in-database\\');
define('IMAGE_DIR', BASE_URI . '\images\\');
define('EDITOR_IMAGE_DIR', BASE_URI . "/editor-images");
define('MYSQLI', BASE_URI . '/mysqli.inc.php');
// These should be true while developing the web site
define('IS_WARNING_FATAL', true);
define('DEBUGGING', true);
// The error types to be reported
define('ERROR_TYPES', E_ALL);
// Settings about mailing the error messages to admin
define('SEND_ERROR_MAIL', false);
define('ADMIN_ERROR_MAIL', 'Administrator@example.com');
define('SENDMAIL_FROM', 'Errors@example.com');
ini_set('sendmail_from', SENDMAIL_FROM);
// By default we don't log errors to a file
define('LOG_ERRORS', false);
define('LOG_ERRORS_FILE', 'c:\\tshirtshop\\errors_log.txt'); // Windows
// define('LOG_ERRORS_FILE', '/home/username/tshirtshop/errors.log'); // Linux
/* Generic error message to be displayed instead of debug info
(when DEBUGGING is false) */
define('SITE_GENERIC_ERROR_MESSAGE', '<h1>TShirtShop Error!</h1>');
require_once 'error_handler.php';
// Set the error handler
ErrorHandler::SetHandler();


# the key should be random binary, use scrypt, bcrypt or PBKDF2 to
# convert a string into a key
# key is specified using hexadecimal
$crypty_key = pack('H*', "bcb04b7e103a0cd8b54763051cef08bc55abe029fdebae5e1d417e2ffb2a00a3");
define ('CRYPT_KEY', "$crypty_key");

$name = 'BetaGrades';
session_name($name . '_Session');

session_start();

function escape_data($data, $dbc){
	if (get_magic_quotes_gpc()) {
		$data = stripslashes($data);
	}
	//$data = addslashes($data);
	return mysqli_real_escape_string ($dbc, trim ($data));
}

function redirect_if_not($check = 'user', $destination = 'index.php', $type = 'admin', $protocol = 'http://'){
	
	// Check for the session item:
	if (!headers_sent()){
	  if (!isset($_SESSION[$check]) || $_SESSION['user'] != $type) {
		  $url = $protocol . BASE_URL . $destination; // Define the URL.
		  header("Location: $url");
		  exit(); // Quit the script.
	  }
	}else {
   include_once('includes/header.html');
   trigger_error('You do not have permission to access this page. Please log in and try again.');
   include_once('includes/footer.html');
}
}

function redirect_invalid_user($check = 'username', $destination = 'index.php', $protocol = 'http://') {

	// Check for the session item:
	if (!headers_sent()){
	  if (!isset($_SESSION[$check])) {
		  $url = $protocol . BASE_URL . $destination; // Define the URL.
		  header("Location: $url");
		  exit(); // Quit the script.
	  }
	}else {
   include_once('includes/header.html');
   trigger_error('You do not have permission to access this page. Please log in and try again.');
   include_once('includes/footer.html');
}
}

function xss_clean($data)
{
// Fix &entity\n;
$data = str_replace(array('&amp;','&lt;','&gt;'), array('&amp;amp;','&amp;lt;','&amp;gt;'), $data);
$data = preg_replace('/(&#*\w+)[\x00-\x20]+;/u', '$1;', $data);
$data = preg_replace('/(&#x*[0-9A-F]+);*/iu', '$1;', $data);
$data = html_entity_decode($data, ENT_COMPAT, 'UTF-8');

// Remove any attribute starting with "on" or xmlns
$data = preg_replace('#(<[^>]+?[\x00-\x20"\'])(?:on|xmlns)[^>]*+>#iu', '$1>', $data);

// Remove javascript: and vbscript: protocols
$data = preg_replace('#([a-z]*)[\x00-\x20]*=[\x00-\x20]*([`\'"]*)[\x00-\x20]*j[\x00-\x20]*a[\x00-\x20]*v[\x00-\x20]*a[\x00-\x20]*s[\x00-\x20]*c[\x00-\x20]*r[\x00-\x20]*i[\x00-\x20]*p[\x00-\x20]*t[\x00-\x20]*:#iu', '$1=$2nojavascript...', $data);
$data = preg_replace('#([a-z]*)[\x00-\x20]*=([\'"]*)[\x00-\x20]*v[\x00-\x20]*b[\x00-\x20]*s[\x00-\x20]*c[\x00-\x20]*r[\x00-\x20]*i[\x00-\x20]*p[\x00-\x20]*t[\x00-\x20]*:#iu', '$1=$2novbscript...', $data);
$data = preg_replace('#([a-z]*)[\x00-\x20]*=([\'"]*)[\x00-\x20]*-moz-binding[\x00-\x20]*:#u', '$1=$2nomozbinding...', $data);

// Only works in IE: <span style="width: expression(alert('Ping!'));"></span>
$data = preg_replace('#(<[^>]+?)style[\x00-\x20]*=[\x00-\x20]*[`\'"]*.*?expression[\x00-\x20]*\([^>]*+>#i', '$1>', $data);
$data = preg_replace('#(<[^>]+?)style[\x00-\x20]*=[\x00-\x20]*[`\'"]*.*?behaviour[\x00-\x20]*\([^>]*+>#i', '$1>', $data);
$data = preg_replace('#(<[^>]+?)style[\x00-\x20]*=[\x00-\x20]*[`\'"]*.*?s[\x00-\x20]*c[\x00-\x20]*r[\x00-\x20]*i[\x00-\x20]*p[\x00-\x20]*t[\x00-\x20]*:*[^>]*+>#iu', '$1>', $data);

// Remove namespaced elements (we do not need them)
$data = preg_replace('#</*\w+:\w[^>]*+>#i', '', $data);

do
{
	// Remove really unwanted tags
	$old_data = $data;
	$data = preg_replace('#</*(?:applet|b(?:ase|gsound|link)|embed|frame(?:set)?|i(?:frame|layer)|l(?:ayer|ink)|meta|object|s(?:cript|tyle)|title|xml)[^>]*+>#i', '', $data);
}
while ($old_data !== $data);

// we are done...
return $data;
}
