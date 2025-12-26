<?php
// 1. ERROR LOGGING
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
ini_set('log_errors', 1);
ini_set('error_log', __DIR__ . '/api_errors.log');

// Log Start
file_put_contents(__DIR__ . '/api_debug.log', "--- New Request at " . date('H:i:s') . " ---\n", FILE_APPEND);

// 2. HEADERS
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

// Polyfill for getallheaders (Hostinger Safety)
if (!function_exists('getallheaders')) {
    function getallheaders() {
        $headers = [];
        foreach ($_SERVER as $name => $value) {
            if (substr($name, 0, 5) == 'HTTP_') {
                $headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value;
            }
        }
        return $headers;
    }
}

try {
    // 3. DB CONNECTION
    $db_path = '../config/db.php'; 
    if (!file_exists($db_path)) throw new Exception("Config File Missing");
    require_once $db_path; 

    // 4. AUTH CHECK
    $SECRET_API_KEY = "vmdc_live_sec_882299_secure"; 
    $headers = getallheaders();
    $received_key = "";
    if (isset($headers['Authorization'])) { $received_key = $headers['Authorization']; }
    elseif (isset($headers['authorization'])) { $received_key = $headers['authorization']; }

    if ($received_key !== $SECRET_API_KEY) throw new Exception("Access Denied");

    // 5. RECEIVE DATA
    $input_data = file_get_contents("php://input");
    $data = json_decode($input_data, true);
    if (empty($data)) throw new Exception("No JSON Data Received.");

    // MAPPING
    $client_name    = $data['name'] ?? 'Unknown';
    $email          = $data['email'] ?? null;
    $phone          = $data['phone'] ?? null;
    $company        = $data['company'] ?? null;
    $message        = $data['message'] ?? null;
    $user_role      = $data['user_role'] ?? null;
    $order_volume   = $data['order_volume'] ?? null;
    $preferred_date = $data['preferred_date'] ?? null;
    $event_title    = $data['event_title'] ?? null;
    $source         = $data['source'] ?? 'Web API';
    $form_name      = $data['form_name'] ?? 'Unknown Form';
    $sub_url        = $data['submission_url'] ?? '';

    // ======================================================
    // 6. AUTO-ASSIGNMENT LOGIC (RANDOM) 🎲
    // ======================================================
    
    $assigned_user_id = null;

    // A. Sari Sales Team fetch karo
    $teamStmt = $pdo->query("SELECT id FROM users WHERE role = 'sales'");
    $sales_team = $teamStmt->fetchAll(PDO::FETCH_COLUMN); // e.g., [2, 5, 8]

    // B. Random Selection
    if (!empty($sales_team)) {
        // array_rand() hamein Random KEY dega (Value nahi)
        $random_key = array_rand($sales_team);
        
        // Us key ke zariye User ID uthao
        $assigned_user_id = $sales_team[$random_key];
    }
    
    // ======================================================

    // 7. INSERT QUERY
    $sql = "INSERT INTO leads 
            (client_name, email, phone, company, message, user_role, order_volume, preferred_date, event_title, source, form_name, submission_url, status, assigned_to, created_at) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'new', ?, NOW())";
            
    $stmt = $pdo->prepare($sql);
    
    if($stmt->execute([
        $client_name, $email, $phone, $company, $message, 
        $user_role, $order_volume, $preferred_date, $event_title, 
        $source, $form_name, $sub_url, $assigned_user_id
    ])) {
        file_put_contents(__DIR__ . '/api_debug.log', "Result: SUCCESS (Randomly Assigned to ID: $assigned_user_id)\n\n", FILE_APPEND);
        http_response_code(200); 
        echo json_encode(["status" => "success", "message" => "Lead saved and randomly assigned."]);
    } else {
        throw new Exception("SQL Failed: " . implode(" - ", $stmt->errorInfo()));
    }

} catch (Exception $e) {
    file_put_contents(__DIR__ . '/api_debug.log', "ERROR: " . $e->getMessage() . "\n\n", FILE_APPEND);
    http_response_code(200); 
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>