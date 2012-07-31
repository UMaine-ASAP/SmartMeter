<?php
class SMNDeliveryError extends Exception {
	public function __construct($message, $code, Exception $previous = null) {
		parent::__construct($message, $code, $previous);
	}
}
?>