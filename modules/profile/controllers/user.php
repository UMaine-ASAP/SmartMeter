<?PHP

require_once('lib/settings.php');
require_once('authentication.php');

require_once('models/user.php');

class UserController 
{
	static function getCurrentUserDetails()
	{
		$user_id = AuthenticationController::getCurrentUserId();
		if($user_id)
		{
			return UserModel::getUserDetails($user_id);
		}
		else
			return false;
	}
}