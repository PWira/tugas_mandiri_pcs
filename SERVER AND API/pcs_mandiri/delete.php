<?php
include('db_query.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $usid = $_POST['usid'];
    $pid = $_POST['pid'];

    switch (true) {
        case $usid != null:
            $result = mysqli_query($bridge, "DELETE FROM users WHERE usid='$usid'");

            if($result){
                echo json_encode(['message'=>'Akun berhasil di Delete']);
            }else {
                echo json_encode(['message'=>'Errors! Internal Data has not been resolved!']);
            }
            break;
        
        case $pid != null:
            // Mendapatkan lokasi penyimpanan dari record yang akan dihapus
            $result1 = mysqli_query($bridge, "SELECT img, content FROM post WHERE pid='$pid'");
            $row1 = mysqli_fetch_assoc($result1);
            $storageLocation1 = $row1['img'];
            $storageLocation2 = $row1['content'];
        
            if (file_exists($storageLocation1) && file_exists($storageLocation2)) {
                unlink($storageLocation1);
                unlink($storageLocation2);
        
                $deleteResult = mysqli_query($bridge, "DELETE FROM post WHERE pid='$pid'");
                if ($deleteResult) {
                    echo json_encode(['message' => 'Data berhasil dihapus, dan file dihapus']);
                } else {
                    echo json_encode(['message' => 'Errors! Internal Database has not been resolved!']);
                }
            } else {
                echo json_encode(['message' => 'Data file tidak ditemukan']);
            }
            break;

        default:
            echo json_encode(['message' => 'Invalid request']);
            break;
    }
}
else {
    echo json_encode(['status' => 'error', 'message' => 'Method not allowed']);
}
$bridge->close();