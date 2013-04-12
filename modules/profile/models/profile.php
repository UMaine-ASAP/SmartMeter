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
		$statement = "INSERT INTO PROFILE (owner_id, name) VALUES (:user_id, :name)";

		$row = Database::query($statement, $data);

		if($row != '')
			return $row['lastInsertId'];
		else
			return false;
	}

	/**
	 *	Find all home profiles associated with a user account
	 *
	 *	@param 	int 		$user_id 	Id of the user whos profiles we are searching for
	 *
	 *
	 *	@return int 					ID of profile matchings users id
	 *
	 * 	TODO: Make this not an ORM object...why did I do that?
	 */

	static function getProfileID($user_id)
	{

		$profile = ORM::for_table('PROFILE')->select('profile_id')->where('owner_id', $user_id)->find_one();

		return $profile;
	}


	/**
	 *	Return profile details given a profile id
	 *
	 *	@param 	int 		$porifle_id	ID of the profile
	 *
	 *
	 *	@return array 					Returns array of profile_id, owner_id, and name
	 */

	static function getProfile($profile_id)
	{
		$profile = ORM::for_table('PROFILE')->where('profile_id', $profile_id)->find_array();

		return $profile;
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
		$statement = "DELETE FROM PROFILE WHERE profile_id = :profile";

		$row = Database::query($statement, $data);

		return true;
	}

}

?>