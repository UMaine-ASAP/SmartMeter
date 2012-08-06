<?PHP
require_once('lib/settings.php');
require_once('controllers/profile.2.php');
require_once('controllers/authentication.php');
require_once('models/profile.php');
require_once('maps/device.php');
require_once('models/device.php');
require_once('controllers/db.php');

//$return = ProfileController::getAllUserProfiles(1);

//echo ProfileController::addProfileHottub($return[0]['profile_id'], "5", "2010-08-23", "2010-08-25");

//$return = ProfileController::getUserProfile("1");

//$return = DeviceMap::getDevices();
/*echo "<pre>";
print_r($return);
echo "</pre>";*/


/*$search_array = array("pool", "heating", "water");

$return = DeviceModel::getDevices($search_array, "2");

echo "<pre>";
print_r($return);
echo "</pre>";*/
/*echo "<pre>";
print_r(ProfileController::getProfileHottubs($return[0]['profile_id']));
echo "</pre>";*/

$subQuery = "SHOW TABLES";
$devices = array();

try
{
	$dbh = DBController::getConnection();
	$statement = $dbh->prepare($subQuery);
	$statement->execute();

	$row = $statement->fetchAll(PDO::FETCH_ASSOC);
	foreach($row as $value)
	{
		$table = explode("_", $value['Tables_in_smartmeter']);
		if($table[0] == "PROFILE")
		{
			if(isset($table[2]))
			{
				$devices[strtolower($table[2])] = array(
					"hasParent" => $table[1],
					$table[2] => $table[2],
					);
			}
			else
			{
				$devices[strtolower($table[1])] = $table[1];
			}
		}
	}

}
catch(PDOException $ex)
{
	error_log($ex);
	$dbh = null;
	return false;
}
$dbh = null;

echo "<pre>";
print_r($devices);
?>