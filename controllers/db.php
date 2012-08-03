<?php

class DBController
{

    private $initialized = false;

    /*
     * If successful, returns a PDO connection object. If none previously existed, it will be created.
     */
    static function getConnection()
    {
        if (!$this->initialized)
        {
            try
            {
                $log = new KLogger("../logs");
                $dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname=' . $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
                $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->dbh = $dbh;

                $this->initialized = true;
                $log->logInfo("DBController: Created PDO object");
                return $dbh;
            } 
            catch (PDOException $ex)
            {
                error_log($ex);
                $dbh = null;
                $log = new KLogger("../logs");
                $log->logError("DBController: Failed to create PDO object");
                return false;
            }
        } 
        else
        {
            return $this->dbh;
        }
    }
    
}

?>
