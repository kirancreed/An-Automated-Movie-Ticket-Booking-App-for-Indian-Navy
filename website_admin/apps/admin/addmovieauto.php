<?php
include("auth.php");
include('../connect/db.php');

$id = null;

if (isset($_POST['title'], $_POST['image'], $_POST['desc'], $_POST['rating'], $_POST['cast'], $_POST['trailer'])) {
    $title = $_POST['title']; 
    $imagePath = $_POST['image'];
    $description = $_POST['desc'];
    $rating =  $_POST['rating'];
    $starring = $_POST['cast'];
    $trailer = $_POST['trailer'];

    if ($trailer == NULL) {
        $stmt = $db->prepare("INSERT INTO movies (NAME, DESCRIPTION, STARRING, RATING, IMAGE) VALUES (:title, :description, :starring, :rating, :imagePath)");
        // Bind parameters
        $stmt->bindParam(':title', $title);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':starring', $starring);
        $stmt->bindParam(':rating', $rating);
        $stmt->bindParam(':imagePath', $imagePath);
    } else {
        $stmt = $db->prepare("INSERT INTO movies (NAME, DESCRIPTION, STARRING, RATING, IMAGE, TRAILER) VALUES (:title, :description, :starring, :rating, :imagePath, :trailer)");
        // Bind parameters
        $stmt->bindParam(':title', $title);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':starring', $starring);
        $stmt->bindParam(':rating', $rating);
        $stmt->bindParam(':imagePath', $imagePath);
        $stmt->bindParam(':trailer', $trailer);
    }

    if ($stmt->execute()) {
        $id = $db->lastInsertId();
        echo '<div id="popup-container">
            <p>MOVIE Added. Redirecting...</p>
            <!-- Add any other content or form elements here -->
          </div>';
        // Redirect to another page after 3 seconds
        echo '<script>
            setTimeout(function(){
                window.location.href = "schedule.php?id=' . $id . '";
            }, 300);
        </script>';
    } else {
        echo "Error adding movie: " . $stmt->errorInfo()[2];
    }

    // Close the statement
    $stmt->closeCursor();


}
?>
