<?php
// Start the session
session_start();

include('connect/db.php');

// Validate form data
$email = $_POST['email'];
$password = $_POST['password'];

// Prepare the SQL query with a placeholder for parameters
$sql = "SELECT * FROM admin WHERE email = :email AND password = :password";

// Prepare the statement
$stmt = $db->prepare($sql);

// Bind parameters
$stmt->bindParam(':email', $email);
$stmt->bindParam(':password', $password);

// Execute the query
$stmt->execute();

// Fetch the result
$user_data = $stmt->fetch(PDO::FETCH_ASSOC);

// If a single row is found, login is successful
if ($user_data) {
    // Store user ID in the session for tracking
    $_SESSION['SESS_ADMIN_ID'] = $user_data['email'];
    $_SESSION['user_id'] = $user_data['ID']; // Replace 'id' with the actual user ID column name

    // Redirect to the index page
    header("Location: admin/index.php");
} else {
    // Login failed, display an error message or redirect
    echo "<script>alert('Invalid email or password. Please try again.'); window.location.href='login.php';</script>";
}

// Close the database connection (not necessary with PDO)
// $db = null;
?>