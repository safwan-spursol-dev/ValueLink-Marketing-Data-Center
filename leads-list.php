<?php
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
// 2. FETCH DATA & LIVE FORMS (Dynamic Dropdown Logic)
// =========================================================

// --- A. Live API Call to WordPress ---
// IMPORTANT: Yahan apna live domain zaroor lagana
$wp_api_url = "https://YOUR_LIVE_DOMAIN.com/wp-json/vmdc/v1/get-forms"; 
$api_key = "vmdc_live_sec_882299_secure"; 

$formNames = []; 

// cURL Request
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
    // Fallback if API fails
    $fallbackStmt = $pdo->query("SELECT DISTINCT form_name FROM leads WHERE form_name IS NOT NULL ORDER BY form_name ASC");
    $formNames = $fallbackStmt->fetchAll(PDO::FETCH_COLUMN);
}

// --- B. Filter & Fetch Leads ---
$selected_form = isset($_GET['form_filter']) ? $_GET['form_filter'] : '';
$sql = "SELECT * FROM leads";
$params = [];

if (!empty($selected_form)) {
    $sql .= " WHERE form_name = ?";
    $params[] = $selected_form;
}
$sql .= " ORDER BY created_at DESC";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$leads = $stmt->fetchAll();

require_once 'includes/header.php';
?>

<style>
    .table-grouped td { vertical-align: top; padding: 15px; }
    .data-label { font-weight: 600; color: #878a99; font-size: 0.8rem; margin-right: 5px; }
    .data-value { color: #212529; font-size: 0.85rem; }
    .lead-name { font-size: 1rem; font-weight: 700; color: #405189; }
    .sub-txt { display: block; margin-bottom: 4px; }
    .note-item { background: #f3f6f9; padding: 10px; border-radius: 5px; margin-bottom: 10px; border-left: 3px solid #405189; }
    .note-meta { font-size: 0.75rem; color: #878a99; display: block; margin-bottom: 3px; }
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
                <div class="col-lg-12">
                    <div class="card">
                        
                        <div class="card-header d-flex align-items-center justify-content-between">
                            <h5 class="card-title mb-0">Received Leads</h5>
                            
                            <form method="GET" action="leads-list.php" class="d-flex align-items-center">
                                <label for="form_filter" class="form-label me-2 mb-0 text-muted fs-13 d-none d-sm-block">Filter:</label>
                                <select class="form-select form-select-sm" name="form_filter" onchange="this.form.submit()" style="min-width: 200px;">
                                    <option value="">All Forms (Mixed)</option>
                                    
                                    <?php foreach ($formNames as $name): ?>
                                        <option value="<?php echo htmlspecialchars($name); ?>" 
                                            <?php echo ($selected_form === $name) ? 'selected' : ''; ?>>
                                            <?php echo htmlspecialchars($name); ?>
                                        </option>
                                    <?php endforeach; ?>
                                    
                                </select>
                            </form>
                        </div>

                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-grouped align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th width="25%">Contact Information</th>
                                            <th width="30%">Business Information</th>
                                            <th width="25%">Message / Event</th>
                                            <th width="15%">Dates, Status & Notes</th>
                                            <th width="5%">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php if (count($leads) > 0): ?>
                                            <?php foreach ($leads as $lead): ?>
                                                <tr>
                                                    <td>
                                                        <div class="mb-2"><span class="lead-name"><?php echo htmlspecialchars($lead['client_name']); ?></span></div>
                                                        <span class="sub-txt"><span class="data-label">Email:</span> <span class="data-value"><?php echo htmlspecialchars($lead['email'] ?? 'N/A'); ?></span></span>
                                                        <span class="sub-txt"><span class="data-label">Phone:</span> <span class="data-value"><?php echo htmlspecialchars($lead['phone'] ?? 'N/A'); ?></span></span>
                                                    </td>

                                                    <td>
                                                        <span class="sub-txt"><span class="data-label">Company:</span> <span class="data-value"><?php echo !empty($lead['company']) ? htmlspecialchars($lead['company']) : 'N/A'; ?></span></span>
                                                        <span class="sub-txt"><span class="data-label">Form:</span> <span class="badge bg-light text-body"><?php echo htmlspecialchars($lead['form_name']); ?></span></span>
                                                        <?php if(!empty($lead['user_role'])): ?><span class="sub-txt"><span class="data-label">Role:</span> <span class="data-value"><?php echo htmlspecialchars($lead['user_role']); ?></span></span><?php endif; ?>
                                                        <?php if(!empty($lead['order_volume'])): ?><span class="sub-txt"><span class="data-label">Volume:</span> <span class="data-value"><?php echo htmlspecialchars($lead['order_volume']); ?></span></span><?php endif; ?>
                                                    </td>

                                                    <td>
                                                        <?php if(!empty($lead['event_title'])): ?>
                                                            <div class="mb-2 p-2 bg-light rounded border border-dashed">
                                                                <span class="data-label text-primary">Event:</span>
                                                                <span class="data-value fw-medium"><?php echo htmlspecialchars($lead['event_title']); ?></span>
                                                            </div>
                                                        <?php endif; ?>
                                                        <span class="data-label">Message:</span>
                                                        <p class="data-value mb-0 mt-1">
                                                            <?php 
                                                            $msgText = htmlspecialchars($lead['message'] ?? '');
                                                            if (strlen($msgText) > 60) {
                                                                echo substr($msgText, 0, 60) . '... <a href="#" data-bs-toggle="modal" data-bs-target="#viewMsgModal" data-msg="'.$msgText.'">Read More</a>';
                                                            } else {
                                                                echo !empty($msgText) ? $msgText : '<span class="text-muted">N/A</span>';
                                                            }
                                                            ?>
                                                        </p>
                                                    </td>

                                                    <td>
                                                        <div class="mb-2">
                                                            <?php 
                                                                $st = $lead['status'];
                                                                $cls = ($st=='new')?'info':(($st=='in_progress')?'warning':(($st=='converted')?'success':'danger'));
                                                            ?>
                                                            <span id="status-badge-<?php echo $lead['id']; ?>" class="badge bg-<?php echo $cls; ?>-subtle text-<?php echo $cls; ?> text-uppercase fs-11 w-100">
                                                                <?php echo str_replace('_', ' ', $st); ?>
                                                            </span>
                                                        </div>
                                                        <span class="sub-txt mb-2 text-center">
                                                            <span class="data-value text-muted" style="font-size: 0.75rem;">
                                                                <?php echo date('d M, Y', strtotime($lead['created_at'])); ?>
                                                            </span>
                                                        </span>
                                                        <button class="btn btn-xs btn-soft-info w-100 view-notes-btn" 
                                                            data-bs-toggle="modal" data-bs-target="#notesModal" 
                                                            data-id="<?php echo $lead['id']; ?>"
                                                            data-client="<?php echo htmlspecialchars($lead['client_name']); ?>">
                                                            <i class="ri-chat-1-line align-middle me-1"></i> Notes
                                                        </button>
                                                    </td>

                                                    <td class="text-center">
                                                        <div class="d-flex flex-column gap-2">
                                                            <?php if ($user_role === 'admin' || $user_role === 'sales'): ?>
                                                                <button class="btn btn-sm btn-soft-primary edit-status-btn"
                                                                    data-bs-toggle="modal" data-bs-target="#updateStatusModal"
                                                                    data-id="<?php echo $lead['id']; ?>"
                                                                    data-status="<?php echo $lead['status']; ?>" title="Change Status">
                                                                    <i class="ri-pencil-fill"></i>
                                                                </button>
                                                            <?php else: ?>
                                                                <button class="btn btn-sm btn-light" disabled><i class="ri-lock-fill"></i></button>
                                                            <?php endif; ?>

                                                            <?php if ($user_role === 'admin'): ?>
                                                                <a href="leads-list.php?action=delete&id=<?php echo $lead['id']; ?>" 
                                                                   class="btn btn-sm btn-soft-danger" 
                                                                   onclick="return confirm('Are you sure you want to permanently delete this lead?');" 
                                                                   title="Delete Lead">
                                                                    <i class="ri-delete-bin-fill"></i>
                                                                </a>
                                                            <?php endif; ?>
                                                        </div>
                                                    </td>
                                                </tr>
                                            <?php endforeach; ?>
                                        <?php else: ?>
                                            <tr><td colspan="5" class="text-center text-muted py-4">No leads found.</td></tr>
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

    <script>
        // STATUS MODAL
        var statusModal = document.getElementById('updateStatusModal');
        statusModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            document.getElementById('modal_status_lead_id').value = button.getAttribute('data-id');
            document.getElementById('modal_status_select').value = button.getAttribute('data-status');
        });
        document.getElementById('statusForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            formData.append('action', 'update_status_ajax');
            fetch('leads-list.php', { method: 'POST', body: formData }).then(res => res.json()).then(data => {
                if(data.success) { bootstrap.Modal.getInstance(statusModal).hide(); location.reload(); } 
                else { alert('Error: ' + data.error); }
            });
        });

        // NOTES MODAL
        var notesModal = document.getElementById('notesModal');
        notesModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var leadId = button.getAttribute('data-id');
            document.getElementById('note_client_name').textContent = button.getAttribute('data-client');
            if(document.getElementById('modal_note_lead_id')) document.getElementById('modal_note_lead_id').value = leadId;
            loadNotes(leadId);
        });

        function loadNotes(leadId) {
            const container = document.getElementById('notes_list_container');
            container.innerHTML = '<div class="text-center text-muted mt-3">Loading...</div>';
            fetch(`leads-list.php?action=fetch_notes&lead_id=${leadId}`).then(res => res.json()).then(data => {
                container.innerHTML = '';
                if(data.length > 0) {
                    data.forEach(note => {
                        container.innerHTML += `<div class="note-item"><span class="note-meta"><strong>${note.user_name}</strong> - ${note.created_at}</span><div class="note-text">${note.note}</div></div>`;
                    });
                } else { container.innerHTML = '<div class="text-center text-muted py-3">No notes attached yet.</div>'; }
            });
        }

        const addNoteForm = document.getElementById('addNoteForm');
        if(addNoteForm) {
            addNoteForm.addEventListener('submit', function(e) {
                e.preventDefault();
                const formData = new FormData(this);
                formData.append('action', 'add_note_ajax');
                fetch('leads-list.php', { method: 'POST', body: formData }).then(res => res.json()).then(data => {
                    if(data.success) { this.reset(); loadNotes(document.getElementById('modal_note_lead_id').value); } 
                    else { alert('Error: ' + data.error); }
                });
            });
        }

        // VIEW MSG
        var msgModal = document.getElementById('viewMsgModal');
        msgModal.addEventListener('show.bs.modal', function (event) {
            document.getElementById('full_msg_content').textContent = event.relatedTarget.getAttribute('data-msg');
        });
    </script>