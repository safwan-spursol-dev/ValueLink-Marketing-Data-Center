<?php
require_once '../db.php';

if (isset($_GET['token'])) {
    $token = $_GET['token'];

    $stmt = $pdo->prepare("SELECT * FROM users WHERE reset_token=? AND reset_token_expiry > NOW()");
    $stmt->execute([$token]);
    $user = $stmt->fetch();

    if ($user && $_SERVER['REQUEST_METHOD'] === 'POST') {
        $new_pass = password_hash($_POST['password'], PASSWORD_DEFAULT);
        $pdo->prepare("UPDATE users SET password=?, reset_token=NULL, reset_token_expiry=NULL WHERE id=?")
            ->execute([$new_pass, $user['id']]);
        echo "Password reset successful.";
        exit;
    }
} else {
    die("Invalid or expired token.");
}
?>
<form method="POST">
    <input type="password" name="password" placeholder="New Password">
    <button type="submit">Reset Password</button>
</form>
