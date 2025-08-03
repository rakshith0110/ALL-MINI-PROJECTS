<?php
// Credentials
$hostname = "localhost";
$username = "root";
$password = "";
$database = "evoting";

// Establish Connection
$conn = mysqli_connect($hostname, $username, $password, $database);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// UserInput Test
function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

// Fetch Data
if(empty($_POST['existingPassword']) || empty($_POST['newPassword']))
{
    $error= "Fields Required.";
}
else
{
    $old= test_input($_POST['existingPassword']);
    $new= test_input($_POST['newPassword']);
}

// Select Database
$db = mysqli_select_db($conn, $database);

// ADD USER NAME FIELD HERE-- FROM SESSION

$sql = "SELECT * FROM tbl_admin WHERE admin_password='".$old."'";
$query = mysqli_query($conn, $sql);
$rows = mysqli_num_rows($query);

if($rows == 1)
{
    // Given Password is Valid
    $sql = "UPDATE tbl_admin SET admin_password=? WHERE admin_username='admin'"; // =============EDIT *SESSSION_SUERNAME *
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "s", $new);
    if(mysqli_stmt_execute($stmt))
    {
        // Successfully Changed
        echo "<img src='images/success.png' width='70' height='70'>";
        echo "<h3 class='text-info specialHead text-center'><strong> SUCCESSFULLY CHANGED.</strong></h3>";
        echo "<a href='cpanel.php' class='btn btn-primary'> <span class='glyphicon glyphicon-ok'></span> <strong> Finish</strong> </a>";
    }
}
else
{
    $error= "Old-Password is Incorrect";

    echo "<img src='images/error.png' width='70' height='70'>";
    echo "<h3 class='text-info specialHead text-center'><strong> $error</strong></h3>";
    echo "<a href='index.html' class='btn btn-primary'> <span class='glyphicon glyphicon-ok'></span> <strong> Finish</strong> </a>";

}

mysqli_close($conn);

?>
