<?php
include("auth.php");
include('../connect/db.php');
$Log_Id = $_SESSION['SESS_ADMIN_ID'];
$uid = $_SESSION['user_id'];
//echo $Log_Id;
// echo $uid;
$options = [];
// Query to get the default status
$sql = "SELECT Auto FROM admin WHERE ID = :uid";
$stmt = $db->prepare($sql);
$stmt->bindParam(':uid', $uid, PDO::PARAM_STR);
$stmt->execute();
$result = $stmt->fetch(PDO::FETCH_ASSOC);
// echo $result;
// Convert the status to a boolean (true/false)
$toggleStatus = $result['Auto'] == 1;


?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the new status from the form submission
    $newToggleStatus = isset($_POST['toggle_status']) ? 1 : 0;

    // Update the status in the database
    $sql = "UPDATE admin SET Auto = :newStatus WHERE ID = :uid";
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':newStatus', $newToggleStatus, PDO::PARAM_INT);
    $stmt->bindParam(':uid', $uid, PDO::PARAM_STR);
    $stmt->execute();

    // Redirect back to the same page to refresh the toggle button's state
    header("Location: " . $_SERVER['PHP_SELF']);
    exit();
}
?>



<!DOCTYPE html>
<html lang="en">

<head>
    
<title>Navy welfare</title>
    <link rel="icon" type="image/x-icon" href="../../images/favicon.ico">
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
            max-width: 100%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%     
            
        }
        .header2 {
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            text-align: center;
            margin-bottom: 20px;
            border-radius: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            
        }

         td {
            border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
                
        }

        th {
            text-align: center;
            border: 1px solid #ddd;
            padding: 8px;
            background-color: #7393B3;
            color: #fff;
            font-weight: bold;
            
            
        }
        

        td:last-child {
            text-align: center;
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
        /* Style the toggle switch */
        .switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
        }

        input:checked + .slider {
            background-color: #2196F3;
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        /* Rounded slider */
        .slider.round {
            border-radius: 34px;
        }

        .slider.round:before {
            border-radius: 50%;
        }
        .toggle-text {
    font-size: 16px;
    font-weight: bold;
    color: #333; /* Change color as needed */
}

.table-container {
    overflow-x: auto;
}

.table-container table {
    width: 100%;
    min-width: 800px; /* Set a minimum width to prevent collapsing too much */
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
                    <h1>Pending Requests</h1>
                </header>
            <div class="container">      

            <form method="post" id="toggleForm">
    <div class="toggle-container">
        <span class="toggle-text">Auto user accept</span>
        <label class="switch">
            <input type="checkbox" name="toggle_status" <?php echo $toggleStatus ? 'checked' : ''; ?> id="toggleButton">
            <span class="slider round"></span>
        </label>
    </div><br>
</form>


    <script>
        // Add an event listener to the checkbox to submit the form when the state changes
        document.getElementById('toggleButton').addEventListener('change', function() {
            var isChecked = this.checked;
            document.getElementById('toggleForm').submit();
            if (isChecked) {
                alert("Auto user accepting turning on.\nThe users will be accepted automatically as soon as they request.");
            } else {
                alert("Auto user accepting turning off.\nYou need to accept users manually.");
            }
        });
    </script>


<div class="table-container">
                <table>
                    <thead height="70">
                        <tr>
                        <th style="text-align:center; width: 5%;">SL No.</th>
            <th style="text-align:center; width: 10%;">Navy No.</th>
            <th style="text-align:center; width: 15%;">Name</th>
            <th style="text-align:center; width: 20%;">Rank</th>
            <th style="text-align:center; width: 10%;">Unit</th>
            <th style="text-align:center; width: 15%;">Mobile</th>
            <th style="text-align:center; width: 15%;">Action</th>
                        </tr>
                     </thead>
                    <tbody> 
                        <?php
                        try {
                            $db = new PDO('mysql:host=' . $db_host . ';dbname=' . $db_database, $db_user, $db_pass);
                            $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                            // Perform a query to retrieve user details
                            $query = "SELECT * FROM user where STATUS=0";
                            $result = $db->query($query);

                            // Loop through the query results and generate table rows
                            $counter = 1;
                            while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
                                $uid=$row['U_ID'];
                                echo "<tr>";
                                echo "<td>{$counter}</td>";
                                echo "<td>{$row['NAVY_NO']}</td>";
                                echo "<td>{$row['NAME']}</td>";
                                echo "<td>{$row['RANK']}</td>";
                                echo "<td>{$row['UNIT']}</td>";
                                echo "<td>{$row['MOB_NO']}</td>";
                                
                                
                                echo '<td style="text-align:left;">
                                <a href="accept.php?uid=' . $uid . '" class="btn accept" style="padding: 5px 2px; background-color: #fff; color:#28a745; font-weight: bold ;" onclick="return confirmAccept()">Accept</a>
                                <span style="margin-right: 10px;"></span> 

                                <a href="remove.php?uid=' . $uid . '" class="btn remove"style=" background-color:#fff ; color:#EE4B2B ; font-weight: bold;" onclick="return confirmRemove()">Remove</a>
                            </td>';
                            //     <a href="remove.php" class="btn remove">Remove</a>
                            // </td>';
                                echo "</tr>";
                                $counter++;
                            }
                        } catch (PDOException $e) {
                            die("Database query failed: " . $e->getMessage());
                        } finally {
                            // Close the database connection
                            $db = null;
                        }
                        ?>
                    </tbody> 
                </table>

                    </div>
            </div>
        </div>
        <?php include("include/footer.php"); ?>
        <div class="control-sidebar-bg"></div>
        <?php include("include/js.php"); ?>

        <script>
            
            function confirmRemove() {
                return confirm("Are you sure you want to remove this user?");
            }

                        
            function confirmAccept() {
                return confirm("Are you sure you want to accept this user?");
            }



        </script>
    </div>
</body>

</html>
