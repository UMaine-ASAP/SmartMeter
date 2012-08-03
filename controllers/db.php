<?php

class DBController
{
    static function getConnection($param)
    {
        try
        {
            $dbh = new PDO('mysql:host=' . $GLOBALS['HOST'] . ';dbname=' . $GLOBALS['DATABASE'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD']);
            $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $dbh;
        } catch (PDOException $ex)
        {
            error_log($ex);
            $dbh = null;
            return false;
        }
    }
}

?>
