<?php
function mysqlDatetime($timestamp = null) {
	if (is_null($timestamp))
		$timestamp = time();
	return date('Y-m-d H:i:s', $timestamp);
}

function phpTimestamp($datetime = null) {
	if (is_null($datetime))
		return time();
	else
		return strtotime($datetime);
}

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
?>