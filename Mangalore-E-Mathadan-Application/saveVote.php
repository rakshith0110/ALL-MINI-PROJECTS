<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SUCCESSFULLY VOTED</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <link href='http://fonts.googleapis.com/css?family=Ubuntu' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed' rel='stylesheet' type='text/css'>

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
                <a href="index.html" class="navbar-brand headerFont text-lg"><strong>Mangalore E-MATDAAN 2024</strong></a>
            </div>

            <div class="collapse navbar-collapse" id="example-nav-collapse">
                <ul class="nav navbar-nav">

                </ul>


                
            </div>

        </div> <!-- end of container -->
    </nav>


    <div class="container" style="padding-top:150px;">
        <div class="row">
            <div class="col-sm-4"></div>
            <div class="col-sm-4 text-center" style="border:2px solid gray;padding:50px;">

            <?php

                            session_start(); // Start the session

                            require('config.php');

                            // Check if selectedCandidate is received
                            if(isset($_POST["selectedCandidate"])) {
                                $selection = test_input($_POST["selectedCandidate"]);
                                // Check if voter ID is stored in the session
                                if(isset($_SESSION['voterId'])) {
                                    $voterID = $_SESSION['voterId'];
                                    // Connect to the database
                                    $conn = @mysqli_connect("localhost", "root", "", "evoting");
                                    // Check database connection
                                    if(!$conn) {
                                        die("Couldn't Connect to Database: " . mysqli_connect_error());
                                    }
                                    // Check if voter has already voted
                                    $query = "SELECT * FROM tbl_users WHERE voter_id = '$voterID'";
                                    $result = mysqli_query($conn, $query);

                                    
                                    if ($result && mysqli_num_rows($result) > 0) {
                                        $row = mysqli_fetch_assoc($result);
                                        $voted_for = $row['voted_for'];
                                        if ($voted_for !== null) {
                                            // User has already voted
                                            echo "<img src='images/error.png' width='70' height='70'>";
                                            echo "<h3 class='text-info specialHead text-center'><strong> You have already voted. Multiple votes are not allowed.</strong></h3>";
                                            echo "<a href='index.html' class='btn btn-primary'> <span class='glyphicon glyphicon-ok'></span> <strong> Finish</strong> </a>";  
                                        } else {
                                            // User has not voted yet, insert the vote into the database
                                            $sql = "UPDATE tbl_users SET voted_for = '$selection' WHERE voter_id = '$voterID'";
                                            if(mysqli_query($conn, $sql)) {
                                                // Display success message
                                                echo "<img src='images/success.png' width='70' height='70'>";
                                                echo "<h3 class='text-info specialHead text-center'><strong> YOU'VE  SUCCESSFULLY   VOTED.</strong></h3>";
                                                echo "<a href='index.html' class='btn btn-primary'> <span class='glyphicon glyphicon-ok'></span> <strong> Finish</strong> </a>";
                                            } else {
                                                // Display error message
                                                echo "<img src='images/error.png' width='70' height='70'>";
                                                echo "<h3 class='text-info specialHead text-center'><strong> SORRY! WE'VE SOME ISSUE..</strong></h3>";
                                                echo "<a href='index.html' class='btn btn-primary'> <span class='glyphicon glyphicon-ok'></span> <strong> Finish</strong> </a>";
                                            }
                                        } 
                                    } else {
                                        // No vote found for this user, allow them to vote
                                        // Insert vote into database
                                        $sql = "INSERT INTO tbl_users (voted_for, voter_id) VALUES ('$selection', '$voterID')";
                                        if(mysqli_query($conn, $sql)) {
                                            // Display success message
                                            echo "<img src='images/success.png' width='70' height='70'>";
                                            echo "<h3 class='text-info specialHead text-center'><strong> YOU'VE  SUCCESSFULLY   VOTED.</strong></h3>";
                                            echo "<a href='index.html' class='btn btn-primary'> <span class='glyphicon glyphicon-ok'></span> <strong> Finish</strong> </a>";
                                        } else {
                                            // Display error message
                                            echo "<img src='images/error.png' width='70' height='70'>";
                                            echo "<h3 class='text-info specialHead text-center'><strong> SORRY! WE'VE SOME ISSUE..</strong></h3>";
                                            echo "<a href='index.html' class='btn btn-primary'> <span class='glyphicon glyphicon-ok'></span> <strong> Finish</strong> </a>";
                                        }
                                    }
                                    


                                    // Close database connection
                                    mysqli_close($conn);
                                } else {
                                    // Display message if voter ID is not set in the session
                                    echo "<br>Voter ID not found.";
                                }
                            } else {
                                // Display message if selectedCandidate is not set
                                echo "<br>No candidate selected.";
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
