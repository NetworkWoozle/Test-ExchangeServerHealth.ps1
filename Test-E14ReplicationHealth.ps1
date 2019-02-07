#This function is used to test replication health for Exchange 2010 DAG members in mixed 2010/2013 organizations

#Copyright (c) 2015 Paul Cunningham
#A copy of the license can be found bundled with this software or can be found at  https://github.com/NetworkWoozle/Test-ExchangeServerHealth.ps1/blob/master/LICENSE

Function Test-E14ReplicationHealth()
{
    param ( $e14mailboxserver )

    $e14replicationhealth = $null
    
    #Find an E14 CAS in the same site
    $ADSite = (Get-ExchangeServer $e14mailboxserver).Site
    $e14cas = (Get-ExchangeServer | Where-Object {$_.IsClientAccessServer -and $_.AdminDisplayVersion -match "Version 14" -and $_.Site -eq $ADSite} | Select-Object -first 1).FQDN

    Write-Verbose "Creating PSSession for $e14cas"
    $url = (Get-PowerShellVirtualDirectory -Server $e14cas -AdPropertiesOnly | Where-Object {$_.Name -eq "Powershell (Default Web Site)"}).InternalURL.AbsoluteUri
    if ($url -eq $null)
    {
        $url = "http://$e14cas/powershell"
    }

    Write-Verbose "Using URL $url"

    try
    {
        $session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $url -ErrorAction STOP
    }
    catch
    {
        Write-Verbose "Something went wrong"
        if ($Log) {Write-LogFile $_.Exception.Message}
        Write-Warning $_.Exception.Message
        #$e14replicationhealth = "Fail"
    }

    try
    {
        Write-Verbose "Running replication health test on $e14mailboxserver"
        #$e14replicationhealth = Invoke-Command -Session $session {Test-ReplicationHealth} -ErrorAction STOP
        $e14replicationhealth = Invoke-Command -Session $session -Args $e14mailboxserver.Name {Test-ReplicationHealth $args[0]} -ErrorAction STOP
    }
    catch
    {
        Write-Verbose "An error occurred"
        if ($Log) {Write-LogFile $_.Exception.Message}
        Write-Warning $_.Exception.Message
        #$e14replicationhealth = "Fail"
    }

    #Write-Verbose "Replication health test: $e14replicationhealth"
    Write-Verbose "Removing PSSession"
    Remove-PSSession $session.Id

    return $e14replicationhealth
}