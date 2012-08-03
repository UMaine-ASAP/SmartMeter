<?PHP
require_once('lib/settings.php');
require_once('authentication.php');
require_once('models/profile.php');



/**
 *	Profile Controller
 *
 *	The profile controller is responsible for all user interactions with the Home Profile System.
 *	This includes the creation, retreival, and deletion of profiles, a profiles interaction with devices,
 *	
 *
 *	@return int 				The ID of the new home profile on success, false otherwise.
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
	 *	Creates a new Home Profile belonging to the user currently logged in.
	 *
	 *	@param 	string 	$name 		Name of the profile as it appears to the user.
	 *
	 *
	 *	@return bool 				True on successful creating, false on fail.
	 */
	static function getUserProfile($owner_id)
	{
		$user_id = AuthenticationController::getCurrentUserID();

		if(!$user_id || $user_id != $owner_id)
		{
			return false;
		}
		else
		{
			$return = ProfileModel::getUserProfile($owner_id);
			return $return['name'];
		}

		return false;
	}

	static function getProfileDevice()
	{

	}
}

?>