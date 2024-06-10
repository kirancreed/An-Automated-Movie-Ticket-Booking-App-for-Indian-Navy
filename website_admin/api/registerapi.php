<?php
include 'connect.php';

// Get the data from the POST request
$rank = $_POST['rank'];
$name = $_POST['name'];
$navyNo = $_POST['navyNo'];
$unit = $_POST['unit'];
$mobileNo = $_POST['mobileNo'];
$password = $_POST['password'];

// Check if mobile number already exists
$checkQuery = "SELECT * FROM user WHERE MOB_NO = ?";
$checkStmt = $db->prepare($checkQuery);
$checkStmt->execute([$mobileNo]);

if ($checkStmt->rowCount() > 0) {
    // Mobile number already exists, return error response
    $response['status'] = 'error';
    $response['message'] = 'Mobile number already exists.';
} else {
    // Fetch the Auto variable from the admin table
    $autoQuery = "SELECT Auto FROM admin LIMIT 1";
    $autoResult = $db->query($autoQuery);
    $autoRow = $autoResult->fetch(PDO::FETCH_ASSOC);
    $auto = $autoRow['Auto'];

    // Determine the value for STATUS
    $status = ($auto == 1) ? 2 : 0;

    // Insert data into the 'user' table
    $query = "INSERT INTO user (RANK, NAME, NAVY_NO, UNIT, MOB_NO, PASSWORD, STATUS) VALUES (?, ?, ?, ?, ?, ?, ?)";
    $stmt = $db->prepare($query);

    if ($stmt) {
        // Bind parameters
        $stmt->bindParam(1, $rank);
        $stmt->bindParam(2, $name);
        $stmt->bindParam(3, $navyNo);
        $stmt->bindParam(4, $unit);
        $stmt->bindParam(5, $mobileNo);
        $stmt->bindParam(6, $password);
        $stmt->bindParam(7, $status);

        // Execute the statement
        if ($stmt->execute()) {
            $response['status'] = 'success';
            $response['message'] = 'Registration successful!';
        } else {
            $response['status'] = 'error';
            $response['message'] = 'Error: ' . $stmt->errorInfo()[2];
        }
    } else {
        $response['status'] = 'error';
        $response['message'] = 'Error in preparing SQL statement.';
    }
}

// Echo the JSON response
echo json_encode($response);
?>
