<?PHP

class DeviceMap
{
	private static $devices = array(

		"pool" => "Pool",
		"hottub" => "Hottub",
		"laundry" => "Laundry",
		"bathroom" => "Bathroom",
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
		"home_basic" => array(
			"hasParent" => "Home",
			"home_basic" => "basic",
			),
		"dishwasher" => array(
			"hasParent" => "Kitchen",
			"dishwasher" => "dishwasher",
			),
		"freezer" => array(
			"hasParent" => "Kitchen",
			"freezer" => "freezer",
			),
		"fridge" => array(
			"hasParent" => "Kitchen",
			"fridge" => "fridge",
			),
		"microwave" => array(
			"hasParent" => "Kitchen",
			"microwave" => "microwave",
			),
		"stove" => array(
			"hasParent" => "Kitchen",
			"stove" => "stove",
			),
		"toaster" => array(
			"hasParent" => "Kitchen",
			"toaster" => "toaster",
			),
		);

	public static function getDevices() {
		return self::$devices;
	}
}


?>