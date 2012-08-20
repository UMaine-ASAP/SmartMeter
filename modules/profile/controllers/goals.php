<?PHP

require_once('authentication.php');
require_once('db.php');
require_once('profile.php');

require_once('models/goals.php');

class GoalsController
{

	/**
	 *	Return all goals belonging to the current user
	 *
	 *
	 *	@return 	array|bool 						On success, array of goals found belonging to the profile, on 
	 *													no goals, null, false on failure.
	 */

	static function getCurrentUserGoals()
	{
		$goals = GoalsModel::getProfileGoals(ProfileController::getCurrentUserProfileID(), 0);
		if($goals || is_null($goals))
		{
			return $goals;
		}
		else
		{
			return false;
		}
	}

	static function getCompletedCurrentUserGoals()
	{	
		$goals = GoalsModel::getProfileGoals(ProfileController::getCurrentUserProfileID(), 1);
		if($goals || is_null($goals))
		{
			return $goals;
		}
		else
		{
			return false;
		}
	}

	static function addGoalInstance($archetype_id, $start_date, $completion_date, $final_value)
	{
		if(AuthenticationController::getCurrentUserID())
		{
			if(GoalsModel::addGoalInstance(ProfileController::getCurrentUserProfileID(), $archetype_id, $start_date, $completion_date, $final_value))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			return false;
		}
	}

	static function completeInstance($instance_id)
	{
		if(GoalsModel::getInstanceProfile($instance_id) == ProfileController::getCurrentUserProfileID())
		{
			if(GoalsModel::completeInstance($instance_id))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			return false;
		}

	}

}

?>