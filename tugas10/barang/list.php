<?php
$connection = new mysqli("localhost", "root", "", "latihan_flutter");
$data = mysqli_query($connection, "SELECT * FROM barang");
$data = mysqli_fetch_all($data, MYSQLI_ASSOC);
echo json_encode($data);
error_reporting(E_ALL);
ini_set('display_errors', 1);
?>