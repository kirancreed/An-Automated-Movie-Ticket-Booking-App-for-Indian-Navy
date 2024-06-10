<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

include "connect.php";

$mobno = $_GET['mobno'];
$password = $_GET['password']; // Assuming password is passed from the client

$sql = "SELECT U_ID, RANK, NAME, NAVY_NO, UNIT, MOB_NO, CAST(STATUS AS INT) AS STATUS FROM user WHERE MOB_NO = :mobno AND PASSWORD = :password ";
$stmt = $db->prepare($sql);
$stmt->bindParam(':mobno', $mobno);
$stmt->bindParam(':password', $password); // Bind password parameter
$stmt->execute();
$returnValue = $stmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($returnValue as $row) {
    $row['STATUS'] = (int)$row['STATUS'];
    $row['U_ID'] = (int)$row['U_ID'];
}

echo json_encode($returnValue);
?>
