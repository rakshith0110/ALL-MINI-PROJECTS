<?php
// Include the database configuration file
include_once 'config.php';
$conn = mysqli_connect($hostname, $username, $password, $database);
// Fetch candidates data from the database
$sql = "SELECT * FROM tbl_candidates";
$result = mysqli_query($conn, $sql);
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Candidates List</title>

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

    cen {
      text-align: center;
    }

    /* Style for candidate sections */
    .candidate-section {
      text-align: center;
      margin-bottom: 80px; /* Increased space between each candidate */
    }

    .candidate-img {
      width: 200px;
      height: 200px;
      border-radius: 50%;
      margin: 0 auto;
    }

    .candidate-name {
      margin-top: 20px;
      font-size: 20px;
      font-weight: bold;
      white-space: nowrap; /* Ensure the name stays in one line */
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .candidate-party {
      margin-top: 10px;
      font-size: 16px;
      font-style: italic;
    }

    .btn-more-details {
      margin-top: 20px;
    }

    /* Flexbox for button container */
    .btn-container {
      display: flex;
      justify-content: center;
      align-items: center;
    }

    /* Margin between buttons */
    .btn-container a {
      margin: 0 5px;
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
        <a href="index.html" class="navbar-brand headerFont text-lg"><strong>Mangalore E-Matdaan 2024</strong></a>
      </div>

      <div class="collapse navbar-collapse" id="example-nav-collapse">
        <ul class="nav navbar-nav">
        </ul>
        <span class="normalFont"><a href="admin.html" class="btn btn-success navbar-right navbar-btn"><strong>Admin Panel</strong></a></span>
      </div>
    </div> <!-- end of container -->
  </nav>

  <div class="container" style="padding:100px;">
    <div class="row">
      <?php
      // Check if there are any candidates
      if (mysqli_num_rows($result) > 0) {
        // Output candidates using a loop
        while ($row = mysqli_fetch_assoc($result)) {
          ?>
          <div class="col-sm-3 candidate-section">
            <img src="<?php echo $row['image_url']; ?>" class="candidate-img img-thumbnail" alt="">
            <h4 class="candidate-name"><?php echo $row['name']; ?></h4>
            <h5 class="candidate-party"><?php echo $row['party_affiliation']; ?> Candidate</h5>
            <!-- Button to fetch more details -->
            <div class="btn-container">
              <a href="<?php echo $row['more_details_url']; ?>" class="btn btn-primary btn-more-details">More Details</a>
            </div>
          </div>
          <?php
        }
      } else {
        // If no candidates found
        echo "<p>No candidates found.</p>";
      }
      ?>
    </div>
  </div>

  <cen><u><h1><a href="index.html">Back to Home</a></h1></u></cen>
</div>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- Bootstrap JS -->
<script src="js/bootstrap.min.js"></script>
</body>
</html>

<?php
// Close database connection
mysqli_close($conn);
?>
