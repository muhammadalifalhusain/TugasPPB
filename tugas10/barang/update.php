<?php
$connection = new mysqli("localhost", "root", "", "latihan_flutter");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
// Ambil data dari request POST
$Kode = $_POST['Kode'];
$NamaBarang = $_POST['NamaBarang'];
$HargaBeli = $_POST['HargaBeli'];
$HargaJual = $_POST['HargaJual'];
$Stok = $_POST['Stok'];

// Query untuk update data barang
$query = "UPDATE barang SET NamaBarang='$NamaBarang', HargaBeli='$HargaBeli',
HargaJual='$HargaJual', Stok='$Stok' WHERE Kode='$Kode'";

if (mysqli_query($connection, $query)) {

// Jika update berhasil
echo json_encode(['success' => 1, 'message' => 'Barang berhasil diperbarui!']);
} else {
// Jika query gagal
echo json_encode(['success' => 0, 'message' => 'Gagal memperbarui barang.']);
}
}
?>