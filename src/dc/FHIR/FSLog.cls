Class dc.FHIR.FSLog Extends %CSP.Page [ ProcedureBlock ]
{

Parameter TableHeader As STRING = "Location,Type,Message,TimeStamp,jobNumber";

ClassMethod OnPage() As %Status
{
	#define del "|"
	write "<head>"
	write "<link rel=""stylesheet"" href=""https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css"">"
	write "<link rel=""stylesheet"" href=""https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css"">"
	write "<script src=""https://code.jquery.com/jquery-3.7.0.js""></script>"
	write "<script src=""https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js""></script>"
	write "<script src=""https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js""></script>"
	write "</head>"
	write "<title>FSLOG</title>"
	write "<body>"
	write "<div>"
	write "<img class=""portalLogo"" src=""portal/InterSystems IRIS.png"">"
	write "</div>"
	write " <table id=""example"" class=""table table-striped"" style=""width:100%;padding: 0.1rem 0.1rem;font-size:12px;"">"
	write " <thead class='table-header'>"
	write "<tr>"
	set header = $listfromstring(..#TableHeader)
	set ptr=0
	while $listnext(header,ptr,head) {
		write "<th style='background-color:#333695;color:white;'>"_head_"</th>"
	} 
	write "</tr>"
	write "</thead>"
	write "<tbody>"
	set key=""
	for  {
		set key = $order(^FSLOG(key), -1, record) quit:key=""
		set location = $piece(record, $$$del, 1)
		set timeStamp = $piece(record, $$$del, *)
		set jobNumber = $piece(location, "^", 3)
		write "<tr>"
		write "<td style=""padding:1px;"">"_location_"</td>"
		write "<td>"_ $piece(record, $$$del, 2)_"</td>"
		write "<td>"_$piece(record, $$$del, 3, *-1)_"</td>"
		write "<td>"_timeStamp_"</td>"
		write "<td>"_jobNumber_"</td>"
		write "</tr>"
	}
	write "</tbody>"
	write "</table>"
	write "</body>"
	;
	&HTML<
		<script language="javascript">
		$(document).ready(function(){
	        $('#example').DataTable();
	    })
		</script>
		>
	return $$$OK
}

ClassMethod OnPageHEAD() As %Boolean
{
	Do ..HyperEventHead(0,0)
}

}