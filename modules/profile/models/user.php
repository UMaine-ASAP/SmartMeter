<?PHP

require_once('lib/settings.php');
require_once('controllers/db.php');

class UserModel
{
	static function getUserDetails($id)
	{
		$data = array("user_id" => $id);
		$statement = "SELECT first, last, email, username FROM AUTH_Users where user_id = :user_id";

		$row = Database::query($statement, $data);
		
		if(isset($row['result'][0]))
			return $row['result'][0];
		else
			return false;

	}
}