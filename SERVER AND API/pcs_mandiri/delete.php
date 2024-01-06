<?php
include('db_query.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['id'];

    $result = mysqli_query($bridge, "DELETE FROM users WHERE id='$id'");

    if($result){
        echo json_encode(['message'=>'Akun berhasil di Delete']);
    }else {
        echo json_encode(['message'=>'Errors! Internal Data has not been resolved!']);
    }
}
$bridge->close();