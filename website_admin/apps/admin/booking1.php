<!-- <?php
include("auth.php");
include('../connect/db.php');
$Log_Id=$_SESSION['SESS_ADMIN_ID'];
?>

<!DOCTYPE html>
<html>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<head>
<title>Navy welfare</title>
    <link rel="icon" type="image/x-icon" href="../../images/favicon.ico">
     <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <?php
    include("include/css.php");
    ?>  
    
</head>
<body class="hold-transition skin-blue sidebar-mini">

<div class="wrapper">
    
    <header class="main-header"> 
    <?php
    include("include/header.php");
    ?>
    </header>
    
    <aside class="main-sidebar">
    <?php
    include("include/leftmenu.php");
    ?>
    </aside>
    
    <div class="content-wrapper">
    <?php
    include("include/topmenu.php");
    ?>
    </div>
    
    <div class="row well" style="background-color:#FAFAFA;">
      
    <?php
    // Fetch booking details with user, movie, and schedule information from the database using JOIN
    $sql = "SELECT
    b.B_ID, 
    b.BOOKING_ID as bookingId,
    u.NAME AS username, 
    GROUP_CONCAT(b.SEAT_NO) AS seatnos, 
    m.NAME AS moviename, 
    b.BOOKING_DATE,
    s.DATE AS show_date,
    s.SHOW_TIME AS show_time
    -- m.STATUS AS movie_status,
    -- s.STATUS AS schedule_status
            FROM 
                booking b
            JOIN 
                user u ON b.U_ID = u.U_ID
            JOIN 
                schedules s ON b.S_ID = s.S_ID
            JOIN 
                movies m ON s.M_ID = m.M_ID
            WHERE
                DATE(s.DATE) >= CURDATE()  -- Filter to show details where the date has not expired
                AND m.STATUS = 0  -- Filter to show only movies with status 0
    AND s.STATUS = 0  -- Filter to show only schedules with status 0
            GROUP BY
                u.U_ID, s.S_ID";

    // Check if a search query is provided
    if(isset($_GET['search'])) {
        $search = $_GET['search'];
        $sql .= " HAVING username LIKE '%$search%' OR moviename LIKE '%$search%' OR bookingId LIKE '%$search%' OR seatnos LIKE '%$search%'";
    }

    $result = $db->query($sql);
    ?>

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <title>Movie Booking Details</title>
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #7393B3;
                
            }

            .search-form {
                margin-bottom: 20px;
                text-align: right;
                
            }

            .header2 {
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            text-align: center;
            margin-bottom: 20px;
            border-radius: 15px;
        }

        .no-bookings {
    text-align: center;
    margin-top: 20px;
    font-weight: bold;
    color: #333;
}
        </style>
    </head>
    <body>
    <header class="header2">
        <h2>Movie Booking Details</h2>
    </header>
        <!-- Search Form -->
        <form class="search-form" method="GET">
            <label for="search"></label>
            <input type="text" placeholder="Search Username..."  name="search" id="search" value="<?php echo isset($_GET['search']) ? $_GET['search'] : ''; ?>">
            <button type="submit"><i class="fa fa-search"></i></button>
            
        </form>

        <?php
        // Check if there are any bookings
        if ($result->rowCount() > 0) {
            echo "<table>";
            echo "<tr><th>Booking ID</th><th>Username</th><th>Seat Numbers</th><th>Movie Name</th><th>Show Date</th><th>Show Time</th><th>Booking Date</th></tr>";

            // Output data of each row
            while($row = $result->fetch(PDO::FETCH_ASSOC)) {
                echo "<tr><td>".$row["bookingId"]."</td><td>".$row["username"]."</td><td>".$row["seatnos"]."</td><td>".$row["moviename"]."</td><td>".$row["show_date"]."</td><td>".$row["show_time"]."</td><td>".$row["BOOKING_DATE"]."</td></tr>";
            }

            echo "</table>";
        } else {
            
            echo "<div class='no-bookings'>No bookings found OR try searching username, movie ,ticket </div>";;
        }

        // Close the database connection
        $db = null;
        ?>

    </body>
    </html>

    </div>
</section>           
</div>
  
 <?php
  include("include/footer.php");
    ?>
        <div class="control-sidebar-bg"></div>
        </div>
        
<?php
  include("include/js.php");
?>

</body>
</html> -->
