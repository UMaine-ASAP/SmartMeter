<?php
// The SMNotifier API
class SMNotifier {
	private $_conn; //  This will be the database connection for queries as of...

	public function __construct() {
		$this->_conn = dbConnect(); // ...now.
	}

	// Call this function!  This is how you send the message!  Make sure $id is a user id!
	public function notify($id, $message, $emailSubject = null) {
		// If the id is returned from a previous query as a string, we want to make it an int so it plays nice with PDO
		if (preg_match('/^\d$/', $id)) {
			$id = (int)$id;
		}
		if (is_int($id)) { // Id must be an int
			$statement = $this->_conn->prepare('SELECT `phone`, `email`, `preferedContact` FROM `users` WHERE `id` = :id');
			$statement->execute(array('id'=>$id));
			$row = $statement->fetch(PDO::FETCH_ASSOC);
			$this->execute($row, $message, $emailSubject); // Pass this off to our logic function
		} else {
			if (is_array($id)) { // Try to provide some helpful hints for multiple user calls
				throw new SMNDeliveryError('Please enter a valid database user row id.  If you meant to notify multiple users, please use the SMNotifier.notifyMultiple() instead.', 11);
			} else {
				throw new SMNDeliveryError('Please enter a valid database user row id.', 11);
			}
		}
	}

	// Identical to notify(), but takes an array of ids instead of one id
	public function notifyMultiple($ids, $message, $emailSubject = null) {
		if (is_array($ids)) {
			// Select all the users
			$statement = $this->_conn->query('SELECT `phone`, `email`, `preferedContact` FROM `users` WHERE `id` IN ('.$this->_conn->quote(implode(',',$ids)).')');
			$results = $statement->fetchAll();
			foreach ($results as $row) {
				$this->execute($row, $message, $emailSubject); // For each, pass on to the logic function
			}
		} else {
			if (is_int($ids)) { // Provide som helpful hints if it looks like they want the other notification function
				throw new SMNDeliveryError('Please use and array of database user row ids.  If you want to notify one user, please user SMNotifier.notify() instead.', 11);
			} else { // Otherwise just throw an excpetion
				throw new SMNDeliveryError('Please use an array of database user row ids.', 11);
			}
		}
	}

	// Check how the user wants to be notified and select that function
	private function execute($row, $message, $emailSubject = null) {
		if ($row['preferedContact'] == 'phone' || $row['preferedContact'] == 'both') {
			$this->notifyPhone($row['phone'], $message);
		}
		if ($row['preferedContact'] == 'email' || $row['preferedContact'] == 'both') {
			$this->notifyEmail($row['email'], $message, $emailSubject);
		}
	}

	// Insert a notification for emails
	private function notifyEmail($email, $message, $subject = null) {
		$statement = $this->_conn->prepare('INSERT INTO `notifications`
		                                   (`email`,`emailSubject`,`message`)
		                                   VALUES
		                                   (:email,:emailSubject,:message)');
		$statment->execute(array(
		                   'email'=>$email,
		                   'emailSubject'=>$emailSubject,
		                   'message'=>$message
		                   ));
	}

	// Insert a notification for phones
	private function notifyPhone($phone, $message) {
		$statement = $this->_conn->prepare('INSERT INTO `notifications`
		                                   (`phone`,`message`)
		                                   VALUES
		                                   (:phone,:message)');
		$statement->execute(array(
		                    'phone'=>$phone,
		                    'message'=>$message
		                   ));
	}
}