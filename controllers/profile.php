<?PHP
/**
 * Controller handling all aspects of a Home Profile
 *
 *
 * @package Controllers
 */
class ProfileController
{
	/**
	 *	Create a new User Profile
	 *
	 *	@param 	string 	$name 	Name of the profile as it appears to the user.
	 *
	 *
	 *	@return int 			The ID of the new home profile on success, false otherwise.
	 */
	static function createProfile($name) 
	{
		//if(!$user_id = AuthenticationController::getCurrentUserID()){
		$user_id = 1;
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
		//}
	}

	/**
	 *	Find all home profiles associated with a user account
	 *
	 *	@param 	string 		$user_id 	Id of the user whos profiles we are searching for
	 *
	 *
	 *	@return array|bool 				Array of Arrays of profile ids/names belonging to the user on succes, false otherwise
	 */
	static function getAllUserProfiles($user_id)
	{
		$data = array("user_id" => $user_id);
		try
		{
			$dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname='. $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
    		$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$statement = $dbh->prepare("SELECT profile_id, name FROM PROFILE WHERE owner_id = :user_id");
			$statement->execute($data);

			$row = $statement->fetchAll(PDO::FETCH_ASSOC);

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
	 *	Function to remove a home profile and all data associated with it.
	 *
	 *	@param 	string 		$profile_id 	Id of the user whos profiles we are searching for
	 *
	 *
	 *	@return bool 						True on success, false otherwise
	 */
	/*static function deleteUserProfile($profile_id)
	{
		$data = array("profile_id" => $profile_id);
		try
		{
			$dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname='. $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
    		$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    		$statement = $dbh;
		}
	}
*/

	/**
	 *
	 *	Profile Components Section
	 *
	 *
	 */


	/**
	 *	Add a new Hot Tub to a profile
	 *
	 *	@param 	int 		$profile_id 	Id of the profile whos hot tubs we are searching for.
	 *	@param 	int 		$weekly_use 	Averge hours per week the Hot Tub is used.
	 *	@param 	string 		$start_date 	Start date of hot tub use period (format: YYYY-MM-DD).
	 *	@param 	string 		$end_date 		End date of hot tub use period (format: YYYY-MM-DD).
	 *
	 *	@return int|bool 					Return the id of the new hot tub on success, false otherwise.
	 */
	static function addProfileHottub($profile_id, $weekly_use, $start_date, $end_date)
	{
		$data = array("profile_id" => $profile_id, "weekly_use" => $weekly_use, "start_date" => $start_date, "end_date" => $end_date);
		try
		{
			$dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname='. $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
			$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$statement = $dbh->prepare("INSERT INTO PROFILE_Hottub (profile_id, weekly_use, start_time, end_time) VALUES (:profile_id, :weekly_use, :start_date, :end_date)");
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
	 *	Find all hottubs associated with a Home Profile
	 *
	 *	@param 	int 		$profile_id 	Id of the profile whos hot tubs we are searching for
	 *
	 *
	 *	@return array|bool 					Array of all the hot tubs associated with the profile on success, false if none or failure. 
	 */
	static function getProfileHottubs($profile_id)
	{
		$data = array("profile_id" => $profile_id);
		try
		{
			$dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname='. $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
    		$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$statement = $dbh->prepare("SELECT * FROM PROFILE_Hottub WHERE profile_id = :profile_id");
			$statement->execute($data);

			$row = $statement->fetchAll(PDO::FETCH_ASSOC);

			if(count($row) == 0){
				return false;
			}
			else {
				return $row;
			}
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
