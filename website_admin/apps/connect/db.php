<?php
//error_reporting(0);
$db_host		= 'localhost';
$db_user		= 'root';
$db_pass		= '';
$db_database	= 'movie_db';
try{
    $db = new PDO('mysql:host='.$db_host.';dbname='.$db_database, $db_user, $db_pass);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
}catch(PDOException $e){
    echo "Connection failed:" .$e->getMessage();
    header("Location: ../admin/error.php"); // Replace error.php with the appropriate error handling page

}
$imageVar = "http://192.168.191.134/movie_app/apps/admin/";
?>
