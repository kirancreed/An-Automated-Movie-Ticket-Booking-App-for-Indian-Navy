<?php
header("Access-Control-Allow-Origin: *");

// Include the database connection file
include 'connect.php';

// Retrieve user ID from the GET request parameters
$userId = isset($_GET['userId']) ? $_GET['userId'] : null;

if ($userId !== null) {
    try {
        // SQL query to fetch booked tickets for the given user ID, including seat numbers, booking date, booking ID, and movie status
        $sql = "SELECT s.S_ID, s.M_ID, s.SHOW_TIME, s.DATE, s.STATUS AS S_STATUS, m.NAME, m.IMAGE, m.STATUS AS MOVIE_STATUS, b.BOOKING_DATE, b.BOOKING_ID, GROUP_CONCAT(b.SEAT_NO) AS SEAT_NUMBERS
        FROM booking b 
        JOIN schedules s ON b.S_ID = s.S_ID
        JOIN movies m ON s.M_ID = m.M_ID
        WHERE b.U_ID = :userId
        AND DATE(s.DATE) >= CURDATE() -- Filter bookings for the current date (without considering time)
        GROUP BY s.S_ID, b.BOOKING_DATE
        ORDER BY s.S_ID";

        $stmt = $db->prepare($sql);
        $stmt->bindParam(':userId', $userId);
        $stmt->execute();

        $ticketsBySchedule = array();

        // Fetch data from each row and organize it by schedule ID and booking date
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $scheduleId = $row['S_ID'];
            $bookingDate = $row['BOOKING_DATE'];

            // Construct the schedule data array including the booking ID, movie status, and schedule status (if available)
            $scheduleData = array(
                'movieName' => $row['NAME'],
                'date' => $row['DATE'],
                'time' => $row['SHOW_TIME'],
                'bookingDate' => $bookingDate,
                'image' => $imageVar . $row['IMAGE'],
                'seats' => explode(',', $row['SEAT_NUMBERS']), // Convert comma-separated seat numbers to array
                'bookingId' => $row['BOOKING_ID'], // Include the booking ID
                'movieStatus' => intval($row['MOVIE_STATUS']), // Convert movie status to integer
                'scheduleStatus' => intval($row['S_STATUS']), // Convert movie status to integer
                // You can fetch and include schedule status here if it's available in the database
            );

            // Add the schedule data to the tickets array for the corresponding schedule ID and booking date
            $ticketsBySchedule[$scheduleId][$bookingDate] = $scheduleData;
        }

        // Return the booked tickets data grouped by schedule ID and booking date as JSON
        echo json_encode($ticketsBySchedule);
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }
} else {
    // No user ID provided
    echo "No user ID provided.";
}

// Close the database connection
$db = null;
?>
