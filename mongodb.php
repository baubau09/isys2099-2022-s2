<?php

// MongoDB stuff
require_once 'vendor/autoload.php';

$client = new MongoDB\Client('mongodb://localhost:27017');
$collection = $client->db_test->product;

// MySQL stuff
$user = 'root';
$pass = '';

global $dbh;

$pdo = new PDO('mysql:host=localhost;dbname=test', $user, $pass);

// Use fixed values now
// You should read them from $_GET or $_POST

$id = 2;
$name = 'phone';
$price = 999.2;
$attributes = ['4G' => 'true', '2SIM' => 'Yes', 'brand' => 'Nokia'];


// Use prepared statement to insert records
$stmt = $pdo->prepare("INSERT INTO product(id, name, price) VALUES(?, ?, ?)");
$stmt->execute([$id, $name, $price]);

// Use insertOne to insert a collection
$res = $collection->insertOne([
  '_id' => $id,
  'attributes' => $attributes
]);


// Use find() to find a document
$document = $collection->find(['_id' => $id]);

foreach ($document as $one) {
  echo 'ID : ' . $one['_id'] . '<br>';
  
  // Use for loop to extract the keys and values
  foreach ($one['attributes'] as $key => $val) {
    echo "$key : $val " . '<br>';
  }
}

// Sample code of updateOne(), update() is very similar

/*
$res = $collection->updateOne(
  ['_id' => '3'],
  [
    '$set' => [
      'name' => 'Dang 2',
      'hobbies' => ['Java 2', 'PHP 2', 'Database 2'],
      'job' => ['title' => 'Developer 2', 'place' => 'Google 2', 'from' => '2010 2'],
      'new_attribute_123' => 123
    ]
  ]
);

var_dump($res);
*/
