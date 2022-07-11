<?php

$user = 'root';
$pass = '';

global $dbh;

$dbh = new PDO('mysql:host=localhost;dbname=citizen', $user, $pass);
