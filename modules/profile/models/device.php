<?PHP

require_once('maps/device.php');
require_once('controllers/db.php');
require_once('lib/constants.php');

class DeviceModel
{


	static function getAllDevices($profile_id)
	{

		$devices = ORM::for_table('PROFILE_Device_instance')
			->join('PROFILE_Device_archetype', array('PROFILE_Device_instance.archetype_id', '=', 'PROFILE_Device_archetype.archetype_id'))
			->join('PROFILE_Device_types', array('PROFILE_Device_archetype.device_type', '=', 'PROFILE_Device_types.type_id'))
			->find_array();

		return $devices;

	}


	/**
	 * Get information about lights in a users profile
	 * @param  int $profile_id ID of profile we are getting lights for
	 * @return array
	 */
	static function getLightData($profile_id)
	{

		$lights = ORM::for_table('PROFILE_Lights_archetype')
			->select('PROFILE_Lights_instance.count')
			->select('PROFILE_Lights_instance.lights_instance_id', 'id')
			->select('PROFILE_Lights_archetype.type')
			->select('PROFILE_Lights_archetype.lights_archetype_id', 'archetype_id')
			->select('PROFILE_Lights_archetype.consumption')
			->select('PROFILE_Light_equivalence_map.equivalent_power')
			->left_outer_join('PROFILE_Lights_instance', array('PROFILE_Lights_instance.lights_archetype_id', '=', 'PROFILE_Lights_archetype.lights_archetype_id'))
			->join('PROFILE_Light_equivalence_map', array('PROFILE_Lights_instance.lights_archetype_id', '=', 'PROFILE_Light_equivalence_map.archetype_id'))
			->where('PROFILE_Lights_instance.profile_id', $profile_id)
			->find_array();

		if(!empty($lights))
			return $lights;
		return false;
	}

	static function getLightStats($profile_id)
	{
		$stats = ORM::for_table('PROFILE_Lights_instance')
			->select('PROFILE_Lights_instance.count')
			->select('PROFILE_Lights_archetype.type')
			->select('PROFILE_Lights_archetype.consumption')
			->join('PROFILE_Lights_archetype', array('PROFILE_Lights_instance.lights_archetype_id', '=', 'PROFILE_Lights_archetype.lights_archetype_id'))
			->where('PROFILE_Lights_instance.profile_id', $profile_id)
			->where_not_null('PROFILE_Lights_instance.count')
			->where_not_equal('PROFILE_Lights_instance.count', 0)
			->find_array();

		return $stats;
	}

	static function editLightData($instance_id, $value)
	{
		$instance = ORM::for_table('PROFILE_Lights_instance')->where('lights_instance_id', $instance_id)->find_one();
		$instance->count = $value;
		$instance->save();

		return $instance->is_dirty('count');
	}

	static function addLightData($profile_id, $archetype_id, $value)
	{
		$instance = ORM::for_table('PROFILE_Lights_instance')->create();
		$instance->lights_archetype_id = $archetype_id;
		$instance->count = $value;
		$instance->profile_id = $profile_id;
		$instance->save();

		return $instance->id();
	}

	static function getLightInstanceProfile($instance_id)
	{
		$profile = ORM::for_table('PROFILE_Lights_instance')
			->select('profile_id')
			->where('lights_instance_id', $instance_id)
			->find_one();

		return $profile->profile_id;
	}

	/**
     * 	Return all device archetypes that a user has access to.  These provide a starting point
     *	allowing a user to create a device instance.
     *
     *
     * 	@param 	int 		$user_id	 	ID of the user looking for archetypes
     *	@param 	int 		$type_id		(Option) ID of the archetype "type" (ex Washer, Dryer, etc)
     *
     *
     * 	@return array|bool 					Array of all available archetypes, false otherwise.
     */

	static function getAllArchetypes($user_id, $type_id)
	{
		if(!isset($user_id))
		{
			return false;
		}

		if(isset($type_id))
		{
			$data = array("user_id" => $user_id, "type_id" => $type_id);
			$querystring = "SELECT * FROM PROFILE_Device_archetype WHERE type_id = :type_id AND (creator_id = -1 OR creator_id = :user_id)";
		}
		else 
		{
			$data = array("user_id" => $user_id);
			$querystring = "SELECT * FROM PROFILE_Device_archetype WHERE creator_id = -1 OR creator_id = :user_id";
		}
		$row = Database::query($querystring, $data);

		if(isset($row['result']))
		{
			return $row['result'];
		}

		return false;
		
	}

	/**
     * 	Return all data belonging to a specific archetype.
     *
     *
     *	@param 	int 		$archetype_id		ID of the archetype
     *
     *
     * 	@return array|bool 						Array of all available archetypes, false otherwise.
     */

	static function getArchetypeDetails($archetype_id)
	{
		if(!isset($archetype_id))
		{	
			return false;
		}

		$data = array("archetype_id" => $archetype_id);
		$querystring = "SELECT * FROM PROFILE_Device_archetype a LEFT JOIN PROFILE_Device_types b ON a.type_id = b.type_id WHERE archetype_id = :archetype_id";

		$row = Database::query($querystring, $data);

		if(isset($row['result'][0]))
		{
			return $row['result'][0];
		}

		return false;

	}


	/**
     * 	Add new archetype
     *
     *
     * 	@param 	int 		$user_id		 	ID of the user adding the archetype
     *	@param 	int 		$type 				Archetype "type" (see PROFILE_Device_types)	
     *	@param 	int 		$build_year 		Year the device was built
     *	@param 	string 		$brand 				Brand of the device
     *	@param 	string 		$model 				(Optional) Device Model Number
     *	@param 	float 		$consumption		(Optional) Consumption in KW/hrs of the device
     *	@param 	int 		$device_type		Device level type (TODO Expand)
     *	@param 	int 		$capacity			(Optional) Capacity of Device
     *
     *
     *
     * 	@return int|bool 						ID of the new archetype on success, false otherwise.
     */

	static function addArchetype($user_id, $type, $build_year, $brand, $model, $consumption, $device_type, $capacity)
	{
		if(!isset($user_id) || !isset($type) || !isset($build_year) || !isset($brand) || !isset($device_type))
		{
			return false;
		}

		$data = array("user_id" => $user_id, "type" => $type, "build_year" => $build_year, "brand" => $brand, "model" => $model, "consumption" => $consumption, "device_type" => $device_type, "capacity" => $capacity);
		$querystring = "INSERT INTO PROFILE_Device_archetype (creator_id, type, build_year, brand, model, consumption, device_type, capacity) VALUES (:user_id, :type:, :build_year, :brand, :model, :consumption, :device_type, :capacity)";

		$row = Database::query($querystring, $data);

		if(isset($row['lastInsertId']))
		{				
			return $row['lastInsertId'];
		}

		return false;
	}



	static function addInstance($archetype_id, $profile_id, $name, $age, $instance_extra)
	{
		if(!isset($archetype_id) || !isset($profile_id) || !isset($name) || !isset($age))
		{
			return false;
		}

		//Checking to see if there is a sub_instance table.
		$archetype = self::getArchetypeDetails($archetype_id);
		$querystring = "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'smartmeter' AND table_name = 'PROFILE_" . $archetype['type'] . "_instance'";
		$row = Database::query($querystring, null);
		if($row['result']['COUNT(*)'] == 0)
		{
			$data = array("archetype_id" => $archetype_id, "profile_id" => $profile_id, "name" => $name, "age" => $age);
			$querystring = "INSERT INTO PROFILE_Device_instance (archetype_id, profile_id, name, age) VALUES (:archetype_id, :profile_id, :name, :age)";

			$row = Database::query($querystring, $data);

			if(isset($row['lastInsertId']))
			{
				return $row['lastInsertId'];
			}
			return false;
		}
		else
		{
			$data = array("archetype_id" => $archetype_id, "profile_id" => $profile_id, "name" => $name, "age" => $age);
			$querystring = "INSERT INTO PROFILE_Device_instance (archetype_id, profile_id, name, age) VALUES (:archetype_id, :profile_id, :name, :age)";

			$row = Database::query($querystring, $data);

			if(isset($row['lastInsertId']))
			{
				$instance_extra['instance_id'] = $row['lastInsertId'];
				$query_pieces = implode(', ', $instance_extra);
				$query_values = implode(', :', $instance_extra);
				$querystring = "INSERT INTO PROFILE_" . $archetype['type'] . "_instance (" . $query_pieces . ") VALUES (" . $query_values . ");";

				$row = Database::query($querystring, $instance_extra);
				if(isset($row['lastInsertId']))
				{
					return $row['lastInsertId'];
				}
				return false;
			}
			return false;
		}
	}



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
     *	Uses getDevicesQuery to build a database query array that is used for the function.
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