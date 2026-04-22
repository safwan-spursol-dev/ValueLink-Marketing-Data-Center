<?php
require_once 'config/db.php';
require_once 'includes/session_check.php';

// --- AJAX HANDLER FOR STATUS TOGGLE (No Reload) ---
if (isset($_POST['action']) && $_POST['action'] == 'toggle_ajax') {
    header('Content-Type: application/json'); // Browser ko batao ke ye JSON hai
    
    $id = $_POST['user_id'];
    
    // Check current status
    $stmt = $pdo->prepare("SELECT is_active FROM users WHERE id = ?");
    $stmt->execute([$id]);
    $user = $stmt->fetch();
    
    if ($user) {
        $new_status = ($user['is_active'] == 1) ? 0 : 1;
        
        $update = $pdo->prepare("UPDATE users SET is_active = ? WHERE id = ?");
        $update->execute([$new_status, $id]);
        
        // Success response bhejo new status ke sath
        echo json_encode(['success' => true, 'new_status' => $new_status]);
    } else {
        echo json_encode(['success' => false, 'message' => 'User not found']);
    }
    exit; // Yahan code rok do taaky poora page load na ho
}

// --- UPDATE USER LOGIC (Modal) ---
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action']) && $_POST['action'] == 'update_user') {
    // ... (Ye code same rahega jo pehle diya tha) ...
    // Sirf reference ke liye: Yahan tumhara purana Update User code ayega
    $id = $_POST['user_id'];
    $name = trim($_POST['full_name']);
    $email = trim($_POST['email']);
    $role = $_POST['department'];
    $dept_redirect = $_POST['dept_redirect'];
    
    $password_query = "";
    $params = [$name, $email, $role];

    if (!empty($_POST['password'])) {
        $hashed_password = password_hash($_POST['password'], PASSWORD_DEFAULT);
        $password_query = ", password = ?";
        $params[] = $hashed_password;
    }
    
    $params[] = $id;

    $sql = "UPDATE users SET name = ?, email = ?, role = ? $password_query WHERE id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    header("Location: users-list.php?department=" . $dept_redirect . "&msg=updated");
    exit;
}

// --- DELETE LOGIC ONLY (Toggle Logic ko AJAX me move kardiya hai) ---
if (isset($_GET['action']) && $_GET['action'] == 'delete') {
    $id = $_GET['id'];
    $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
    $stmt->execute([$id]);
    header("Location: users-list.php?department=" . $_GET['dept_redirect'] . "&msg=deleted");
    exit;
}

// --- DEPARTMENT FILTER ---
$selected_dept = isset($_GET['department']) ? $_GET['department'] : '';
$users = [];
if ($selected_dept) {
    $stmt = $pdo->prepare("SELECT * FROM users WHERE role = ? ORDER BY id DESC");
    $stmt->execute([$selected_dept]);
    $users = $stmt->fetchAll();
}

require_once 'includes/header.php';
?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Users List</h4>
                        <div class="page-title-right">
                            <form method="GET" action="users-list.php" class="d-flex align-items-center">
                                <label class="me-2 text-muted">Select Department:</label>
                                <select name="department" class="form-select form-select-sm" onchange="this.form.submit()" style="width: 200px;">
                                    <option value="">-- Select --</option>
                                    <option value="marketing" <?php echo ($selected_dept == 'marketing') ? 'selected' : ''; ?>>Marketing Team</option>
                                    <option value="sales" <?php echo ($selected_dept == 'sales') ? 'selected' : ''; ?>>Sales Team</option>
                                    <option value="admin" <?php echo ($selected_dept == 'admin') ? 'selected' : ''; ?>>Admin</option>
                                </select>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <?php if(isset($_GET['msg']) && $_GET['msg']=='updated'): ?>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>User Updated Successfully!</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Team Members</h5>
                        </div>
                        <div class="card-body">
                            <?php if (empty($selected_dept)): ?>
                                <div class="text-center py-5">
                                    <div class="avatar-lg mx-auto mb-4">
                                        <div class="avatar-title bg-light text-primary rounded-circle fs-24">
                                            <i class="ri-filter-fill"></i>
                                        </div>
                                    </div>
                                    <h4>Please select a department to view list</h4>
                                </div>
                            <?php else: ?>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped align-middle table-nowrap mb-0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if (count($users) > 0): ?>
                                                <?php foreach ($users as $user): ?>
                                                    <tr>
                                                        <td class="fw-medium"><?php echo $user['id']; ?></td>
                                                        <td><?php echo htmlspecialchars($user['name']); ?></td>
                                                        <td><?php echo htmlspecialchars($user['email']); ?></td>
                                                        <td class="text-uppercase"><?php echo $user['role']; ?></td>
                                                        <td>
    <span id="status-badge-<?php echo $user['id']; ?>" 
          class="badge <?php echo ($user['is_active'] == 1) ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'; ?> text-uppercase">
        <?php echo ($user['is_active'] == 1) ? 'Active' : 'Inactive'; ?>
    </span>
</td>

<td>
    <div class="d-flex gap-2">
        <button type="button" class="btn btn-sm btn-primary edit-btn"
            data-bs-toggle="modal" 
            data-bs-target="#editUserModal"
            data-id="<?php echo $user['id']; ?>"
            data-name="<?php echo htmlspecialchars($user['name']); ?>"
            data-email="<?php echo htmlspecialchars($user['email']); ?>"
            data-role="<?php echo $user['role']; ?>">
            <i class="ri-pencil-fill"></i> Edit
        </button>

        <button type="button" 
                class="btn btn-sm toggle-btn <?php echo ($user['is_active'] == 1) ? 'btn-warning' : 'btn-success'; ?>" 
                data-id="<?php echo $user['id']; ?>">
            <i class="icon-toggle ri-<?php echo ($user['is_active'] == 1) ? 'lock-fill' : 'lock-unlock-fill'; ?>"></i>
        </button>

        <a href="users-list.php?action=delete&id=<?php echo $user['id']; ?>&dept_redirect=<?php echo $selected_dept; ?>" 
           class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?');">
            <i class="ri-delete-bin-fill"></i>
        </a>
    </div>
</td>
                                                    </tr>
                                                <?php endforeach; ?>
                                            <?php else: ?>
                                                <tr><td colspan="6" class="text-center">No users found.</td></tr>
                                            <?php endif; ?>
                                        </tbody>
                                    </table>
                                </div>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">Edit User Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update_user">
                        <input type="hidden" name="user_id" id="modal_user_id">
                        <input type="hidden" name="dept_redirect" value="<?php echo $selected_dept; ?>">

                        <div class="mb-3">
                            <label for="modal_full_name" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="modal_full_name" name="full_name" required>
                        </div>

                        <div class="mb-3">
                            <label for="modal_email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="modal_email" name="email" required>
                        </div>

                        <div class="mb-3">
                            <label for="modal_department" class="form-label">Department</label>
                            <select class="form-select" id="modal_department" name="department" required>
                                <option value="marketing">Marketing Team</option>
                                <option value="sales">Sales Team</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="modal_password" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="modal_password" name="password" placeholder="Leave blank to keep current password">
                            <small class="text-muted">Only fill this if you want to change the password.</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update User</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <?php require_once 'includes/footer.php'; ?>
    
    <script>
        // Jab bhi koi edit button click ho
        document.querySelectorAll('.edit-btn').forEach(button => {
            button.addEventListener('click', function() {
                // Button se data uthao
                const id = this.getAttribute('data-id');
                const name = this.getAttribute('data-name');
                const email = this.getAttribute('data-email');
                const role = this.getAttribute('data-role');

                // Modal ke inputs me set kardo
                document.getElementById('modal_user_id').value = id;
                document.getElementById('modal_full_name').value = name;
                document.getElementById('modal_email').value = email;
                document.getElementById('modal_department').value = role;
                
                // Password field ko empty kardo taaky ghalti se purana override na ho jaye
                document.getElementById('modal_password').value = '';
            });
        });

        // --- NEW AJAX TOGGLE SCRIPT ---
    document.querySelectorAll('.toggle-btn').forEach(button => {
        button.addEventListener('click', function() {
            const userId = this.getAttribute('data-id');
            const btn = this; // Button ka reference save karo
            const icon = btn.querySelector('.icon-toggle'); // Button ke andar wala icon
            
            // FormData object banao backend bhejne ke liye
            const formData = new FormData();
            formData.append('action', 'toggle_ajax');
            formData.append('user_id', userId);

            // Fetch API use karke backend ko call karo
            fetch('users-list.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json()) // Response ko JSON me convert karo
            .then(data => {
                if (data.success) {
                    const badge = document.getElementById('status-badge-' + userId);

                    // UI Update karo based on new status
                    if (data.new_status == 1) {
                        // Ab user ACTIVE ho gaya hai
                        
                        // 1. Badge Update
                        badge.className = 'badge bg-success-subtle text-success text-uppercase';
                        badge.textContent = 'Active';

                        // 2. Button Update (Ab Deactivate ka option dikhao - Yellow)
                        btn.className = 'btn btn-sm toggle-btn btn-warning';
                        icon.className = 'icon-toggle ri-lock-fill';
                        
                    } else {
                        // Ab user INACTIVE ho gaya hai
                        
                        // 1. Badge Update
                        badge.className = 'badge bg-danger-subtle text-danger text-uppercase';
                        badge.textContent = 'Inactive';

                        // 2. Button Update (Ab Activate ka option dikhao - Green)
                        btn.className = 'btn btn-sm toggle-btn btn-success';
                        icon.className = 'icon-toggle ri-lock-unlock-fill';
                    }
                } else {
                    alert('Error updating status!');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        });
    });
    </script>