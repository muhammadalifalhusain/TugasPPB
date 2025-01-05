<?php
$connection = new mysqli("localhost", "root", "", "latihan_flutter");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
// Ambil data dari request POST
$Kode = $_POST['Kode'];
$NamaBarang = $_POST['NamaBarang'];
$HargaBeli = $_POST['HargaBeli'];
$HargaJual = $_POST['HargaJual'];
$Stok = $_POST['Stok'];

// Query untuk menambahkan data barang
$query = "INSERT INTO barang (Kode, NamaBarang, HargaBeli, HargaJual, Stok) VALUES
('$Kode', '$NamaBarang', '$HargaBeli', '$HargaJual', '$Stok')";

if (mysqli_query($connection, $query)) {
// Jika insert berhasil
echo json_encode(['success' => 1, 'message' => 'Barang berhasil ditambahkan!']);
} else {
// Jika query gagal
echo json_encode(['success' => 0, 'message' => 'Gagal menambahkan barang.']);

}
}
?>