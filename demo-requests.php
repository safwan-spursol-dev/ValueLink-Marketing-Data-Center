<?php
require_once 'config/db.php'; 
require_once 'includes/session_check.php';

$msg = "";
$user_role = $_SESSION['role'] ?? 'marketing';
$user_id = $_SESSION['user_id'];

// =========================================================
// 1. BACKEND HANDLERS (DELETE, AJAX STATUS, NOTES, QUAL)
// =========================================================

// A. HANDLE DELETE
if (isset($_GET['action']) && $_GET['action'] == 'delete' && isset($_GET['id'])) {
    if ($user_role === 'admin') {
        $id = $_GET['id'];
        $stmt = $pdo->prepare("SELECT * FROM leads WHERE id = ?");
        $stmt->execute([$id]);
        $lead = $stmt->fetch();
        if ($lead) {
            $logStmt = $pdo->prepare("INSERT INTO activity_logs (user_id, lead_id, lead_name, lead_email, lead_form, lead_created_at, action_type, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $logStmt->execute([$user_id, $id, $lead['client_name'], $lead['email'], $lead['form_name'], $lead['created_at'], 'Deleted', "Permanently deleted the lead."]);
            $delStmt = $pdo->prepare("DELETE FROM leads WHERE id = ?");
            $delStmt->execute([$id]);
        }
        header("Location: demo-requests.php?msg=deleted");
        exit;
    } else { die("Access Denied"); }
}

// B. AJAX: UPDATE STATUS
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action']) && $_POST['action'] == 'update_status_ajax') {
    header('Content-Type: application/json');
    if ($user_role === 'marketing') { echo json_encode(['success' => false, 'error' => 'Permission Denied']); exit; }
    $lead_id = $_POST['lead_id'];
    $new_status = $_POST['status'];
    try {
        $stmt = $pdo->prepare("SELECT status, client_name, email, form_name, created_at FROM leads WHERE id = ?");
        $stmt->execute([$lead_id]);
        $lead = $stmt->fetch();
        if ($lead && $lead['status'] !== $new_status) {
            $updateStmt = $pdo->prepare("UPDATE leads SET status = ? WHERE id = ?");
            $updateStmt->execute([$new_status, $lead_id]);
            $desc = "Changed status to '" . ucfirst($new_status) . "'";
            $logStmt = $pdo->prepare("INSERT INTO activity_logs (user_id, lead_id, lead_name, lead_email, lead_form, lead_created_at, action_type, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $logStmt->execute([$user_id, $lead_id, $lead['client_name'], $lead['email'], $lead['form_name'], $lead['created_at'], 'Status Update', $desc]);
        }
        echo json_encode(['success' => true, 'new_status' => $new_status]);
    } catch (PDOException $e) { echo json_encode(['success' => false, 'error' => $e->getMessage()]); }
    exit;
}

// C. AJAX: UPDATE QUALIFICATION
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action']) && $_POST['action'] == 'update_qualification_ajax') {
    header('Content-Type: application/json');
    if ($user_role === 'marketing') { echo json_encode(['success' => false, 'error' => 'Permission Denied']); exit; }
    $lead_id = $_POST['lead_id'];
    $qualification = $_POST['qualification'];
    try {
        $stmt = $pdo->prepare("SELECT qualification_scale, client_name, email, form_name, created_at FROM leads WHERE id = ?");
        $stmt->execute([$lead_id]);
        $lead = $stmt->fetch();
        if ($lead && $lead['qualification_scale'] !== $qualification) {
            $updateStmt = $pdo->prepare("UPDATE leads SET qualification_scale = ? WHERE id = ?");
            $updateStmt->execute([$qualification, $lead_id]);
            $desc = "Changed Qualification Scale to '" . ($qualification ? $qualification : 'Unassigned') . "'";
            $logStmt = $pdo->prepare("INSERT INTO activity_logs (user_id, lead_id, lead_name, lead_email, lead_form, lead_created_at, action_type, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $logStmt->execute([$user_id, $lead_id, $lead['client_name'], $lead['email'], $lead['form_name'], $lead['created_at'], 'Qualification Update', $desc]);
        }
        echo json_encode(['success' => true]);
    } catch (PDOException $e) { echo json_encode(['success' => false, 'error' => $e->getMessage()]); }
    exit;
}

// D. AJAX: ADD NOTE
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action']) && $_POST['action'] == 'add_note_ajax') {
    header('Content-Type: application/json');
    if ($user_role === 'marketing') { echo json_encode(['success' => false, 'error' => 'Permission Denied']); exit; }
    $lead_id = $_POST['lead_id'];
    $note_text = trim($_POST['note']);
    if (!empty($note_text)) {
        try {
            $stmt = $pdo->prepare("INSERT INTO lead_notes (lead_id, user_id, note) VALUES (?, ?, ?)");
            $stmt->execute([$lead_id, $user_id, $note_text]);
            echo json_encode(['success' => true]);
        } catch (PDOException $e) { echo json_encode(['success' => false, 'error' => $e->getMessage()]); }
    } else { echo json_encode(['success' => false, 'error' => 'Empty note']); }
    exit;
}

// E. AJAX: FETCH NOTES
if ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET['action']) && $_GET['action'] == 'fetch_notes') {
    header('Content-Type: application/json');
    $lead_id = $_GET['lead_id'];
    $stmt = $pdo->prepare("SELECT ln.note, ln.created_at, u.name as user_name FROM lead_notes ln JOIN users u ON ln.user_id = u.id WHERE ln.lead_id = ? ORDER BY ln.created_at DESC");
    $stmt->execute([$lead_id]);
    $notes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach($notes as &$note) { $note['created_at'] = date('d M, h:i A', strtotime($note['created_at'])); }
    echo json_encode($notes);
    exit;
}

// =========================================================
// 2. FETCH DATA & FILTERS LOGIC
// =========================================================

$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
$limit = isset($_GET['limit']) && is_numeric($_GET['limit']) ? (int)$_GET['limit'] : 10; 
$allowed_limits = [10, 15, 20, 50];
if (!in_array($limit, $allowed_limits)) { $limit = 10; }
$offset = ($page - 1) * $limit;

// Fetch unique Roles and Volumes
$rolesStmt = $pdo->query("SELECT DISTINCT user_role FROM leads WHERE user_role IS NOT NULL AND user_role != '' AND form_name = 'Demo Request Form'");
$uniqueRoles = $rolesStmt->fetchAll(PDO::FETCH_COLUMN);

$volumesStmt = $pdo->query("SELECT DISTINCT order_volume FROM leads WHERE order_volume IS NOT NULL AND order_volume != '' AND form_name = 'Demo Request Form'");
$uniqueVolumes = $volumesStmt->fetchAll(PDO::FETCH_COLUMN);

// ✨ CAPTURE ALL 5 FILTERS ✨
$date_range    = isset($_GET['date_range']) ? $_GET['date_range'] : ''; 
$selected_role = isset($_GET['role_filter']) ? $_GET['role_filter'] : ''; 
$selected_vol  = isset($_GET['volume_filter']) ? $_GET['volume_filter'] : ''; 
$selected_qual = isset($_GET['qualification_filter']) ? $_GET['qualification_filter'] : ''; 
$selected_status = isset($_GET['status_filter']) ? $_GET['status_filter'] : ''; 

// ONLY FETCH STRICTLY "Demo Request Form"
$where_clauses = ["leads.form_name = 'Demo Request Form'"];
$params = [];

if (!empty($selected_role)) {
    $where_clauses[] = "leads.user_role = ?";
    $params[] = $selected_role;
}
if (!empty($selected_vol)) {
    $where_clauses[] = "leads.order_volume = ?";
    $params[] = $selected_vol;
}
if (!empty($selected_qual)) {
    $where_clauses[] = "leads.qualification_scale = ?";
    $params[] = $selected_qual;
}
if (!empty($selected_status)) {
    $where_clauses[] = "leads.status = ?";
    $params[] = $selected_status;
}
if (!empty($date_range)) {
    $dates = explode(" to ", $date_range);
    if (count($dates) == 2) {
        $where_clauses[] = "DATE(leads.created_at) BETWEEN ? AND ?";
        $params[] = trim($dates[0]); $params[] = trim($dates[1]); 
    } else {
        $where_clauses[] = "DATE(leads.created_at) = ?";
        $params[] = trim($dates[0]);
    }
}

$where_sql = "WHERE " . implode(" AND ", $where_clauses);

$count_sql = "SELECT COUNT(*) FROM leads $where_sql";
$count_stmt = $pdo->prepare($count_sql);
$count_stmt->execute($params);
$total_leads = $count_stmt->fetchColumn();
$total_pages = ceil($total_leads / $limit);

$sql = "SELECT leads.* FROM leads 
        $where_sql 
        ORDER BY leads.created_at DESC 
        LIMIT $limit OFFSET $offset";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$leads = $stmt->fetchAll(PDO::FETCH_ASSOC);

require_once 'includes/header.php';
?>

<style>
    .table-grouped td { vertical-align: top; padding: 15px; }
    .info-row { margin-bottom: 4px; font-size: 13px; line-height: 1.5; color: #555; }
    .lbl { font-weight: 700; color: #333; margin-right: 4px; }
    .val { font-weight: 400; color: #666; }

    .pagination .page-item .page-link {
        margin: 0 5px; border-radius: 50% !important; width: 35px; height: 35px; 
        display: flex; align-items: center; justify-content: center;
        border: 1px solid #e9ebec; color: #405189; font-weight: 600; font-size: 15px; 
        transition: all 0.3s ease;
    }
    .pagination .page-item .page-link:hover { background-color: #c7c7c7; border-color: #d8dbe0; }
    .pagination .page-item.active .page-link { background-color: #405189; border-color: #405189; color: #fff; }

    /* Qualification Select */
    .qual-select {
        border: 1px solid #ced4da; border-radius: 4px; font-size: 12px;
        padding: 5px 30px 5px 8px; background-position: right 8px center; cursor: pointer;
    }

    /* Status Dropdown behaving like a Badge */
    .status-badge-select {
        border: none !important;
        font-weight: 700;
        text-transform: uppercase;
        font-size: 11px;
        padding: 4px 24px 4px 8px; 
        border-radius: 4px;
        cursor: pointer;
        appearance: none;
        -webkit-appearance: none;
        -moz-appearance: none;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right .5rem center;
        background-size: 10px 10px;
    }
    .status-badge-select:focus {
        outline: none;
        box-shadow: 0 0 0 2px rgba(64,81,137,.25);
    }

    /* ✨ Color styles for status options */
    .status-badge-select option {
        padding: 4px 8px;
        background-color: white;
        color: black;
    }
    .status-badge-select option[value="Customer Already"] {
        background: linear-gradient(#cfe2ff 0%, #cfe2ff 100%);
        color: #084298;
    }
    .status-badge-select option[value="Conversion - MSA Sent"] {
        background: linear-gradient(#fff3cd 0%, #fff3cd 100%);
        color: #664d03;
    }
    .status-badge-select option[value="Not Qualified"] {
        background: linear-gradient(#f8d7da 0%, #f8d7da 100%);
        color: #842029;
    }
    .status-badge-select option[value="Not Sure of Status"] {
        background: linear-gradient(#e2e3e5 0%, #e2e3e5 100%);
        color: #41464b;
    }
    .status-badge-select option[value="MSA Signed"] {
        background: linear-gradient(#d1e7dd 0%, #d1e7dd 100%);
        color: #0f5132;
    }
    .status-badge-select option[value="Demo Done"] {
        background: linear-gradient(#cff4fc 0%, #cff4fc 100%);
        color: #055160;
    }
    .status-badge-select option[value="new"] {
        background: linear-gradient(#cfe2ff 0%, #cfe2ff 100%);
        color: #084298;
    }
</style>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Demo Requests</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                                <li class="breadcrumb-item active">Demo Requests</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <?php if (isset($_GET['msg']) && $_GET['msg'] == 'deleted'): ?>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Lead Deleted Successfully!</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <?php endif; ?>

            <div class="row">
                <div class="col-lg-12 mb-4">
                    <div class="card mb-5">

                        <div class="card-header d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between gap-3">
                            <h5 class="card-title mb-0" style="min-width: 150px;">Demo Requests <br><span id="total-leads-badge" class="badge bg-secondary-subtle text-secondary mt-1"><?php echo $total_leads; ?> Total</span></h5>
                            
                            <form id="filter-form" method="GET" action="demo-requests.php" class="d-flex flex-wrap align-items-center gap-2 w-100 justify-content-md-end">
                                <input type="hidden" name="limit" value="<?php echo $limit; ?>">
                                
                                <div class="input-group input-group-sm" style="flex: 1; min-width: 170px; max-width: 200px;">
                                    <span class="input-group-text bg-light"><i class="ri-calendar-2-line"></i></span>
                                    <input type="text" class="form-control bg-light border-light" name="date_range" id="date_range_picker" placeholder="Date Range" value="<?php echo htmlspecialchars($date_range); ?>">
                                </div>

                                <select class="form-select form-select-sm" name="role_filter" style="flex: 1; min-width: 120px; max-width: 150px;">
                                    <option value="">All Roles</option>
                                    <?php foreach ($uniqueRoles as $role): ?>
                                        <option value="<?php echo htmlspecialchars($role); ?>" <?php echo ($selected_role === $role) ? 'selected' : ''; ?>><?php echo htmlspecialchars($role); ?></option>
                                    <?php endforeach; ?>
                                </select>

                                <select class="form-select form-select-sm" name="volume_filter" style="flex: 1; min-width: 120px; max-width: 160px;">
                                    <option value="">All Volumes</option>
                                    <?php foreach ($uniqueVolumes as $vol): ?>
                                        <option value="<?php echo htmlspecialchars($vol); ?>" <?php echo ($selected_vol === $vol) ? 'selected' : ''; ?>><?php echo htmlspecialchars($vol); ?></option>
                                    <?php endforeach; ?>
                                </select>

                                <select class="form-select form-select-sm" name="qualification_filter" style="flex: 1; min-width: 120px; max-width: 150px;">
                                    <option value="">All MQL</option>
                                    <option value="Qualified" <?php echo ($selected_qual === 'Qualified') ? 'selected' : ''; ?>>Qualified</option>
                                    <option value="Not Qualified" <?php echo ($selected_qual === 'Not Qualified') ? 'selected' : ''; ?>>Not Qualified</option>
                                    <option value="Junk" <?php echo ($selected_qual === 'Junk') ? 'selected' : ''; ?>>Junk</option>
                                </select>

                                <select class="form-select form-select-sm" name="status_filter" style="flex: 1; min-width: 130px; max-width: 180px;">
                                    <option value="">All SQL</option>
                                    <option value="Customer Already" <?php echo ($selected_status === 'Customer Already') ? 'selected' : ''; ?>>Customer Already</option>
                                    <option value="Conversion - MSA Sent" <?php echo ($selected_status === 'Conversion - MSA Sent') ? 'selected' : ''; ?>>Conversion - MSA Sent</option>
                                    <option value="Not Qualified" <?php echo ($selected_status === 'Not Qualified') ? 'selected' : ''; ?>>Not Qualified</option>
                                    <option value="Not Sure of Status" <?php echo ($selected_status === 'Not Sure of Status') ? 'selected' : ''; ?>>Not Sure of Status</option>
                                    <option value="MSA Signed" <?php echo ($selected_status === 'MSA Signed') ? 'selected' : ''; ?>>MSA Signed</option>
                                    <option value="Demo Done" <?php echo ($selected_status === 'Demo Done') ? 'selected' : ''; ?>>Demo Done</option>
                                    <option value="new" <?php echo ($selected_status === 'new' || $selected_status === 'New') ? 'selected' : ''; ?>>New</option>
                                </select>

                                <div class="d-flex gap-2">
                                    <button type="button" id="export-demo-btn" class="btn btn-sm btn-success w-100 w-sm-auto" title="Export to Excel">
                                        <i class="ri-file-excel-2-fill align-bottom me-1"></i> Export
                                    </button>

                                    <span id="filter-reset-btn">
                                        <?php if(!empty($date_range) || !empty($selected_role) || !empty($selected_vol) || !empty($selected_qual) || !empty($selected_status)): ?>
                                            <a href="demo-requests.php" class="btn btn-sm btn-soft-danger w-100 w-sm-auto" title="Clear Filters"><i class="ri-close-line"></i></a>
                                        <?php endif; ?>
                                    </span>
                                </div>
                            </form>
                        </div>

                        <div id="leads-area-wrapper">            
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-grouped align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th width="20%">Contact Info</th>
                                                <th width="25%">Business Details</th>
                                                <th width="20%">Message</th>
                                                <th width="15%">MQL Status</th>
                                                <th width="15%">SQL Status</th>
                                                <th width="5%">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if (count($leads) > 0): ?>
                                                <?php foreach ($leads as $lead): ?>
                                                    <tr>
                                                        <td>
                                                            <div class="info-row"><span class="lbl">Full Name:</span> <span class="val"><?php echo htmlspecialchars($lead['client_name']); ?></span></div>
                                                            <div class="info-row"><span class="lbl">Email:</span> <span class="val"><?php echo htmlspecialchars($lead['email'] ?? 'N/A'); ?></span></div>
                                                            <div class="info-row"><span class="lbl">Phone:</span> <span class="val"><?php echo htmlspecialchars($lead['phone'] ?? 'N/A'); ?></span></div>
                                                        </td>

                                                        <td>
                                                            <div class="info-row"><span class="lbl">Company:</span> <span class="val"><?php echo !empty($lead['company']) ? htmlspecialchars($lead['company']) : 'N/A'; ?></span></div>
                                                            <?php if(!empty($lead['user_role'])): ?><div class="info-row"><span class="lbl">Role:</span> <span class="val"><span class="val"><?php echo htmlspecialchars($lead['user_role']); ?></span></span></div><?php endif; ?>
                                                            <?php if(!empty($lead['order_volume'])): ?><div class="info-row"><span class="lbl">Volume:</span> <span class="val"><?php echo htmlspecialchars($lead['order_volume']); ?></span></div><?php endif; ?>
                                                            <div class="info-row"><span class="lbl">Source Form:</span> <span class="val"><?php echo htmlspecialchars($lead['form_name']); ?></span></div>
                                                        </td>
                                                            
                                                        <td>
                                                            <div class="info-row"><span class="lbl">Message:</span></div>
                                                            <div class="val" style="font-size: 13px; line-height: 1.4;">
                                                                <?php
                                                                $msgText = htmlspecialchars($lead['message'] ?? '');
                                                                if (strlen($msgText) > 80) {
                                                                    echo substr($msgText, 0, 80) . '... <a href="#" data-bs-toggle="modal" data-bs-target="#viewMsgModal" data-msg="'.$msgText.'">Read More</a>';
                                                                } else { echo !empty($msgText) ? $msgText : 'N/A'; }
                                                                ?>
                                                            </div>
                                                            <?php if(!empty($lead['preferred_date'])): ?>
                                                                <div class="info-row mt-2">
                                                                    <span class="lbl">Preferred Date:</span>
                                                                    <span class="val"><?php echo date('d M, Y', strtotime($lead['preferred_date'])); ?></span>
                                                                </div>
                                                            <?php endif; ?>
                                                        </td>

                                                        <td>
                                                            <?php $qual = isset($lead['qualification_scale']) ? $lead['qualification_scale'] : ''; ?>
                                                            <select class="form-select form-select-sm qual-select update-qual-dropdown" data-id="<?php echo $lead['id']; ?>">
                                                                <option value="" <?php echo ($qual === '') ? 'selected' : ''; ?>>- Select Scale -</option>
                                                                <option value="Qualified" <?php echo ($qual === 'Qualified') ? 'selected' : ''; ?>> Qualified</option>
                                                                <option value="Not Qualified" <?php echo ($qual === 'Not Qualified') ? 'selected' : ''; ?>> Not Qualified</option>
                                                                <option value="Junk" <?php echo ($qual === 'Junk') ? 'selected' : ''; ?>> Junk</option>
                                                            </select>
                                                        </td>
                                                            
                                                        <td>
                                                            <?php 
                                                                $st = $lead['status'];
                                                                $cls = 'secondary'; 
                                                                if ($st == 'Customer Already') { $cls = 'info'; }
                                                                elseif ($st == 'Conversion - MSA Sent') { $cls = 'warning'; }
                                                                elseif ($st == 'Not Qualified') { $cls = 'danger'; }
                                                                elseif ($st == 'Not Sure of Status') { $cls = 'secondary'; }
                                                                elseif ($st == 'MSA Signed') { $cls = 'success'; }
                                                                elseif ($st == 'Demo Done') { $cls = 'primary'; }
                                                                elseif ($st == 'new') { $cls = 'info'; $st = 'New'; }
                                                            ?>
                                                            
                                                            <select class="status-badge-select bg-<?php echo $cls; ?>-subtle text-<?php echo $cls; ?> update-status-dropdown w-100 mb-1" data-id="<?php echo $lead['id']; ?>">
                                                                <option value="Customer Already" <?php echo ($st == 'Customer Already') ? 'selected' : ''; ?>>Customer Already</option>
                                                                <option value="Conversion - MSA Sent" <?php echo ($st == 'Conversion - MSA Sent') ? 'selected' : ''; ?>>Conversion - MSA Sent</option>
                                                                <option value="Not Qualified" <?php echo ($st == 'Not Qualified') ? 'selected' : ''; ?>>Not Qualified</option>
                                                                <option value="Not Sure of Status" <?php echo ($st == 'Not Sure of Status') ? 'selected' : ''; ?>>Not Sure of Status</option>
                                                                <option value="MSA Signed" <?php echo ($st == 'MSA Signed') ? 'selected' : ''; ?>>MSA Signed</option>
                                                                <option value="Demo Done" <?php echo ($st == 'Demo Done') ? 'selected' : ''; ?>>Demo Done</option>
                                                                <option value="new" <?php echo ($st == 'New' || $st == 'new') ? 'selected' : ''; ?>>New</option>
                                                            </select>
                                                            
                                                            <div class="mt-2 text-center text-bold" style="font-size: 13px;">
                                                                <i class="ri-calendar-line me-1"></i>
                                                                <?php echo date('d M, Y', strtotime($lead['created_at'])); ?>
                                                            </div>
                                                            
                                                            <div class="mt-2">
                                                                <button class="btn btn-xs btn-soft-info view-notes-btn w-100" 
                                                                    data-bs-toggle="modal" data-bs-target="#notesModal" 
                                                                    data-id="<?php echo $lead['id']; ?>" 
                                                                    data-client="<?php echo htmlspecialchars($lead['client_name']); ?>">
                                                                    <i class="ri-chat-1-line me-1"></i> Notes
                                                                </button>
                                                            </div>
                                                        </td>
                                                            
                                                        <td class="text-center">
                                                            <div class="d-flex flex-column gap-2">
                                                                <?php if ($user_role === 'admin'): ?>
                                                                    <a href="demo-requests.php?action=delete&id=<?php echo $lead['id']; ?>" class="btn btn-sm btn-soft-danger" onclick="return confirm('Delete lead?');"><i class="ri-delete-bin-fill"></i></a>
                                                                <?php endif; ?>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                <?php endforeach; ?>
                                            <?php else: ?>
                                                <tr><td colspan="6" class="text-center text-muted py-4">No Demo Requests found.</td></tr>
                                            <?php endif; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                                            
                            <div class="card-footer border-top-0 py-3">
                                <div class="row align-items-center">
                                    <div class="col-md-4 mb-md-0">
                                        <form method="GET" action="demo-requests.php" class="d-flex align-items-center justify-content-center justify-content-md-start gap-2">
                                            <input type="hidden" name="date_range" value="<?php echo htmlspecialchars($date_range); ?>">
                                            <input type="hidden" name="role_filter" value="<?php echo htmlspecialchars($selected_role); ?>">
                                            <input type="hidden" name="volume_filter" value="<?php echo htmlspecialchars($selected_vol); ?>">
                                            <input type="hidden" name="qualification_filter" value="<?php echo htmlspecialchars($selected_qual); ?>">
                                            <input type="hidden" name="status_filter" value="<?php echo htmlspecialchars($selected_status); ?>">
                                            
                                            <input type="hidden" name="page" value="1"> <span class="text-muted fs-12">Show</span>
                                            <select class="form-select form-select-sm" name="limit" onchange="this.form.submit()" style="width: 70px; text-align: center;">
                                                <?php foreach([10, 15, 20, 50] as $opt): ?><option value="<?php echo $opt; ?>" <?php echo ($limit == $opt) ? 'selected' : ''; ?>><?php echo $opt; ?></option><?php endforeach; ?>
                                            </select>
                                            <span class="text-muted fs-12">of <b><?php echo $total_leads; ?></b> results</span>
                                        </form>
                                    </div>
                                    <div class="col-md-4">
                                        <?php if ($total_pages > 1): ?>
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination pagination-sm mb-0 justify-content-center">
                                                    <?php $params = "&limit=$limit&date_range=".urlencode($date_range)."&role_filter=".urlencode($selected_role)."&volume_filter=".urlencode($selected_vol)."&qualification_filter=".urlencode($selected_qual)."&status_filter=".urlencode($selected_status); ?>
                                                    <li class="page-item <?php echo ($page <= 1) ? 'disabled' : ''; ?>"><a class="page-link" href="?page=<?php echo $page - 1; ?><?php echo $params; ?>" aria-label="Previous"><i class="ri-arrow-left-s-line"></i></a></li>
                                                    <?php 
                                                    $start = max(1, $page - 1); $end = min($total_pages, $page + 1);
                                                    if($page == 1) { $end = min($total_pages, 3); }
                                                    if($page == $total_pages) { $start = max(1, $total_pages - 2); }
                                                    for ($i = $start; $i <= $end; $i++): 
                                                    ?>
                                                        <li class="page-item <?php echo ($i == $page) ? 'active' : ''; ?>"><a class="page-link" href="?page=<?php echo $i; ?><?php echo $params; ?>"><?php echo $i; ?></a></li>
                                                    <?php endfor; ?>
                                                    <li class="page-item <?php echo ($page >= $total_pages) ? 'disabled' : ''; ?>"><a class="page-link" href="?page=<?php echo $page + 1; ?><?php echo $params; ?>" aria-label="Next"><i class="ri-arrow-right-s-line"></i></a></li>
                                                </ul>
                                            </nav>
                                        <?php endif; ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="notesModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title">Notes for <span id="note_client_name" class="text-primary"></span></h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <div class="modal-body">
                    <h6 class="text-muted text-uppercase fs-12 mb-3">History</h6>
                    <div id="notes_list_container" style="max-height: 300px; overflow-y: auto; margin-bottom: 20px;"><div class="text-center text-muted">Loading notes...</div></div>
                    <?php if ($user_role === 'admin' || $user_role === 'sales'): ?>
                        <hr><h6 class="text-muted text-uppercase fs-12 mb-2">Add New Note</h6>
                        <form id="addNoteForm">
                            <input type="hidden" name="lead_id" id="modal_note_lead_id">
                            <div class="mb-2"><textarea class="form-control" name="note" rows="3" placeholder="Type internal note here..." required></textarea></div>
                            <div class="text-end"><button type="submit" class="btn btn-success btn-sm"><i class="ri-save-line"></i> Save Note</button></div>
                        </form>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="viewMsgModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered"><div class="modal-content"><div class="modal-header"><h5 class="modal-title">Full Message</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div><div class="modal-body"><p id="full_msg_content" class="text-muted text-break"></p></div><div class="modal-footer"><button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button></div></div></div>
    </div>

    <?php require_once 'includes/footer.php'; ?>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
    document.addEventListener("DOMContentLoaded", function() {

        // NOTES MODAL
        var notesModal = document.getElementById('notesModal');
        if (notesModal) {
            notesModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget; var leadId = button.getAttribute('data-id');
                document.getElementById('note_client_name').textContent = button.getAttribute('data-client');
                document.getElementById('modal_note_lead_id').value = leadId;
                loadNotes(leadId);
            });
        }
        function loadNotes(leadId) {
            const container = document.getElementById('notes_list_container');
            container.innerHTML = '<div class="text-center text-muted mt-3">Loading...</div>';
            fetch(`demo-requests.php?action=fetch_notes&lead_id=${leadId}`).then(res => res.json()).then(data => {
                container.innerHTML = '';
                if(data.length > 0) {
                    data.forEach(note => { container.innerHTML += `<div class="note-item"><span class="note-meta"><strong>${note.user_name}</strong> - ${note.created_at}</span><div class="note-text">${note.note}</div></div>`; });
                } else { container.innerHTML = '<div class="text-center text-muted py-3">No notes attached yet.</div>'; }
            });
        }
        const addNoteForm = document.getElementById('addNoteForm');
        if(addNoteForm) {
            addNoteForm.addEventListener('submit', function(e) {
                e.preventDefault(); const formData = new FormData(this); formData.append('action', 'add_note_ajax');
                fetch('demo-requests.php', { method: 'POST', body: formData }).then(res => res.json()).then(data => {
                    if(data.success) { this.reset(); loadNotes(document.getElementById('modal_note_lead_id').value); } else { alert('Error: ' + data.error); }
                });
            });
        }

        // VIEW MSG MODAL
        var msgModal = document.getElementById('viewMsgModal');
        if (msgModal) {
            msgModal.addEventListener('show.bs.modal', function (event) {
                document.getElementById('full_msg_content').textContent = event.relatedTarget.getAttribute('data-msg');
            });
        }

        // AJAX FILTERING
        const dateInput = document.querySelector("#date_range_picker");
        if (dateInput) { flatpickr(dateInput, { mode: "range", dateFormat: "Y-m-d", defaultDate: dateInput.value, onClose: function(d, s) { if (s !== "") triggerFilterChange(); } }); }

        const filterForm = document.querySelector("#filter-form");
        if (filterForm) {
            filterForm.addEventListener("change", function(e) { if (e.target.tagName === "SELECT" || e.target.tagName === "INPUT") { e.preventDefault(); triggerFilterChange(); } });
            filterForm.addEventListener("submit", function(e) { e.preventDefault(); triggerFilterChange(); });
        }

        // INLINE DROPDOWN HANDLERS (Status & Qualification)
        const wrapper = document.querySelector("#leads-area-wrapper");
        if (wrapper) {
            wrapper.addEventListener("click", function(e) {
                const link = e.target.closest(".pagination .page-link");
                if (link && !link.closest(".disabled")) { e.preventDefault(); fetchData(link.getAttribute("href")); }
            });

            wrapper.addEventListener("change", function(e) {
                if (e.target.classList.contains('update-status-dropdown')) {
                    const leadId = e.target.getAttribute('data-id');
                    const statusValue = e.target.value;
                    const formData = new FormData();
                    formData.append('action', 'update_status_ajax');
                    formData.append('lead_id', leadId);
                    formData.append('status', statusValue);
                    
                    e.target.style.opacity = '0.5';
                    fetch('demo-requests.php', { method: 'POST', body: formData })
                        .then(res => res.json())
                        .then(data => {
                            if(data.success) { location.reload(); }
                            else { alert('Error: ' + data.error); e.target.style.opacity = '1'; }
                        }).catch(err => { console.error(err); e.target.style.opacity = '1'; });
                }

                if (e.target.classList.contains('update-qual-dropdown')) {
                    const leadId = e.target.getAttribute('data-id');
                    const qualValue = e.target.value;
                    const formData = new FormData();
                    formData.append('action', 'update_qualification_ajax');
                    formData.append('lead_id', leadId);
                    formData.append('qualification', qualValue);

                    e.target.style.opacity = '0.5';
                    fetch('demo-requests.php', { method: 'POST', body: formData })
                        .then(res => res.json())
                        .then(data => {
                            e.target.style.opacity = '1';
                            if(!data.success) { alert('Error updating qualification: ' + data.error); }
                        }).catch(err => { console.error(err); e.target.style.opacity = '1'; });
                }
            });
        }

        function triggerFilterChange() {
            const form = document.querySelector("#filter-form"); if (!form) return;
            const formData = new FormData(form); const params = new URLSearchParams(formData);
            const limitSelect = document.querySelector("select[name='limit']"); if(limitSelect && !formData.has('limit')) { params.set('limit', limitSelect.value); }
            fetchData("demo-requests.php?" + params.toString());
        }

        function fetchData(url) {
            const container = document.querySelector("#leads-area-wrapper");
            container.style.opacity = "0.5"; container.style.pointerEvents = "none";
            fetch(url).then(response => response.text()).then(html => {
                const doc = new DOMParser().parseFromString(html, "text/html");
                container.innerHTML = doc.querySelector("#leads-area-wrapper").innerHTML;
                if(document.querySelector("#total-leads-badge")) document.querySelector("#total-leads-badge").innerHTML = doc.querySelector("#total-leads-badge").innerHTML;
                if(document.querySelector("#filter-reset-btn")) document.querySelector("#filter-reset-btn").innerHTML = doc.querySelector("#filter-reset-btn").innerHTML;
                window.history.pushState({}, "", url);
                container.style.opacity = "1"; container.style.pointerEvents = "auto";
            });
        }

        // ✨ EXPORT BUTTON LOGIC ✨
        const exportBtn = document.getElementById('export-demo-btn');
        if (exportBtn) {
            exportBtn.addEventListener('click', function() {
                // Filters ki values get karo
                const dateRange = document.querySelector('input[name="date_range"]') ? document.querySelector('input[name="date_range"]').value : '';
                const roleFilter = document.querySelector('select[name="role_filter"]') ? document.querySelector('select[name="role_filter"]').value : '';
                const volFilter = document.querySelector('select[name="volume_filter"]') ? document.querySelector('select[name="volume_filter"]').value : '';
                const qualFilter = document.querySelector('select[name="qualification_filter"]') ? document.querySelector('select[name="qualification_filter"]').value : '';
                const statusFilter = document.querySelector('select[name="status_filter"]') ? document.querySelector('select[name="status_filter"]').value : '';

                // URL parameters banao
                const params = new URLSearchParams({
                    date_range: dateRange,
                    role_filter: roleFilter,
                    volume_filter: volFilter,
                    qualification_filter: qualFilter,
                    status_filter: statusFilter
                });

                // Export file par bhej do taaky download shuru ho jaye
                window.location.href = 'export_demo_requests.php?' + params.toString();
            });
        }
    });
    </script>