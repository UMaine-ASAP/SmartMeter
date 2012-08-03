<?PHP

require_once('lib/settings.php');

class ProfileModel
{
	/**
	 *	Create a new User Profile
	 *
	 *	@param 	int 	$user_id	ID of the user the profile will be tied to.
	 *	@param 	string 	$name 		Name of the profile as it appears to the user.
	 *
	 *
	 *	@return int 				The ID of the new home profile on success, false otherwise.
	 */

	static function createProfile($user_id, $name)
	{
		if(is_null($user_id) || is_null($name))
		{
			return false;
		}

		$data = array("user_id" => $user_id, "name" => $name);

		try
		{
			$dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname='. $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
			$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$statement = $dbh->prepare("INSERT INTO PROFILE (owner_id, name) VALUES (:user_id, :name)");
			$statement->execute($data);

			return $dbh->lastInsertId();
		}
		catch(PDOException $ex)
		{
			error_log($ex);
			$dbh = null;
			return false;
		}
		$dbh = null;
	}
}

?>