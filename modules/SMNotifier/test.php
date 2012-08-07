<?php
/**
 * Simple testing file to ensure Twilio functionality. 
 */
require_once "Services/Twilio.php";

$accountSID = 'ACb2437c9f7866e0ee48afe5f56cff1c2a';
$authToken = 'd16fd99172b2244b3e13be7444430ace';
$sendingNumber = '+18482072331';

$client = new Services_Twilio($accountSID, $authToken);

$people = array(
  "+12075985408" => "Ross Trundy",
  "+16037232939" => "Benjamin Carlson"
);

foreach ($people as $number => $name)
{
    $sms = $client->account->sms_messages->create(
            $sendingNumber, //this is the from number
            $number,        //to number
            "Sample notification for $name"
            );
}

?>
