<?php
// 1. Database Connect karo
require_once 'config/db.php';

echo "<h3>Testing Auto-Assignment Logic...</h3>";

// ======================================================
// 🧠 STEP 1: RANDOM SALES AGENT DHUNDO (Yehi Logic API ma bhi hogi)
// ======================================================
try {
    // Sirf wahi users uthao jo 'sales' role ke hain aur active hain
    $stmt = $pdo->query("SELECT id, name FROM users WHERE role = 'sales' AND is_active = '1' ORDER BY RAND() LIMIT 1");
    $agent = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($agent) {
        $assigned_to = $agent['id'];
        $agent_name = $agent['name'];
        echo "✅ Selected Agent: <b>" . htmlspecialchars($agent_name) . "</b> (ID: $assigned_to)<br>";
    } else {
        $assigned_to = null; // Agar koi sales agent nahi mila
        echo "⚠️ No Sales Agent Found! Lead will be unassigned.<br>";
    }

    // ======================================================
    // 💾 STEP 2: DUMMY LEAD INSERT KARO
    // ======================================================
    
    // Dummy Data
    $client_name = "Test User Localhost";
    $email = "test" . rand(100, 999) . "@localhost.com";
    $phone = "0300-1234567";
    $source = "Local Test";
    $message = "Checking auto assignment logic.";
    
    $sql = "INSERT INTO leads (client_name, email, phone, source, message, assigned_to, status, created_at) 
            VALUES (?, ?, ?, ?, ?, ?, 'new', NOW())";
            
    $insertStmt = $pdo->prepare($sql);
    $insertStmt->execute([$client_name, $email, $phone, $source, $message, $assigned_to]);

    echo "🎉 Lead Inserted Successfully! Check your Dashboard.";

} catch (PDOException $e) {
    echo "❌ Error: " . $e->getMessage();
}
?>