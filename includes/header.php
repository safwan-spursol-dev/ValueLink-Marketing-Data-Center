<?php
require_once __DIR__ . '/../auto_cron.php';
?>
<!doctype html>
<html lang="en" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg"
    data-sidebar-image="none" data-preloader="disable">

<head>

    <meta charset="utf-8" />
    <title>ValueLink Marketing Data Center</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="<?php echo BASE_URL; ?>assets/images/favicon.png">

    <script src="<?php echo BASE_URL; ?>assets/js/layout.js"></script>
    <link href="<?php echo BASE_URL; ?>assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo BASE_URL; ?>assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo BASE_URL; ?>assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo BASE_URL; ?>assets/css/custom.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>

<body>

    <div id="layout-wrapper">

        <header id="page-topbar">
            <div class="layout-width">
                <div class="navbar-header">
                    <div class="d-flex">
                        <div class="navbar-brand-box horizontal-logo">
                            <a href="<?php echo BASE_URL; ?>index.php" class="logo logo-dark">
                                <span class="logo-sm">
                                    <img src="<?php echo BASE_URL; ?>assets/images/favicon.png" alt="" height="22">
                                </span>
                                <span class="logo-lg">
                                    <img src="<?php echo BASE_URL; ?>assets/images/logo-dark.png" alt="" height="17">
                                </span>
                            </a>

                            <a href="<?php echo BASE_URL; ?>index.php" class="logo logo-light">
                                <span class="logo-sm">
                                    <img src="<?php echo BASE_URL; ?>assets/images/favicon.png" alt="" height="22">
                                </span>
                                <span class="logo-lg">
                                    <img src="<?php echo BASE_URL; ?>assets/images/logo-light.png" alt="" height="17">
                                </span>
                            </a>
                        </div>

                        <button type="button"
                            class="btn btn-sm px-3 fs-16 header-item vertical-menu-btn topnav-hamburger"
                            id="topnav-hamburger-icon">
                            <span class="hamburger-icon">
                                <span></span>
                                <span></span>
                                <span></span>
                            </span>
                        </button>


                    </div>

                    <div class="d-flex align-items-center">





                        <div class="ms-1 header-item d-none d-sm-flex">
                            <button type="button" class="btn btn-icon btn-topbar btn-ghost-secondary rounded-circle"
                                data-toggle="fullscreen">
                                <i class='bx bx-fullscreen fs-22'></i>
                            </button>
                        </div>

                        <div class="ms-1 header-item d-none d-sm-flex">
                            <button type="button"
                                class="btn btn-icon btn-topbar btn-ghost-secondary rounded-circle light-dark-mode">
                                <i class='bx bx-moon fs-22'></i>
                            </button>
                        </div>


                       <div class="dropdown ms-sm-3 header-item topbar-user">
                            <button type="button" class="btn" id="page-header-user-dropdown" data-bs-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                                <span class="d-flex align-items-center">
                                    <img class="rounded-circle header-profile-user" 
                                         src="<?php echo BASE_URL; ?>assets/images/users/<?php echo !empty($_SESSION['image']) ? $_SESSION['image'] : 'default.png'; ?>" 
                                         alt="Header Avatar">                                    
                                    <span class="text-start ms-xl-2">
                                        <span class="d-none d-xl-inline-block ms-1 fw-medium user-name-text">
                                            <?php echo isset($_SESSION['name']) ? htmlspecialchars($_SESSION['name']) : 'User'; ?>
                                        </span>
                                        
                                        <span class="d-none d-xl-block ms-1 fs-12 user-name-sub-text text-uppercase">
                                            <?php echo isset($_SESSION['role']) ? htmlspecialchars($_SESSION['role']) : 'Member'; ?>
                                        </span>
                                    </span>
                                </span>
                            </button>
                            <div class="dropdown-menu dropdown-menu-end">
                                <h6 class="dropdown-header">Welcome <?php echo isset($_SESSION['name']) ? htmlspecialchars($_SESSION['name']) : ''; ?>!</h6>
                                
                                <a class="dropdown-item" href="<?php echo BASE_URL; ?>profile.php">
                                    <i class="mdi mdi-account-circle text-muted fs-16 align-middle me-1"></i> 
                                    <span class="align-middle">Profile</span>
                                </a>
                                
                                <div class="dropdown-divider"></div>
                                
                                <a class="dropdown-item" href="<?php echo BASE_URL; ?>auth/logout.php">
                                    <i class="mdi mdi-logout text-muted fs-16 align-middle me-1"></i> 
                                    <span class="align-middle" data-key="t-logout">Logout</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div id="removeNotificationModal" class="modal fade zoomIn" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
                            id="NotificationModalbtn-close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mt-2 text-center">
                            <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop"
                                colors="primary:#f7b84b,secondary:#f06548" style="width:100px;height:100px"></lord-icon>
                            <div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
                                <h4>Are you sure ?</h4>
                                <p class="text-muted mx-4 mb-0">Are you sure you want to remove this Notification ?</p>
                            </div>
                        </div>
                        <div class="d-flex gap-2 justify-content-center mt-4 mb-2">
                            <button type="button" class="btn w-sm btn-light" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn w-sm btn-danger" id="delete-notification">Yes, Delete
                                It!</button>
                        </div>
                    </div>

                </div></div></div><div class="app-menu navbar-menu">
            <div class="navbar-brand-box">
                <a href="<?php echo BASE_URL; ?>index.php" class="logo logo-dark">
                    <span class="logo-sm">
                        <img src="<?php echo BASE_URL; ?>assets/images/favicon.png" alt="" height="33">
                    </span>
                    <span class="logo-lg">
                        <img src="<?php echo BASE_URL; ?>assets/images/logo-dark.png" alt="" height="33">
                    </span>
                </a>
                <a href="<?php echo BASE_URL; ?>index.php" class="logo logo-light">
                    <span class="logo-sm">
                        <img src="<?php echo BASE_URL; ?>assets/images/favicon.png" alt="" height="33">
                    </span>
                    <span class="logo-lg">
                        <img src="<?php echo BASE_URL; ?>assets/images/logo-light.png" alt="" height="33">
                    </span>
                </a>
                <button type="button" class="btn btn-sm p-0 fs-20 header-item float-end btn-vertical-sm-hover"
                    id="vertical-hover">
                    <i class="ri-record-circle-line"></i>
                </button>
            </div>

            <div id="scrollbar">
                <div class="container-fluid">

                    <div id="two-column-menu">
                    </div>
                    <ul class="navbar-nav" id="navbar-nav">
                        <li class="menu-title"><span data-key="t-menu">Menu</span></li>
                        <li class="nav-item">
                            <a class="nav-link menu-link" href="<?php echo BASE_URL; ?>index.php"
                                role="button" >
                                <i class="ri-dashboard-2-line"></i> <span data-key="t-dashboards">Dashboards</span>
                            </a>
                        </li> <?php if (isset($_SESSION['role']) && ($_SESSION['role'] === 'marketing' || $_SESSION['role'] === 'admin')): ?>
                        
                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarLeads" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarLeads">
                                <i class="ri-contacts-book-2-line"></i> <span data-key="t-leads">Leads</span>
                            </a>
                            <div class="collapse menu-dropdown" id="sidebarLeads">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="<?php echo BASE_URL; ?>leads-list.php" class="nav-link" data-key="t-all-forms"> All Forms </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="<?php echo BASE_URL; ?>demo-requests.php" class="nav-link" data-key="t-demo-requests"> Demo Requests </a>
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <?php endif; ?>

                        <?php if (isset($_SESSION['role']) && $_SESSION['role'] === 'admin'): ?>
                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarApps" data-bs-toggle="collapse" role="button"
                                aria-expanded="false" aria-controls="sidebarApps">
                                <i class="ri-apps-2-line"></i> <span data-key="t-apps">User Management</span>
                            </a>
                            <div class="collapse menu-dropdown" id="sidebarApps">
                                <ul class="nav nav-sm flex-column">
                                    <li class="nav-item">
                                        <a href="<?php echo BASE_URL; ?>users-add.php" class="nav-link" data-key="t-calendar"> Create User
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="<?php echo BASE_URL; ?>users-list.php" class="nav-link" data-key="t-chat"> Manage Users </a>
                                    </li>
                                   
                                </ul>
                            </div>
                        </li>
                        <?php endif; ?>

                        <?php if ($_SESSION['role'] === 'sales'): ?>

                            <li class="nav-item">
                                <a class="nav-link menu-link" href="#sidebarLeads" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarLeads">
                                    <i class="ri-stack-line"></i> <span data-key="t-leads">Leads Management</span>
                                </a>
                                <div class="collapse menu-dropdown" id="sidebarLeads">
                                    <ul class="nav nav-sm flex-column">
                                                
                                        <li class="nav-item">
                                            <a href="<?php echo BASE_URL; ?>leads-list.php" class="nav-link" data-key="t-view-leads"> View All Leads </a>
                                        </li>
                                                
                                        <li class="nav-item">
                                            <a href="<?php echo BASE_URL; ?>assigned_leads.php" class="nav-link" data-key="t-assigned-me"> Assigned to Me </a>
                                        </li>
                                                
                                    </ul>
                                </div>
                            </li>
                                                
                        <?php endif; ?>

                        <?php if (isset($_SESSION['role']) && $_SESSION['role'] === 'admin'): ?>
                            <li class="nav-item">
                                <a class="nav-link menu-link" href="<?php echo BASE_URL; ?>logs.php">
                                    <i class="ri-history-line"></i> <span>Activity Logs</span>
                                </a>
                            </li>
                        <?php endif; ?>

                        <?php if (isset($_SESSION['role']) && $_SESSION['role'] === 'admin'): ?>
                        <li class="nav-item">
                            <a class="nav-link menu-link" href="#sidebarImport" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarImport">
                                <i class="ri-file-upload-line"></i> <span data-key="t-import">Import Leads</span>
                            </a>
                            <div class="collapse menu-dropdown" id="sidebarImport">
                                <ul class="nav nav-sm flex-column">

                                    <li class="nav-item">
                                        <a href="<?php echo BASE_URL; ?>add-lead.php" class="nav-link " data-key="t-add-lead" > 
                                            Add Lead (Manual) 
                                        </a>
                                    </li>

                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-demo-request.php" class="nav-link" data-key="t-f1">Demo Request Form</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-mobile-demo.php" class="nav-link" data-key="t-f2">Request a Demo Form (Mobile)</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-contact-us.php" class="nav-link" data-key="t-f3">Contact Us Form</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-events.php" class="nav-link" data-key="t-f4">Events Form</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-newsletter.php" class="nav-link" data-key="t-f5">Newsletter Subscription Form</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-lenders-checklist.php" class="nav-link" data-key="t-f6">Lender's Checklist Download Form</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-omni-demo.php" class="nav-link" data-key="t-f7">Omni Demo Request Form</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-crosscheck-demo.php" class="nav-link" data-key="t-f8">CrossCheck Demo Request</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-integrations.php" class="nav-link" data-key="t-f9">Integrations Form</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-case-study.php" class="nav-link" data-key="t-f10">Case Study Form</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-cs-vandyk.php" class="nav-link" data-key="t-f11">Case Study - VanDyk Mortgage</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-cs-anniemac.php" class="nav-link" data-key="t-f12">Case Study - AnnieMac</a></li>
                                    <li class="nav-item"><a href="<?php echo BASE_URL; ?>import_modules/import-cs-georgemason.php" class="nav-link" data-key="t-f13">Case Study - George Mason</a></li>
                                </ul>
                            </div>
                        </li>
                        <?php endif; ?>
                        

                    </ul>
                </div>
                </div>

            <div class="sidebar-background"></div>
        </div>
        <div class="vertical-overlay"></div>