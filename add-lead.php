<?php
// add-lead.php
require_once 'config/db.php'; 
require_once 'includes/session_check.php';

$message = "";
$msgType = "";

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['add_lead_btn'])) {
    
    // 1. Basic Fields Fetching
    $selected_form_type = $_POST['form_type'] ?? '';
    $client_name        = trim($_POST['client_name'] ?? '');
    $company            = trim($_POST['company'] ?? '');
    $email              = strtolower(trim($_POST['email'] ?? ''));
    $phone              = trim($_POST['phone'] ?? '');
    
    // ✨ NAYA FIELD: Job Title Fetching
    $job_title          = trim($_POST['job_title'] ?? ''); 
    $user_role          = trim($_POST['user_role'] ?? '');
    $order_volume       = trim($_POST['order_volume'] ?? '');
    $msg_text           = trim($_POST['message'] ?? '');

    // 2. Date Fields Fetching
    $submission_date = trim($_POST['submission_date'] ?? ''); 
    $preferred_date  = trim($_POST['preferred_date'] ?? '');  
    $general_date    = trim($_POST['general_date'] ?? '');    

    if (empty($selected_form_type) || empty($client_name)) {
        $message = "Form Type and Name are required fields.";
        $msgType = "danger";
    } else {
        
        $form_name = "";
        $db_preferred_date = NULL;
        $db_event_title = NULL;

        // ====================================================
        // 🧠 SMART MAPPING LOGIC 
        // ====================================================
        // Yahan form value se uska proper naam set ho raha hai
        $form_names_map = [
            'demo_request' => 'Demo Request Form',
            'contact_us' => 'Contact Us Form',
            'newsletter' => 'Newsletter Subscription Form',
            'mobile_demo' => 'Request a Demo Form Mobile View',
            'events_form' => 'Events Form',
            'lenders_checklist' => "Lender's Checklist Download Form",
            'omni_demo' => 'Omni Demo Request Form',
            'crosscheck_demo' => 'CrossCheck Demo Request',
            'integrations' => 'Integrations Form',
            'case_study' => 'Case Study Form',
            'case_study_vandyk' => 'Case Study Form - VanDyk Mortgage',
            'case_study_anniemac' => 'Case Study Form - ValueLink Partners with AnnieMac',
            'case_study_georgemason' => 'Case Study Form - George Mason Mortgage'
        ];

        $form_name = $form_names_map[$selected_form_type] ?? "Unknown Form";

        if ($selected_form_type === 'demo_request' || $selected_form_type === 'omni_demo' || $selected_form_type === 'crosscheck_demo' || $selected_form_type === 'case_study_anniemac') {
            $db_preferred_date = !empty($preferred_date) ? $preferred_date : NULL;
        }
        if ($selected_form_type === 'events_form') {
            $db_event_title = !empty($general_date) ? $general_date : NULL;
        }

        // ====================================================
        // 🗓️ CREATED_AT HANDLING
        // ====================================================
        $created_at = date('Y-m-d H:i:s'); 
        if (!empty($submission_date)) {
            $created_at = date('Y-m-d H:i:s', strtotime($submission_date));
        } elseif (!empty($general_date) && $selected_form_type !== 'events_form') {
            $created_at = date('Y-m-d H:i:s', strtotime($general_date));
        }

        // ====================================================
        // 🚀 DATABASE INSERTION
        // ====================================================
        try {
            // ✨ SQL UPDATE: job_title column added here
            $sql = "INSERT INTO leads 
                    (client_name, email, phone, company, job_title, message, user_role, order_volume, form_name, source, status, created_at, preferred_date, event_title) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Manual Entry', 'new', ?, ?, ?)";
            
            $stmt = $pdo->prepare($sql);
            // ✨ BINDING UPDATE: $job_title passed to array
            $stmt->execute([
                $client_name, $email, $phone, $company, $job_title, $msg_text, 
                $user_role, $order_volume, $form_name, $created_at, 
                $db_preferred_date, $db_event_title
            ]);

            $message = "Success! Lead added manually under <b>$form_name</b>.";
            $msgType = "success";

        } catch (PDOException $e) {
            $message = "Database Error: " . $e->getMessage();
            $msgType = "danger";
        }
    }
}

require_once 'includes/header.php';
?>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row">
                <div class="col-12">
                    <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                        <h4 class="mb-sm-0">Add New Lead</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="leads-list.php">Leads</a></li>
                                <li class="breadcrumb-item active">Add Lead</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-8">
                    
                    <?php if (!empty($message)): ?>
                        <div class="alert alert-<?php echo $msgType; ?> alert-dismissible fade show" role="alert">
                            <?php echo $message; ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <?php endif; ?>

                    <div class="card shadow-sm">
                        <div class="card-header bg-white py-3 border-bottom">
                            <h6 class="card-title mb-0">Lead Details Form</h6>
                        </div>
                        <div class="card-body">
                            <form method="POST" action="add-lead.php">
                                
                                <div class="row g-3">
                                    <div class="col-md-12 mb-2">
                                        <label class="form-label fw-bold">Form Type (Target) <span class="text-danger">*</span></label>
                                        <select name="form_type" class="form-select" required>
                                            <option value="" selected disabled>-- Select Form --</option>
                                            <option value="demo_request">Demo Request Form</option>
                                            <option value="mobile_demo">Request a Demo Form (Mobile)</option>
                                            <option value="contact_us">Contact Us Form</option>
                                            <option value="events_form">Events Form</option>
                                            <option value="newsletter">Newsletter Subscription Form</option>
                                            <option value="lenders_checklist">Lender's Checklist Download Form</option>
                                            <option value="omni_demo">Omni Demo Request Form</option>
                                            <option value="crosscheck_demo">CrossCheck Demo Request</option>
                                            <option value="integrations">Integrations Form</option>
                                            <option value="case_study">Case Study Form</option>
                                            <option value="case_study_vandyk">Case Study Form - VanDyk Mortgage</option>
                                            <option value="case_study_anniemac">Case Study Form - ValueLink Partners with AnnieMac</option>
                                            <option value="case_study_georgemason">Case Study Form - George Mason Mortgage</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="client_name" placeholder="e.g. John Doe" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Company</label>
                                        <input type="text" class="form-control" name="company" placeholder="e.g. Acme Corp">
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Email Address</label>
                                        <input type="email" class="form-control" name="email" placeholder="e.g. john@example.com">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Phone Number</label>
                                        <input type="text" class="form-control" name="phone" placeholder="e.g. +1 234 567 8900">
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label">Job Title</label>
                                        <input type="text" class="form-control" name="job_title" placeholder="e.g. CEO, Manager">
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">User Role</label>
                                        <input type="text" class="form-control" name="user_role" placeholder="e.g. Lender, AMC">
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Order Volumes</label>
                                        <select name="order_volume" class="form-select">
                                            <option value="">- Select Volume -</option>
                                            <option value="0–99 orders / month">0–99 orders / month</option>
                                            <option value="100–499 orders / month">100–499 orders / month</option>
                                            <option value="500–999 orders / month">500–999 orders / month</option>
                                            <option value="1,000–4,999 orders / month">1,000–4,999 orders / month</option>
                                            <option value="5,000+ orders / month">5,000+ orders / month</option>
                                            <option value="Not sure / exploring options">Not sure / exploring options</option>
                                        </select>
                                    </div>

                                    <div class="col-md-12 mt-4">
                                        <h6 class="fw-bold text-muted border-bottom pb-2">Date Fields (Form Specific)</h6>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label">Submission Create Date</label>
                                        <input type="datetime-local" class="form-control" name="submission_date" title="Leave blank for Current Time">
                                        <small class="text-muted fs-11">Overrides system timestamp</small>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Preferred Date</label>
                                        <input type="date" class="form-control" name="preferred_date">
                                        <small class="text-muted fs-11">Used in Demo Requests & AnnieMac</small>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">General Date</label>
                                        <input type="date" class="form-control" name="general_date">
                                        <small class="text-muted fs-11">Becomes Event Title in Events Form</small>
                                    </div>

                                    <div class="col-md-12 mt-3">
                                        <label class="form-label">Message / Looking For</label>
                                        <textarea class="form-control" name="message" rows="4" placeholder="Enter client's message..."></textarea>
                                    </div>

                                    <div class="col-md-12 mt-4 text-end">
                                        <a href="leads-list.php" class="btn btn-light me-2">Cancel</a>
                                        <button type="submit" name="add_lead_btn" class="btn btn-primary">
                                            <i class="ri-save-line align-bottom me-1"></i> Save Lead
                                        </button>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <?php require_once 'includes/footer.php'; ?>
</div>