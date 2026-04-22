<?php
require_once 'config/db.php';
require_once 'includes/session_check.php';

// Access Control: Only Admin
if ($_SESSION['role'] !== 'admin') {
    die("Access Denied: You do not have permission to view logs.");
}

// Fetch Logs with User Details
// Hum 'users' table se join laga rahy hain taaky Action Taker ka naam aur Role mil jaye
$sql = "SELECT logs.*, u.name as action_taker_name, u.role as action_taker_role 
        FROM activity_logs logs 
        LEFT JOIN users u ON logs.user_id = u.id 
        ORDER BY logs.created_at DESC";

$stmt = $pdo->query($sql);
$logs = $stmt->fetchAll();

require_once 'includes/header.php';
?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Activity Logs</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                                <li class="breadcrumb-item active">Logs</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">System Audit Trail</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Date & Time</th>
                                            <th>Action Taker</th>
                                            <th>Action</th>
                                            <th>Description</th>
                                            <th>Lead Details (Snapshot)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php if (count($logs) > 0): ?>
                                            <?php foreach ($logs as $log): ?>
                                                <tr>
                                                    <td style="white-space: nowrap;">
                                                        <?php echo date('d M, Y', strtotime($log['created_at'])); ?><br>
                                                        <small class="text-muted"><?php echo date('h:i A', strtotime($log['created_at'])); ?></small>
                                                    </td>

                                                    <td>
                                                        <span class="fw-medium text-primary">
                                                            <?php echo htmlspecialchars($log['action_taker_name'] ?? 'Unknown User'); ?>
                                                        </span><br>
                                                        <span class="badge bg-light text-body border">
                                                            <?php echo ucfirst(htmlspecialchars($log['action_taker_role'] ?? 'N/A')); ?>
                                                        </span>
                                                    </td>

                                                    <td>
                                                        <?php 
                                                            $type = $log['action_type'];
                                                            $badgeClass = 'secondary';
                                                            if($type == 'Status Update') $badgeClass = 'warning';
                                                            if($type == 'Note Added') $badgeClass = 'info';
                                                            if($type == 'Deleted') $badgeClass = 'danger';
                                                        ?>
                                                        <span class="badge bg-<?php echo $badgeClass; ?>-subtle text-<?php echo $badgeClass; ?>">
                                                            <?php echo htmlspecialchars($type); ?>
                                                        </span>
                                                    </td>

                                                    <td>
                                                        <?php echo htmlspecialchars($log['description']); ?>
                                                    </td>

                                                    <td>
                                                        <small class="d-block text-muted"><strong>Form:</strong> <?php echo htmlspecialchars($log['lead_form']); ?></small>
                                                        <small class="d-block text-muted"><strong>Name:</strong> <?php echo htmlspecialchars($log['lead_name']); ?></small>
                                                        <small class="d-block text-muted"><strong>Email:</strong> <?php echo htmlspecialchars($log['lead_email']); ?></small>
                                                        <small class="d-block text-muted"><strong>Received:</strong> <?php echo date('d M, Y', strtotime($log['lead_created_at'])); ?></small>
                                                    </td>
                                                </tr>
                                            <?php endforeach; ?>
                                        <?php else: ?>
                                            <tr>
                                                <td colspan="5" class="text-center text-muted">No activity recorded yet.</td>
                                            </tr>
                                        <?php endif; ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <?php require_once 'includes/footer.php'; ?>