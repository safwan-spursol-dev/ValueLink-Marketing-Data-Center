<?php
require_once '../config/db.php'; 
require_once '../includes/session_check.php';

$message = ""; $msgType = "";
$form_name = "Demo Request Form";
$headerRowIndex = 0;

if (isset($_POST['import_btn'])) {
    if ($_FILES['csv_file']['error'] == 0) {
        $name = $_FILES['csv_file']['name'];
        $ext = strtolower(pathinfo($name, PATHINFO_EXTENSION));
        
        // ✨ NAYA CHECK: Demo ki pehchan (baqi demo forms exclude kar diye)
        $filename_lower = strtolower($name);
        $clean_filename = str_replace(['-', '_'], ' ', $filename_lower);
        
        if (strpos($clean_filename, 'demo') === false || strpos($clean_filename, 'mobile') !== false || strpos($clean_filename, 'omni') !== false || strpos($clean_filename, 'crosscheck') !== false) {
            $message = "Error: Your file <b>'$name'</b> is not matched with standard $form_name.";
            $msgType = "danger";
        }
        elseif ($ext === 'csv') {
            $fileRows = [];
            if (($handle = fopen($_FILES['csv_file']['tmp_name'], "r")) !== FALSE) {
                while (($data = fgetcsv($handle)) !== FALSE) { $fileRows[] = $data; }
                fclose($handle);
            }

            if (count($fileRows) > 0) {
                $map = ['name'=>-1, 'email'=>-1, 'phone'=>-1, 'company'=>-1, 'message'=>-1, 'date'=>-1, 'preferred_date'=>-1, 'user_role'=>-1, 'order_volume'=>-1, 'event_title'=>-1];

                if (isset($fileRows[$headerRowIndex])) {
                    foreach ($fileRows[$headerRowIndex] as $index => $colName) {
                        $col = strtolower(trim(preg_replace('/[\x00-\x1F\x80-\xFF]/', '', $colName)));
                        if (strpos($col, 'name') !== false || strpos($col, "hi, i'm") !== false || strpos($col, "hi i'm") !== false) $map['name'] = $index;
                        elseif (strpos($col, 'email') !== false) $map['email'] = $index;
                        elseif ($col === 'company' || $col === 'from') $map['company'] = $index;
                        elseif (strpos($col, 'phone') !== false) $map['phone'] = $index;
                        elseif (strpos($col, 'message') !== false || strpos($col, "looking for") !== false) $map['message'] = $index;
                        elseif (strpos($col, 'role') !== false) $map['user_role'] = $index;
                        elseif (strpos($col, 'volume') !== false) $map['order_volume'] = $index;
                        elseif ($col === 'submission create date') $map['date'] = $index;
                        elseif (strpos($col, 'prefered') !== false || strpos($col, 'preferred') !== false) $map['preferred_date'] = $index;
                        elseif (strpos($col, 'date') !== false && $map['date'] === -1) $map['date'] = $index;
                    }
                }

                $count = 0;
                for ($i = $headerRowIndex + 1; $i < count($fileRows); $i++) {
                    $data = $fileRows[$i];
                    if (empty(implode('', $data))) continue;

                    $client_name = ($map['name'] > -1 && isset($data[$map['name']])) ? trim($data[$map['name']]) : 'Imported User';
                    $email = ($map['email'] > -1 && isset($data[$map['email']])) ? strtolower(trim($data[$map['email']])) : '';
                    $phone = ($map['phone'] > -1 && isset($data[$map['phone']])) ? trim($data[$map['phone']]) : '';
                    $company = ($map['company'] > -1 && isset($data[$map['company']])) ? trim($data[$map['company']]) : '';
                    $msg_text = ($map['message'] > -1 && isset($data[$map['message']])) ? trim($data[$map['message']]) : '';
                    $user_role = ($map['user_role'] > -1 && isset($data[$map['user_role']])) ? trim($data[$map['user_role']]) : '';
                    $order_volume = ($map['order_volume'] > -1 && isset($data[$map['order_volume']])) ? trim($data[$map['order_volume']]) : '';

                    $preferred_date_raw = ($map['preferred_date'] > -1 && isset($data[$map['preferred_date']])) ? trim($data[$map['preferred_date']]) : '';
                    $preferred_date = '';
                    if (!empty($preferred_date_raw)) {
                        $pdObj = DateTime::createFromFormat('m/d/Y', $preferred_date_raw);
                        if (!$pdObj) $pdObj = DateTime::createFromFormat('n/j/Y', $preferred_date_raw);
                        if (!$pdObj) $pdObj = DateTime::createFromFormat('Y-m-d', $preferred_date_raw);
                        $preferred_date = $pdObj ? $pdObj->format('Y-m-d') : $preferred_date_raw;
                    }

                    $date_raw = ($map['date'] > -1 && isset($data[$map['date']])) ? trim($data[$map['date']]) : '';
                    $created_at = date('Y-m-d H:i:s');
                    if (!empty($date_raw)) {
                        $dateObj = DateTime::createFromFormat('m/d/Y G:i', $date_raw); 
                        if (!$dateObj) $dateObj = DateTime::createFromFormat('M/d/Y', $date_raw); 
                        if ($dateObj) {
                            $created_at = $dateObj->format('Y-m-d H:i:s');
                        } else {
                            $ts = strtotime(str_replace('/', ' ', $date_raw));
                            if (!$ts) $ts = strtotime($date_raw);
                            if ($ts) $created_at = date('Y-m-d H:i:s', $ts);
                        }
                    }

                    try {
                        $sql = "INSERT INTO leads (client_name, email, phone, company, message, user_role, order_volume, form_name, source, status, created_at, preferred_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'CSV Import', 'new', ?, ?)";
                        $stmt = $pdo->prepare($sql);
                        $stmt->execute([$client_name, $email, $phone, $company, $msg_text, $user_role, $order_volume, $form_name, $created_at, $preferred_date]);
                        $count++;
                    } catch (PDOException $e) { }
                }
                $message = "Success! Form: <b>$form_name</b>. Imported <b>$count</b> leads.";
                $msgType = "success";
            }
        } else { $message = "Invalid format."; $msgType = "danger"; }
    }
}
require_once '../includes/header.php';
?>
<div class="main-content"><div class="page-content"><div class="container-fluid"><div class="row justify-content-center"><div class="col-md-6">
    <div class="d-flex align-items-center justify-content-between mb-4"><h4 class="mb-0">Import: <?php echo $form_name; ?></h4><a href="<?php echo BASE_URL; ?>leads-list.php" class="btn btn-light btn-sm">Back</a></div>
    <?php if (!empty($message)): ?><div class="alert alert-<?php echo $msgType; ?> alert-dismissible"><?php echo $message; ?><button type="button" class="btn-close" data-bs-dismiss="alert"></button></div><?php endif; ?>
    <div class="card shadow-sm"><div class="card-body">
        <form method="POST" enctype="multipart/form-data" id="importForm">
            <input type="hidden" name="import_btn" value="1">
            <div class="mb-3"><input type="file" class="form-control" name="csv_file" accept=".csv" required></div>
            <div class="d-grid mt-4"><button type="submit" id="importBtn" class="btn btn-primary">Upload & Import</button></div>
        </form>
    </div></div>
</div></div></div></div><?php require_once '../includes/footer.php'; ?></div>
<script> document.getElementById('importForm')?.addEventListener('submit', function() { document.getElementById('importBtn').innerHTML = 'Processing...'; document.getElementById('importBtn').disabled = true; }); </script>