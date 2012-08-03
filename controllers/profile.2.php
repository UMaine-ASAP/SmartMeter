<?PHP
require_once('lib/settings.php');
require_once('authentication.php');
require_once('models/profile.php');

class ProfileController
{
	static function startNewProfile($name)
	{
		if(!$user_id = AuthenticationController::getCurrentUserID())
		{
			return false;
		}
		
		if(!ProfileModel::createProfile($user_id, $name))
		{
			return false;
		}

		return true;
	}
}

?>