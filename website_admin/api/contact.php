<?php
try {
    // Create connection
    include 'connect.php';
    
    // Query to fetch email and phone number from admin table
    $sql = "SELECT phone_no FROM admin";
    
    // Prepare the statement
    $stmt = $db->prepare($sql);
    
    // Execute the query
    $stmt->execute();
    
    // Fetch all rows as associative array
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    // Check if there are rows
    if (count($result) > 0) {
        // Send JSON response
        header('Content-Type: application/json');
        echo json_encode($result);
    } else {
        // No records found
        echo "0 results";
    }
} catch(PDOException $e) {
    // Error handling
    echo "Connection failed: " . $e->getMessage();
}

// Close connection
$db = null;

?>
