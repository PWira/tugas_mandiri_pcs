<?php
include('db_query.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Validasi atau hash password sesuai kebutuhan
    // Contoh validasi sederhana, sesuaikan dengan kebutuhan aplikasi Anda
    $hashedPassword = md5($password);

    // Cek apakah username sudah terdaftar
    $stmtCheck = $bridge->prepare("SELECT * FROM users WHERE username = ?");
    $stmtCheck->bind_param("s", $username);
    $stmtCheck->execute();
    $resultCheck = $stmtCheck->get_result();

    if ($resultCheck->num_rows > 0) {
        // Username sudah terdaftar
        $response['status'] = 'error';
        $response['message'] = 'Username already exists';
    } else {
        // Insert user baru
        $stmtInsert = $bridge->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
        $stmtInsert->bind_param("ss", $username, $hashedPassword);

        if ($stmtInsert->execute()) {
            $response['status'] = 'success';
            $response['message'] = 'Registration successful';
        } else {
            $response['status'] = 'error';
            $response['message'] = 'Registration failed';
        }
    }

    echo json_encode($response);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Method not allowed']);
}

$bridge->close();
?>
