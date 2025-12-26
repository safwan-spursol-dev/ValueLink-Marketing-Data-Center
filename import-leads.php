<?php
// 1. DATABASE CONNECTION
require_once 'config/db.php'; 
require_once 'includes/session_check.php';

$message = "";
$msgType = "";

// 2. IMPORT LOGIC START
if (isset($_POST['import_btn'])) {
    
    // Check if Form Type is selected
    $selected_form_type = $_POST['form_type'] ?? '';

    if (empty($selected_form_type)) {
        $message = "Please select a Form Type first.";
        $msgType = "danger";
    }
    elseif ($_FILES['csv_file']['error'] == 0) {
        $name = $_FILES['csv_file']['name'];
        $ext = strtolower(pathinfo($name, PATHINFO_EXTENSION));
        
        if ($ext === 'csv') {
            
            $fileRows = [];
            if (($handle = fopen($_FILES['csv_file']['tmp_name'], "r")) !== FALSE) {
                while (($data = fgetcsv($handle)) !== FALSE) {
                    $fileRows[] = $data;
                }
                fclose($handle);
            }

            if (count($fileRows) > 0) {
                
                $headerRowIndex = 0;
                $form_name = ""; 
                $isValid = true;
                
                // 🛠️ MAP INITIALIZATION
                $map = [
                    'name'=>-1, 'email'=>-1, 'phone'=>-1, 'company'=>-1, 
                    'message'=>-1, 'date'=>-1,
                    'user_role'=>-1, 'order_volume'=>-1
                ];
                
                // ====================================================
                // 🧠 LOGIC SWITCH: STRICT SELECTION ONLY
                // ====================================================
                
                switch ($selected_form_type) {

                    case 'contact_us':
                        $form_name = "Contact Us Form";
                        $headerRowIndex = 2; // Row 3 is header
                        break;

                    case 'demo_request':
                        $form_name = "Demo Request Form";
                        $headerRowIndex = 0; // Row 1 is header
                        break;

                    case 'newsletter':
                        $form_name = "Newsletter Subscription Form";
                        $headerRowIndex = 0;
                        break;

                    case 'mobile_demo':
                        $form_name = "Request a Demo Form Mobile View";
                        $headerRowIndex = 0;
                        break;

                    default:
                        $isValid = false;
                        $message = "Invalid Form Type Selected.";
                        $msgType = "danger";
                        break;
                }

                if ($isValid) {

                    // ====================================================
                    // 🛠️ MAPPING PROCESS
                    // ====================================================
                    
                    if (isset($fileRows[$headerRowIndex])) {
                        $headers = $fileRows[$headerRowIndex];

                        foreach ($headers as $index => $colName) {
                            $clean_raw = preg_replace('/[\x00-\x1F\x80-\xFF]/', '', $colName); 
                            $col = strtolower(trim($clean_raw));

                            // --- MAPPING PER FORM ---
                            
                            if ($selected_form_type === 'demo_request') {
                                // Simplified Headers Logic
                                if ($col === 'name') $map['name'] = $index;
                                elseif ($col === 'email') $map['email'] = $index;
                                elseif ($col === 'company') $map['company'] = $index;
                                elseif ($col === 'phone') $map['phone'] = $index;
                                elseif ($col === 'message') $map['message'] = $index;
                                elseif (strpos($col, 'user role') !== false) $map['user_role'] = $index;
                                elseif (strpos($col, 'order volumes') !== false) $map['order_volume'] = $index;
                                elseif (strpos($col, 'date') !== false) $map['date'] = $index;
                            }
                            
                            elseif ($selected_form_type === 'contact_us') {
                                if ($col === 'name') $map['name'] = $index;
                                elseif ($col === 'email') $map['email'] = $index;
                                elseif ($col === 'company') $map['company'] = $index;
                                elseif ($col === 'message') $map['message'] = $index;
                                elseif (strpos($col, 'date') !== false) $map['date'] = $index;
                            }

                            elseif ($selected_form_type === 'newsletter') {
                                if (strpos($col, 'email') !== false) $map['email'] = $index;
                                elseif (strpos($col, 'date') !== false) $map['date'] = $index;
                            }

                            elseif ($selected_form_type === 'mobile_demo') {
                                if ($col === 'name') $map['name'] = $index;
                                elseif (strpos($col, 'email') !== false) $map['email'] = $index;
                                elseif ($col === 'phone') $map['phone'] = $index;
                                elseif ($col === 'company') $map['company'] = $index;
                                elseif ($col === 'message') $map['message'] = $index;
                                elseif (strpos($col, 'date') !== false) $map['date'] = $index;
                                elseif (strpos($col, "role") !== false) $map['user_role'] = $index;
                                elseif (strpos($col, "volume") !== false) $map['order_volume'] = $index;
                            }
                        }
                    }

                    // ====================================================
                    // 🚀 DATA INSERT LOOP
                    // ====================================================
                    $count = 0;
                    $skipped = 0;

                    for ($i = $headerRowIndex + 1; $i < count($fileRows); $i++) {
                        $data = $fileRows[$i];
                        if (empty(implode('', $data))) continue;

                        // FETCH DATA
                        $client_name = ($map['name'] > -1 && isset($data[$map['name']])) ? trim($data[$map['name']]) : '';
                        if (empty($client_name)) $client_name = 'Imported User';

                        $email = ($map['email'] > -1 && isset($data[$map['email']])) ? trim($data[$map['email']]) : '';
                        $phone = ($map['phone'] > -1 && isset($data[$map['phone']])) ? trim($data[$map['phone']]) : '';
                        $company = ($map['company'] > -1 && isset($data[$map['company']])) ? trim($data[$map['company']]) : '';
                        $msg_text = ($map['message'] > -1 && isset($data[$map['message']])) ? trim($data[$map['message']]) : '';
                        $user_role = ($map['user_role'] > -1 && isset($data[$map['user_role']])) ? trim($data[$map['user_role']]) : '';
                        $order_volume = ($map['order_volume'] > -1 && isset($data[$map['order_volume']])) ? trim($data[$map['order_volume']]) : '';

                        // DATE FIX
                        $date_raw = ($map['date'] > -1 && isset($data[$map['date']])) ? $data[$map['date']] : '';
                        $created_at = date('Y-m-d H:i:s');
                        if (!empty($date_raw)) {
                            $ts = strtotime(str_replace('/', '-', $date_raw));
                            if (!$ts) $ts = strtotime($date_raw);
                            if ($ts) $created_at = date('Y-m-d H:i:s', $ts);
                        }

                        // CHECK DUPLICATE
                        if (!empty($email)) {
                            $checkStmt = $pdo->prepare("SELECT id FROM leads WHERE email = ? AND form_name = ?");
                            $checkStmt->execute([$email, $form_name]);
                            if ($checkStmt->rowCount() > 0) { $skipped++; continue; }
                        }

                        // INSERT
                        try {
                            $sql = "INSERT INTO leads 
                                    (client_name, email, phone, company, message, user_role, order_volume, form_name, source, status, created_at) 
                                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'CSV Import', 'new', ?)";
                            
                            $stmt = $pdo->prepare($sql);
                            $stmt->execute([$client_name, $email, $phone, $company, $msg_text, $user_role, $order_volume, $form_name, $created_at]);
                            $count++;
                        } catch (PDOException $e) { }
                    }

                    $message = "Success! Form: <b>$form_name</b>. Imported: <b>$count</b> leads. Skipped: <b>$skipped</b>.";
                    $msgType = "success";
                }
            } else {
                $message = "File appears to be empty.";
                $msgType = "danger";
            }
        } else {
            $message = "Invalid file format. Please upload a CSV file.";
            $msgType = "danger";
        }
    } else {
        $message = "Error uploading file.";
        $msgType = "danger";
    }
}

require_once 'includes/header.php';
?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row justify-content-center">
                <div class="col-md-6">
                    
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h4 class="mb-0">Import Leads (CSV)</h4>
                        <a href="leads-list.php" class="btn btn-light btn-sm">
                            <i class="ri-arrow-left-line align-middle"></i> Back
                        </a>
                    </div>

                    <?php if (!empty($message)): ?>
                        <div class="alert alert-<?php echo $msgType; ?> alert-dismissible fade show" role="alert">
                            <?php echo $message; ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <?php endif; ?>

                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3 border-bottom">
                            <h6 class="card-title mb-0">Upload File & Select Form</h6>
                        </div>
                        <div class="card-body">
                            <form method="POST" enctype="multipart/form-data" id="importForm">
                                
                                <input type="hidden" name="import_btn" value="1">

                                <div class="mb-3">
                                    <label for="form_type" class="form-label fw-bold">Select Form Type</label>
                                    <select name="form_type" id="form_type" class="form-select" required>
                                        <option value="" selected disabled>-- Choose Form Type --</option>
                                        <option value="contact_us">Contact Us Form</option>
                                        <option value="demo_request">Demo Request Form</option>
                                        <option value="newsletter">Newsletter Subscription Form</option>
                                        <option value="mobile_demo">Request a Demo Form (Mobile)</option>
                                    </select>
                                </div>

                                <div id="uploadSection" style="display: none;">
                                    <div class="mb-3">
                                        <label for="csv_file" class="form-label fw-bold">Choose CSV File</label>
                                        <input type="file" class="form-control" name="csv_file" id="csv_file" accept=".csv" required>
                                    </div>

                                    <div class="d-grid mt-4">
                                        <button type="submit" id="importBtn" class="btn btn-primary">
                                            Upload & Import
                                        </button>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>

                    <div class="text-center mt-3 text-muted" style="font-size: 12px;">
                        Duplicate emails within the same form will be skipped automatically.
                    </div>

                </div>
            </div>

        </div>
    </div>
    <?php require_once 'includes/footer.php'; ?>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Toggle Logic for Upload Section
        const formSelect = document.getElementById('form_type');
        const uploadSection = document.getElementById('uploadSection');

        if(formSelect && uploadSection) {
            formSelect.addEventListener('change', function() {
                if (this.value !== "") {
                    // Show Section
                    uploadSection.style.display = "block";
                } else {
                    // Hide Section
                    uploadSection.style.display = "none";
                }
            });
        }

        // Processing Spinner Logic
        var form = document.getElementById('importForm');
        if(form){
            form.addEventListener('submit', function() {
                var btn = document.getElementById('importBtn');
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span> Processing...';
            });
        }
    });
</script>