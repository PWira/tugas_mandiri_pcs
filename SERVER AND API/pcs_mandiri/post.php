<?php
include('db_query.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $data = $_POST;
    $pid = $data['pid'];
    $usid = $data['usid'];

    $title = $data['title'];
    $jumlahlike = $data['jumlahlike'];
    $content = $data['content'];
    // $comment = $data['comment'];
    $img_ = $_FILES['img']['name'];
    $tempname_ = $_FILES['img']['tmp_name'];
    $imgFolder = 'DATABASES/img/';
    $contentFolder = 'DATABASES/content/';
    // $commentFolder = 'DATABASES/comment/';

    $imgPath = $imgFolder . $img_;
    move_uploaded_file($tempname_, $imgPath);

    $contentPath = $contentFolder . $title . '.txt';
    file_put_contents($contentPath, $content);
    
    // $commentPath = $commentFolder . $usid . "_" . $pid . "_" . $title . '.txt';
    // file_put_contents($commentPath, $comment);

    switch (true) {
        case $imgPath != null && $title != null && $contentPath != null:
            $stmt = mysqli_prepare($bridge, "INSERT INTO post (img, title, content) VALUES (?, ?, ?)");
            mysqli_stmt_bind_param($stmt, "sss", $imgPath, $title, $contentPath);
            mysqli_stmt_execute($stmt);
            mysqli_stmt_close($stmt);

            if ($stmt) {
                $response['status'] = 'success';
                $response['message'] = 'Data upload success';
            } else {
                $response['status'] = 'error';
                $response['message'] = 'Data failed to upload';
            }
            break;
        
        case $pid != null:
            $stmt = mysqli_prepare($bridge, "UPDATE post SET jumlahlike = jumlahlike + ? WHERE pid = ?");
            mysqli_stmt_bind_param($stmt, "ii", $jumlahlike, $pid);
            mysqli_stmt_execute($stmt);
            mysqli_stmt_close($stmt);
        
            if ($stmt) {
                $response['status'] = 'success';
                $response['message'] = 'like success!';
            } else {
                $response['status'] = 'error';
                $response['message'] = 'Error like!';
            }
            break;
        
        // case $comment != null:
        //     $finding = mysqli_query($bridge, "SELECT usid FROM users WHERE tokens='$tokens'");

        //     $stmt = mysqli_prepare($bridge, "INSERT INTO comment (usid, pid, comment) VALUES (?, ?, ?)");
        //     mysqli_stmt_bind_param($stmt, "ccc", $finding, $pid, $commentPath);
        //     mysqli_stmt_execute($stmt);
        //     mysqli_stmt_close($stmt);

        //     if ($stmt) {
        //         $response['status'] = 'success';
        //         $response['message'] = 'Success commented';
        //     } else {
        //         $response['status'] = 'error';
        //         $response['message'] = 'Failed to comment + ratio';
        //     }
        //     break;

        default:
            return;
            break;
    }

    echo json_encode($response);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Method not allowed']);
}

$bridge->close();
?>
