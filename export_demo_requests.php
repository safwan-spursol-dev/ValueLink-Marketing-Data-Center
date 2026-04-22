<?php
// export_demo_requests.php
require_once 'config/db.php';
require_once 'includes/session_check.php';

// 1. Capture All 5 Filters (Jo demo-requests.php par hain)
$date_range    = isset($_GET['date_range']) ? $_GET['date_range'] : ''; 
$selected_role = isset($_GET['role_filter']) ? $_GET['role_filter'] : ''; 
$selected_vol  = isset($_GET['volume_filter']) ? $_GET['volume_filter'] : ''; 
$selected_qual = isset($_GET['qualification_filter']) ? $_GET['qualification_filter'] : ''; 
$selected_status = isset($_GET['status_filter']) ? $_GET['status_filter'] : ''; 

// 2. Build Query (Strictly for Demo Request Form)
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

// 3. Fetch Data
$sql = "SELECT * FROM leads $where_sql ORDER BY created_at DESC";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

// 4. Generate Native Excel XML
$filename = "Demo_Requests_Export_" . date('Y-m-d') . ".xls";

header("Content-Type: application/vnd.ms-excel; charset=UTF-8");
header("Content-Disposition: attachment; filename=\"$filename\"");
header("Pragma: no-cache");
header("Expires: 0");

echo '<?xml version="1.0"?>' . "\n";
echo '<?mso-application progid="Excel.Sheet"?>' . "\n";
echo '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"' . "\n";
echo '  xmlns:o="urn:schemas-microsoft-com:office:office"' . "\n";
echo '  xmlns:x="urn:schemas-microsoft-com:office:excel"' . "\n";
echo '  xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"' . "\n";
echo '  xmlns:html="http://www.w3.org/TR/REC-html40">' . "\n";
echo '  <Styles><Style ss:ID="Header"><Font ss:Bold="1" ss:Color="#FFFFFF"/><Interior ss:Color="#405189" ss:Pattern="Solid"/></Style></Styles>' . "\n";

echo '  <Worksheet ss:Name="Demo Requests">' . "\n";
echo '    <Table>' . "\n";

// Define Columns (Important fields shuru mein rakh li hain)
// Note: Backend ma column names abhi bhi 'qualification_scale' aur 'status' hain, jabky UI py MQL/SQL ha
$fixedColumns = ['id', 'client_name', 'email', 'phone', 'company', 'user_role', 'order_volume', 'qualification_scale', 'status', 'created_at'];

$dynamicKeys = [];
if (count($rows) > 0) {
    $allKeys = array_keys($rows[0]);
    $dynamicKeys = array_diff($allKeys, $fixedColumns, ['form_name', 'updated_at', 'assigned_to', 'event_title', 'source']); 
}

// Headers Print (Sirf yahan hum headings ko custom format kar rahy hain Excel ky liya)
echo '      <Row>' . "\n";
foreach ($fixedColumns as $col) {
    $headerName = strtoupper(str_replace('_', ' ', $col));
    // Excel sheet me bhi sir ki pasandida headings likh dain
    if ($col === 'qualification_scale') $headerName = 'MQL STATUS';
    if ($col === 'status') $headerName = 'SQL STATUS';
    
    echo '        <Cell ss:StyleID="Header"><Data ss:Type="String">' . htmlspecialchars($headerName) . '</Data></Cell>' . "\n";
}
foreach ($dynamicKeys as $col) {
    echo '        <Cell ss:StyleID="Header"><Data ss:Type="String">' . htmlspecialchars(strtoupper(str_replace('_', ' ', $col))) . '</Data></Cell>' . "\n";
}
echo '      </Row>' . "\n";

// Data Rows Print (N/A logic ke sath)
foreach ($rows as $row) {
    echo '      <Row>' . "\n";
    foreach ($fixedColumns as $col) {
        $val = isset($row[$col]) ? trim((string)$row[$col]) : '';
        if ($val === '') { $val = 'N/A'; }
        echo '        <Cell><Data ss:Type="String">' . htmlspecialchars($val) . '</Data></Cell>' . "\n";
    }
    foreach ($dynamicKeys as $col) {
        $val = isset($row[$col]) ? trim((string)$row[$col]) : '';
        if ($val === '') { $val = 'N/A'; }
        elseif (strlen($val) > 1000) { $val = substr($val, 0, 1000) . '...'; } // Excel crash protection
        echo '        <Cell><Data ss:Type="String">' . htmlspecialchars($val) . '</Data></Cell>' . "\n";
    }
    echo '      </Row>' . "\n";
}

echo '    </Table>' . "\n";
echo '  </Worksheet>' . "\n";
echo '</Workbook>';
exit;
?>