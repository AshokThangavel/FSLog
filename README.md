## FSLog
The FHIR server in InterSystems IRIS stores its internal log messages in a global called `^FSLOG`.

A CSP log viewer page lets you see the contents of this global in a readable, web-based format.
## Prerequisites
FHIR Namespace should be used for this log
Internal FSLOG log should be enabled. Refer more details about the log in https://docs.intersystems.com/irisforhealth20232/csp/docbook/Doc.View.cls?KEY=HXFHIR_server_debugMaintain#HXFHIR_server_debug_log

This is a simple web based Internal FHIR server log display.
FSLog output

[http://localhost:54589/csp/irisapp/irisapp/dc.FHIR.FSLog.cls](http://localhost:52773/csp/healthshare/irisapp/dc.FHIR.FSLog.cls)

<img width="1915" height="955" alt="image" src="https://github.com/user-attachments/assets/43858fea-e11f-4174-a29a-99a2536b26f8" />

