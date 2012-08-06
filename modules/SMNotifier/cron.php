`<?php
/**
 * SMNotifier crontab to send notifications.
 *
 * This background script selects unsent notifications in the database and sends them.
 *
 * @author Harry Grillo <harry@redbassett.com>
 * @package SMNotifier
 */
include_once "src/funcs.inc.php";
include_once "Services/Twilio.php";
include_once "vars.inc.php";

$client = new Services_Twilio($twilioApi['accountSid'], $twilioApi['authToken']); // Initiate new Twilio API object
$conn = dbConnect();

$sql = 'SELECT `id`, `phone`, `message`, `email`, `emailSubject` FROM `NOTIFICATION_Pending` LIMIT 1000';
$completed = array();

$results = $conn->query($sql); // Select first 1000 unsent notifications


foreach ($results as $notification) {
	if ($notification['phone'] != '') { // If phone is set, this is a text message
		try { // Attempt to send the message to twilio
			$client->account->sms_messages->create($twilioApi['number'], $notification['phone'], $notification['message']);
		} catch (Services_Twilio_RestException $e) { // And get the API error message if it fails
			echo $e->getMessage();
		}
	} elseif ($notification['email'] != '') { // If email is set, this is an email
		mail($notification['email'], $notification['emailSubject'], $emailTemplate['pre'].$notification['message'].$emailTemplate['post']);
	}
	$completed[] = $notification['id']; // Add this to the list of completed notifications
}

// And then move the row to the `sent` table
$statement = $conn->prepare('INSERT INTO `NOTIFICATION_Archive` (`id`, `phone`, `message`, `email`, `emailSubject`) (SELECT `id`, `phone`, `message`, `email`, `emailSubject` FROM `NOTIFICATION_Pending` WHERE `id` IN ('.implode(',', $completed).'))');
$statement->execute();
$statement = $conn->prepare('DELETE FROM `NOTIFICATION_Pending` WHERE `id` IN ('.implode(',', $completed).')');
$statement->execute();