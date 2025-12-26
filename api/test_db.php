<?php
// Errors screen par dikhao taaky humein pata chale masla kya hai
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

echo "<h2>🕵️‍♂️ System Diagnostic Tool</h2>";

// 1. Check Current Location
echo "<p><strong>Current Folder (API):</strong> " . __DIR__ . "</p>";

// 2. Check DB File Path
// Hum maan ke chal rahe hain ke config folder ek step peeche hai (../config)
$expected_path = __DIR__ . '/../config/db.php';
$real_path = realpath($expected_path);

echo "<p><strong>Looking for DB at:</strong> " . $expected_path . "</p>";

if (file_exists($expected_path)) {
    echo "<p style='color:green; font-weight:bold;'>✅ File Found! (Real Path: $real_path)</p>";
} else {
    echo "<p style='color:red; font-weight:bold;'>❌ File NOT Found! Path ghalat hai.</p>";
    
    // Debugging Hint: Parent folder ma kya kya hai?
    echo "<p><strong>Parent Directory List:</strong></p><pre>";
    print_r(scandir(__DIR__ . '/../'));
    echo "</pre>";
    exit; // Aage mat jao agar file hi nahi mili
}

// 3. Try Connection
echo "<hr><p><strong>Attempting Database Connection...</strong></p>";
try {
    require_once $expected_path;

    if (isset($pdo)) {
        echo "<p style='color:green; font-weight:bold; font-size: 20px;'>🎉 SUCCESS: Database Connected Successfully!</p>";
        echo "<p>Ab tum receive_lead.php fix kar sakte ho!</p>";
    } else {
        echo "<p style='color:red;'>❌ Error: File mili lekin '$pdo' variable set nahi hua. db.php ka code check karo.</p>";
    }
} catch (Exception $e) {
    echo "<p style='color:red;'>❌ CRITICAL DB ERROR: " . $e->getMessage() . "</p>";
    echo "<p>Tip: Apne DB username/password check karo live server par.</p>";
}
?>