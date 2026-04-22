<?php
require_once '../db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if ($user) {
        $token = bin2hex(random_bytes(32));
        $expiry = date('Y-m-d H:i:s', strtotime('+1 hour'));

        $pdo->prepare("UPDATE users SET reset_token=?, reset_token_expiry=? WHERE id=?")
            ->execute([$token, $expiry, $user['id']]);

        $reset_link = "http://localhost/vmdc-app/auth/reset_password.php?token=$token";
        echo "Password reset link (simulate email): <a href='$reset_link'>$reset_link</a>";
    } else {
        echo "Email not found.";
    }
}
?>
<form method="POST">
    <input type="email" name="email" placeholder="Enter your email">
    <button type="submit">Send Reset Link</button>
</form>
