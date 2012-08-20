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


class Database {

    private static $dbh;

    private static function startDB() {
        if( Database::$dbh == null ) {
                Database::$dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname='. $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
                Database::$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        }
    }

    static function query($query_string, $data = array()) {
        Database::startDB();

        try 
           {
                $statement = Database::$dbh->prepare($query_string);
                $statement->execute($data);
    
                $result = $statement->fetchAll();

               return array('result' => $result, 'lastInsertId' => Database::$dbh->lastInsertId());
        }
        catch(PDOException $ex)
        {
            error_log($ex);
            Database::$dbh = null;
            return false;
        }

    }
    function __deconstruct__() {
        print "destroying DB";
        Database::$dbh = null;
    }

}
?>
