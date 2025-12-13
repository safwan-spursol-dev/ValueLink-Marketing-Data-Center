<?php
session_start();

if (!isset($_SESSION['user_id'])) {
    header("Location: auth/login.php");
    exit;
}

// Optional: Restrict page access by role
function require_role($allowed_roles = []) {
    if (!in_array($_SESSION['role'], $allowed_roles)) {
        die("Access denied.");
    }
}
