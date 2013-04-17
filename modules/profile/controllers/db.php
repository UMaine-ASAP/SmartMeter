<?php


class Database {

    private static $dbh;

    private static function startDB() {
        if( self::$dbh == null ) {
                self::$dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname='. $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
                self::$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        }
    }

    static function query($query_string, $data = array()) {
        self::startDB();

        try 
           {
                $statement = self::$dbh->prepare($query_string);
                $statement->execute($data);
    
                $result = $statement->fetchAll();

               return array('result' => $result, 'lastInsertId' => self::$dbh->lastInsertId());
        }
        catch(PDOException $ex)
        {
            error_log($ex);
            self::$dbh = null;
            return false;
        }

    }
    function __deconstruct__() {
        print "destroying DB";
        self::$dbh = null;
    }

}
?>
