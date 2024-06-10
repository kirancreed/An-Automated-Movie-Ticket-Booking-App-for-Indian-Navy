<?php

// Include the database connection code
include 'connect.php';

// Check if 'mid' parameter is provided
if (isset($_GET['mid'])) {
    $mid = $_GET['mid'];
    $currentDateTime = date('Y-m-d H:i:s');

    // Fetch details of a specific movie based on the passed 'mid', with STATUS equal to 0, and the conditions mentioned
    $sql = "SELECT m.*, s.DATE, s.SHOW_TIME 
            FROM movies m 
            INNER JOIN schedules s ON m.M_ID = s.M_ID
            WHERE m.M_ID = $mid 
            AND m.STATUS = 0
            AND s.STATUS = 0
            AND (
                s.DATE > CURDATE() 
                OR (s.DATE = CURDATE() AND s.SHOW_TIME > CURTIME())
            )";

    $result = $db->query($sql);

    // Check if movie details are found
    if ($result->rowCount() > 0) {
        $movie = array();
        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            // Store movie details
            $movie['M_ID'] = $row['M_ID'];
            $movie['NAME'] = $row['NAME'];
            $movie['STARRING'] = $row['STARRING'];
            $movie['youtubeUrl'] = $row['TRAILER'];
            $movie['RATING'] = $row['RATING'];
            $movie['IMAGE'] = $row['IMAGE'];
            $movie['DESCRIPTION'] = $row['DESCRIPTION'];
            // Check if the date-time combination is not expired
            $dateTime = $row['DATE'] . ' ' . $row['SHOW_TIME'];
            if ($dateTime > $currentDateTime) {
                // Store date and time details as an array of associative arrays
                $movie['dateTimes'][] = array(
                    'date' => $row['DATE'],
                    'time' => $row['SHOW_TIME']
                );
            }
        }
        // Output JSON response
        header('Content-Type: application/json');
        echo json_encode($movie);
    } else {
        // Movie not found
        echo "Movie not found for mid: $mid";
    }
} else {
    // 'mid' parameter is missing
    echo "Please provide the 'mid' parameter.";
}

?>
