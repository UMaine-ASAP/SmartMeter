<?php
/**
 * SMNotifier variables
 *
 * Variables used by various parts of the SMNotifier package.
 *
 * @author Harry Grillo <harry@redbassett.com>
 * @package SMNotifier
 */

// Enter a default email subject to be displayed when no email subject is specified.
$defaultEmailSubject = 'A default subject for emails if no subject is provided.';

// Enter your Twilio account SID and autherntication token below to send texts.
// HEY FELLOWS THIS IS ROSS'S TWILIO STUFF; DO NOT USE THIS IN PRODUCTION. THANKS! :*
$twilioApi['accountSid'] = 'ACb2437c9f7866e0ee48afe5f56cff1c2a';
$twilioApi['authToken'] = 'd16fd99172b2244b3e13be7444430ace';
// Enter you Twilio sending number.
$twilioApi['number'] = '+18482072331';

// Enter your database login information.
$dbVars['host'] = 'localhost'; // The IP or hostname of your database server.
$dbVars['database'] = 'smartmeter'; // The database in which the notifications will be stored.
$dbVars['user'] = 'smartmeter'; // The user to access the database with.
$dbVars['password'] = 'firetruck'; // The password for the above user.
$dbVars['port'] = ''; // The database server port to use (leave blank unless needed).
$dbVars['type'] = 'mysql'; // The type of database to connect to.

// Email Tempalte
$emailTemplate['pre'] = <<<EndOfPre
Below is an email from smartmeter.


EndOfPre;

$emailTemplate['post'] = <<<EndOfPost


Please click <a href="#">here</a> to change your notification preferences.
EndOfPost;
// Leave this line in