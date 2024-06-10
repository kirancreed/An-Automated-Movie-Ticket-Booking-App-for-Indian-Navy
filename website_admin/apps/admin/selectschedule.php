<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Schedule Selection</title>
<style>
    /* Modal styles */
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4);
    }
    
    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 600px;
    }
    
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }
    
    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
</style>
</head>
<body>

<?php
// Check if MID is passed from the previous page
if(isset($_GET['mid']) && isset($_GET['msg'])) {
    $mid = $_GET['mid'];
    $msg = $_GET['msg'];    
    // Connect to your database
    include("auth.php");
    include('../connect/db.php');

    
            // Prepare and execute query to fetch schedules based on MID
            $sql = "SELECT * FROM schedules WHERE M_ID = :mid";
            $stmt = $db->prepare($sql);
            $stmt->bindParam(':mid', $mid);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            // Check if schedules exist for the given MID
            if(count($result) > 0) {
                // If there is more than one schedule, show a popup message
                if(count($result) > 1) {
                    // Display the modal for multiple schedules
                    echo "<div id='popup' class='modal'>";
                    echo "<div class='modal-content'>";
                    echo "<span class='close'>&times;</span>";
                    echo "<p>Multiple schedules found. Please select a schedule:</p>";
                    // Display radio buttons for each schedule option
                    foreach($result as $schedule) {
                        $scheduleID = $schedule['S_ID'];
                        echo "<input type='radio' name='selected_schedule' value='$scheduleID'> Date: " . $schedule['DATE'] . ", Time: " . $schedule['SHOW_TIME'] . "<br>";
                    }
                    echo "<button id='submitBtn'>Select</button>";
                    echo "</div>";
                    echo "</div>";
                } else if (count($result) == 1) {
                    // If only one schedule, redirect based on $msg
                    $schedule = $result[0];
                    if ($msg === "reservation") {
                        // Redirect to reservation page
                        echo "<script>window.location.href = 'seat.php?sid=".$schedule['S_ID']."';</script>";
                    } elseif ($msg === "view") {
                        // Redirect to view page
                        echo "<script>window.location.href = 'booking.php?sid=".$schedule['S_ID']."';</script>";
                    }
                }
            } else {
                echo "No schedules found ";
            }
        } 
     else {
        echo "MID or msg not provided.";
    }
    ?>

<script>
    // Get the modal
    var modal = document.getElementById('popup');
    
    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];
    
    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
        
        window.location.href = "movielist.php";

    }
    
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
            window.location.href = "movielist.php";
        }
    }
    
    // When the user clicks the Select button
    document.getElementById('submitBtn').addEventListener('click', function() {
        var radios = document.getElementsByName('selected_schedule');
        var selectedSchedule;
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
                selectedSchedule = radios[i].value;
                break;
            }
        }
        if (selectedSchedule !== undefined) {
            <?php
            // Check the value of $msg and redirect accordingly
            if ($msg === "reservation") {
                echo "window.location.href = 'seat.php?sid=' + selectedSchedule;";
            } elseif ($msg === "view") {
                echo "window.location.href = 'booking.php?sid=' + selectedSchedule;";
            }
            ?>
        } else {
            alert("Please select a schedule.");
        }
    });
    
    // Show the modal
    modal.style.display = "block";
</script>


</body>
</html>
