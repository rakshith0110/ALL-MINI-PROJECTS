<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Panel</title>
    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Ubuntu' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed' rel='stylesheet' type='text/css'>
    <!-- Custom CSS -->
    <style>
        .headerFont {
            font-family: 'Ubuntu', sans-serif;
            font-size: 24px;
        }

        .subFont {
            font-family: 'Raleway', sans-serif;
            font-size: 14px;
        }

        .specialHead {
            font-family: 'Oswald', sans-serif;
        }

        .normalFont {
            font-family: 'Roboto Condensed', sans-serif;
        }
    </style>
</head>
<body>
<div class="container">
    <nav class="navbar navbar-default navbar-fixed-top navbar-inverse" role="navigation">
        <div class="container">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#example-nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="navbar-header">
                <a href="cpanel.php" class="navbar-brand headerFont text-lg"><strong>E-MATDAAN</strong></a>
            </div>
            <div class="collapse navbar-collapse" id="example-nav-collapse">
                <ul class="nav navbar-nav">
                    <!-- 
                    <li><a href="#featuresTab"><span class="subFont"><strong>Features</strong></span></a></li>
                    <li><a href="#feedbackTab"><span class="subFont"><strong>Feedback</strong></span></a></li>
                    <li><a href="#"><span class="subFont"><strong>About</strong></span></a></li>
                    -->
                </ul>
                <button type="submit" class="btn btn-success navbar-right navbar-btn"><span class="normalFont"><strong>Admin Panel</strong></span></button>
            </div>
        </div> <!-- end of container -->
    </nav>
    <div class="container" style="padding-top:150px;">
        <div class="row">
            <div class="col-sm-4"></div>
            <div class="col-sm-4 text-center" style="border:2px solid gray;padding:50px;">
                <?php

                 session_start();

                // Credentials
                $DB_HOST = "localhost";
                $DB_USER = "root";
                $DB_PASSWORD = "";
                $DB_NAME = "evoting";

                // UserInput Test
                function test_input($data)
                {
                    $data = trim($data);
                    $data = stripslashes($data);
                    $data = htmlspecialchars($data);
                    return $data;
                }

                if (empty($_POST['voterId']) || empty($_POST['voterPassword'])) {
                    $error = "Username or Password is Required.";
                    echo "<p class='alert alert-danger'><strong>$error</strong></p>";
                } else {
                    $voter_id = test_input($_POST['voterId']);
                    $password = test_input($_POST['voterPassword']);

                    // Establish Connection
                    $conn = mysqli_connect($DB_HOST, $DB_USER, $DB_PASSWORD, $DB_NAME);
                    if (!$conn) {
                        die("Connection failed: " . mysqli_connect_error());
                    }
                   
                    $sql = "SELECT * FROM evoting.tbl_users WHERE voter_id='".$voter_id."'AND password='".$password."'";
                    $result = mysqli_query($conn, $sql);

                    if (mysqli_num_rows($result) == 1) {
                        // Store voter ID in session
                        $_SESSION['voterId'] = $voter_id;
                        header("location:voteballot.php");
                    } else {
                        $error = "Authentication Failed";
                        echo "<p class='alert alert-danger'><strong>$error</strong></p>";
                        echo "<p class='normalFont text-primary'><strong>Your combination of Username and Password is incorrect. Please try again or contact the system developer.</strong> </p>";
                        echo "<br><a href='voter_login.html' class='btn btn-primary'><span class='glyphicon glyphicon-refresh'></span> <strong>Try Again</strong></a>";
                    }

                    mysqli_close($conn);
                }
                ?>
            </div>
            <div class="col-sm-4"></div>
        </div>
    </div>
</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.min.js"></script>
</body>
</html>
