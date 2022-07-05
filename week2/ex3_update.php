<?php

// Update user and password variables according to your system configuration
$user = 'root';
$pass = '';

global $pdo;

$pdo = new PDO('mysql:host=localhost;dbname=company', $user, $pass);

// Check for post back event
if (isset($_POST['act'])) {
  // Call exec() method to update data
  // This example use UPDATE, you can change it to INSERT and DELETE (very similar)

  $dnumber = $_POST['number'];
  $dname = $_POST['name'];

  // Use prepared statement
  $stmt = $pdo->prepare("UPDATE Department SET Dname = ? WHERE Dnumber = ?");
  $stmt->execute([$dname, $dnumber]);
  if ($stmt->rowCount() > 0) {
    echo '<h3>Update successfully</h3>';
  }

}

?>

<form method="post">
<div>
  Enter department number<br>
  <input type="text" name="number">
</div>
<div>
  New department name<br>
  <input type="text" name="name">
</div>
<div>
  <input type="submit" name="act" value="Update">
</div>
</form>
<p><a href="ex2_display.php">View all departments here</a></p>