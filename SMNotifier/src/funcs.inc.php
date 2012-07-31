<?php
// Connect to the database using the variables in vars.inc.php
function dbConnect() {
	global $dbVars;

	$port = (isset($dbVars['port'])) ? 'port='.$dbVars['port'].';' : '';
	try {
		$conn = new PDO($dbVars['type'].':host='.$dbVars['host'].';'.$port.'dbname='.$dbVars['database'], $dbVars['user'], $dbVars['password']);
		return $conn;
	} catch (PDOException $e) {
		throw new SMNDeliveryError('Failed to connect to database. ("'.$e->getMessage().'")', 21);
	}
}