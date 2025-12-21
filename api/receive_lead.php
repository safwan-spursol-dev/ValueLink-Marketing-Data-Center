<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

require_once '../db.php'; 

// Security Key
$SECRET_API_KEY = "vmdc_live_sec_882299_secure"; 

// Authorization Check
$headers = getallheaders();
$received_key = "";
if (isset($headers['Authorization'])) { $received_key = $headers['Authorization']; }
elseif (isset($headers['authorization'])) { $received_key = $headers['authorization']; }

if ($received_key !== $SECRET_API_KEY) {
    http_response_code(401);
    echo json_encode(["status" => "error", "message" => "Access Denied"]);
    exit;
}

// Receive Data
$data = json_decode(file_get_contents("php://input"), true);

if (empty($data)) {
    http_response_code(400);
    echo json_encode(["status" => "error", "message" => "No data"]);
    exit;
}

// Data Mapping (City Removed)
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

try {
    // Insert Query (City Removed)
    $sql = "INSERT INTO leads 
            (client_name, email, phone, company, message, user_role, order_volume, preferred_date, event_title, source, form_name, submission_url, status, created_at) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'new', NOW())";
            
    $stmt = $pdo->prepare($sql);
    
    $stmt->execute([
        $client_name, $email, $phone, $company, $message, 
        $user_role, $order_volume, $preferred_date, $event_title, 
        $source, $form_name, $sub_url
    ]);
    
    http_response_code(201); 
    echo json_encode(["status" => "success", "message" => "Lead saved successfully"]);

} catch (Exception $e) {
    error_log("API Error: " . $e->getMessage());
    http_response_code(500); 
    echo json_encode(["status" => "error", "message" => "Server Error"]);
}
?>