<?php
$connection = new mysqli("localhost", "root", "", "latihan_flutter");
$KdBrg = $_POST['Kode'];

$result = mysqli_query($connection, "DELETE FROM barang WHERE Kode='$Kode'");

if($result) {
echo json_encode(['message' => 'Data delete successfully']);
} else {
echo json_encode(['message' => 'Data Failed to delete']);
}
?>