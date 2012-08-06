<?PHP

class DeviceMap
{
	private static $devices = array(

		"pool" => "Pool",
		"hottub" => "Hottub",
		"heating" => array(
			"hasParent" => "Home",
			"heating" => "heating",
			),
		"water" => array(
			"hasParent" => "Home",
			"water" => "water",
			),
		"lights" => array(
			"hasParent" => "Home",
			"lights" => "lights",
			),
		"cooling" => array(
			"hasParent" => "Home",
			"water" => "cooling",
			),
		);

	public static function getDevices() {
		return self::$devices;
	}
}


?>