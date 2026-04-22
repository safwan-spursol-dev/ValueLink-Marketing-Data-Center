<?php
// auto_cron.php
// Ye file background mein check karti hai ke automation chalani hai ya nahi.

$target_day = '05'; // Kis tareekh ko mail bhejni hai
$current_day = date('d');
$current_month = date('Y-m'); // Example: 2026-04
$log_file = __DIR__ . '/cron_last_run.txt'; // Is file mein record save hoga

// 1. Check karo kya aaj 24 tareekh hai?
if ($current_day === $target_day) {
    
    // 2. Check karo kya is maheene already run ho chuka hai?
    $last_run = file_exists($log_file) ? trim(file_get_contents($log_file)) : '';

    if ($last_run !== $current_month) {
        
        // 3. Fauran log file update kardo taaky agar 2 user ek sath page kholien to 2 emails na jayen
        file_put_contents($log_file, $current_month);

        // 4. Email bhejne wali script ko background mein chala do
        try {
            require_once __DIR__ . '/cron_monthly_report.php';
        } catch (Exception $e) {
            // Agar koi error aaye to page break na ho, chup chap ignore karde
            error_log("Monthly Cron Error: " . $e->getMessage());
        }
    }
}
?>