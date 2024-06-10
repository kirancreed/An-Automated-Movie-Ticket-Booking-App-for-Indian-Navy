<?php
session_start(); // Start the session

// Include your database connection file (e.g., include('../connect/db.php'))
include('../connect/db.php');

// Check if the form data is submitted via GET method
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    // Retrieve form data from GET parameters
    $currentPassword = $_GET["currentPassword"];
    $newPassword = $_GET["newPassword"];
    $confirmPassword = $_GET["confirmPassword"];

    // Check if new password is not null and has at least 6 characters
    if (empty($newPassword)) {
        echo "<script>alert('New password cannot be empty.'); window.location.href = 'profile.php';</script>";
        exit;
    }
    if (strlen($newPassword) < 6) {
        echo "<script>alert('New password must have at least 6 characters.'); window.location.href = 'profile.php';</script>";
        exit;
    }

    // Check if new password and confirm password match
    if ($confirmPassword != $newPassword) {
        echo "<script>alert('New password and confirmation password do not match.'); window.location.href = 'profile.php';</script>";
        exit;
    }

    // Assuming you have a session or some identifier for the user, fetch user data from the database
    $userId = $_SESSION['SESS_ADMIN_ID'];
    $uid = $_SESSION['user_id'];
    $sql = "SELECT PASSWORD FROM admin WHERE ID = :user_id";
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':user_id', $uid);
    $stmt->execute();
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    // Verify if the current password matches the one stored in the database
    $storedPassword = $row['PASSWORD'];

    // Compare the plain-text current password with the password from the database
    if ($currentPassword === $storedPassword) {
        // Current password is correct, proceed with updating the password

        // Update the password in the database
        $updateSql = "UPDATE admin SET PASSWORD = :new_password WHERE ID = :user_id";
        $updateStmt = $db->prepare($updateSql);
        $updateStmt->bindParam(':new_password', $newPassword);
        $updateStmt->bindParam(':user_id', $uid);
        if ($updateStmt->execute()) {
            // Password updated successfully
            header("Location: index.php");
            exit;
        } else {
            // Error updating password
            echo "<script>alert('Error updating password.'); window.location.href = 'profile.php';</script>";
        }
    } else {
        // Current password is incorrect
        echo "<script>alert('Current password is incorrect.'); window.location.href = 'profile.php';</script>";
    }
} else {
    // Handle the case where the form data is not submitted via GET method
    echo "<script>alert('Form data not submitted via GET method.'); window.location.href = 'profile.php';</script>";
}
?>
