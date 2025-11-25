/// FSLog details
Class dc.FHIR.FSLog Extends %CSP.Page
{

Parameter Title As STRING [ Final ] = "FSLOG";

Parameter APPLICATION As STRING = "FSLOG";

Parameter CATEGORY As STRING = "FHIR";

ClassMethod OnRenderScreen() As %Status
{
	#define del "|"
	set channelType =$O(^FSLogChannel(""))
	&html<

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FSLOG</title>

</head>

<body>
    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="spinner"></div>
    </div>

    <!-- Header Section - Reduced size -->
    <div class="header-container">
        <div class="container">
            <div class="logo-section">
                <!--img class="portalLogo" src="portal/InterSystems IRIS.png" alt="InterSystems IRIS Logo"-->
            </div>
            <div class="title-section">
                <h1>FSLOG Dashboard</h1>
                <div class="status-badge">
                    <i class="fas fa-database"></i>
                    FSLogChannel is <span>#(channelType)#</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container-fluid"> <!-- Changed from container to container-fluid for full width -->
        <div class="content-container">
            <div class="content-header">
                <h2 class="content-title">
                    <i class="fas fa-table"></i>
                    SQL Query Logs
                </h2>
                <div class="d-flex gap-2">
                    <!--button class="btn btn-sm btn-outline-primary" id="refreshBtn">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button-->
                    <!--button class="btn btn-sm btn-outline-secondary" id="exportBtn">
                        <i class="fas fa-download"></i> Export
                    </button-->
                </div>
            </div>

            <!-- Table without custom wrapper - DataTables will handle scrolling -->
            <table id="example" class="table table-striped" style="width:100%">
                <thead>
                    <tr>
                        <th>Location</th>
                        <th>Type</th>
                        <th>Message</th>
                        <th>TimeStamp</th>
                        <th>Job Number</th>
                    </tr>
                </thead>
                <tbody>
		>
		s key=""
		for  {
			set key = $order(^FSLOG(key), -1, record) quit:key=""
			set location = $piece(record, $$$del, 1)
			set timeStamp = $piece(record, $$$del, *)
			set jobNumber = $piece(location, "^", 3)
			write "<tr>"
			write "<td>"_location_"</td>"
			write "<td> <span class=""type-badge type-sql"">"_ $piece(record, $$$del, 2)_"</span></td>"
			write "<td class=""message-cell"">"_$piece(record, $$$del, 3, *-1)_"</td>"
			write "<td class=""timestamp-cell"">"_timeStamp_"</td>"
			write "<td><span class=""job-number"">"_jobNumber_"</span></td>"
			write "</tr>"
		}

		&HTML<
		 </tbody>
            </table>
        </div>
    </div>
	>
	q 1
}

XData Style
{
<data>
	<![CDATA[
:root{--primary-color:#4361ee;--secondary-color:#3f37c9;--accent-color:#4cc9f0;--dark-color:#1a1a2e;--light-color:#f8f9fa;--success-color:#06ffa5;--info-color:#4cc9f0;--warning-color:#ff9e00;--danger-color:#ff006e;--table-hover:rgba(67,97,238,.05)}*{margin:0;padding:0;box-sizing:border-box}body{font-family:'Inter',sans-serif;background-color:#f5f7ff;color:var(--dark-color);line-height:1.6}.header-container{background:linear-gradient(135deg,var(--primary-color),var(--secondary-color));color:#fff;padding:1rem 0;box-shadow:0 4px 20px rgba(0,0,0,.1);margin-bottom:1.5rem}.logo-section{display:flex;align-items:center;gap:1rem}.portalLogo{height:40px;filter:brightness(0) invert(1)}.title-section{margin-top:.5rem}.title-section h1{font-size:1.5rem;font-weight:700;margin-bottom:.3rem}.status-badge{background-color:rgba(255,255,255,.2);color:#fff;padding:.25rem .6rem;border-radius:30px;font-weight:600;font-size:.85rem;display:inline-flex;align-items:center;gap:.5rem;backdrop-filter:blur(4px);border:1px solid rgba(255,255,255,.2)}.status-badge i{font-size:.75rem}.content-container{background-color:#fff;border-radius:12px;box-shadow:0 4px 20px rgba(0,0,0,.05);padding:1.5rem;margin-bottom:2rem}.content-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:1.5rem;flex-wrap:wrap;gap:1rem;width:100%}.content-title{font-size:1.3rem;font-weight:600;color:var(--dark-color);display:flex;align-items:center;gap:.5rem}.content-title i{color:var(--primary-color)}.dataTables_wrapper{border-radius:8px;box-shadow:0 2px 10px rgba(0,0,0,.03);overflow:hidden;width:100%}.dataTables_scroll{background-color:#fff;width:100%}.dataTables_scrollHead{background-color:var(--primary-color);width:100%}#example{margin-bottom:0!important;min-width:1000px;width:100%}#example thead th{background-color:var(--primary-color);color:#fff;font-weight:600;border:none;padding:1rem;font-size:.9rem;text-transform:uppercase;letter-spacing:.5px;white-space:nowrap}#example tbody tr{transition:background-color .2s ease}#example tbody tr:hover{background-color:var(--table-hover)}#example tbody td{padding:1rem;vertical-align:middle;border-bottom:1px solid #f0f0f0;font-size:.9rem;white-space:nowrap}#example tbody tr:last-child td{border-bottom:none}#example th:nth-child(1),#example td:nth-child(1){width:25%;max-width:300px;overflow:hidden;text-overflow:ellipsis}#example th:nth-child(2),#example td:nth-child(2){width:8%;text-align:center}#example th:nth-child(3),#example td:nth-child(3){width:40%;max-width:500px;overflow:hidden;text-overflow:ellipsis}#example th:nth-child(4),#example td:nth-child(4){width:18%}#example th:nth-child(5),#example td:nth-child(5){width:9%;text-align:center}.type-badge{padding:.35rem .65rem;border-radius:4px;font-weight:600;font-size:.8rem;display:inline-block;text-transform:uppercase;letter-spacing:.5px}.type-sql{background-color:rgba(67,97,238,.1);color:var(--primary-color)}.message-cell{max-width:400px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.message-cell:hover{white-space:normal;overflow:visible}.timestamp-cell{font-family:'Courier New',monospace;font-size:.85rem;color:#555}.job-number{font-family:'Courier New',monospace;background-color:rgba(67,97,238,.1);color:var(--primary-color);padding:.25rem .5rem;border-radius:4px;font-weight:600;display:inline-block}.dataTables_wrapper .dataTables_filter input{border:1px solid #ddd;border-radius:4px;padding:.5rem;margin-left:.5rem}.dataTables_wrapper .dataTables_length select{border:1px solid #ddd;border-radius:4px;padding:.3rem}.dataTables_wrapper .dataTables_paginate .paginate_button{border-radius:4px!important;margin:0 2px!important}.dataTables_wrapper .dataTables_paginate .paginate_button.current{background:var(--primary-color)!important;color:#fff!important;border:none!important}.dataTables_scrollBody{border:none!important}@media (max-width:1200px){#example th:nth-child(1),#example td:nth-child(1){width:20%}#example th:nth-child(3),#example td:nth-child(3){width:45%}}@media (max-width:992px){#example th:nth-child(1),#example td:nth-child(1){width:18%}#example th:nth-child(3),#example td:nth-child(3){width:48%}}.loading-overlay{position:fixed;top:0;left:0;width:100%;height:100%;background-color:rgba(255,255,255,.8);display:flex;justify-content:center;align-items:center;z-index:9999;visibility:hidden;opacity:0;transition:all .3s ease}.loading-overlay.active{visibility:visible;opacity:1}.spinner{width:50px;height:50px;border:5px solid rgba(67,97,238,.2);border-radius:50%;border-top-color:var(--primary-color);animation:spin 1s ease-in-out infinite}@keyframes spin{to{transform:rotate(360deg)}}
	]]>>
</data>
}

ClassMethod OnPage() As %Status
{
	Do ..OnPageCSPROOT()
	Quit 1
}

ClassMethod AppDescription()
{
	Q ""
}

ClassMethod OnPageCSPROOT() As %Boolean
{
	Do ..OnPageHTML()
}

ClassMethod OnPageHTML() As %Boolean
{
	Write "<html>"
	Write !
	Do ..OnPageHEAD()
	Do ..OnPageBODY()
	Write !,"</html>"
	Return $$$OK
}

ClassMethod OnPageHEAD() As %Boolean
{
	Write "<head>",!
	Write !,"<title>"_..#Title_"</title>",!
	&HTML<
    <link rel="shortcut icon" href="portal/ISC_IRIS_icon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
	>
	Write "<style>",!
	Do ..LoadCSS()
	Write "</style>",!
	Write "</head>",!
	Write ..HyperEventHead(0,0)
	Return $$$OK
}

ClassMethod OnPageBODY() As %Boolean
{
	Do ..RenderScreen()
	Return $$$OK
}

/// Override this method to render your screens in UI
ClassMethod RenderScreen()
{
	Do ..OnRenderScreen()
	Do ..Scripts()
}

ClassMethod LoadCSS()
{
	Set obj = ##class(%Dictionary.CompiledXData).%OpenId($Classname()_"||Style")
	Return:(obj = "") $$$OK
	Set xdata = obj.Data
	Set status = ##class(%XML.TextReader).ParseStream(xdata, .textreader)
	While textreader.Read() { If (textreader.NodeType="chars") { Write textreader.Value } }
	Return $$$OK
}

/// Write your javascripts here within &HTML< ... >
ClassMethod Scripts()
{
	&HTML<
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script language="JavaScript" type="text/javascript" src="/irishealth2025com/csp/broker/cspxmlhttp.js"></script>
    <script language="JavaScript" type="text/javascript" src="/irishealth2025com/csp/broker/cspbroker.js"></script>

    <script language="javascript">
        $(document).ready(function(){
            // Initialize DataTable with custom configuration
            const dataTable = $('#example').DataTable({
                pageLength: 25,
                responsive: true,
                order: [[3, 'desc']], // Sort by timestamp column by default
                scrollX: true, // Enable horizontal scrolling
                scrollCollapse: true, // Collapse the table to fit the container
                columnDefs: [
                    { targets: 0, width: '25%' }, // Location
                    { targets: 1, width: '8%' },  // Type
                    { targets: 2, width: '40%' }, // Message
                    { targets: 3, width: '18%' }, // TimeStamp
                    { targets: 4, width: '9%' }   // Job Number
                ],
                dom: '<"row"<"col-sm-6"l><"col-sm-6"f>>' +
                     '<"row"<"col-sm-12"tr>>' +
                     '<"row"<"col-sm-5"i><"col-sm-7"p>>',
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search logs..."
                }
            });

            // Refresh button functionality
            $('#refreshBtn').on('click', function() {
                showLoading();

                // Simulate data refresh
                setTimeout(function() {
                    dataTable.ajax.reload();
                    hideLoading();

                    // Show success notification
                    showNotification('Data refreshed successfully', 'success');
                }, 800);
            });

            // Export button functionality
            $('#exportBtn').on('click', function() {
                showNotification('Export functionality would be implemented here', 'info');
            });

            // Helper functions
            function showLoading() {
                $('#loadingOverlay').addClass('active');
            }

            function hideLoading() {
                $('#loadingOverlay').removeClass('active');
            }

            function showNotification(message, type) {
                const alertClass = type === 'success' ? 'alert-success' :
                                  type === 'error' ? 'alert-danger' : 'alert-info';

                const notification = $(`
                    <div class="alert ${alertClass} alert-dismissible fade show position-fixed"
                         style="top: 20px; right: 20px; z-index: 9999; min-width: 300px;"
                         role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                `);

                $('body').append(notification);

                // Auto dismiss after 3 seconds
                setTimeout(function() {
                    notification.alert('close');
                }, 3000);
            }
        });
	</script>
	>
}

}