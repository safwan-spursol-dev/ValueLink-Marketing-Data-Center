<?php
if (session_status() === PHP_SESSION_NONE) { session_start(); }

// Conflict Avoidance
if (basename($_SERVER['PHP_SELF']) === 'login.php') { return; }

if (!isset($_SESSION['user_id']) || empty($_SESSION['user_id'])) {
    header("Location: auth/login.php"); exit;
}

if (!isset($pdo)) {
    $db_file = __DIR__ . '/../config/db.php';
    if (file_exists($db_file)) { require_once $db_file; }
}

if (isset($pdo)) {
    try {
        // 🔒 CHECK: is_active column
        $stmtCheck = $pdo->prepare("SELECT is_active FROM users WHERE id = ? LIMIT 1");
        $stmtCheck->execute([$_SESSION['user_id']]);
        $isActive = $stmtCheck->fetchColumn();

        // Agar $isActive 1 nahi hai (Yani 0 hai ya user delete ho gaya)
        if ($isActive != 1) {
            session_unset();
            session_destroy();
            
            echo "<!DOCTYPE html><html><body><script>
                  alert('Your account has been deactivated. Logging out.');
                  window.location.href = 'auth/login.php?err=banned';
                  </script></body></html>";
            exit;
        }
    } catch (Exception $e) { }
}
?>