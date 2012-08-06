<?PHP

require_once('maps/device.php');

class DeviceModel
{
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

	static function getDevices($device_types, $profile_id)
	{
		$queryArray = self::getDevicesQuery($device_types, $profile_id);
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