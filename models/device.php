<?PHP

require_once('maps/device.php');
require_once('controllers/db.php');

class DeviceModel
{

	/**
     * 	Function to build a query to find all specified devices belonging to a home profile. Will
     * 	determine if devices belongs to a root category or sub category and will return the appropriate
     * 	ID to query with.
     *
     * 	@param 	array 		$device_types 	Names of devices you would like to retrieve data on
     *	@param 	int 		$profile_id		ID of the profile those devices should be tied to.
     *
     *
     * 	@return array|bool 					Array of data to build a query with, false otherwise.
     */

	static function getDevicesQuery($device_types, $profile_id)
	{

		$DeviceMap = DeviceMap::getDevices();
		$queryArray = array();
		$extraIDs = array();


		if(!isset($device_types) || !isset($profile_id) || !is_array($device_types))
		{
			return false;
		}


		foreach ($device_types as $value)
		{
			$search = $DeviceMap[$value];
			if(is_array($search)){
				
				if(!array_key_exists(strtolower($search['hasParent']), $extraIDs))
				{
					$data = array("profile_id" => $profile_id);
					$searchID = strtolower($search['hasParent']) . "_id";
					$subQuery = "SELECT " . $searchID . " FROM PROFILE_" . $search['hasParent'] . " WHERE profile_id = :profile_id";

					try
					{
						$dbh = DBController::getConnection();
						$statement = $dbh->prepare($subQuery);
						$statement->execute($data);

						$row = $statement->fetch(PDO::FETCH_ASSOC);

						$extraIDs[$search['hasParent']] = $row[$searchID];

					}
					catch(PDOException $ex)
					{
						error_log($ex);
						$dbh = null;
						return false;
					}
					$dbh = null;
				}				
				$queryArray[$value] = array("PROFILE_". $search['hasParent'] . "_" . $search[$value], $extraIDs[$search['hasParent']], $searchID);
			}
			else
			{
				$queryArray[$value] = array("PROFILE_" . $search, $profile_id);
			}
		}
		return $queryArray;

	}


	/**
     * 	Function that will return all data pertaining to the devices specified in the device_types array
     * 	associated with the specified profile id.  Data returned as a multidimensional array in the format below.
     *
     *		[x][][]			device_type		the type of device returned (eg. pool)
     *		[][x][]			device_list		array of all devices associated with the profile
     *		[][][x]			device_data		key => value array for all data in the database
     *
     *
     * 	@param 	array 		$device_types 	Names of devices you would like to retrieve data on
     *	@param 	int 		$profile_id		ID of the profile those devices should be tied to.
     *
     *
     * 	@return array|bool 					Array of data to build a query with, false otherwise.
     */

	static function getDevices($device_types, $profile_id)
	{

		$queryArray = self::getDevicesQuery($device_types, $profile_id);

		if(!is_array($device_types) || !is_array($queryArray))
		{
			return false;
		}

		$result = array();

		foreach($queryArray as $key => $value)
		{
			if(isset($value[2]))
			{
				$searchID = $value[2];
			}
			else {
				$searchID = "profile_id";
			}

			$data = array($searchID => $value[1]);

			$subQuery = "SELECT * FROM ". $value[0] . " WHERE ". $searchID ." = :" . $searchID . "";

			try
			{

				$dbh = DBController::getConnection();
				$statement = $dbh->prepare($subQuery);
				$statement->execute($data);

				$row = $statement->fetchAll(PDO::FETCH_ASSOC);

				$result[$key] = $row;

			}
			catch(PDOException $ex)
			{
				error_log($ex);
				$dbh = null;
				return false;
			}
		$dbh = null;
		}
		return $result;
	}
}

?>