<?php
/**
 * Supporting functions for SMNotifier
 *
 * Functions used by both the notification creation and sending systems.
 *
 * @author Harry Grillo <harry@redbassett.com>
 * @package SMNotifier
 */

/**
 * Connect to database
 *
 * Connects to the database where notifications are stored.
 *
 * @return object(PDO) The PDO connection to the database.
 * @throws If connection fails, throws exception of type SMNDeliveryError which contains the error message from the failed PDO connection.
 */
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