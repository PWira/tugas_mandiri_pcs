<?php
include('db_query.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $token = $_POST['tokens'];

    // Validasi atau hash password sesuai kebutuhan
    // Contoh validasi sederhana, sesuaikan dengan kebutuhan aplikasi Anda
    $hashedPassword = md5($password);

    $stmt = $bridge->prepare("SELECT * FROM users WHERE username = ? AND password = ?");
    $stmt->bind_param("ss", $username, $hashedPassword);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Login berhasil
        echo json_encode($token);
        $response['status'] = 'success';
        $response['message'] = 'Login successful';
    } else {
        // Login gagal
        $response['status'] = 'error';
        $response['message'] = 'Invalid username or password';
    }

    echo json_encode($response);
} else {
    // Metode HTTP selain POST tidak diizinkan
    echo json_encode(['status' => 'error', 'message' => 'Method not allowed']);
}

$bridge->close();
?>
