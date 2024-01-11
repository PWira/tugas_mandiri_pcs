<?php
include('db_query.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $title = $data['title'];
    $content = $data['content'];
    $img_ = $_FILES['img']['name'];
    $tempname_ = $_FILES['img']['tmp_name'];
    $imgFolder = 'DATABASES/'; // Folder untuk gambar
    $contentFolder = 'DATABASES/'; // Folder untuk konten teks

    // Simpan gambar
    $imgPath = $imgFolder . $img_;
    move_uploaded_file($tempname_, $imgPath);

    // Buat file teks baru dengan timestamp sebagai nama file
    $timestamp = time();
    $contentPath = $contentFolder . $timestamp . '.txt';
    file_put_contents($contentPath, $content);

    // Simpan informasi post ke database
    $stmt = mysqli_prepare($bridge, "INSERT INTO post (img, title, content) VALUES (?, ?, ?)");
    mysqli_stmt_bind_param($stmt, "sss", $img_, $title, $contentPath);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);

    if ($stmt) {
        echo json_encode(['message' => 'Data upload success']);
    } else {
        echo json_encode(['message' => 'Data failed to upload']);
    }
}
?>
