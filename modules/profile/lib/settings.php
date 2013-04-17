<?PHP

$HOST = "kenai.asap.um.maine.edu";
$DATABASE = "smartmeter";

$USERNAME = "smartmeter";
$PASSWORD = "firetruck";

$web_root = "/smartmeter/modules/profile";
$session_timeout = 3600;

ORM::configure('mysql:host=kenai.asap.um.maine.edu;dbname=smartmeter');
ORM::configure('username', 'smartmeter');
ORM::configure('password', 'firetruck');
ORM::configure('id_column_overrides', array(
	'PROFILE_Lights_instance' => 'lights_instance_id'

	));
?>