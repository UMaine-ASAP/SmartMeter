<?php
class SMNotifier {
	private $_conn;

	public function __construct() {
		$this->_conn = dbConnect();
	}

	public function notify($id, $message, $emailSubject = null) {
		if (is_int($id)) {
			$statement = $this->_conn->prepare('SELECT `phone`, `email`, `prefferedContact` FROM `users` WHERE `id` = :id');
			$statement->execute(array('id'=>$id));
			$row = $statement->fetch(PDO::FETCH_ASSOC);
			$this->execute($row, $message, $emailSubject);
		} else {
			throw new SMNDeliveryError('Please enter a valid database user row id.', 11);
		}
	}

	public function notifyMultiple($ids, $message, $emailSubject = null) {
		if (is_array($ids)) {
			$statement = $this->_conn->query('SELECT `phone`, `email`, `prefferedContact` FROM `users` WHERE `id` IN ('.$this->_conn->quote(implode(',',$ids)).')');
			$results = $statement->fetchAll();
			foreach ($results as $row) {
				$this->execute($row, $message, $emailSubject);
			}
		} else {
			if (is_int($ids)) {
				throw new SMNDeliveryError('Please use and array of database user row ids.  If you want to notify one user, please user SMNotifier.notify() instead.', 11);
			} else {
				throw new SMNDeliveryError('Please use an array of database user row ids.', 11);
			}
		}
	}

	private function execute($row, $message, $emailSubject = null) {
		if ($row['prefferedContact'] == 'phone' || $row['prefferedContact'] == 'both') {
			$this->notifyPhone($row['phone'], $message);
		}
		if ($row['prefferedContact'] == 'email' || $row['prefferedContact'] == 'both') {
			$this->notifyEmail($row['email'], $message, $emailSubject);
		}
	}

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
?>