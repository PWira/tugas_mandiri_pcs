<?php
include('db_query.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $hashedPassword = md5($password);

    $stmtCheck = $bridge->prepare("SELECT * FROM users WHERE username = ?");
    $stmtCheck->bind_param("s", $username);
    $stmtCheck->execute();
    $resultCheck = $stmtCheck->get_result();

    if ($resultCheck->num_rows > 0) {
        // Username sudah terdaftar
        $response['status'] = 'error';
        $response['message'] = 'Username already exists';
    } else{
        // user baru
        $stmtInsert = $bridge->prepare("INSERT INTO users (username, password, tokens) VALUES (?, ?, ?)");
        $stmtInsert->bind_param("sss", $username, $hashedPassword, $token);

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
