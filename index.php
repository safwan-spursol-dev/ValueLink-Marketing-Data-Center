<?php
require_once 'config/db.php'; 
require_once 'includes/session_check.php';

$role = $_SESSION['role'];

// =========================================================
// 1. DATE FILTER LOGIC (DYNAMIC: OLDEST TO TODAY)
// =========================================================

    // Step A: Database se sabse purani date nikalo
    $minDateStmt = $pdo->query("SELECT MIN(created_at) FROM leads");
    $oldest_record = $minDateStmt->fetchColumn();

    // Step B: Agar data hai to wo date lo, warna current month ki 1st date (Fallback)
    if ($oldest_record) {
        $default_start = date('Y-m-d', strtotime($oldest_record));
    } else {
        $default_start = date('Y-m-01'); // Fallback for empty DB
    }

    $default_end = date('Y-m-d'); // Aaj ki date

    // Step C: Check karo agar user ne khud filter lagaya hai
    if (isset($_GET['date_range']) && !empty($_GET['date_range'])) {
        $dates = explode(' to ', $_GET['date_range']);
        $start_date = $dates[0];
        $end_date = isset($dates[1]) ? $dates[1] : $dates[0]; 
    } else {
        // Agar user ne filter nahi chera, to Hamari Dynamic Range use karo
        $start_date = $default_start;
        $end_date = $default_end;
    }

// =========================================================
// 2. HELPER FUNCTIONS
// =========================================================
function getFilteredCount($pdo, $status = null, $start, $end) {
    if ($status) {
        $stmt = $pdo->prepare("SELECT COUNT(*) FROM leads WHERE status = ? AND DATE(created_at) BETWEEN ? AND ?");
        $stmt->execute([$status, $start, $end]);
    } else {
        $stmt = $pdo->prepare("SELECT COUNT(*) FROM leads WHERE DATE(created_at) BETWEEN ? AND ?");
        $stmt->execute([$start, $end]);
    }
    return $stmt->fetchColumn();
}

function getAllTimeCount($pdo, $status = null) {
    if ($status) {
        $stmt = $pdo->prepare("SELECT COUNT(*) FROM leads WHERE status = ?");
        $stmt->execute([$status]);
    } else {
        $stmt = $pdo->query("SELECT COUNT(*) FROM leads");
    }
    return $stmt->fetchColumn();
}

// =========================================================
// 3. FETCH DATA (COMMON & ROLE BASED)
// =========================================================

// --- A. CARDS DATA (ALL TIME) ---
$card_total = getAllTimeCount($pdo);
$card_new = getAllTimeCount($pdo, 'new');
$card_progress = getAllTimeCount($pdo, 'in_progress');
$card_won = getAllTimeCount($pdo, 'converted');
$card_lost = getAllTimeCount($pdo, 'lost');
$card_success_ratio = ($card_total > 0) ? round(($card_won / $card_total) * 100, 1) : 0;

// Marketing Top Stats (All Time)
$stmtSrcAll = $pdo->query("SELECT source, COUNT(*) as count FROM leads GROUP BY source ORDER BY count DESC LIMIT 1");
$topSourceAll = $stmtSrcAll->fetch(PDO::FETCH_ASSOC);
$stmtFormAll = $pdo->query("SELECT form_name, COUNT(*) as count FROM leads GROUP BY form_name ORDER BY count DESC LIMIT 1");
$topFormAll = $stmtFormAll->fetch(PDO::FETCH_ASSOC);

// --- B. CHARTS DATA (FILTERED) ---
$chart_new = getFilteredCount($pdo, 'new', $start_date, $end_date);
$chart_progress = getFilteredCount($pdo, 'in_progress', $start_date, $end_date);
$chart_won = getFilteredCount($pdo, 'converted', $start_date, $end_date);
$chart_lost = getFilteredCount($pdo, 'lost', $start_date, $end_date);
$statusCounts = [$chart_new, $chart_progress, $chart_won, $chart_lost];

// Sources Data
$stmtSrc = $pdo->prepare("SELECT source, COUNT(*) as count FROM leads WHERE DATE(created_at) BETWEEN ? AND ? GROUP BY source ORDER BY count DESC LIMIT 5");
$stmtSrc->execute([$start_date, $end_date]);
$sourcesData = $stmtSrc->fetchAll(PDO::FETCH_ASSOC);
$sourceLabels = []; $sourceCounts = [];
foreach($sourcesData as $s) { $sourceLabels[] = $s['source']; $sourceCounts[] = $s['count']; }

// Forms Data
$stmtForm = $pdo->prepare("SELECT form_name, COUNT(*) as count FROM leads WHERE DATE(created_at) BETWEEN ? AND ? GROUP BY form_name ORDER BY count DESC LIMIT 5");
$stmtForm->execute([$start_date, $end_date]);
$formsData = $stmtForm->fetchAll(PDO::FETCH_ASSOC);


// =========================================================
// 4. SPECIAL DATA (ROLE SPECIFIC)
// =========================================================
$trendDates = []; $trendCounts = [];
$recentLogs = []; $recentLeads = []; $teamStats = [];
$qualityLabels = []; $qualityTotal = []; $qualityWon = [];
$freshLeads = []; $negotiationLeads = []; 

// ADMIN DATA
if ($role === 'admin') {
    $trendStmt = $pdo->prepare("SELECT DATE(created_at) as date, COUNT(*) as count FROM leads WHERE DATE(created_at) BETWEEN ? AND ? GROUP BY DATE(created_at) ORDER BY date ASC");
    $trendStmt->execute([$start_date, $end_date]);
    $trendData = $trendStmt->fetchAll(PDO::FETCH_ASSOC);
    foreach($trendData as $t) { $trendDates[] = date('d M, Y ', strtotime($t['date'])); $trendCounts[] = $t['count']; }

    $recentLogs = $pdo->query("SELECT l.description, l.created_at, u.name as user_name FROM activity_logs l LEFT JOIN users u ON l.user_id = u.id ORDER BY l.created_at DESC LIMIT 6")->fetchAll(PDO::FETCH_ASSOC);
    $recentLeads = $pdo->query("SELECT id, client_name, company, status, source, created_at FROM leads ORDER BY created_at DESC LIMIT 5")->fetchAll(PDO::FETCH_ASSOC);
    $teamStats = $pdo->query("SELECT u.name, u.role, COUNT(al.id) as total_activities, SUM(CASE WHEN al.description LIKE '%to \'Converted\'%' THEN 1 ELSE 0 END) as wins FROM users u LEFT JOIN activity_logs al ON u.id = al.user_id WHERE u.role != 'marketing' GROUP BY u.id ORDER BY wins DESC, total_activities DESC LIMIT 5")->fetchAll(PDO::FETCH_ASSOC);
}

// MARKETING DATA
if ($role === 'marketing') {
    $trendStmt = $pdo->prepare("SELECT DATE(created_at) as date, COUNT(*) as count FROM leads WHERE DATE(created_at) BETWEEN ? AND ? GROUP BY DATE(created_at) ORDER BY date ASC");
    $trendStmt->execute([$start_date, $end_date]);
    $trendData = $trendStmt->fetchAll(PDO::FETCH_ASSOC);
    foreach($trendData as $t) { $trendDates[] = date('d M, Y', strtotime($t['date'])); $trendCounts[] = $t['count']; }

    $recentLeads = $pdo->query("SELECT id, client_name, company, status, form_name, created_at FROM leads ORDER BY created_at DESC LIMIT 5")->fetchAll(PDO::FETCH_ASSOC);
    
    // Quality Chart
    $qualStmt = $pdo->prepare("SELECT source, COUNT(*) as total, SUM(CASE WHEN status = 'converted' THEN 1 ELSE 0 END) as won FROM leads WHERE DATE(created_at) BETWEEN ? AND ? GROUP BY source ORDER BY total DESC LIMIT 5");
    $qualStmt->execute([$start_date, $end_date]);
    $qualData = $qualStmt->fetchAll(PDO::FETCH_ASSOC);
    foreach($qualData as $q) { $qualityLabels[] = $q['source']; $qualityTotal[] = $q['total']; $qualityWon[] = $q['won']; }
}

// SALES DATA
if ($role === 'sales') {
    $freshLeads = $pdo->query("SELECT id, client_name, company, phone, created_at FROM leads WHERE status = 'new' ORDER BY created_at DESC LIMIT 5")->fetchAll(PDO::FETCH_ASSOC);
    $negotiationLeads = $pdo->query("SELECT id, client_name, company, phone, created_at FROM leads WHERE status = 'in_progress' ORDER BY created_at DESC LIMIT 5")->fetchAll(PDO::FETCH_ASSOC);
    $trendStmt = $pdo->prepare("SELECT DATE(created_at) as date, COUNT(*) as count FROM leads WHERE status = 'converted' AND DATE(created_at) BETWEEN ? AND ? GROUP BY DATE(created_at) ORDER BY date ASC");
    $trendStmt->execute([$start_date, $end_date]);
    $trendData = $trendStmt->fetchAll(PDO::FETCH_ASSOC);
    foreach($trendData as $t) { $trendDates[] = date('d M, Y', strtotime($t['date'])); $trendCounts[] = $t['count']; }
}

require_once 'includes/header.php';
?>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <div class="row mb-3 pb-1">
                <div class="col-12">
                    <div class="d-flex align-items-lg-center flex-lg-row flex-column">
                        <div class="flex-grow-1">
                            <h4 class="fs-16 mb-1">Dashboard</h4>
                            <p class="text-muted mb-0">Welcome back, <span class="fw-bold text-primary"><?php echo ucfirst($role); ?></span>!</p>
                        </div>
                        <div class="mt-3 mt-lg-0">
                            <form method="GET" action="index.php" id="dateFilterForm">
                                <div class="input-group">
                                    <input type="text" class="form-control border-0 dash-filter-picker shadow-sm" 
                                           name="date_range" id="date_range_picker"
                                           value="<?php echo htmlspecialchars($start_date . ' to ' . $end_date); ?>"
                                           style="min-width: 210px; background-color: #fff; cursor: pointer;" readonly>
                                    <div class="input-group-text bg-primary border-primary text-white">
                                        <i class="ri-calendar-2-line"></i>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <?php if ($role === 'admin'): ?>
                <div class="row">
                    <div class="col-xl-3 col-md-6"><div class="card card-animate overflow-hidden"><div class="card-body"><div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">Total Leads</p></div></div><div class="d-flex align-items-end justify-content-between mt-4"><div><h4 class="fs-22 fw-semibold ff-secondary mb-4"><?php echo $card_total; ?></h4></div><div class="avatar-sm flex-shrink-0"><span class="avatar-title bg-primary-subtle rounded fs-3"><i class="ri-team-line text-primary"></i></span></div></div></div></div></div>
                    <div class="col-xl-3 col-md-6"><div class="card card-animate overflow-hidden"><div class="card-body"><div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">Won</p></div></div><div class="d-flex align-items-end justify-content-between mt-4"><div><h4 class="fs-22 fw-semibold ff-secondary mb-4 text-success"><?php echo $card_won; ?></h4></div><div class="avatar-sm flex-shrink-0"><span class="avatar-title bg-success-subtle rounded fs-3"><i class="ri-trophy-line text-success"></i></span></div></div></div></div></div>
                    <div class="col-xl-3 col-md-6"><div class="card card-animate overflow-hidden"><div class="card-body"><div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">Lost</p></div></div><div class="d-flex align-items-end justify-content-between mt-4"><div><h4 class="fs-22 fw-semibold ff-secondary mb-4 text-danger"><?php echo $card_lost; ?></h4></div><div class="avatar-sm flex-shrink-0"><span class="avatar-title bg-danger-subtle rounded fs-3"><i class="ri-close-circle-line text-danger"></i></span></div></div></div></div></div>
                    <div class="col-xl-3 col-md-6"><div class="card card-animate overflow-hidden"><div class="card-body"><div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">Success Ratio</p></div></div><div class="d-flex align-items-end justify-content-between mt-4"><div><h4 class="fs-22 fw-semibold ff-secondary mb-4 text-warning"><?php echo $card_success_ratio; ?>%</h4></div><div class="avatar-sm flex-shrink-0"><span class="avatar-title bg-warning-subtle rounded fs-3"><i class="ri-pie-chart-line text-warning"></i></span></div></div></div></div></div>
                </div>
                <div class="row"><div class="col-12"><div class="card"><div class="card-header border-0 align-items-center d-flex"><h4 class="card-title mb-0 flex-grow-1">Lead Acquisition Trend</h4></div><div class="card-body p-0 pb-2"><div class="w-100"><div id="trend_chart" style="height: 300px;"></div></div></div></div></div></div>
                <div class="row">
                    <div class="col-xl-6"><div class="card card-height-100"><div class="card-header align-items-center d-flex"><h4 class="card-title mb-0 flex-grow-1">🏆 Team Performance</h4></div><div class="card-body"><div class="table-responsive table-card"><table class="table table-borderless table-centered align-middle table-nowrap mb-0"><thead class="text-muted table-light"><tr><th>Agent</th><th>Role</th><th>Activities</th><th>Deals Won</th></tr></thead><tbody><?php foreach($teamStats as $member): ?><tr><td><div class="d-flex align-items-center"><div class="flex-shrink-0 me-2"><div class="avatar-xs"><span class="avatar-title rounded-circle bg-primary-subtle text-primary"><?php echo strtoupper(substr($member['name'],0,1)); ?></span></div></div><div class="flex-grow-1"><?php echo htmlspecialchars($member['name']); ?></div></div></td><td><span class="badge bg-light text-body"><?php echo ucfirst($member['role']); ?></span></td><td><?php echo $member['total_activities']; ?></td><td><?php if($member['wins'] > 0): ?><span class="text-success fw-bold"><i class="ri-arrow-up-line"></i> <?php echo $member['wins']; ?></span><?php else: ?><span class="text-muted">0</span><?php endif; ?></td></tr><?php endforeach; ?></tbody></table></div></div></div></div>
                    <div class="col-xl-6"><div class="card card-height-100"><div class="card-header align-items-center d-flex"><h4 class="card-title mb-0 flex-grow-1">🕒 Recent Activity</h4></div><div class="card-body p-0"><div class="p-3"><?php foreach($recentLogs as $log): ?><div class="d-flex mb-3"><div class="flex-shrink-0 me-3"><div class="avatar-xs"><span class="avatar-title bg-light text-primary rounded-circle"><i class="ri-time-line"></i></span></div></div><div class="flex-grow-1"><p class="mb-1 text-muted"><?php echo htmlspecialchars($log['description']); ?> <small class="text-dark fw-medium">(<?php echo $log['user_name']; ?>)</small></p><small class="text-muted"><?php echo date('d M, h:i A', strtotime($log['created_at'])); ?></small></div></div><?php endforeach; ?></div></div></div></div>
                </div>
                <div class="row"><div class="col-xl-8"><div class="card"><div class="card-header align-items-center d-flex"><h4 class="card-title mb-0 flex-grow-1">🆕 Recent 5 Leads</h4><div class="flex-shrink-0"><a href="leads-list.php" class="btn btn-soft-primary btn-sm">View All</a></div></div><div class="card-body"><div class="table-responsive table-card"><table class="table table-nowrap table-striped-columns mb-0"><thead class="table-light"><tr><th>Name</th><th>Company</th><th>Source</th><th>Status</th><th>Received</th></tr></thead><tbody><?php foreach($recentLeads as $lead): ?><tr><td class="fw-medium"><?php echo htmlspecialchars($lead['client_name']); ?></td><td><?php echo htmlspecialchars($lead['company'] ?? '-'); ?></td><td><?php echo htmlspecialchars($lead['source']); ?></td><td><span class="badge bg-primary-subtle text-primary"><?php echo ucfirst($lead['status']); ?></span></td><td><?php echo date('d M', strtotime($lead['created_at'])); ?></td></tr><?php endforeach; ?></tbody></table></div></div></div></div><div class="col-xl-4"><div class="card"><div class="card-header"><h4 class="card-title mb-0">Status Overview</h4></div><div class="card-body"><div id="status_chart" style="height: 330px;"></div></div></div></div></div>

            <?php elseif ($role === 'marketing'): ?>
                <div class="row">
                    <div class="col-xl-3 col-md-6">
                        <div class="card card-animate overflow-hidden"> <div class="card-body">
                                <div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">Total Generated</p></div></div>
                                <div class="d-flex align-items-end justify-content-between mt-4">
                                    <div><h4 class="fs-22 fw-semibold ff-secondary mb-4"><?php echo $card_total; ?></h4></div> <div class="avatar-sm flex-shrink-0">
                                        <span class="avatar-title bg-primary-subtle rounded fs-3"><i class="ri-bar-chart-fill text-primary"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card card-animate overflow-hidden">
                            <div class="card-body">
                                <div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">Won (Quality)</p></div></div>
                                <div class="d-flex align-items-end justify-content-between mt-4">
                                    <div><h4 class="fs-22 fw-semibold ff-secondary mb-4 text-success"><?php echo $card_won; ?></h4></div>
                                    <div class="avatar-sm flex-shrink-0">
                                        <span class="avatar-title bg-success-subtle rounded fs-3"><i class="ri-check-double-line text-success"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card card-animate overflow-hidden">
                            <div class="card-body">
                                <div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">Conversion Rate</p></div></div>
                                <div class="d-flex align-items-end justify-content-between mt-4">
                                    <div><h4 class="fs-22 fw-semibold ff-secondary mb-4 text-info"><?php echo $card_success_ratio; ?>%</h4></div>
                                    <div class="avatar-sm flex-shrink-0">
                                        <span class="avatar-title bg-info-subtle rounded fs-3"><i class="ri-percent-line text-info"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card card-animate overflow-hidden">
                            <div class="card-body">
                                <div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">Lost Leads</p></div></div>
                                <div class="d-flex align-items-end justify-content-between mt-4">
                                    <div><h4 class="fs-22 fw-semibold ff-secondary mb-4 text-danger"><?php echo $card_lost; ?></h4></div>
                                    <div class="avatar-sm flex-shrink-0">
                                        <span class="avatar-title bg-danger-subtle rounded fs-3"><i class="ri-close-circle-line text-danger"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row"><div class="col-12"><div class="card"><div class="card-header border-0 align-items-center d-flex"><h4 class="card-title mb-0 flex-grow-1">Source Quality Analysis (Total vs Won)</h4></div><div class="card-body"><div id="quality_chart" style="height: 350px;"></div></div></div></div></div>
                <div class="row"><div class="col-xl-6"><div class="card card-height-100"><div class="card-header"><h4 class="card-title mb-0">Traffic Sources Breakdown</h4></div><div class="card-body"><div id="source_chart" style="height: 350px;"></div></div></div></div><div class="col-xl-6"><div class="card card-height-100"><div class="card-header"><h4 class="card-title mb-0">Lead Quality Analysis</h4></div><div class="card-body"><div id="status_chart" style="height: 350px;"></div></div></div></div></div>
                <div class="row"><div class="col-xl-6"><div class="card"><div class="card-header"><h4 class="card-title mb-0">Form Performance</h4></div><div class="card-body"><div class="table-responsive"><table class="table table-striped mb-0"><thead><tr><th>Form Name</th><th>Leads Generated</th></tr></thead><tbody><?php foreach($formsData as $f): ?><tr><td><?php echo htmlspecialchars($f['form_name']); ?></td><td><span class="badge bg-secondary"><?php echo $f['count']; ?></span></td></tr><?php endforeach; ?></tbody></table></div></div></div></div><div class="col-xl-6"><div class="card"><div class="card-header"><h4 class="card-title mb-0">🆕 Recently Received Leads</h4></div><div class="card-body"><div class="table-responsive"><table class="table table-nowrap table-sm align-middle mb-0"><thead><tr><th>Client</th><th>Form</th><th>Status</th></tr></thead><tbody><?php foreach($recentLeads as $lead): ?><tr><td class="fw-medium"><?php echo htmlspecialchars($lead['client_name']); ?></td><td><small class="text-muted"><?php echo htmlspecialchars($lead['form_name']); ?></small></td><td><span class="badge bg-primary-subtle text-primary"><?php echo ucfirst($lead['status']); ?></span></td></tr><?php endforeach; ?></tbody></table></div></div></div></div></div>

            <?php elseif ($role === 'sales'): ?>
                <div class="row">
                    <div class="col-xl-3 col-md-6"><div class="card card-animate overflow-hidden"><div class="card-body"><div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">New Leads</p></div></div><div class="d-flex align-items-end justify-content-between mt-4"><div><h4 class="fs-22 fw-semibold ff-secondary mb-4"><?php echo $card_new; ?></h4></div><div class="avatar-sm flex-shrink-0"><span class="avatar-title bg-primary-subtle rounded fs-3"><i class="ri-phone-line text-primary"></i></span></div></div></div></div></div>
                    <div class="col-xl-3 col-md-6"><div class="card card-animate overflow-hidden"><div class="card-body"><div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">In Discussion</p></div></div><div class="d-flex align-items-end justify-content-between mt-4"><div><h4 class="fs-22 fw-semibold ff-secondary mb-4"><?php echo $card_progress; ?></h4></div><div class="avatar-sm flex-shrink-0"><span class="avatar-title bg-warning-subtle rounded fs-3"><i class="ri-chat-1-line text-warning"></i></span></div></div></div></div></div>
                    <div class="col-xl-3 col-md-6"><div class="card card-animate overflow-hidden"><div class="card-body"><div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">Deals Closed</p></div></div><div class="d-flex align-items-end justify-content-between mt-4"><div><h4 class="fs-22 fw-semibold ff-secondary mb-4 text-success"><?php echo $card_won; ?></h4></div><div class="avatar-sm flex-shrink-0"><span class="avatar-title bg-success-subtle rounded fs-3"><i class="ri-trophy-line text-success"></i></span></div></div></div></div></div>
                    <div class="col-xl-3 col-md-6"><div class="card card-animate overflow-hidden"><div class="card-body"><div class="d-flex align-items-center"><div class="flex-grow-1"><p class="text-uppercase fw-medium text-muted mb-0">Lost</p></div></div><div class="d-flex align-items-end justify-content-between mt-4"><div><h4 class="fs-22 fw-semibold ff-secondary mb-4 text-danger"><?php echo $card_lost; ?></h4></div><div class="avatar-sm flex-shrink-0"><span class="avatar-title bg-danger-subtle rounded fs-3"><i class="ri-close-circle-line text-danger"></i></span></div></div></div></div></div>
                </div>
                <div class="row"><div class="col-12"><div class="card"><div class="card-header border-0 align-items-center d-flex"><h4 class="card-title mb-0 flex-grow-1">Closing Performance (Won Deals)</h4></div><div class="card-body p-0 pb-2"><div class="w-100"><div id="trend_chart" style="height: 300px;"></div></div></div></div></div></div>
                <div class="row">
                    <div class="col-xl-6"><div class="card card-height-100"><div class="card-header align-items-center d-flex"><h4 class="card-title mb-0 flex-grow-1">🔥 Fresh Leads (Action Required)</h4><div class="flex-shrink-0"><span class="badge bg-danger-subtle text-danger">Call Now</span></div></div><div class="card-body p-0"><div class="table-responsive"><table class="table table-striped table-nowrap align-middle mb-0"><thead class="table-light"><tr><th>Client Name</th><th>Company</th><th>Received</th></tr></thead><tbody><?php foreach($freshLeads as $lead): ?><tr><td class="fw-medium"><?php echo htmlspecialchars($lead['client_name']); ?></td><td><?php echo htmlspecialchars($lead['company'] ?? '-'); ?></td><td class="text-muted"><?php echo date('d M, h:i A', strtotime($lead['created_at'])); ?></td></tr><?php endforeach; ?><?php if(empty($freshLeads)): ?><tr><td colspan="3" class="text-center text-muted p-3">No new leads pending! Good job.</td></tr><?php endif; ?></tbody></table></div></div></div></div>
                    <div class="col-xl-6"><div class="card card-height-100"><div class="card-header align-items-center d-flex"><h4 class="card-title mb-0 flex-grow-1">💬 Active Negotiations (Follow Up)</h4><div class="flex-shrink-0"><span class="badge bg-warning-subtle text-warning">In Progress</span></div></div><div class="card-body p-0"><div class="table-responsive"><table class="table table-striped table-nowrap align-middle mb-0"><thead class="table-light"><tr><th>Client Name</th><th>Company</th><th>Started</th></tr></thead><tbody><?php foreach($negotiationLeads as $lead): ?><tr><td class="fw-medium"><?php echo htmlspecialchars($lead['client_name']); ?></td><td><?php echo htmlspecialchars($lead['company'] ?? '-'); ?></td><td class="text-muted"><?php echo date('d M, h:i A', strtotime($lead['created_at'])); ?></td></tr><?php endforeach; ?><?php if(empty($negotiationLeads)): ?><tr><td colspan="3" class="text-center text-muted p-3">No active negotiations.</td></tr><?php endif; ?></tbody></table></div></div></div></div>
                </div>
            <?php endif; ?>

        </div>
    </div>
    
    <?php require_once 'includes/footer.php'; ?>

    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <script>
        // 1. DATE PICKER
        flatpickr("#date_range_picker", {
            mode: "range", dateFormat: "Y-m-d", defaultDate: ["<?php echo $start_date; ?>", "<?php echo $end_date; ?>"],
            onClose: function(selectedDates) { if (selectedDates.length === 2) document.getElementById("dateFilterForm").submit(); }
        });

        // 2. TREND CHART (STRAIGHT LINE WITH DOTS)
        <?php if (!empty($trendDates)): ?>
        var trendOptions = {
            series: [{ name: '<?php echo ($role==='sales') ? "Deals Closed" : "Leads Received"; ?>', data: <?php echo json_encode($trendCounts); ?> }],
            chart: { 
                type: 'line', 
                height: 300, 
                toolbar: {show: false},
                zoom: { enabled: false }
            },
            stroke: { 
                curve: 'straight', 
                width: 3 
            },
            markers: { 
                size: 7, 
                colors: ['#405189'], 
                strokeColors: '#fff', 
                strokeWidth: 2,
                hover: { size: 9 }
            },
            dataLabels: { enabled: false },
            xaxis: { categories: <?php echo json_encode($trendDates); ?>, axisBorder: { show: false }, axisTicks: { show: false } },
            colors: ['#405189'],
            grid: { borderColor: '#f1f1f1', strokeDashArray: 4 },
            fill: { type: 'solid', opacity: 1 }
        };
        new ApexCharts(document.querySelector("#trend_chart"), trendOptions).render();
        <?php endif; ?>

        // 3. MARKETING QUALITY CHART
        <?php if ($role === 'marketing'): ?>
        var qualityOptions = {
            series: [
                { name: 'Total Leads', data: <?php echo json_encode($qualityTotal); ?> },
                { name: 'Won Leads', data: <?php echo json_encode($qualityWon); ?> }
            ],
            chart: { type: 'bar', height: 350, stacked: true },
            plotOptions: { bar: { horizontal: true, dataLabels: { total: { enabled: true, offsetX: 0, style: { fontSize: '13px', fontWeight: 900 } } } } },
            stroke: { width: 1, colors: ['#fff'] },
            xaxis: { categories: <?php echo json_encode($qualityLabels); ?> },
            fill: { opacity: 1 },
            colors: ['#405189', '#0ab39c'],
            legend: { position: 'top', horizontalAlign: 'left' }
        };
        new ApexCharts(document.querySelector("#quality_chart"), qualityOptions).render();
        <?php endif; ?>

        // 4. COMMON CHARTS
        var statusOptions = {
            series: [{ name: 'Leads', data: <?php echo json_encode($statusCounts); ?> }],
            chart: { type: 'bar', height: 350, toolbar: {show: false} },
            plotOptions: { bar: { borderRadius: 4, horizontal: false, columnWidth: '55%' } },
            dataLabels: { enabled: false },
            colors: ['#0dcaf0', '#ffc107', '#198754', '#dc3545'],
            xaxis: { categories: ['New', 'In Progress', 'Converted', 'Lost'] }
        };
        if(document.querySelector("#status_chart")) new ApexCharts(document.querySelector("#status_chart"), statusOptions).render();

        <?php if ($role === 'marketing' || $role === 'admin'): ?>
        var sourceOptions = {
            series: <?php echo json_encode($sourceCounts); ?>,
            chart: { type: 'donut', height: 350 },
            labels: <?php echo json_encode($sourceLabels); ?>,
            colors: ['#405189', '#0ab39c', '#f7b84b', '#f06548', '#299cdb'],
            legend: { position: 'bottom' }
        };
        if(document.querySelector("#source_chart")) new ApexCharts(document.querySelector("#source_chart"), sourceOptions).render();
        <?php endif; ?>
    </script>