<?php
require_once 'config/db.php';

if (session_status() === PHP_SESSION_NONE) { session_start(); }

header('Content-Type: application/json');

// Agar user login nahi hai, to Guest hai
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['status' => 'guest']);
    exit;
}

try {
    // 🔒 CHECK: is_active column
    $stmt = $pdo->prepare("SELECT is_active FROM users WHERE id = ?");
    $stmt->execute([$_SESSION['user_id']]);
    $isActive = $stmt->fetchColumn();

    // Agar 1 nahi hai (0 hai) -> BANNED
    if ($isActive != 1) {
        session_unset();
        session_destroy();
        echo json_encode(['status' => 'banned']);
    } else {
        echo json_encode(['status' => 'active']);
    }

} catch (Exception $e) {
    echo json_encode(['status' => 'guest']);
}