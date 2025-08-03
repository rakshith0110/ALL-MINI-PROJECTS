<?php
// Include the database configuration file
include_once 'config.php';
$conn = mysqli_connect($hostname, $username, $password, $database);
// Fetch candidates data from the database along with logo URLs
$sql = "SELECT c.*, p.logo_url FROM tbl_candidates c
        LEFT JOIN tbl_party_logos p ON c.party_affiliation = p.party_name";
$result = mysqli_query($conn, $sql);
?>

<<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Candidates List</title>
  <!-- Bootstrap -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link href='http://fonts.googleapis.com/css?family=Ubuntu' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed' rel='stylesheet' type='text/css'>
  <style>
    /* Your CSS styles */
    body {
      font-size: 16px; /* Increase body font size */
    }
    .photo img, .logo img {
      max-width: 150px; /* Increase max-width for photos and logos */
      height: auto; /* Maintain aspect ratio */
    }
    .container {
      margin-top: 15px; /* Increase margin top */
      margin-bottom: 10px; /* Increase margin bottom */
    }
    .table th, .table td {
      padding: 20px; /* Increase padding for table cells */
      font-size: 18px; /* Increase font size for table cells */
      text-align: center; /* Align content horizontally in the middle */
      vertical-align: middle; /* Align content vertically in the middle */
    }
    .vote-button {
      margin-top: 20px; /* Increase margin top for vote buttons */
      font-size: 18px; /* Increase font size for vote buttons */
    }
    @keyframes fadeIn {
      from {
        opacity: 0;
      }
      to {
        opacity: 1;
      }
    }
    .fadeIn {
      animation: fadeIn 1s ease-in-out;
    }
    @keyframes slideIn {
      from {
        transform: translateY(-20px);
        opacity: 0;
      }
      to {
        transform: translateY(0);
        opacity: 1;
      }
    }
    .slideIn {
      animation: slideIn 1s ease-in-out;
    }
    /* Navbar styling */
    header {
      background-color: #343a40; /* Dark background color */
      padding: 15px 0; /* Add padding to the top and bottom */
    }
    .navbar-brand {
      font-size: 28px; /* Increase font size */
      color: #ffffff; /* White text color */
      font-weight: bold; /* Bold font weight */
    }
    .navbar-toggler {
      border-color: #ffffff; /* White border color */
    }
    .navbar-nav .nav-link {
      color: #ffffff; /* White text color for links */
    }
    .navbar-nav .nav-link:hover {
      color: #ffffff; /* White text color for links on hover */
    }
    .navbar-btn {
      margin-left: 10px; /* Adjust margin */
    }
    /* Sign Out button styling */
    .navbar-btn .btn-success {
      background-color: #28a745; /* Green background color */
      border-color: #28a745; /* Green border color */
      font-weight: bold; /* Bold font weight */
    }
    .navbar-btn .btn-success:hover {
      background-color: #218838; /* Darker green background color on hover */
      border-color: #1e7e34; /* Darker green border color on hover */
    }
  </style>
</head>
<body>
<header>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand">Be smart do your part, VOTE!</a>
     
      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav">
          
        </ul>
        <a href="index.html" class="btn btn-success navbar-right navbar-btn"><span class="normalFont"><strong>Sign Out</strong></span></a>
      </div>
    </div>
  </nav>
</header>

<div class="container">
  <!-- Your HTML content -->
  <div class="mt-4">
    <div class="table-responsive">
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>ID</th>
            <th>NAME</th>
            <th class="photo">PHOTO</th>
            <th class="logo">LOGO</th>
            <th>Vote</th>
          </tr>
        </thead>
        <tbody>
          <?php
          while ($row = mysqli_fetch_assoc($result)) {
              echo "<tr class='row-height fadeIn'>";
              echo "<td>" . $row['id'] . "</td>";
              echo "<td>" . $row['name'] . "</td>";
              echo "<td class='photo'><img src='" . $row['image_url'] . "' alt='Photo'></td>";
              echo "<td class='logo'><img src='" . $row['logo_url'] . "' alt='Logo'></td>";
              echo "<td><button class='btn btn-success btn-sm vote-button slideIn' data-id='" . $row['party_affiliation'] . "'>Vote</button></td>";
              echo "</tr>";
          }
          ?>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- Your JavaScript code -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
  // Animate rows on page load
  document.querySelectorAll('.fadeIn').forEach(row => {
    setTimeout(() => {
      row.classList.add('slideIn');
    }, 300); // Delay animation to create staggered effect
  });

  // Handle vote button click event
  document.querySelectorAll('.vote-button').forEach(button => {
    button.addEventListener('click', function() {
      console.log("Button clicked"); // Debug message
      const candidateValue = button.getAttribute('data-id');
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = 'saveVote.php';
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'selectedCandidate';
      input.value = candidateValue;
      form.appendChild(input);
      document.body.appendChild(form);
      form.submit();
    });
  });
</script>
</body>
</html>
