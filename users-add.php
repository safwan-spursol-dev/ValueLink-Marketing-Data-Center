<?php
// Database connection aur Session check
require_once 'config/db.php';
require_once 'includes/session_check.php';
require_once 'mailer.php';

// Agar form submit hua hai
$message = "";
$error = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = trim($_POST['full_name']);
    $email = trim($_POST['email']);
    $role = $_POST['department'];
    $password = $_POST['password']; // Ye plain password hum email me bhejenge
    $confirm_password = $_POST['confirm_password'];

    // Basic Validation
    if (empty($name) || empty($email) || empty($password)) {
        $error = "All fields are required!";
    } elseif ($password !== $confirm_password) {
        $error = "Passwords do not match!";
    } else {
        // Check if email already exists
        $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
        $stmt->execute([$email]);
        
        if ($stmt->rowCount() > 0) {
            $error = "Email already exists!";
        } else {
            // Password Hashing (Database me secure password jayega)
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);

            try {
                // Insert into Database
                $sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
                $stmt = $pdo->prepare($sql);
                
                if ($stmt->execute([$name, $email, $hashed_password, $role])) {
                    
                    // ==========================================
                    // START: EMAIL TRIGGER LOGIC
                    // ==========================================
                    
                  // Email Content
                    $subject = "Welcome to VMDC Team - Registration Details";
                                
                    // HTML Body for better look
                    $msg = "
                    <h3>Dear $name,</h3>
                    <p>You have been registered in the <strong>" . ucfirst($role) . "</strong> department.</p>
                    <p>Here are your login credentials:</p>
                    <ul>
                        <li><strong>Email:</strong> $email</li>
                        <li><strong>Password:</strong> $password</li>
                    </ul>
                    <br>
                    <p style='color:red;'><strong>NOTE:</strong> Do not share this info with others!</p>
                    <p>Regards,<br>VMDC Admin Team</p>
                    ";
                                
                    // Call our Custom Function
                    $emailStatus = sendMail($email, $name, $subject, $msg);
                                
                    if ($emailStatus === true) {
                        $message = "User created and Email sent successfully!";
                    } else {
                        $message = "User created but Email Failed: " . $emailStatus;
                    }

                    // ==========================================
                    // END: EMAIL TRIGGER LOGIC
                    // ==========================================

                } else {
                    $error = "Something went wrong.";
                }
            } catch (PDOException $e) {
                $error = "Database Error: " . $e->getMessage();
            }
        }
    }
}

require_once 'includes/header.php';
?>

<div class="main-content">

    <div class="page-content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Add New User</h4>

                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                                <li class="breadcrumb-item active">Add User</li>
                            </ol>
                        </div>

                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header align-items-center d-flex">
                            <h4 class="card-title mb-0 flex-grow-1">Create Team Member</h4>
                        </div><div class="card-body">
                            
                            <?php if($message): ?>
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <strong>Success!</strong> <?php echo $message; ?>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            <?php endif; ?>

                            <?php if($error): ?>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <strong>Error!</strong> <?php echo $error; ?>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            <?php endif; ?>

                            <form action="" method="POST">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="full_name" class="form-label">Full Name</label>
                                        <input type="text" class="form-control" id="full_name" name="full_name" placeholder="Enter full name" required>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="email" class="form-label">Email Address</label>
                                        <input type="email" class="form-control" id="email" name="email" placeholder="name@example.com" required>
                                    </div>

                                    <div class="col-md-12 mb-3">
                                        <label for="department" class="form-label">Department (Role)</label>
                                        <select class="form-select" id="department" name="department" required>
                                            <option value="" selected disabled>Select Department</option>
                                            <option value="marketing">Marketing Team (Add Leads)</option>
                                            <option value="sales">Sales Team (Manage Status)</option>
                                            <option value="admin">Admin (Full Access)</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="confirm_password" class="form-label">Confirm Password</label>
                                        <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Confirm password" required>
                                    </div>

                                    <div class="col-lg-12 mt-3">
                                        <div class="text-end">
                                            <button type="submit" class="btn btn-primary">Create User & Send Email</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        </div>
    <?php require_once 'includes/footer.php'; ?>