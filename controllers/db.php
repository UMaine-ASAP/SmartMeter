<?php

class DBController
{

    private $initialized = false;

    static function getConnection($param)
    {
        if (!$this->initialized)
        {
            try
            {
                $dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname=' . $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
                $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->dbh = $dbh;

                $this->initialized = true;

                return $dbh;
            } 
            catch (PDOException $ex)
            {
                error_log($ex);
                $dbh = null;
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
