<?php
include_once "./src/funcs.inc.php";
include_once "./Services/Twilio.php";
include_once "./vars.inc.php";

$client = new Services_Twilio($twilioApi['accountSid'], $twilioApi['authToken']);
$conn = dbConnect();

$sql = 'SELECT `id`, `phone`, `message`, `email`, `emailSubject` FROM `notifications` LIMIT 1000';
$completed = array();

$results = $conn->query($sql);


foreach ($results as $notification) {
	if ($notification['phone'] != '') {
		try {
			$client->account->sms_messages->create($twilioApi['number'], $notification['phone'], $notification['message']);
		} catch (Services_Twilio_RestException $e) {
			echo $e->getMessage();
		}
	} elseif ($notification['email'] != '')
		mail($notification['email'], $notification['emailSubject'], $emailTemplate['pre'].$notification['message'].$emailTemplate['post']);
	$completed[] = $notification['id'];
}

$statement = $conn->prepare('INSERT INTO `sent` (`id`, `phone`, `message`, `email`, `emailSubject`) VALUES (SELECT `id`, `phone`, `message`, `email`, `emailSubject` FROM `notifications` WHERE `id` IN ('.implode(',', $completed).'))');
$statement->execute();
$statement = $conn->prepare('DELETE FROM `notifications` WHERE `id` IN ('.implode(',', $completed).')');
$statement->execute();
?>