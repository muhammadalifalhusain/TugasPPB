<?php
$connection = new mysqli("localhost", "root", "", "latihan_flutter");
$title = $_POST['title'];
$content = $_POST['content'];
$date = date('Y-m-d-H');
$result = mysqli_query($connection, "insert into note set
title='$title', content='$content', date='$date'");
if($result){
echo json_encode([
'message' => 'Data input successfully'
]);
}else{
echo json_encode([
'message' => 'Data Failed to input'
]);
}
?>