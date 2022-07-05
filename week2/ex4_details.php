<?php

// Update user and password variables according to your system configuration
$user = 'root';
$pass = '';

global $pdo;

$pdo = new PDO('mysql:host=localhost;dbname=company', $user, $pass);

// Call query() method to extract data
$stmt = $pdo->prepare("SELECT * FROM Employee WHERE Dno = ?");
$stmt->execute([$_GET['dnumber']]);

echo '<ul>';
while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
  $fname = $row['Fname'];
  $lname = $row['Lname'];
  echo "<li>$fname $lname</li>";
}
echo '</ul>';
?>

<p><a href="ex4.php">Back to Department page</a></p>