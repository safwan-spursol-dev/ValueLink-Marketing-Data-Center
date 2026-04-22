<?php
require_once '../db.php';
session_start();

// Only admins can create users
if ($_SESSION['role'] !== 'admin') {
    die("Access denied.");
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = trim($_POST['name']);
    $email = trim($_POST['email']);
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $role = $_POST['role'];

    // Validate
    if (empty($name) || empty($email) || empty($_POST['password'])) {
        die("All fields are required.");
    }

    try {
        $stmt = $pdo->prepare("INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)");
        $stmt->execute([$name, $email, $password, $role]);
        echo "User created successfully.";
    } catch (PDOException $e) {
        if ($e->getCode() == 23000) {
            echo "Email already exists.";
        } else {
            echo "Error: " . $e->getMessage();
        }
    }
}
?>
<form method="POST">
    <input type="text" name="name" placeholder="Full Name"><br>
    <input type="email" name="email" placeholder="Email"><br>
    <input type="password" name="password" placeholder="Password"><br>
    <select name="role">
        <option value="marketing">Marketing</option>
        <option value="sales">Sales</option>
        <option value="admin">Admin</option>
    </select><br>
    <button type="submit">Create User</button>
</form>
