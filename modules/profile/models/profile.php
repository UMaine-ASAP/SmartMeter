<?PHP

require_once('lib/settings.php');
require_once('controllers/db.php');

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
			$dbh = DBController::getConnection();
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

	/**
	 *	Find all home profiles associated with a user account
	 *
	 *	@param 	string 		$user_id 	Id of the user whos profiles we are searching for
	 *
	 *
	 *	@return array|bool 				Array of profile id and name belonging to the user on succes, false otherwise
	 */

	static function getUserProfile($owner_id)
	{
		$data = array("owner_id" => $owner_id);
		try
		{
			$dbh = DBController::getConnection();
			$statement = $dbh->prepare("SELECT profile_id, name FROM PROFILE WHERE owner_id = :owner_id");
			$statement->execute($data);

			$row = $statement->fetch(PDO::FETCH_ASSOC);

			if(count($row) == 0)
			{
				return null;
			}

			return $row;
		}
		catch(PDOException $ex)
			{
				error_log($ex);
				$dbh = null;
				return false;
			}

		$dbh = null;

	}

	/**
	 *	Find all home profiles associated with a user account
	 *
	 *	@param 	string 		$user_id 	Id of the user whos profiles we are searching for
	 *
	 *
	 *	@return int 					profile id  on success, false otherwise
	 */

	static function getUserProfileID($owner_id)
	{
		$data = array("owner_id" => $owner_id);
		try
		{
			$dbh = DBController::getConnection();
			$statement = $dbh->prepare("SELECT profile_id FROM PROFILE WHERE owner_id = :owner_id");
			$statement->execute($data);

			$row = $statement->fetch(PDO::FETCH_ASSOC);

			if(count($row) == 0)
			{
				return null;
			}

			return $row['profile_id'];
		}
		catch(PDOException $ex)
			{
				error_log($ex);
				$dbh = null;
				return false;
			}

		$dbh = null;

	}

	/**
	 *	Remove the home profile belonging to the user specified
	 *
	 *  	TODO: Ensure all keys are setup in the database to support this.
	 *
	 *	@param 	string 		$profile_id 	Profile id to be deleted
	 *	
	 *
	 *	@return int 	 					true on success, false otherwise
	 */

	static function removeProfile($profile_id)
	{
		$data = array("profile" => $profile_id);
		try
		{
			$dbh = DBController::getConnection();
			$statement = $dbh->prepare("DELETE FROM PROFILE WHERE profile_id = :profile_id");
			$statement->execute($data);


			return true;
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