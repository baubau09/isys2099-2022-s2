<?php

// Update user and password variables according to your system configuration
$user = 'root';
$pass = '';

global $pdo;

$pdo = new PDO('mysql:host=localhost;dbname=company', $user, $pass);

// Call query() method to extract data
$res = $pdo->query("SELECT * FROM Department ORDER BY Dname");
echo '<ul>';
foreach ($res as $row) {
  $number = $row['Dnumber'];
  $name = $row['Dname'];
  echo "<li><a href='ex4_details.php?dnumber=$number'>$number - $name</a></li>";
}
echo '</ul>';
?>
