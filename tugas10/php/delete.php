<?php
$connection = new mysqli("localhost", "root", "", "latihan_flutter");
$id = $_POST['id'];
$result = mysqli_query($connection, "delete from note where
id=".$id);
if($result){
echo json_encode([
'message' => 'Data delete successfully'
]);
}else{
echo json_encode([
'message' => 'Data Failed to delete'
]);
}
?>