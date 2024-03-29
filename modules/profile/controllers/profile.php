<?PHP
require_once('lib/settings.php');
require_once('authentication.php');
require_once('models/profile.php');
require_once('models/device.php');



/**
 *	Profile Controller
 *
 *	The profile controller is responsible for all user interactions with the Home Profile System.
 *	This includes the creation, retreival, and deletion of profiles, a profiles interaction with devices,
 *	
 */
class ProfileController
{

	/**
	 *	Create a new User Profile
	 *
	 *	Creates a new Home Profile belonging to the user currently logged in.
	 *  If the user already has a profile or is not logged in, a new profile will not be created.
	 *
	 *	@param 	string 	$name 		Name of the profile as it appears to the user.
	 *
	 *
	 *	@return bool 				True on successful creating, false on fail.
	 */
	static function startNewProfile($name)
	{
		$user_id = AuthenticationController::getCurrentUserID();

		if(!$user_id || ProfileModel::getUserProfile($user_id))
		{
			return false;
		}

		if(!ProfileModel::createProfile($user_id, $name))
		{
			return false;
		}

		return true;
	}

	/**
	 *	Get a User's Profile
	 *
	 *	Gets the Home Profile belonging to a specified user.  Will return false if
	 *	if the user is not logged in/doesn't own the profile.  Will return null if
	 *	no profile belongs to that user.
	 *
	 *	@param 	int 		$owner_id 		Owner ID of the profile we are looking for
	 *
	 *
	 *	@return array|bool  				Returns an array of the profile if found, false otherwise.
	 */

	static function getCurrentUserProfile()
	{

		if($return = ProfileModel::getProfile(self::getCurrentUserProfileID()))
		{
			return $return[0];
		}
		else
		{
			return false;
		}
	}


	/**
	 *	Get current user's profile id
	 *
	 *
	 *	@param 	int 		$owner_id 		Owner ID of the profile we are looking for
	 *
	 *
	 *	@return int  						Returns id of the profile belinging to the currently logged in user
	 */


	static function getCurrentUserProfileID()
	{

		if($return = ProfileModel::getProfileID(AuthenticationController::getCurrentUserID()))
		{
			return $return->profile_id;;
		}
		else
		{
			return false;
		}
	}

	static function getCurrentUserDevices()
	{
		if($return = DeviceModel::getAllDevices(self::getCurrentUserProfileID()))
		{
			return $return;
		}
		else
		{
			return false;
		}
	}

	static function getLightData()
	{
		if(is_array($return = DeviceModel::getLightData(self::getCurrentUserProfileID())))
		{
			return $return;
		}
		else
		{
			return false;
		}
	}

	static function getLightStats()
	{
		if(is_array($result = DeviceModel::getLightStats(self::getCurrentUserProfileID())))
		{
			$return = array();
            $return['bulbs'] = 0;
            $return['wattage'] = 0;

			for($i=0; $i<3; $i++)
			{
				$return[$i] = array();
				$return[$i]['wattage'] = 0;

				foreach($result as $light)
				{
					if($light['type'] == $i)
					{
						$return[$i]['wattage'] += $light['consumption']*$light['count'];
                        $return['bulbs'] += $light['count'];
                        $return['wattage'] += $light['consumption']*$light['count'];

					}
				}
			}
			return $return;
		}

		else
		{
			return false;
		}
	}

	static function editLightData($instance_id, $value)
	{
		if(self::getCurrentUserProfileID() == DeviceModel::getLightInstanceProfile($instance_id))
			return DeviceModel::editLightData($instance_id, $value);

		return false;
	}

	static function addLightData($archetype_id, $value)
	{
		if($profile_id = self::getCurrentUserProfileID())
			return DeviceModel::addLightData($profile_id, $archetype_id, $value);

		return false;
	}

	/**
	 *	Remove a User's Profile
	 *
	 *	Delete an entire user's home profile from the database.  Also will loop though,
	 * 	remove any custom devices and all other
	 *
	 *	@param 	string 		$profile_id 	Profile ID to delete.
	 *
	 *
	 *	@return bool  						Returns true on success, false otherwise.
	 */

	static function removeProfile($profile_id)
	{

		if(!$profile_id || $profile_id != ProfileModel::getUserProfileID(AuthenticationController::getCurrentUserID()))
		{
			return false;
		}
		else
		{
			$return = ProfileModel::removeProfile($profile_id);
			return $return;
		}

		return false;
	}



	/**
	 *	Get devices belonging to a user's profile.
	 *
	 *	Data returned as a multidimensional array in the format below.
     *
     *		[x][][]			device_type			the type of device returned (eg. pool)
     *		[][x][]			device_list			array of all devices associated with the profile
     *		[][][x]			device_data			key => value array for all data in the database
	 *
	 *
	 *	@param 	array 		$device_types 		Array of device names we are searching for.
	 * 	@param 	int 		$profile_id 		ID of the profile the device should belong to.
	 *
	 *
	 *	@return array|bool  					Returns an array of the devices if found, all of which will 
	 *												be null if there is no data associated, false otherwise.
	 */


	static function getProfileDevices($owner_id, $device_types)
	{
		$user_id = AuthenticationController::getCurrentUserID();

		if(!$user_id || $user_id != $owner_id || is_array($device_types))
		{
			return false;
		}
		else
		{
			$return = DeviceModel::getDevices($devices, ProfileModel::getUserProfileID($owner_id));
			return $return;
		}

	}
}

?>