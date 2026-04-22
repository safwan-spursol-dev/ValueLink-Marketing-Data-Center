<?php
// cron_monthly_report.php
require_once __DIR__ . '/config/db.php';

// PHPMailer classes (Apne path ke hisaab se adjust kar lena)
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

// Agar composer use kar rahy ho to ye line uncomment kar dena:
// require __DIR__ . '/vendor/autoload.php';

// Agar direct files rakhi hain to aisay link karo:
require __DIR__ . '/PHPMailer/src/Exception.php';
require __DIR__ . '/PHPMailer/src/PHPMailer.php';
require __DIR__ . '/PHPMailer/src/SMTP.php';

// =========================================================
// 1. FETCH DATA (Pichle 30 din ka data)
// =========================================================
// Hum sirf pichle 1 maheene ka data utha rahy hain taaky report sirf recent data ki ho
$sql = "SELECT * FROM leads WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH) ORDER BY form_name ASC, created_at DESC";
$stmt = $pdo->query($sql);
$leads = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Group Data by Form Name (Alag alag sheets ke liye)
$grouped_leads = [];
foreach ($leads as $lead) {
    $formName = !empty($lead['form_name']) ? $lead['form_name'] : 'Unknown Form';
    $grouped_leads[$formName][] = $lead;
}

// =========================================================
// 2. GENERATE EXCEL FILE (IN MEMORY)
// =========================================================
$xml = '<?xml version="1.0"?>' . "\n";
$xml .= '<?mso-application progid="Excel.Sheet"?>' . "\n";
$xml .= '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"' . "\n";
$xml .= '  xmlns:o="urn:schemas-microsoft-com:office:office"' . "\n";
$xml .= '  xmlns:x="urn:schemas-microsoft-com:office:excel"' . "\n";
$xml .= '  xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"' . "\n";
$xml .= '  xmlns:html="http://www.w3.org/TR/REC-html40">' . "\n";
$xml .= '  <Styles><Style ss:ID="Header"><Font ss:Bold="1" ss:Color="#FFFFFF"/><Interior ss:Color="#405189" ss:Pattern="Solid"/></Style></Styles>' . "\n";

if (count($grouped_leads) > 0) {
    foreach ($grouped_leads as $formName => $rows) {
        $sheetName = substr(preg_replace('/[\\\\\/\?\*\[\]:]/', '', $formName), 0, 31);
        
        $xml .= '  <Worksheet ss:Name="' . htmlspecialchars($sheetName) . '">' . "\n";
        $xml .= '    <Table>' . "\n";

        $fixedColumns = ['id', 'client_name', 'email', 'phone', 'company', 'qualification_scale', 'status', 'created_at'];
        $dynamicKeys = [];
        if (count($rows) > 0) {
            $allKeys = array_keys($rows[0]);
            $dynamicKeys = array_diff($allKeys, $fixedColumns, ['form_name', 'updated_at', 'assigned_to']); 
        }

        // Headers
        $xml .= '      <Row>' . "\n";
        foreach ($fixedColumns as $col) {
            $hName = strtoupper(str_replace('_', ' ', $col));
            if($col == 'qualification_scale') $hName = 'MQL STATUS';
            if($col == 'status') $hName = 'SQL STATUS';
            $xml .= '        <Cell ss:StyleID="Header"><Data ss:Type="String">' . htmlspecialchars($hName) . '</Data></Cell>' . "\n";
        }
        foreach ($dynamicKeys as $col) {
            $xml .= '        <Cell ss:StyleID="Header"><Data ss:Type="String">' . htmlspecialchars(strtoupper(str_replace('_', ' ', $col))) . '</Data></Cell>' . "\n";
        }
        $xml .= '      </Row>' . "\n";

        // Rows
        foreach ($rows as $row) {
            $xml .= '      <Row>' . "\n";
            foreach ($fixedColumns as $col) {
                $val = isset($row[$col]) ? trim((string)$row[$col]) : '';
                if ($val === '') $val = 'N/A';
                $xml .= '        <Cell><Data ss:Type="String">' . htmlspecialchars($val) . '</Data></Cell>' . "\n";
            }
            foreach ($dynamicKeys as $col) {
                $val = isset($row[$col]) ? trim((string)$row[$col]) : '';
                if ($val === '') $val = 'N/A';
                elseif (strlen($val) > 1000) $val = substr($val, 0, 1000) . '...';
                $xml .= '        <Cell><Data ss:Type="String">' . htmlspecialchars($val) . '</Data></Cell>' . "\n";
            }
            $xml .= '      </Row>' . "\n";
        }
        $xml .= '    </Table>' . "\n";
        $xml .= '  </Worksheet>' . "\n";
    }
} else {
    // Agar koi data na ho
    $xml .= '  <Worksheet ss:Name="No Data"><Table><Row><Cell><Data ss:Type="String">No leads found for this month.</Data></Cell></Row></Table></Worksheet>' . "\n";
}
$xml .= '</Workbook>';

// Save Temporary File
$filename = __DIR__ . '/Monthly_Leads_Report_' . date('M_Y') . '.xls';
file_put_contents($filename, $xml);

// =========================================================
// 3. SEND EMAIL VIA PHPMAILER
// =========================================================
$mail = new PHPMailer(true);

try {
    // SMTP Settings
    $mail->isSMTP();
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = 'valuelinkmarketing@gmail.com'; // Sender Email
    $mail->Password   = 'mlzgvaalybhzbkns'; // ✨ Step 1 wala App Password yahan dalo
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port       = 587;

    // Email Info
    $mail->setFrom('valuelinkmarketing@gmail.com', 'ValueLink CRM System');
    $mail->addAddress('safwanshaekh55@gmail.com');     // Receiver Email (Tumhara email)

    // Attachments
    $mail->addAttachment($filename); 

    // Content
    $mail->isHTML(true);
    $mail->Subject = 'Automated Monthly Leads Report - ' . date('F Y');
    
    $total_leads_count = count($leads);
    $mail->Body    = "
        <h3>Monthly Leads Report</h3>
        <p>Hello Team,</p>
        <p>Please find attached the automated leads report for the last 30 days.</p>
        <p><b>Total Leads Generated:</b> $total_leads_count</p>
        <br>
        <p>Best Regards,<br>ValueLink-Marketing-Data-Center</p>
    ";

    $mail->send();
    // echo 'Report has been sent successfully.';

} catch (Exception $e) {
    // echo "Report could not be sent. Mailer Error: {$mail->ErrorInfo}";
}

// Delete the temporary file after sending
if (file_exists($filename)) {
    unlink($filename);
}
?>