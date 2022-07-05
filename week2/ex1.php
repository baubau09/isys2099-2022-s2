<?php

// Update user and password variables according to your system configuration
$user = 'root';
$pass = '';

global $pdo;

$pdo = new PDO('mysql:host=localhost;dbname=company', $user, $pass);

// print_r($pdo);
var_dump($pdo);