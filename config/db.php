<?php
/**
 * Secure Database Connection for VMDC Project
 * --------------------------------------------
 * Uses PDO for prepared statements and error handling
 */

$host = 'localhost';
$dbname = 'vmdc';
$username = 'root';
$password = ''; 
try {
    // Create PDO instance with secure options
    $pdo = new PDO(
        "mysql:host=$host;dbname=$dbname;charset=utf8mb4",
        $username,
        $password,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,  // Throw exceptions on error
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Fetch associative arrays
            PDO::ATTR_EMULATE_PREPARES => false, // Use real prepared statements
        ]
    );

    // Optional: You can check connection
    // echo "Database connected successfully.";

} catch (PDOException $e) {
    // Log error instead of displaying in production
    error_log("Database connection failed: " . $e->getMessage());
    die("Database connection error. Please contact the administrator.");
}
