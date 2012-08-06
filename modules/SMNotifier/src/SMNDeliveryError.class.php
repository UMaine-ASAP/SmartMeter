<?php
/**
 * Exception Class
 *
 * Exception class for exceptions thrown by SMNotifier.
 *
 * @author Harry Grillo <harry@redbassett.com>
 * @package SMNotifier
 */
class SMNDeliveryError extends Exception {
	public function __construct($message, $code, Exception $previous = null) {
		parent::__construct($message, $code, $previous);
	}
}