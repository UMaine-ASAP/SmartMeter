<?php

/**
 * SMNotifier main class.
 *
 * SMNotifier class used to trigger notifications.
 *
 * @author Harry Grillo <harry@redbassett.com>
 * @package SMNotifier
 */
class SMNotifier
{

    private $_conn; //  This will be the database connection for queries as of...

    /**
     * SMNotifier API constructor.
     *
     * Generates a new SMNotifier object and creates a DB connection for it.
     *
     * @access public
     */

    public function __construct()
    {
        $this->_conn = dbConnect();
    }

    /**
     * Send a single-user notification.
     *
     * Sends a notification to a single user by selecting their contact preferences from the user table in the database and then placing the notification in the send queue based on that preference.
     *
     * @param int $id The id of the user's row in the database.
     * @param string $message The message of the notification.  In the case of emails, this will be placed between the email template post and pre settings in vars.inc.php.
     * @param string $emaiLSubject If an email is sent, this will be its subject line.
     * @access public
     */
    public function notify($id, $message, $emailSubject = null)
    {
        // If the id is returned from a previous query as a string, we want to make it an int so it plays nice with PDO
        if (preg_match('/^\d$/', $id))
        {
            $id = (int) $id;
        }
        if (is_int($id))
        { // Id must be an int
            $statement = $this->_conn->prepare('SELECT `phone`, `email`, `preferredContact` FROM `AUTH_Users` WHERE `user_id` = :id');
            if ($statement->execute(array('id' => $id)))
            {
                if ($row = $statement->fetch(PDO::FETCH_ASSOC))
                {
                    $this->execute($row, $message, $emailSubject); // Pass this off to our logic function
                } else
                {
                    throw new SMNDeliveryError('Please enter a valid user ID.', 23);
                }
            } else
            {
                throw new SMNDeliveryError('Please check your database query.  ' . print_r($statement->errorInfo(), true), 22);
            }
        } else
        {
            if (is_array($id))
            { // Try to provide some helpful hints for multiple user calls
                throw new SMNDeliveryError('Please enter a valid database user row id.  If you meant to notify multiple users, please use the SMNotifier.notifyMultiple() instead.', 11);
            } else
            {
                throw new SMNDeliveryError('Please enter a valid database user row id.', 11);
            }
        }
    }

    /**
     * Sends a multiple-user notification.
     *
     * Sends a notifiation to multiple users by selecting their contact preferences from the user table in the database and then placing the notification in the send queue based on that preference.
     *
     * @param array(int) $ids Array of ids of the users' rows in the database.
     * @param string $message The message of the notification.  In the case of emails, this will be placed between the email template post and pre settings in vars.inc.php.
     * @param string $emaiLSubject If an email is sent, this will be its subject line.
     * @access public
     */
    public function notifyMultiple($ids, $message, $emailSubject = null)
    {
        if (is_array($ids))
        {
            // Select all the users
            $statement = $this->_conn->query('SELECT `phone`, `email`, `preferredContact` FROM `AUTH_Users` WHERE `user_id` IN (' . $this->_conn->quote(implode(',', $ids)) . ')');
            $results = $statement->fetchAll();
            foreach ($results as $row)
            {
                $this->execute($row, $message, $emailSubject); // For each, pass on to the logic function
            }
        } else
        {
            if (is_int($ids))
            { // Provide som helpful hints if it looks like they want the other notification function
                throw new SMNDeliveryError('Please use and array of database user row ids.  If you want to notify one user, please user SMNotifier.notify() instead.', 11);
            } else
            { // Otherwise just throw an excpetion
                throw new SMNDeliveryError('Please use an array of database user row ids.', 11);
            }
        }
    }

    /**
     * Supporting function to figure out which method a user wants to be contacted by.
     *
     * Takes a user row, calculates what method to contact the user by, and sends the notification information on to the handler function for that method of contact.
     *
     * @param array $row User row from database.
     * @param string $message The notification message.
     * @param string $emailSubject The subjectline if this generates and email.
     * @access private
     */
    private function execute($row, $message, $emailSubject = null)
    {
        if ($row['preferredContact'] == 'phone' || $row['preferredContact'] == 'both')
        {
            $this->notifyPhone($row['phone'], $message);
        }
        if ($row['preferredContact'] == 'email' || $row['preferredContact'] == 'both')
        {
            $this->notifyEmail($row['email'], $message, $emailSubject);
        }
    }

    /**
     * Supporting function to insert email notifications.
     *
     * Once the notification contact method has been decided, this function is called to insert a new notification from for an email notification.
     *
     * @param string $email The email address to send to.
     * @param string $message The message body of the email.
     * @param string $subject The message subject of the email.
     * @access private
     */
    private function notifyEmail($email, $message, $subject = null)
    {
        $statement = $this->_conn->prepare('INSERT INTO `NOTIFICATION_Pending`
		                                   (`email`,`emailSubject`,`message`)
		                                   VALUES
		                                   (:email,:emailSubject,:message)');
        $statment->execute(array(
            'email' => $email,
            'emailSubject' => $emailSubject,
            'message' => $message
        ));
    }

    /**
     * Supporting function to insert phone (text) notifications.
     *
     * Once the notification contact method has been decided, this function is called to insert a new notification from for a phone (text) notification.
     *
     * @param string $phone The phone number to send to.
     * @param string $message The message body of the text
     * @access private
     */
    private function notifyPhone($phone, $message)
    {
        $statement = $this->_conn->prepare('INSERT INTO `NOTIFICATION_Pending`
		                                   (`phone`,`message`)
		                                   VALUES
		                                   (:phone,:message)');
        $statement->execute(array(
            'phone' => $phone,
            'message' => $message
        ));
    }

}