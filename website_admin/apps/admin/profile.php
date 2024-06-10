<?php
include("auth.php");
include('../connect/db.php');
$Log_Id = $_SESSION['SESS_ADMIN_ID'];
$uid = $_SESSION['user_id'];
// Initialize variables to store fetched data
$email = "";
$phone = "";

// Fetch email and phone number from the database
$sql = "SELECT email, phone_no FROM admin WHERE ID = :admin_id";
$stmt = $db->prepare($sql);
$stmt->bindParam(':admin_id', $uid);
$stmt->execute();
$row = $stmt->fetch(PDO::FETCH_ASSOC);

// Assign fetched values to variables
if ($stmt->rowCount() > 0) {
    // Assign fetched values to variables
    $email = $row['email'];
    $phone = $row['phone_no'];
} //else {
    // Handle the case where no results are returned
   // echo "No results found.";
    // You may choose to exit the script or set default values for $email and $phone
    //exit(); // Uncomment this line if you want to exit the script
    //$email = ""; // Set default email
  //  $phone = ""; // Set default phone
//}

// Check if form is submitted and if the phone field is set in the POST data
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["phone"])) {
    // Check if the phone number is not empty
    if (!empty($_POST["phone"])) {
        // Prepare an SQL statement
        $sql = "UPDATE admin SET phone_no = :phone WHERE ID = :admin_id";
        $stmt = $db->prepare($sql);
        
        // Bind parameters
        $stmt->bindParam(':phone', $_POST["phone"]);
        $stmt->bindParam(':admin_id', $uid);

        // Execute the statement
        if ($stmt->execute()) {
            // Phone number updated successfully
            // You can redirect or display a success message here
            echo '<script>alert("Phone number updated successfully!");</script>';
            // Update the phone variable to the new value
            $phone = $_POST["phone"];
        } else {
            // Error updating phone number
            echo '<script>alert("Error updating phone number: ' . $db->errorInfo() . '");</script>';
        }
    } else {
        // Handle the case where phone field is empty
        echo '<script>alert("Phone number cannot be empty!");</script>';
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    
<title>Navy welfare</title>
    <link rel="icon" type="image/x-icon" href="../../images/favicon.ico">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <style>
        /* Your CSS styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-indent: 50px;
        }

        .header2 {
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            text-align: center;
            margin-bottom: 20px;
            border-radius: 15px;
        }

        .profile-info {
            margin-bottom: 20px;
            
            
        }

        .profile-info label {
            font-weight: bold;
        }

        .profile-info p {
            margin: 5px 0;
        }

        .btn {
            padding: 5px 10px; 
            background-color: #dc3545;
            color: #fff;
            border: none;
            cursor: pointer;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #a83542;
        }
        /* CSS for modal */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
    background-color: #fefefe;
    margin: 15% auto; /* 15% from the top and centered */
    padding: 20px;
    border: 1px solid #888;
    width: 50%; /* Could be more or less, depending on screen size */
    text-align: left; 
}

/* Close Button */
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
    <?php
    include('include/css.php');
    ?>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <header class="main-header">
            <?php include("include/header.php"); ?>
        </header>
        <aside class="main-sidebar">
            <?php include("include/leftmenu.php"); ?>
        </aside>
        <div class="content-wrapper">
            <?php include("include/topmenu.php"); ?></div>
            <header class="header2">
                <h1>Admin Profile</h1>
            </header>
            <div class="container">
                <div class="profile-info">
                    <label>Email:</label><input type="email" id="email" value="<?php echo isset($email) ? htmlspecialchars($email) : ''; ?>" name="email" readonly style="border-style: groove;" >
 </div>
               
                <div class="profile-info">
                    <label>Phone:</label>
                    <input type="tel" id="phone" value="<?php echo htmlspecialchars($phone); ?>" readonly ></input>
                    <button class="btn" onclick="editPhone()">Edit Phone</button>
                </div>
                
                <form id="phoneForm" style="display: none;" method="POST">
                    <label for="phone">New Phone:</label>
                    <input type="tel" id="newPhone" name="phone" value="<?php echo $phone; ?>">
                    <button type="submit" class="btn">Update Phone</button>
                </form>




                 <!-- Add a modal for password change -->
                 <div id="passwordModal" class="modal">
    <div class="modal-content">
        
        <span class="close" onclick="closeModal()">&times;</span>
        <h2  class="header2">Change Password</h2>
        <form id="changePasswordForm" method="POST" >
            <label for="currentPassword">Current Password:</label>
            <input type="password" id="currentPassword" name="currentPassword"><br>
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword"><br>
            <label for="confirmPassword">Confirm New Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword"><br>
            <button type="submit" class="btn" id="changePasswordBtn" >Change Password</button>
        </form>
    </div>
</div>

<!-- Add a button to trigger the modal -->
<div class="profile-info">
<label >Password:</label>
    <button class="btn" onclick="openModal()">Rest Password</button>
</div>

<!-- Password Change Modal -->
<div id="passwordModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Change Password</h2>
        <form id="changePasswordForm" method="GET" action="update_password.php">
            <label for="currentPassword">Current Password:</label>
            <input type="password" id="currentPassword" name="currentPassword"><br>
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword"><br>
            <label for="confirmPassword">Confirm New Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword"><br>
            <button type="submit" class="btn" id="changePasswordBtn">Change Password</button>
        </form>
    </div>
</div>

<script>
    // JavaScript functions for modal handling
    function openModal() { 
        document.getElementById("passwordModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("passwordModal").style.display = "none";
    }

    // JavaScript function to handle form submission
    document.getElementById("changePasswordForm").addEventListener("submit", function(event) {
        event.preventDefault();
        var currentPassword = document.getElementById("currentPassword").value;
        var newPassword = document.getElementById("newPassword").value;
        var confirmPassword = document.getElementById("confirmPassword").value;

        // Perform validation here if needed

        // Submit the form with password as query parameters
        window.location.href = "update_password.php?currentPassword=" + encodeURIComponent(currentPassword) + "&newPassword=" + encodeURIComponent(newPassword)+ "&confirmPassword=" + encodeURIComponent(confirmPassword);
    });
</script>

            </div>
            
        </div>
        <?php include("include/footer.php"); ?>
        <div class="control-sidebar-bg"></div>
        <?php include("include/js.php"); ?>
        <script>
    // JavaScript function for phone number validation
    function validatePhoneNumber() {
        var phoneNumber = document.getElementById("newPhone").value.trim();
        var phonePattern = /^\d{10}$/; // Regular expression for a 10-digit number

        // Check if the entered phone number matches the pattern
        if (!phonePattern.test(phoneNumber)) {
            // Invalid number, show error popup
            alert("Invalid phone number. Please enter a 10-digit number.");
            return false;
        }
        return true;
    }

    // JavaScript function to handle the edit phone button click
    function editPhone() {
        document.getElementById("phoneForm").style.display = "block";
    }

    // JavaScript function to handle form submission for updating phone number
    document.getElementById("phoneForm").addEventListener("submit", function(event) {
        event.preventDefault();

        // Trigger phone number validation
        if (validatePhoneNumber()) {
            // Submit the form
            this.submit();
        }
    });

    // JavaScript function to update phone number in the page dynamically
    function updatePhoneNumber(phone) {
        document.getElementById("phone").innerText = phone;
    }
</script>

    </div>
</body>
</html>
