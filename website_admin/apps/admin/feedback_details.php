<?php
include("auth.php");
include('../connect/db.php');
$Log_Id = $_SESSION['SESS_ADMIN_ID'];

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['delete'])) {
    $selectedFeedbackIds = $_POST['feedback_ids'] ?? [];
    if (!empty($selectedFeedbackIds)) {
        $placeholders = implode(',', array_fill(0, count($selectedFeedbackIds), '?'));
        $deleteQuery = "DELETE FROM feedback WHERE F_ID IN ($placeholders)";
        $deleteStatement = $db->prepare($deleteQuery);
        $deleteStatement->execute($selectedFeedbackIds);
        // Optionally, you can redirect or display a success message after deletion
        
    }
}

?>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


    <title>Navy welfare</title>
    <link rel="icon" type="image/x-icon" href="../../images/favicon.ico">
       <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .print-btn {
            float: right;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            text-decoration: none;
            font-size: 1.2em;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s;
        }

        .print-btn:hover {
            background-color: #0056b3;
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            /* Align table in the center */
            border: 1px solid #ddd; /* Add border to the table */
        }

        th,
        td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
            
        }

        th {
            background-color: #333;
            color: #fff;
        }

        @media print {
            .print-btn {
                display: none;
            }
            .delete-button-container {
        display: none;
    }
    .button-container {
        display: none;

    }

        }

        .header2 {
            background-color: #333;
            color: #fff;
            padding: 10px 20px;
            text-align: center;
            margin-bottom: 10px;
            border-radius: 20px;
            height: 110px;
        }

        .print-icon {
            color: black;
        }

        .table-container {
            overflow-x: auto;
        }

        .table-container table {
            width: 100%;
            min-width: 800px;
            /* Set a minimum width to prevent collapsing too much */
        }

        .select-all-checkbox {
            text-align: center;
            width: 5%;
        }

        /* CSS for the button */
        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
        }

        button:hover {
            background-color: #0056b3;
        }

        /* CSS for the icon */
        .back-icon {
            margin-right: 5px;
        }
        button a {
        color: white;
        text-decoration: none; /* Remove underline from the link */
    }

    .button-container {
        text-align: left; /* Align the button to the left */
    }
    </style>
</head>

<body>
<header class="header2">
        <div class="button-container">
            <a href="feedback.php"><button><i class="fas fa-arrow-left back-icon"></i>Back</button></a>
        </div>
        <h1>Feedback Details</h1>
    </header>
        <div class="container">

        <div>
            Start Date: <input type="date" id="start-date" name="start_date">
            End Date: <input type="date" id="end-date" name="end_date">
            <button onclick="filterByDate()">Filter</button>
        </div>

        <div class="table-container">
            <form method="post" action="">
                <table>
                <colgroup>
        <col style="width: 5%;">
        <col style="width: 15%;">
        <col style="width: 15%;">
        <col style="width: 30%;">
        <col style="width: 15%;">
        <col style="width: 10%;">
    </colgroup>
                    <thead>
                    <tr>
        <th style="text-align:center; width: 5%; border: 1px solid #ddd;">S.No.</th>
        <th style="text-align:center; width: 15%; border: 1px solid #ddd;">Name</th>
        <th style="text-align:center; width: 15%; border: 1px solid #ddd;">Rating</th>
        <th style="border: 1px solid #ddd; width: 30%;">Feedback</th>
        <th style="text-align:center; width: 15%; border: 1px solid #ddd;">Date</th>
        <th style="text-align:center; width: 10%; border: 1px solid #ddd;" class="select-all-checkbox">
            <input type="checkbox" id="select-all-checkbox" onclick="toggleSelectAll()">
        </th>
    </tr>
                    </thead>
                    <tbody id="feedback-table-body">
                        <?php
                        try {
                            // Assuming $db is your PDO database connection

                            // Parse the query parameter to get the service
                            $service = $_GET['service'];

                            // Fetch feedback data from the database based on the selected service and date range
                            $startDate = $_GET['start_date'] ?? null;
                            $endDate = $_GET['end_date'] ?? null;

                            $query = "SELECT f.F_ID, u.NAME, f.RATING, f.DESCRIPTION, f.DATE
                                      FROM feedback f
                                      INNER JOIN user u ON f.U_ID = u.U_ID
                                      WHERE f.SERVICES = :service";

                            if ($startDate && $endDate) {
                                $query .= " AND f.DATE BETWEEN :start_date AND :end_date";
                            }

                            $query .= " ORDER BY f.DATE DESC"; // Order by feedback date in descending order

                            $statement = $db->prepare($query);
                            $statement->bindParam(':service', $service);
                            if ($startDate && $endDate) {
                                $statement->bindParam(':start_date', $startDate);
                                $statement->bindParam(':end_date', $endDate);
                            }
                            $statement->execute();
                            $feedbackData = $statement->fetchAll(PDO::FETCH_ASSOC);
                            echo "<center><h1>" . $service . "</h1></center>";

                            // Display the fetched data in the table
                            foreach ($feedbackData as $index => $item) {
                                $ratingStars = str_repeat('★', $item['RATING']) . str_repeat('☆', 5 - $item['RATING']);
                                $row = "<tr><td style='border: 1px solid #ddd;'>" . ($index + 1) . "</td><td style='border: 1px solid #ddd;'>{$item['NAME']}</td><td style='border: 1px solid #ddd;'>{$ratingStars}</td><td style='border: 1px solid #ddd;'>{$item['DESCRIPTION']}</td><td style='text-align:center; width: 15%; border: 1px solid #ddd;'>{$item['DATE']}</td><td style='text-align:center; width: 10%; border: 1px solid #ddd;'><input type=\"checkbox\" name=\"feedback_ids[]\" value=\"{$item['F_ID']}\"></td></tr>";
                                echo $row;
                            }
                            
                        } catch (PDOException $e) {
                            echo "Error: " . $e->getMessage();
                        }
                        ?>
                    </tbody>
                </table>
                <button class="print-btn" onclick="window.print()" style="color: black; background-color: white;"><i class="fas fa-print">PRINT</i></button>
                <button class="delete-button-container" type="submit" name="delete" onclick="showAlert()">Delete Selected</button>
                    <!-- </div> -->
            </form>
        </div>
    </div>

    <script>
        function showAlert() {
            // Display the alert message
            alert("Are you sure you want to delete the selected feedback?");
        }

        function filterByDate() {
            var startDate = document.getElementById("start-date").value;
            var endDate = document.getElementById("end-date").value;
            window.location.href = "feedback_details.php?service=<?php echo $service; ?>&start_date=" + startDate + "&end_date=" + endDate;
        }

        function toggleSelectAll() {
            var checkboxes = document.querySelectorAll('input[name="feedback_ids[]"]');
            var selectAllCheckbox = document.getElementById("select-all-checkbox");
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = selectAllCheckbox.checked;
            });
        }
    </script>
</body>

</html>
