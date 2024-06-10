<?php
include("auth.php");
include('../connect/db.php');
$Log_Id = $_SESSION['SESS_ADMIN_ID'];
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
            max-width: 100%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
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
            border-collapse: collapse;
            width: 100%;
                /* margin-top: 0px; */
                
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
        .table-container {
    overflow-x: auto;
}

        .table-container table {
            width: 100%;
            min-width: 800px;
            /* Set a minimum width to prevent collapsing too much */
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
                    <h1>User List</h1>
                </header>
            <div class="container">
                


            <div class="table-container">
                <table>
                    <thead height="70">
                                         <tr>
                            <th style="text-align: center;">SL No.</th>
                            <th style="text-align: center;">Navy No.</th>
                            <th style="text-align: center;">Name</th>
                            <th style="text-align: center;">Rank</th>
                            <th style="text-align: center;">Unit</th>
                            <th style="text-align: center;">Mobile</th>
                            <th style="text-align: center;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        try {
                            $db = new PDO('mysql:host=' . $db_host . ';dbname=' . $db_database, $db_user, $db_pass);
                            $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                            // Perform a query to retrieve user details
                            $query = "SELECT * FROM user where STATUS=1";
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
                                echo '<td style="text-align:center;"><a href="remove.php?uid=' . $uid . '" onclick="return confirmRemove()"><i class="fas fa-trash-alt"></i></a></td>';// remove button


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
</script>


    </div>
</body>

</html>
