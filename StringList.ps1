
#Copyright (c) 2015 Paul Cunningham
#A copy of the license can be found bundled with this software or can be found at  https://github.com/NetworkWoozle/Test-ExchangeServerHealth.ps1/blob/master/LICENSE

#...................................
# Initialization Strings
#...................................

$initstring0 = "Initializing..."
$initstring1 = "Loading the Exchange Server PowerShell snapin"
$initstring2 = "The Exchange Server PowerShell snapin did not load."
$initstring3 = "Setting scope to entire forest"

#...................................
# Logfile Strings
#...................................

$logstring0 = "====================================="
$logstring1 = " Exchange Server Health Check"

#...................................
# Error/Warning Strings
# TODO - Reorganize? Should probably be seperated out
#...................................

$string0 = "Server is not an Exchange server. "
$string1 = "Server is not reachable. "
$string3 = "------ Checking"
$string4 = "Could not test service health. "
$string5 = "required services not running. "
$string6 = "Could not check queue. "
$string7 = "Public Folder database not mounted. "
$string8 = "Skipping Edge Transport server. "
$string9 = "Mailbox databases not mounted. "
$string10 = "MAPI tests failed. "
$string11 = "Mail flow test failed. "
$string12 = "No Exchange Server 2003 checks performed. "
$string13 = "Server not found in DNS. "
$string14 = "Sending email. "
$string15 = "Done."
$string16 = "------ Finishing"
$string17 = "Unable to retrieve uptime. "
$string18 = "Ping failed. "
$string19 = "No alerts found, and AlertsOnly switch was used. No email sent. "
$string20 = "You have specified a single server to check"
$string21 = "Couldn't find the server $server. Script will terminate."
$string22 = "The file $ignorelistfile could not be found. No servers, DAGs or databases will be ignored."
$string23 = "You have specified a filename containing a list of servers to check"
$string24 = "The file $serverlist could not be found. Script will terminate."
$string25 = "Retrieving server list"
$string26 = "Removing servers in ignorelist from server list"
$string27 = "Beginning the server health checks"
$string28 = "Servers, DAGs and databases to ignore:"
$string29 = "Servers to check:"
$string30 = "Checking DNS"
$string31 = "DNS check passed"
$string32 = "Checking ping"
$string33 = "Ping test passed"
$string34 = "Checking uptime"
$string35 = "Checking service health"
$string36 = "Checking Hub Transport Server"
$string37 = "Checking Mailbox Server"
$string38 = "Ignore list contains no server names."
$string39 = "Checking public folder database"
$string40 = "Public folder database status is"
$string41 = "Checking mailbox databases"
$string42 = "Mailbox database status is"
$string43 = "Offline databases: "
$string44 = "Checking MAPI connectivity"
$string45 = "MAPI connectivity status is"
$string46 = "MAPI failed to: "
$string47 = "Checking mail flow"
$string48 = "Mail flow status is"
$string49 = "No active DBs"
$string50 = "Finished checking server"
$string51 = "Skipped"
$string52 = "Using alternative test for Exchange 2013 CAS-only server"
$string60 = "Beginning the DAG health checks"
$string61 = "Could not determine server with active database copy"
$string62 = "mounted on server that is activation preference"
$string63 = "unhealthy database copy count is"
$string64 = "healthy copy/replay queue count is"
$string65 = "(of"
$string66 = ")"
$string67 = "unhealthy content index count is"
$string68 = "DAGs to check:"
$string69 = "DAG databases to check"