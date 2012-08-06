<?PHP

require_once('models/device.php');

class DeviceController
{

	/**
	 *	Get devices belonging to a profile.
	 *
	 *
	 *	@param 	array 		$device_types 		Array of device names we are searching for.
	 * 	@param 	int 		$profile_id 		ID of the profile the device should belong to.
	 *
	 *
	 *	@return array|bool  					Returns an array of the devices, false otherwise.
	 */

	static function getProfileDevices($device_types, $profile_id)
	{
			return DeviceModel::getDevices($device_types, $profile_id);
	}
}

?>