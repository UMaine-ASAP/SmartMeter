<?php


class DBController
{

    private static $initialized = false;

    /*
     * If successful, returns a PDO connection object. If none previously existed, it will be created.
     */
    static function getConnection()
    {
        static $dbh;
        if (!self::$initialized)
        {
            try
            {
                $dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname=' . $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
                $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                self::$initialized = true;
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
            return $dbh;
        }
    }
    
}

?>
