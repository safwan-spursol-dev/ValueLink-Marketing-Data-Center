<?php
require_once 'config/db.php';
require_once 'includes/session_check.php';

$user_id = $_SESSION['user_id'];
$message = "";
$error = "";

// 1. Fetch User Data
$stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
$stmt->execute([$user_id]);
$user = $stmt->fetch();

// 2. Handle Form Submit
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $new_name = trim($_POST['full_name']);
    $current_password = $_POST['current_password'];
    $new_password = $_POST['new_password'];
    $confirm_password = $_POST['confirm_password'];

    // Verify Password First
    if (empty($current_password)) {
        $error = "Please enter Current Password to save changes.";
    } 
    elseif (!password_verify($current_password, $user['password'])) {
        $error = "Incorrect Current Password!";
    } 
    else {
        try {
            // A. Update Name
            if (!empty($new_name) && $new_name !== $user['name']) {
                $stmt = $pdo->prepare("UPDATE users SET name = ? WHERE id = ?");
                $stmt->execute([$new_name, $user_id]);
                $_SESSION['name'] = $new_name;
                $message .= "Name updated. ";
            }

            // B. Update Password
            if (!empty($new_password)) {
                if ($new_password !== $confirm_password) {
                    $error = "New passwords do not match!";
                } else {
                    $hash = password_hash($new_password, PASSWORD_DEFAULT);
                    $stmt = $pdo->prepare("UPDATE users SET password = ? WHERE id = ?");
                    $stmt->execute([$hash, $user_id]);
                    $message .= "Password changed. ";
                }
            }

            // C. IMAGE UPLOAD LOGIC
            if (!empty($_FILES['profile_image']['name'])) {
                $target_dir = "assets/images/users/";
                $file_name = time() . "_" . basename($_FILES["profile_image"]["name"]); // Unique Name
                $target_file = $target_dir . $file_name;
                $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));
                
                // Validate Extension
                $allowed_types = ['jpg', 'jpeg', 'png', 'gif'];
                if (in_array($imageFileType, $allowed_types)) {
                    if (move_uploaded_file($_FILES["profile_image"]["tmp_name"], $target_file)) {
                        // DB Update
                        $stmt = $pdo->prepare("UPDATE users SET image = ? WHERE id = ?");
                        $stmt->execute([$file_name, $user_id]);
                        
                        // Session Update (Taaky header foran change ho)
                        $_SESSION['image'] = $file_name;
                        $message .= "Profile Image updated.";
                    } else {
                        $error = "Failed to upload image.";
                    }
                } else {
                    $error = "Only JPG, JPEG, PNG & GIF files are allowed.";
                }
            }

            if (empty($message) && empty($error)) {
                $message = "Nothing to update.";
            }

            // Refresh Data
            $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
            $stmt->execute([$user_id]);
            $user = $stmt->fetch();

        } catch (PDOException $e) {
            $error = "Database Error: " . $e->getMessage();
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
                        <h4 class="mb-sm-0">My Profile</h4>
                    </div>
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-xxl-3">
                    <div class="card mt-n5">
                        <div class="card-body p-4">
                            <div class="text-center">
                                <div class="profile-user position-relative d-inline-block mx-auto mb-4">
                                    <img src="assets/images/users/<?php echo !empty($user['image']) ? $user['image'] : 'default.png'; ?>" 
                                         class="rounded-circle avatar-xl img-thumbnail user-profile-image" 
                                         alt="user-profile-image">
                                </div>
                                <h5 class="fs-16 mb-1"><?php echo htmlspecialchars($user['name']); ?></h5>
                                <p class="text-muted mb-0 text-uppercase"><?php echo $user['role']; ?></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xxl-9">
                    <div class="card mt-xxl-n5">
                        <div class="card-header">
                            <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#"><i class="fas fa-home"></i> Edit Profile</a>
                                </li>
                            </ul>
                        </div>
                        <div class="card-body p-4">
                            
                            <?php if($message): ?>
                                <div class="alert alert-success alert-dismissible fade show">
                                    <?php echo $message; ?>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            <?php endif; ?>
                            <?php if($error): ?>
                                <div class="alert alert-danger alert-dismissible fade show">
                                    <?php echo $error; ?>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            <?php endif; ?>

                            <form action="" method="POST" enctype="multipart/form-data">
                                <div class="row">
                                    
                                    <div class="col-lg-12 mb-4">
                                        <label for="profile_image" class="form-label">Profile Picture</label>
                                        <input type="file" class="form-control" id="profile_image" name="profile_image" accept="image/*">
                                        <small class="text-muted">Allowed: jpg, jpeg, png</small>
                                    </div>

                                    <div class="col-lg-6 mb-3">
                                        <label class="form-label">Full Name</label>
                                        <input type="text" class="form-control" name="full_name" value="<?php echo htmlspecialchars($user['name']); ?>" required>
                                    </div>

                                    <div class="col-lg-6 mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" value="<?php echo htmlspecialchars($user['email']); ?>" disabled>
                                    </div>

                                    <div class="col-lg-12 mt-3"><h5 class="text-muted text-uppercase fs-13">Change Password</h5></div>

                                    <div class="col-lg-6 mb-3">
                                        <label class="form-label">New Password</label>
                                        <input type="password" class="form-control" name="new_password" placeholder="Leave blank to keep current">
                                    </div>
                                    <div class="col-lg-6 mb-3">
                                        <label class="form-label">Confirm New Password</label>
                                        <input type="password" class="form-control" name="confirm_password">
                                    </div>

                                    <div class="col-lg-12 mt-3">
                                        <div class="alert alert-warning border-0">
                                            <strong>Authentication Required:</strong> Please enter your current password to save changes.
                                        </div>
                                    </div>

                                    <div class="col-lg-12 mb-3">
                                        <label class="form-label">Current Password <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" name="current_password" required>
                                    </div>

                                    <div class="col-lg-12 text-end">
                                        <button type="submit" class="btn btn-primary">Save Changes</button>
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