<?php
include 'connect.php';

header("Access-Control-Allow-Origin: *");

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Log the received data to a file
    $receivedData = $_POST;

    // Check if all required parameters are present
    if (isset($_POST['userId']) && isset($_POST['old_password']) && isset($_POST['new_password'])) {
        // Get the user ID, old password, and new password from the request
        $userId = $_POST['userId'];
        $oldPassword = $_POST['old_password'];
        $newPassword = $_POST['new_password'];

        try {
            // Retrieve the old password from the database
            $stmt = $db->prepare("SELECT PASSWORD FROM user WHERE U_ID = ?");
            $stmt->execute([$userId]);
            $user = $stmt->fetch();

            if ($user) {
                $correctOldPassword = $user['PASSWORD']; // Assuming the password column is named PASSWORD

                // Check if the old password matches the correct password for the user
                if ($oldPassword === $correctOldPassword) {
                    try {
                        // Prepare and execute an SQL UPDATE statement to update the password
                        $stmt = $db->prepare("UPDATE user SET PASSWORD = ? WHERE U_ID = ?");
                        $stmt->execute([$newPassword, $userId]);
                
                        // Check if the password was successfully updated
                        if ($stmt->rowCount() > 0) {
                            // Password updated successfully
                            echo json_encode(array('success' => true, 'message' => 'Password changed successfully'));
                        } else {
                            // No rows were affected, indicating that the user ID might be incorrect
                            echo json_encode(array('success' => false, 'message' => 'Failed to update password. User ID might be incorrect.'));
                        }
                    } catch (PDOException $e) {
                        // Handle database connection or query errors
                        echo json_encode(array('success' => false, 'message' => 'Database error: ' . $e->getMessage()));
                    }
                } else {
                    // Old password doesn't match, return an error message
                    echo json_encode(array('success' => false, 'message' => 'Incorrect old password'));
                }
            } else {
                // User not found in the database
                echo json_encode(array('success' => false, 'message' => 'User not found'));
            }
        } catch (PDOException $e) {
            // Handle database connection or query errors
            echo json_encode(array('success' => false, 'message' => 'Database error: ' . $e->getMessage()));
        }
    } else {
        // Required parameters are missing
        echo json_encode(array('success' => false, 'message' => 'Missing parameters'));
    }
} else {
    // Invalid request method
    echo json_encode(array('success' => false, 'message' => 'Invalid request method'));
}
?>
