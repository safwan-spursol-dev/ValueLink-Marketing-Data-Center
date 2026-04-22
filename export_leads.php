<?php
// export_leads.php
require_once 'config/db.php';
require_once 'includes/session_check.php';

// 1. Capture Filters (Jo URL se aa rahy hain)
$selected_form   = isset($_GET['form_filter']) ? $_GET['form_filter'] : '';
$date_range      = isset($_GET['date_range']) ? $_GET['date_range'] : ''; 
$selected_qual   = isset($_GET['qualification_filter']) ? $_GET['qualification_filter'] : ''; 
$selected_status = isset($_GET['status_filter']) ? $_GET['status_filter'] : ''; 

// 2. Build Query
$where_clauses = [];
$params = [];

if (!empty($selected_form)) {
    $where_clauses[] = "leads.form_name = ?";
    $params[] = $selected_form;
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
        $params[] = trim($dates[0]); 
        $params[] = trim($dates[1]); 
    } else {
        $where_clauses[] = "DATE(leads.created_at) = ?";
        $params[] = trim($dates[0]);
    }
}

$where_sql = "";
if (count($where_clauses) > 0) {
    $where_sql = "WHERE " . implode(" AND ", $where_clauses);
}

// 3. Fetch Data from DB
$sql = "SELECT * FROM leads $where_sql ORDER BY form_name ASC, created_at DESC";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$leads = $stmt->fetchAll(PDO::FETCH_ASSOC);

// 4. Group Data by Form Name
$grouped_leads = [];
foreach ($leads as $lead) {
    $formName = !empty($lead['form_name']) ? $lead['form_name'] : 'Unknown Form';
    $grouped_leads[$formName][] = $lead;
}

// 5. Generate Native Excel XML (SpreadsheetML) File
$filename = "Leads_Export_" . date('Y-m-d') . ".xls";

header("Content-Type: application/vnd.ms-excel; charset=UTF-8");
header("Content-Disposition: attachment; filename=\"$filename\"");
header("Pragma: no-cache");
header("Expires: 0");

// XML Excel Header
echo '<?xml version="1.0"?>' . "\n";
echo '<?mso-application progid="Excel.Sheet"?>' . "\n";
echo '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"' . "\n";
echo '  xmlns:o="urn:schemas-microsoft-com:office:office"' . "\n";
echo '  xmlns:x="urn:schemas-microsoft-com:office:excel"' . "\n";
echo '  xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"' . "\n";
echo '  xmlns:html="http://www.w3.org/TR/REC-html40">' . "\n";

// Style for Headers
echo '  <Styles>' . "\n";
echo '    <Style ss:ID="Header">' . "\n";
echo '      <Font ss:Bold="1" ss:Color="#FFFFFF"/>' . "\n";
echo '      <Interior ss:Color="#405189" ss:Pattern="Solid"/>' . "\n";
echo '    </Style>' . "\n";
echo '  </Styles>' . "\n";

// Loop through each Form to create a Separate Sheet
foreach ($grouped_leads as $formName => $rows) {
    
    // Clean Sheet Name
    $sheetName = preg_replace('/[\\\\\/\?\*\[\]:]/', '', $formName);
    $sheetName = substr($sheetName, 0, 31);
    
    echo '  <Worksheet ss:Name="' . htmlspecialchars($sheetName) . '">' . "\n";
    echo '    <Table>' . "\n";

    // Define Fixed Columns & Find Dynamic Columns
    $fixedColumns = ['id', 'client_name', 'email', 'phone', 'company', 'qualification_scale', 'status', 'created_at'];
    
    $dynamicKeys = [];
    if (count($rows) > 0) {
        $allKeys = array_keys($rows[0]);
        $dynamicKeys = array_diff($allKeys, $fixedColumns, ['form_name', 'updated_at', 'assigned_to']); 
    }

    // --- ROW 1: TABLE HEADERS ---
    echo '      <Row>' . "\n";
    foreach ($fixedColumns as $col) {
        echo '        <Cell ss:StyleID="Header"><Data ss:Type="String">' . htmlspecialchars(strtoupper(str_replace('_', ' ', $col))) . '</Data></Cell>' . "\n";
    }
    foreach ($dynamicKeys as $col) {
        echo '        <Cell ss:StyleID="Header"><Data ss:Type="String">' . htmlspecialchars(strtoupper(str_replace('_', ' ', $col))) . '</Data></Cell>' . "\n";
    }
    echo '      </Row>' . "\n";

    // --- ROW 2+: DATA ROWS ---
    foreach ($rows as $row) {
        echo '      <Row>' . "\n";
        
        // ✨ Print Fixed Data (With N/A Logic) ✨
        foreach ($fixedColumns as $col) {
            $val = isset($row[$col]) ? trim((string)$row[$col]) : '';
            
            // Agar field khali ha to 'N/A' assign kar do
            if ($val === '') {
                $val = 'N/A';
            }
            
            echo '        <Cell><Data ss:Type="String">' . htmlspecialchars($val) . '</Data></Cell>' . "\n";
        }
        
        // ✨ Print Dynamic Data (With N/A Logic) ✨
        foreach ($dynamicKeys as $col) {
            $val = isset($row[$col]) ? trim((string)$row[$col]) : '';
            
            // Agar field khali ha to 'N/A' assign kar do
            if ($val === '') {
                $val = 'N/A';
            } else {
                // Trim very long messages to prevent Excel crash
                if (strlen($val) > 1000) { 
                    $val = substr($val, 0, 1000) . '...'; 
                }
            }
            
            echo '        <Cell><Data ss:Type="String">' . htmlspecialchars($val) . '</Data></Cell>' . "\n";
        }
        
        echo '      </Row>' . "\n";
    }

    echo '    </Table>' . "\n";
    echo '  </Worksheet>' . "\n";
}

// Close Excel Workbook
echo '</Workbook>';
exit;
?>