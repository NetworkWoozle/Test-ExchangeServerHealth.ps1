#This function is used to generate HTML for the DAG member health report

#Copyright (c) 2015 Paul Cunningham
#A copy of the license can be found bundled with this software or can be found at  https://github.com/NetworkWoozle/Test-ExchangeServerHealth.ps1/blob/master/LICENSE
Function New-DAGMemberHTMLTableCell()
{
    param( $lineitem )
    
    $htmltablecell = $null

    switch ($($line."$lineitem"))
    {
        $null { $htmltablecell = "<td>n/a</td>" }
        "Passed" { $htmltablecell = "<td class=""pass"">$($line."$lineitem")</td>" }
        default { $htmltablecell = "<td class=""warn"">$($line."$lineitem")</td>" }
    }
    
    return $htmltablecell
}
