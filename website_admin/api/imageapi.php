<?php

// Include the database connection code
include 'connect.php';

// Fetch movie image URLs from the database where schedule date is not past current date and time is not expired
$sql = "SELECT DISTINCT m.M_ID, m.IMAGE, m.NAME
FROM movies m
INNER JOIN schedules s ON m.M_ID = s.M_ID
WHERE (s.DATE > CURDATE() OR (s.DATE = CURDATE() AND s.SHOW_TIME >= CURTIME()))
AND m.STATUS = 0
AND s.STATUS = 0;
";

$result = $db->query($sql);

// Check if there are results
if ($result->rowCount() > 0) {
    // Fetch and store results in an array
    $movies = array();
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        $movies[] = array(
            'id' => (int)$row['M_ID'],
            'imageUrl' => $imageVar . $row['IMAGE'],
            'name' => $row['NAME']
             
        );
    }

    // Output JSON response
    header('Content-Type: application/json');
    echo json_encode($movies);
} else {
    // No results found
    echo "No movies found in the database.";
}

?>
