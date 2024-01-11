<?php

$bridge = new mysqli("localhost","root","","pcs_db");
$username = $_POST['username'];

class tokens {
    private $__dakey = "lX1ZPKe3BLwqAXQ1RJk674EltlUqT3UkrVQtC6MALfyrBFRj7X9sL7hcH1IGj3hd" ;
  
    public function getToken() {
      return $this->__dakey;
    }
  }
  
  $mainkey = new tokens();
  
  $secret_token = $mainkey->getToken();


function generateToken($username) {
    global $secret_token;
    // Menggunakan openssl_random_pseudo_bytes untuk menghasilkan string acak
    $random_bytes = openssl_random_pseudo_bytes(32); // Ubah panjang sesuai kebutuhan

    // Konversi string acak ke dalam format hex
    $random_hex = bin2hex($random_bytes);

    $header = json_encode(['typ' => 'JWT', 'alg' => 'HS256']);
    $payload = json_encode(['username' => $username]);

    $base64UrlHeader = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($header));
    $base64UrlPayload = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($payload));

    $signature = hash_hmac('sha256', $base64UrlHeader . "." . $base64UrlPayload, $random_hex, true);
    $base64UrlSignature = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($signature));

    return $base64UrlHeader . "." . $base64UrlPayload . "." . $base64UrlSignature;
}

// Verifikasi Token
function verifyToken($token) {
    global $secret_token;

    list($base64UrlHeader, $base64UrlPayload, $base64UrlSignature) = explode('.', $token);

    $data = $base64UrlHeader . "." . $base64UrlPayload;
    $signature = hash_hmac('sha256', $data, $secret_key, true);
    $base64UrlComputedSignature = str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($signature));

    if ($base64UrlSignature === $base64UrlComputedSignature) {
        $payload = json_decode(base64_decode($base64UrlPayload), true);
        return $payload; // Token valid
    } else {
        return false; // Tanda tangan tidak cocok
    }
}

$token = generateToken($username);