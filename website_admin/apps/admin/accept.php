<?php
// Include the database connection code
include("auth.php");
include('../connect/db.php');
$Log_Id=$_SESSION['SESS_ADMIN_ID'];

// Check if the UID parameter is set in the URL
if (isset($_GET['uid'])) {
    // Get the UID from the URL
    $uid = $_GET['uid'];

    try {
        // Prepare and execute the SQL statement to update the user status
        $stmt = $db->prepare("UPDATE user SET STATUS = 1 WHERE U_ID = ?");
        $stmt->execute([$uid]);

        // For demonstration purposes, redirect back to the previous page with a success message
        header("Location: ".$_SERVER['HTTP_REFERER']."?success=User status updated successfully");
        exit();
    } catch (PDOException $e) {
        // Handle the exception (e.g., display an error message)
        echo "Error: " . $e->getMessage();
        // You might want to log the error or redirect to an error page
       // header("Location: error.php"); // Replace error.php with the appropriate error handling page
    
    }
} else {
    // Redirect or display an error message if UID is not set
    header("Location: error.php"); // Replace error.php with the appropriate error handling page
    exit();
}
?>
