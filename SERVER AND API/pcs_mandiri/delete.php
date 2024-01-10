<?php
include('db_query.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $usid = $_POST['usid'];

    $result = mysqli_query($bridge, "DELETE FROM users WHERE usid='$usid'");

    if($result){
        echo json_encode(['message'=>'Akun berhasil di Delete']);
    }else {
        echo json_encode(['message'=>'Errors! Internal Data has not been resolved!']);
    }
}
$bridge->close();