<?php
// import-case-study.php
require_once '../config/db.php'; 
require_once '../includes/session_check.php';

$message = "";
$msgType = "";
$form_name = "Case Study Form";
$headerRowIndex = 0;

if (isset($_POST['import_btn'])) {
    if ($_FILES['csv_file']['error'] == 0) {
        $name = $_FILES['csv_file']['name'];
        $ext = strtolower(pathinfo($name, PATHINFO_EXTENSION));
        
        if ($ext === 'csv') {
            $fileRows = [];
            if (($handle = fopen($_FILES['csv_file']['tmp_name'], "r")) !== FALSE) {
                while (($data = fgetcsv($handle)) !== FALSE) { $fileRows[] = $data; }
                fclose($handle);
            }

            if (count($fileRows) > 0) {
                $map = ['name'=>-1, 'company'=>-1, 'email'=>-1, 'phone'=>-1, 'user_role'=>-1, 'order_volume'=>-1, 'date'=>-1];

                if (isset($fileRows[$headerRowIndex])) {
                    $headers = $fileRows[$headerRowIndex];
                    foreach ($headers as $index => $colName) {
                        $clean_raw = preg_replace('/[\x00-\x1F\x80-\xFF]/', '', $colName); 
                        $col = strtolower(trim($clean_raw));

                        if (strpos($col, 'name') !== false) $map['name'] = $index;
                        elseif (strpos($col, 'company') !== false) $map['company'] = $index;
                        elseif (strpos($col, 'email') !== false) $map['email'] = $index;
                        elseif (strpos($col, 'phone') !== false) $map['phone'] = $index;
                        elseif (strpos($col, 'role') !== false) $map['user_role'] = $index;
                        elseif (strpos($col, 'volume') !== false) $map['order_volume'] = $index;
                        elseif ($col === 'submission create date') $map['date'] = $index;
                    }
                }

                $count = 0;
                for ($i = $headerRowIndex + 1; $i < count($fileRows); $i++) {
                    $data = $fileRows[$i];
                    if (empty(implode('', $data))) continue;

                    $client_name = ($map['name'] > -1 && isset($data[$map['name']])) ? trim($data[$map['name']]) : 'Imported User';
                    $company = ($map['company'] > -1 && isset($data[$map['company']])) ? trim($data[$map['company']]) : '';
                    $email = ($map['email'] > -1 && isset($data[$map['email']])) ? trim($data[$map['email']]) : '';
                    $phone = ($map['phone'] > -1 && isset($data[$map['phone']])) ? trim($data[$map['phone']]) : '';
                    $user_role = ($map['user_role'] > -1 && isset($data[$map['user_role']])) ? trim($data[$map['user_role']]) : '';
                    $order_volume = ($map['order_volume'] > -1 && isset($data[$map['order_volume']])) ? trim($data[$map['order_volume']]) : '';
                    
                    $date_raw = ($map['date'] > -1 && isset($data[$map['date']])) ? trim($data[$map['date']]) : '';
                    $created_at = date('Y-m-d H:i:s');
                    if (!empty($date_raw)) {
                        $ts = strtotime(str_replace('/', ' ', $date_raw));
                        if (!$ts) $ts = strtotime($date_raw);
                        if ($ts) $created_at = date('Y-m-d H:i:s', $ts);
                    }

                    try {
                        $sql = "INSERT INTO leads (client_name, company, email, phone, user_role, order_volume, form_name, source, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, 'CSV Import', 'new', ?)";
                        $stmt = $pdo->prepare($sql);
                        $stmt->execute([$client_name, $company, $email, $phone, $user_role, $order_volume, $form_name, $created_at]);
                        $count++;
                    } catch (PDOException $e) { }
                }
                $message = "Success! Form: <b>$form_name</b>. Imported <b>$count</b> leads.";
                $msgType = "success";
            }
        }
    }
}
require_once '../includes/header.php';
?>

<div class="main-content"><div class="page-content"><div class="container-fluid"><div class="row justify-content-center"><div class="col-md-6">
    <div class="d-flex align-items-center justify-content-between mb-4"><h4 class="mb-0">Import: <?php echo $form_name; ?></h4><a href="leads-list.php" class="btn btn-light btn-sm">Back</a></div>
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