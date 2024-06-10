<?php

// Allow requests from any origin
header("Access-Control-Allow-Origin: *");

// Include the database connection file
include 'connect.php';

// Retrieve POST data
$date = $_POST['date'];
$time = $_POST['time'];
$mid = $_POST['mid'];

// Format date and time strings
$formattedDate = date('Y-m-d', strtotime($date)); // Convert date string to 'Y-m-d' format
$formattedTime = date('H:i:s', strtotime($time)); // Convert time string to 'H:i:s' format

// Prepare SQL statement to retrieve booked seats
$sql = "SELECT SEAT_NO FROM booking WHERE S_ID IN (SELECT S_ID FROM schedules WHERE M_ID = :mid AND DATE = :date AND SHOW_TIME = :time)";
$stmt = $db->prepare($sql);
$stmt->bindParam(':mid', $mid);
$stmt->bindParam(':date', $date);
$stmt->bindParam(':time', $time);

// Execute the query
try {
    $stmt->execute();
    $bookedSeats = $stmt->fetchAll(PDO::FETCH_COLUMN);
} catch (PDOException $e) {
    // Handle query execution error
    die("Query failed: " . $e->getMessage());
}

// Append the predefined string to the booked seats array
$predefinedSeats = explode(',', "BB18,BB17,BB16,BB15,BB14");
$mergedSeats = array_merge($bookedSeats, $predefinedSeats);

// Encode the merged seats array as JSON
$jsonResponse = json_encode($mergedSeats);

// Return the JSON response
echo $jsonResponse;

?>
