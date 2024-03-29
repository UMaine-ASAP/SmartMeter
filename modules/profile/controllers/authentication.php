<?PHP
require_once("lib/settings.php");
require_once("lib/phpass/PasswordHash.php");

require_once("db.php");

class AuthenticationController
{

    /**
     * Gets the ID of the User who is currently logged in. Since it calls checkLogin, it will log the user
     * out if their session has expired or their IP has changed during their current session.
     *
     * 		@return The logged in user's ID, or false if no user is logged in.
     */
    static function getCurrentUserID()
    {
        if (self::checkLogin())
        {
            return intval($_SESSION['UserID']);
        }

        return false;
    }

    /**
     * Determines if a user is currently logged in. If so, it checks their session data and logs them out
     * if their session has expired or their IP has changed. It then updates their latest access time to
     * the current time() value
     *
     * 	@return True if a user is currently logged in, false otherwise
     */
    static function checkLogin()
    {
        if (isset($_SESSION['UserID']))
        {
            $latestAccess = time();

            if ($latestAccess - $_SESSION['LastAccess'] > $GLOBALS["session_timeout"])
            {
                self::logOut();
                return false;
            }

            if (strcmp($_SESSION['RemoteIP'], $_SERVER['REMOTE_ADDR']) != 0)
            {
                self::logOut();
                return false;
            }

            $_SESSION['LastAccess'] = $latestAccess;
            return true;
        }

        return false;
    }

    /**
     * 	Attempts to log in as a user with the given username and password. If the login is successful,
     * 	the appropriate $_SESSION variables will automatically be set. Note that this function takes
     * 	an arbitrary non-insignificant amount of time to return a result; this is intentional. Not only
     * 	does it make brute forcing harder, it prevents some kind of theoretical attacker from timing
     * 	it and determining whether they have a valid username.
     *
     * 		@param string $username The username given by the user attempting to log in.
     * 		@param string $password The plaintext password submitted by the user attempting to log in.
     *
     * 	@return False if the login was unsuccessful, true otherwise.
     */
    static function attemptLogin($username, $password)
    {
        //sanity check -- if a user attempts to log in and they/another user is actually logged in, log them out first
        if (self::isLoggedIn())
        {
            self::logOut();
        }

        //passwords greater than 72 characters in length take a long time to hash; by blatantly disallowing them we keep
        //people from putting in gigantic passwords and ddosing the website (intentionally or accidentally)
        if (strlen($password) > 72)
        {
            return false;
        }

        //try to find a user with that username


        $data = array("username" => $username);
        $querystring = "SELECT COUNT(username) FROM AUTH_Users WHERE username=:username";

        $row = Database::query($querystring, $data);

        
        $result = $row['result'][0];
        
        if ($result == 0)
        {
            usleep(rand(100000, 250000)); //so that they can't easily search for usernames by timing how long this takes
            return false;
        }
        else
        {
            $querystring = "SELECT * FROM AUTH_Users WHERE username=:username";
            $data = array("username" => $username);

            $row = Database::query($querystring, $data);
            if(isset($row['result'][0]))
                $user = $row['result'][0];
            else
                $user = null;
            
        }

        //instantiate a PasswordHash class from phpass
        $hasher = new PasswordHash(8, false);

        if ($hasher->CheckPassword($password, $user['password']))
        {
            //great success!
            self::doLogin($user);
            
            $dbh = null;
            return true;
        }
        
        $dbh = null;
        //nope
        return false;
    }

    /**
     * Completely destroys the current session.
     */
    static function destorySession()
    {
        if (session_id() === '')
        {
            //$_SESSION = array();
//			return true;
        }

        $_SESSION['UserID'] = '';
        $_SESSION['LastAccess'] = '';
        $_SESSION['RemoteIP'] = '';

        unset($_SESSION['UserID']);
        unset($_SESSION['LastAccess']);
        unset($_SESSION['RemoteIP']);

        //$_SESSION = array();
        //session_destroy();
        return true;
    }

    /**
     * 	Attempts to hash a specified plaintext password. If successful, returns the hash to the caller.
     * 	Hashing will fail if the password is longer than 72 characters (to prevent DDOS) or if the resulting
     * 	hash is less than 20 characters long (which means something went wrong while creating the hash)
     *
     * 		@param string $password The plaintext password to hash.
     * 	@return The hashed password, or false if hashing failed.
     */
    static function createHash($password)
    {
        $hasher = new PasswordHash(8, false);

        if (strlen($password) > 72)
        {
            //passwords longer than 72 characters can take a VERY LONG time to hash
            return false;
        }

        $hash = $hasher->HashPassword($password);

        if (strlen($hash) > 20)
        {
            return $hash;
        }

        return false; //if strlen was less than 20, something was direly wrong
    }

    /**
     * Sets a users's password to the secure hash of the plaintext password passed to the function.
     * 		@param int $userID The ID of the user whose password will be updated.
     * 		@param string $password The plaintext of the user's new password (will be hashed)
     *
     * 	@return True if the update was successful, false otherwise.
     *
     */
    static function updateUserPassword($userID, $password)
    {
        // Check user has permissions to change password
        if (!$user = self::getCurrentUserID())
        {
            return false;
        }
        
        //we know the user exists at this point

        if ($hash = self::create_hash($password))
        {
            try
            {
                $dbh = DBController::getConnection();
                $data = array("password" => $hash, "userid" => $userid);
                
                $statement = $dbh->prepare("UPDATE AUTH_Users SET password=:password WHERE user_id=:userid");
                $statement->execute($data);
                
                $result = $statement->fetchColumn();
                
                if ($result == 0)
                {
                    error_log("WARNING: Unable to update user with ID $userid's password to $hash");
                    return false;
                }
                
                $dbh = null;
                
                return true;
            }
            catch (PDOException $ex)
            {
                error_log($ex);
                $dbh = null;
                return false;
            }
        }

        return false;
    }

    /**
     * Logs the current user out. Currently, it just destroys their session. In the future, it'll
     * probably have to take more factors into account.
     */
    static function logOut()
    {
        self::destorySession();
    }

    /**
     * Determines if a user is logged in.
     * 	@return True if a user is currently logged in, false otherwise.
     */
    static function isLoggedIn()
    {
        return self::checkLogin();
    }

    /**
     * Resets $_SESSION, then sets appropriate variables within it (currently UserID and LastAccess)
     */
    private static function doLogin($user)
    {
        $_SESSION = array();
        $_SESSION['UserID'] = $user['user_id'];
        $_SESSION['LastAccess'] = time();
        $_SESSION['RemoteIP'] = $_SERVER['REMOTE_ADDR'];
    }

}

?>