<?php
$connection = new mysqli("localhost", "root", "", "latihan_flutter");

// Cek apakah request method adalah POST dan parameter KdBrg ada
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['Kode'])) {
$Kode = $_POST['Kode']; // Mendapatkan KdBrg dari POST

// Query untuk mengambil data barang berdasarkan KdBrg
$data = mysqli_query($connection, "SELECT * FROM barang WHERE
Kode='$Kode'");

// Cek apakah data ditemukan

if ($data) {
$row = mysqli_fetch_array($data, MYSQLI_ASSOC);

// Mengembalikan data dalam format JSON
echo json_encode($row);
} else {
// Jika barang tidak ditemukan
echo json_encode(['success' => 0, 'message' => 'Barang tidak ditemukan']);
}
} else {
// Jika parameter KdBrg tidak ada atau metode request salah
echo json_encode(['success' => 0, 'message' => 'Parameter Kode tidak valid']);
}
?>