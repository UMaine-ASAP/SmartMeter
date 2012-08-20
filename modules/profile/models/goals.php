<?PHP

class GoalsModel 
{

	/**
	 *	Return all profile goals
	 *
	 * 	@param 		int			$profile_id 		ID of the profile the goals should be associated with
	 *
	 *
	 *	@return 	array|bool 						On success, array of goals found belonging to the profile, on 
	 *													no goals, null, false on failure.
	 */
	static function getProfileGoals($profile_id, $completed)
	{
		$data = array("profile_id" => $profile_id, "completed" => $completed);;
		$querystring = "SELECT a.*, b.*, c.name as category_name FROM GOALS_Instance a LEFT JOIN GOALS_Archetype b ON a.goal_archetype_id = b.archetype_id  LEFT JOIN GOALS_Category c ON b.category_id = c.category_id WHERE profile_id = :profile_id AND completed = :completed";
		$row = Database::query($querystring, $data);

		return $row['result'];
	}

	static function getInstanceProfile($instance_id)
	{
		$data = array("instance_id" => $instance_id);
		$querystring = "SELECT profile_id FROM GOALS_Instance WHERE instance_id = :instance_id";
		$row = Database::query($querystring, $data);

		return $row['result'][0]['profile_id'];
	}

	static function addGoalInstance($profile_id, $archetype_id, $start_date, $completion_date, $final_value)
	{
		$data = array("profile_id" => $profile_id, "archetype_id" => $archetype_id, "start_date" => $start_date, "completion_date" => $completion_date, "final_value" => $final_value)
		$querystring = "INSERT INTO GOALS_Instance (profile_id, archetype_id, start_date, completion_date, final_value) VALUES (:profile_id, :archetype_id, :start_date, :completion_date, :final_value)";
		$row = Database::query($querystring, $data);

		return $row['lastInsertId'];
	}

	static function completeInstance($instance_id)
	{
		$data = array("instance_id" => $instance_id);
		$querystring = "UPDATE GOALS_Instance SET completed = 1 WHERE instance_id = :instance_id";
		$row = Database::query($querystring, $data);

		return true;
	}

	static function getAllArchetypes($category_id)
	{
		if(isset($category_id))
		{
			$data = array("category_id" => $category_id)
			$querystring = "SELECT * FROM GOALS_Archetype WHERE category_id = :category_id";
			$row = Database::query($querystring, $data);

			return $row['result']
		}
		else
		{
			$data = "";
			$querystring = "SELECT * FROM GOALS_Archetype";
			$row = Database::query($querystring, $data);

			return $row['result'];
		}
	}
}

?>