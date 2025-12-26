<?php
// PATH UPDATE: Root folder ma ho to config folder ma jao
require_once 'config/db.php'; 
require_once 'includes/session_check.php';

$msg = "";
$user_role = $_SESSION['role'] ?? 'marketing';
$user_id = $_SESSION['user_id'];

// =========================================================
// 1. BACKEND HANDLERS (DELETE, AJAX STATUS, NOTES)
// =========================================================

// A. HANDLE DELETE (Only Admin)
if (isset($_GET['action']) && $_GET['action'] == 'delete' && isset($_GET['id'])) {
    if ($user_role === 'admin') {
        $id = $_GET['id'];
        
        // Log Data Fetch
        $stmt = $pdo->prepare("SELECT * FROM leads WHERE id = ?");
        $stmt->execute([$id]);
        $lead = $stmt->fetch();

        if ($lead) {
            // Log Insert
            $logStmt = $pdo->prepare("INSERT INTO activity_logs (user_id, lead_id, lead_name, lead_email, lead_form, lead_created_at, action_type, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $desc = "Permanently deleted the lead.";
            $logStmt->execute([$user_id, $id, $lead['client_name'], $lead['email'], $lead['form_name'], $lead['created_at'], 'Deleted', $desc]);

            // Delete
            $delStmt = $pdo->prepare("DELETE FROM leads WHERE id = ?");
            $delStmt->execute([$id]);
        }
        header("Location: leads-list.php?msg=deleted");
        exit;
    } else {
        die("Access Denied");
    }
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

            $desc = "Changed status from '" . ucfirst($lead['status']) . "' to '" . ucfirst($new_status) . "'";
            $logStmt = $pdo->prepare("INSERT INTO activity_logs (user_id, lead_id, lead_name, lead_email, lead_form, lead_created_at, action_type, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $logStmt->execute([$user_id, $lead_id, $lead['client_name'], $lead['email'], $lead['form_name'], $lead['created_at'], 'Status Update', $desc]);
        }
        echo json_encode(['success' => true, 'new_status' => $new_status]);
    } catch (PDOException $e) {
        echo json_encode(['success' => false, 'error' => $e->getMessage()]);
    }
    exit;
}

// C. AJAX: ADD NOTE
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['action']) && $_POST['action'] == 'add_note_ajax') {
    header('Content-Type: application/json');
    if ($user_role === 'marketing') { echo json_encode(['success' => false, 'error' => 'Permission Denied']); exit; }

    $lead_id = $_POST['lead_id'];
    $note_text = trim($_POST['note']);

    if (!empty($note_text)) {
        try {
            $stmt = $pdo->prepare("INSERT INTO lead_notes (lead_id, user_id, note) VALUES (?, ?, ?)");
            $stmt->execute([$lead_id, $user_id, $note_text]);

            $lStmt = $pdo->prepare("SELECT client_name, email, form_name, created_at FROM leads WHERE id = ?");
            $lStmt->execute([$lead_id]);
            $lead = $lStmt->fetch();

            $desc = "Added a new note: " . substr($note_text, 0, 30) . "...";
            $logStmt = $pdo->prepare("INSERT INTO activity_logs (user_id, lead_id, lead_name, lead_email, lead_form, lead_created_at, action_type, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            $logStmt->execute([$user_id, $lead_id, $lead['client_name'], $lead['email'], $lead['form_name'], $lead['created_at'], 'Note Added', $desc]);

            echo json_encode(['success' => true]);
        } catch (PDOException $e) { echo json_encode(['success' => false, 'error' => $e->getMessage()]); }
    } else { echo json_encode(['success' => false, 'error' => 'Empty note']); }
    exit;
}

// D. AJAX: FETCH NOTES
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
// 2. FETCH DATA & LIVE FORMS
// =========================================================

// --- A. Live API Call to WordPress ---
// IMPORTANT: Replace this URL with your actual WordPress site URL
$wp_api_url = "https://preview2.valuelinksoftware.com/wp-json/vmdc/v1/get-forms"; 
$api_key = "vmdc_live_sec_882299_secure"; 

$formNames = []; 

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $wp_api_url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_HTTPHEADER, ["Authorization: " . $api_key, "Content-Type: application/json"]);
curl_setopt($ch, CURLOPT_TIMEOUT, 5); 
$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

if ($http_code == 200 && $response) {
    $data = json_decode($response, true);
    if (is_array($data)) {
        foreach ($data as $form) { $formNames[] = $form['title']; }
    }
} else {
    $fallbackStmt = $pdo->query("SELECT DISTINCT form_name FROM leads WHERE form_name IS NOT NULL ORDER BY form_name ASC");
    $formNames = $fallbackStmt->fetchAll(PDO::FETCH_COLUMN);
}

// --- B. Pagination & Filtering Logic 🚀 ---

// 1. Get Current Page & Limit
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
$limit = isset($_GET['limit']) && is_numeric($_GET['limit']) ? (int)$_GET['limit'] : 10; // Default 10

// Valid Limits Check (Taaky koi url ma limit=1000 na likh de)
$allowed_limits = [10, 15, 20, 50];
if (!in_array($limit, $allowed_limits)) { $limit = 10; }

// Offset Calculation (Kitni rows skip karni hain)
$offset = ($page - 1) * $limit;

// 2. Build Query Conditions
$selected_form = isset($_GET['form_filter']) ? $_GET['form_filter'] : '';
$date_range    = isset($_GET['date_range']) ? $_GET['date_range'] : ''; // <--- New Variable

$where_clauses = [];
$params = [];

// A. Form Filter
if (!empty($selected_form)) {
    $where_clauses[] = "leads.form_name = ?";
    $params[] = $selected_form;
}

// B. Date Range Filter Logic 📅
if (!empty($date_range)) {
    // Flatpickr format: "2023-10-01 to 2023-10-15"
    $dates = explode(" to ", $date_range);
    
    if (count($dates) == 2) {
        // Range Selection
        $where_clauses[] = "DATE(leads.created_at) BETWEEN ? AND ?";
        $params[] = trim($dates[0]); // Start Date
        $params[] = trim($dates[1]); // End Date
    } else {
        // Single Date Selection
        $where_clauses[] = "DATE(leads.created_at) = ?";
        $params[] = trim($dates[0]);
    }
}

// WHERE SQL Build
$where_sql = "";
if (count($where_clauses) > 0) {
    $where_sql = "WHERE " . implode(" AND ", $where_clauses);
}

// 3. GET TOTAL COUNT (For Pagination Math)
// Pehle ginti karo ke total kitni leads hain (Filter ke mutabiq)
$count_sql = "SELECT COUNT(*) FROM leads $where_sql";
$count_stmt = $pdo->prepare($count_sql);
$count_stmt->execute($params);
$total_leads = $count_stmt->fetchColumn();

// Total Pages Formula
$total_pages = ceil($total_leads / $limit);

// 4. FETCH DATA (With Limit & Offset)
// Ab data mangwao
$sql = "SELECT leads.*, users.name as assigned_user_name, users.image as assigned_user_image 
        FROM leads 
        LEFT JOIN users ON leads.assigned_to = users.id 
        $where_sql 
        ORDER BY leads.created_at DESC 
        LIMIT $limit OFFSET $offset";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$leads = $stmt->fetchAll();

require_once 'includes/header.php';
?>

<style>
   <style>
    .table-grouped td { vertical-align: top; padding: 15px; }
    
    /* Rows Spacing */
    .info-row {
        margin-bottom: 4px;
        font-size: 13px;
        line-height: 1.5;
        color: #555; /* Default text color */
    }

    /* Label: Strong & Dark (e.g. Full Name:) */
    .lbl {
        font-weight: 700;
        color: #333; /* Dark Black */
        margin-right: 4px;
    }

    /* Value: Normal Text */
    .val {
        font-weight: 400;
        color: #666; /* Soft Grey */
    }
    /* --- PAGINATION STYLING (Bigger & Clearer) --- */
.pagination .page-item .page-link {
    margin: 0 5px;            /* Thora gap barhaya */
    border-radius: 50% !important; 
    width: 35px;              /* Button ka size 35px se 40px kardiya */
    height: 35px;             /* Height bhi 40px */
    display: flex; 
    align-items: center; 
    justify-content: center;
    border: 1px solid #e9ebec; 
    color: #405189; 
    font-weight: 600;         /* Text/Numbers ko thora mota kiya */
    font-size: 15px;          /* Numbers ka size */
    transition: all 0.3s ease;
}

/* ARROWS SPECIFIC STYLE (Jinko bara karna tha) */
.pagination .page-item .page-link i {
    font-size: 20px;          /* Arrow Icon ka size bara kardiya (Pahle approx 14px tha) */
    line-height: 0;           /* Alignment fix */
}

/* Hover Effect */
.pagination .page-item .page-link:hover {
    background-color: #c7c7c7ff;
    border-color: #d8dbe0;
}

/* Active Page Style */
.pagination .page-item.active .page-link {
    background-color: #405189;
    border-color: #405189;
    color: #fff;
    box-shadow: 0 4px 8px rgba(64, 81, 137, 0.3); /* Shadow add kiya taaky utha hua lagy */
}

/* Disable Hover */
.pagination .page-item.disabled .page-link {
    background-color: #f8f9fa;
    color: #adb5bd;
    opacity: 0.6;
}
</style>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Leads Management</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                                <li class="breadcrumb-item active">Leads</li>
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
    
                                <h5 class="card-title mb-0">Received Leads <span id="total-leads-badge" class="badge bg-secondary-subtle text-secondary"><?php echo $total_leads; ?> Total</span></h5>

                                <form id="filter-form" method="GET" action="leads-list.php" class="d-flex flex-column flex-sm-row align-items-stretch align-items-sm-center gap-2 w-100 w-md-auto">

                                    <input type="hidden" name="limit" value="<?php echo $limit; ?>">

                                    <div class="input-group input-group-sm" style="flex: 1; min-width: 220px;">
                                        <span class="input-group-text bg-light"><i class="ri-calendar-2-line"></i></span>
                                        <input type="text" class="form-control bg-light border-light" 
                                               name="date_range" 
                                               id="date_range_picker" 
                                               placeholder="Select Date Range" 
                                               value="<?php echo htmlspecialchars($date_range); ?>">
                                    </div>

                                    <select class="form-select form-select-sm" name="form_filter" style="flex: 1; min-width: 180px;">
                                        <option value="">All Forms (Mixed)</option>
                                        <?php foreach ($formNames as $name): ?>
                                            <option value="<?php echo htmlspecialchars($name); ?>" 
                                                <?php echo ($selected_form === $name) ? 'selected' : ''; ?>>
                                                <?php echo htmlspecialchars($name); ?>
                                            </option>
                                        <?php endforeach; ?>
                                    </select>
                                        
                                    <span id="filter-reset-btn">
                                        <?php if(!empty($selected_form) || !empty($date_range)): ?>
                                            <a href="leads-list.php" class="btn btn-sm btn-soft-danger w-100 w-sm-auto" title="Clear Filters">
                                                <i class="ri-close-line"></i>
                                            </a>
                                        <?php endif; ?>
                                    </span>
                                    
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
                                                <th width="15%">Assigned To</th>
                                                <th width="15%">Status & Notes</th>
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
                                                            <?php if(!empty($lead['user_role'])): ?><div class="info-row"><span class="lbl">Role:</span> <span class="val"><?php echo htmlspecialchars($lead['user_role']); ?></span></div><?php endif; ?>
                                                            <?php if(!empty($lead['order_volume'])): ?><div class="info-row"><span class="lbl">Volume:</span> <span class="val"><?php echo htmlspecialchars($lead['order_volume']); ?></span></div><?php endif; ?>
                                                            <div class="info-row"><span class="lbl">Form Title:</span> <span class="val"><?php echo htmlspecialchars($lead['form_name']); ?></span></div>
                                                        </td>
                                                            
                                                        <td>
                                                            <?php if(!empty($lead['event_title'])): ?>
                                                                <div class="info-row"><span class="lbl">Event:</span> <span class="val"><?php echo htmlspecialchars($lead['event_title']); ?></span></div>
                                                            <?php endif; ?>
                                                            <div class="info-row"><span class="lbl">Message:</span></div>
                                                            <div class="val" style="font-size: 13px; line-height: 1.4;">
                                                                <?php 
                                                                $msgText = htmlspecialchars($lead['message'] ?? '');
                                                                if (strlen($msgText) > 80) {
                                                                    echo substr($msgText, 0, 80) . '... <a href="#" data-bs-toggle="modal" data-bs-target="#viewMsgModal" data-msg="'.$msgText.'">Read More</a>';
                                                                } else { echo !empty($msgText) ? $msgText : 'N/A'; }
                                                                ?>
                                                            </div>
                                                        </td>
                                                            
                                                        <td>
                                                            <?php if (!empty($lead['assigned_user_name'])): ?>
                                                                <div class="d-flex align-items-center">
                                                                    <div class="flex-shrink-0 me-2">
                                                                        <?php
                                                                            $db_image = $lead['assigned_user_image'] ?? '';
                                                                            $img_src = (!empty($db_image) && file_exists('uploads/' . $db_image)) ? 'uploads/' . $db_image : 'assets/images/users/dummy.png';
                                                                        ?>
                                                                        <img src="<?php echo htmlspecialchars($img_src); ?>" alt="" class="avatar-xs rounded-circle">
                                                                    </div>
                                                                    <div><h5 class="fs-13 mb-0"><?php echo htmlspecialchars($lead['assigned_user_name']); ?></h5></div>
                                                                </div>
                                                            <?php else: ?>
                                                                <span class="badge bg-warning-subtle text-warning">Unassigned</span>
                                                            <?php endif; ?>
                                                        </td>
                                                            
                                                        <td>
                                                            <?php 
                                                                $st = $lead['status'];
                                                                $cls = ($st=='new')?'info':(($st=='in_progress')?'warning':(($st=='converted')?'success':'danger'));
                                                            ?>
                                                            <span class="badge bg-<?php echo $cls; ?>-subtle text-<?php echo $cls; ?> text-uppercase fs-11 w-100">
                                                                <?php echo str_replace('_', ' ', $st); ?>
                                                            </span>
                                                            
                                                            <div class="mt-2 text-center text-muted" style="font-size: 11px;">
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
                                                                <?php if ($user_role === 'admin' || $user_role === 'sales'): ?>
                                                                    <button class="btn btn-sm btn-soft-primary edit-status-btn" data-bs-toggle="modal" data-bs-target="#updateStatusModal" data-id="<?php echo $lead['id']; ?>" data-status="<?php echo $lead['status']; ?>"><i class="ri-pencil-fill"></i></button>
                                                                <?php endif; ?>
                                                                <?php if ($user_role === 'admin'): ?>
                                                                    <a href="leads-list.php?action=delete&id=<?php echo $lead['id']; ?>" class="btn btn-sm btn-soft-danger" onclick="return confirm('Delete lead?');"><i class="ri-delete-bin-fill"></i></a>
                                                                <?php endif; ?>
                                                                <?php if ($user_role === 'marketing'): ?>
                                                                <button type="button" class="btn btn-sm btn-ghost-danger cursor-default" title="Permission Denied" style="cursor: not-allowed;">
                                                                    <i class="ri-lock-2-fill align-bottom fs-15"></i>
                                                                </button>
                                                                <?php endif; ?>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                <?php endforeach; ?>
                                            <?php else: ?>
                                                <tr><td colspan="6" class="text-center text-muted py-4">No leads found.</td></tr>
                                            <?php endif; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                                            
                            <div class="card-footer border-top-0 py-3">
                                <div class="row align-items-center">
                                    <div class="col-md-4 mb-md-0">
                                        <form method="GET" action="leads-list.php" class="d-flex align-items-center justify-content-center justify-content-md-start gap-2">
                                <input type="hidden" name="form_filter" value="<?php echo htmlspecialchars($selected_form); ?>">
                                <input type="hidden" name="date_range" value="<?php echo htmlspecialchars($date_range); ?>">
                                <input type="hidden" name="page" value="1"> <span class="text-muted fs-12">Show</span>
                                <select class="form-select form-select-sm" name="limit" onchange="this.form.submit()" style="width: 70px; text-align: center;">
                                    <?php foreach([10, 15, 20] as $opt): ?><option value="<?php echo $opt; ?>" <?php echo ($limit == $opt) ? 'selected' : ''; ?>><?php echo $opt; ?></option><?php endforeach; ?>
                                </select>
                                <span class="text-muted fs-12">of <b><?php echo $total_leads; ?></b> results</span>
                                        </form>
                                    </div>
                                    <div class="col-md-4">
                                        <?php if ($total_pages > 1): ?>
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination pagination-sm mb-0 justify-content-center">
                                                    <li class="page-item <?php echo ($page <= 1) ? 'disabled' : ''; ?>">
                                                        <a class="page-link" href="?page=<?php echo $page - 1; ?>&limit=<?php echo $limit; ?>&form_filter=<?php echo urlencode($selected_form); ?>&date_range=<?php echo urlencode($date_range); ?>" aria-label="Previous"><i class="ri-arrow-left-s-line"></i></a>
                                                    </li>
                                                    <?php 
                                                    $start = max(1, $page - 1); $end = min($total_pages, $page + 1);
                                                    if($page == 1) { $end = min($total_pages, 3); }
                                                    if($page == $total_pages) { $start = max(1, $total_pages - 2); }
                                                    for ($i = $start; $i <= $end; $i++): 
                                                    ?>
                                                        <li class="page-item <?php echo ($i == $page) ? 'active' : ''; ?>"><a class="page-link" href="?page=<?php echo $i; ?>&limit=<?php echo $limit; ?>&form_filter=<?php echo urlencode($selected_form); ?>&date_range=<?php echo urlencode($date_range); ?>"><?php echo $i; ?></a></li>
                                                    <?php endfor; ?>
                                                    <li class="page-item <?php echo ($page >= $total_pages) ? 'disabled' : ''; ?>">
                                                        <a class="page-link" href="?page=<?php echo $page + 1; ?>&limit=<?php echo $limit; ?>&form_filter=<?php echo urlencode($selected_form); ?>&date_range=<?php echo urlencode($date_range); ?>" aria-label="Next"><i class="ri-arrow-right-s-line"></i></a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        <?php endif; ?>
                                    </div>
                                    <div class="col-md-4"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="updateStatusModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title">Update Lead Status</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <form id="statusForm">
                    <div class="modal-body">
                        <input type="hidden" name="lead_id" id="modal_status_lead_id">
                        <div class="mb-3">
                            <label class="form-label">Select New Status</label>
                            <select class="form-select" name="status" id="modal_status_select" required>
                                <option value="new">New</option>
                                <option value="in_progress">In Progress</option>
                                <option value="converted">Converted (Won)</option>
                                <option value="lost">Lost</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer"><button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button><button type="submit" class="btn btn-primary">Update Status</button></div>
                </form>
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
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title">Full Message</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <div class="modal-body"><p id="full_msg_content" class="text-muted text-break"></p></div>
                <div class="modal-footer"><button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button></div>
            </div>
        </div>
    </div>

    <?php require_once 'includes/footer.php'; ?>

  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {

    // =========================================================
    // 1. STATUS UPDATE MODAL LOGIC
    // =========================================================
    var statusModal = document.getElementById('updateStatusModal');
    if (statusModal) {
        statusModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            document.getElementById('modal_status_lead_id').value = button.getAttribute('data-id');
            document.getElementById('modal_status_select').value = button.getAttribute('data-status');
        });

        document.getElementById('statusForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            formData.append('action', 'update_status_ajax');
            fetch('leads-list.php', { method: 'POST', body: formData })
                .then(res => res.json())
                .then(data => {
                    if(data.success) { 
                        bootstrap.Modal.getInstance(statusModal).hide(); 
                        location.reload(); 
                    } else { 
                        alert('Error: ' + data.error); 
                    }
                });
        });
    }

    // =========================================================
    // 2. NOTES MODAL LOGIC & FUNCTIONS
    // =========================================================
    var notesModal = document.getElementById('notesModal');
    if (notesModal) {
        notesModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var leadId = button.getAttribute('data-id');
            document.getElementById('note_client_name').textContent = button.getAttribute('data-client');
            
            if(document.getElementById('modal_note_lead_id')) {
                document.getElementById('modal_note_lead_id').value = leadId;
            }
            loadNotes(leadId);
        });
    }

    // Function to Fetch Notes from DB
    function loadNotes(leadId) {
        const container = document.getElementById('notes_list_container');
        if(!container) return;

        container.innerHTML = '<div class="text-center text-muted mt-3">Loading...</div>';
        fetch(`leads-list.php?action=fetch_notes&lead_id=${leadId}`)
            .then(res => res.json())
            .then(data => {
                container.innerHTML = '';
                if(data.length > 0) {
                    data.forEach(note => {
                        container.innerHTML += `<div class="note-item"><span class="note-meta"><strong>${note.user_name}</strong> - ${note.created_at}</span><div class="note-text">${note.note}</div></div>`;
                    });
                } else { 
                    container.innerHTML = '<div class="text-center text-muted py-3">No notes attached yet.</div>'; 
                }
            });
    }

    // Handle Add Note Form Submit
    const addNoteForm = document.getElementById('addNoteForm');
    if(addNoteForm) {
        addNoteForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            formData.append('action', 'add_note_ajax');
            fetch('leads-list.php', { method: 'POST', body: formData })
                .then(res => res.json())
                .then(data => {
                    if(data.success) { 
                        this.reset(); 
                        loadNotes(document.getElementById('modal_note_lead_id').value); 
                    } else { 
                        alert('Error: ' + data.error); 
                    }
                });
        });
    }

    // =========================================================
    // 3. VIEW FULL MESSAGE MODAL
    // =========================================================
    var msgModal = document.getElementById('viewMsgModal');
    if (msgModal) {
        msgModal.addEventListener('show.bs.modal', function (event) {
            document.getElementById('full_msg_content').textContent = event.relatedTarget.getAttribute('data-msg');
        });
    }

    // =========================================================
    // 4. AJAX FILTERING, PAGINATION & DATE PICKER CONFIG
    // =========================================================
    
    // --- Configuration ---
    const wrapperID = "#leads-area-wrapper";   
    const formID = "#filter-form";             
    const badgeID = "#total-leads-badge";      
    const datePickerID = "#date_range_picker"; 
    const resetBtnID = "#filter-reset-btn"; 

    // --- Initialize Flatpickr Calendar ---
    const dateInput = document.querySelector(datePickerID);
    if (dateInput) {
        flatpickr(dateInput, {
            mode: "range",
            dateFormat: "Y-m-d",
            defaultDate: dateInput.value,
            onClose: function(selectedDates, dateStr, instance) {
                // Calendar close hony par filter trigger karo
                if (dateStr !== "" || dateInput.value !== "") {
                    triggerFilterChange();
                }
            }
        });
    }

    // --- Event Listeners for Filters ---
    const filterForm = document.querySelector(formID);
    if (filterForm) {
        // Change Event (Dropdowns & Inputs)
        filterForm.addEventListener("change", function(e) {
            if (e.target.tagName === "SELECT" || e.target.tagName === "INPUT") {
                e.preventDefault();
                triggerFilterChange();
            }
        });
        
        // Prevent Default Form Submit
        filterForm.addEventListener("submit", function(e) {
            e.preventDefault();
            triggerFilterChange();
        });
    }

    // --- Event Delegation for Pagination (Click) ---
    const wrapper = document.querySelector(wrapperID);
    if (wrapper) {
        wrapper.addEventListener("click", function(e) {
            const link = e.target.closest(".pagination .page-link");
            if (link && !link.closest(".disabled")) {
                e.preventDefault();
                const url = link.getAttribute("href");
                fetchData(url);
            }
        });
    }

    // =========================================================
    // 5. CORE AJAX FUNCTIONS (TRIGGER & FETCH)
    // =========================================================

    function triggerFilterChange() {
        const form = document.querySelector(formID);
        // Safety Check
        if (!form) return;

        const formData = new FormData(form);
        const params = new URLSearchParams(formData);
        
        // Footer Limit Check
        const limitSelect = document.querySelector("select[name='limit']");
        if(limitSelect && !formData.has('limit')) {
            params.set('limit', limitSelect.value);
        }

        const url = "leads-list.php?" + params.toString();
        fetchData(url);
    }

    function fetchData(url) {
        const container = document.querySelector(wrapperID);
        const badge = document.querySelector(badgeID);
        const resetBtn = document.querySelector(resetBtnID); 

        if(!container) return;

        // Loading Effect
        container.style.opacity = "0.5";
        container.style.pointerEvents = "none";

        fetch(url)
            .then(response => response.text())
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, "text/html");

                // A. Update Table & Footer
                const newContent = doc.querySelector(wrapperID).innerHTML;
                container.innerHTML = newContent;

                // B. Update Badge Count
                if (badge && doc.querySelector(badgeID)) {
                    badge.innerHTML = doc.querySelector(badgeID).innerHTML;
                }

                // C. Update Clear Button
                if (resetBtn && doc.querySelector(resetBtnID)) {
                    resetBtn.innerHTML = doc.querySelector(resetBtnID).innerHTML;
                }

                // Update URL
                window.history.pushState({}, "", url);

                // Restore UI
                container.style.opacity = "1";
                container.style.pointerEvents = "auto";
            })
            .catch(err => {
                console.error("Error loading data:", err);
                container.style.opacity = "1";
                container.style.pointerEvents = "auto";
            });
    }

});
</script>