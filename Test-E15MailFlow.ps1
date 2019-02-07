#This function is used to test mail flow for Exchange 2013 Mailbox servers

#Copyright (c) 2015 Paul Cunningham
#A copy of the license can be found bundled with this software or can be found at  https://github.com/NetworkWoozle/Test-ExchangeServerHealth.ps1/blob/master/LICENSE

Function Test-E15MailFlow()
{
    param ( $e15mailboxserver )

    $e15mailflowresult = $null
    
    Write-Verbose "Creating PSSession for $e15mailboxserver"
    $url = (Get-PowerShellVirtualDirectory -Server $e15mailboxserver -AdPropertiesOnly | Where-Object {$_.Name -eq "Powershell (Default Web Site)"}).InternalURL.AbsoluteUri
    if ($url -eq $null)
    {
        $url = "http://$e15mailboxserver/powershell"
    }

    try
    {
        $session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $url -ErrorAction STOP
    }
    catch
    {
        Write-Verbose "Something went wrong"
        if ($Log) {Write-LogFile $_.Exception.Message}
        Write-Warning $_.Exception.Message
        $e15mailflowresult = "Fail"
    }

    try
    {
        Write-Verbose "Running mail flow test on $e15mailboxserver"
        $result = Invoke-Command -Session $session {Test-Mailflow} -ErrorAction STOP
        $e15mailflowresult = $result.TestMailflowResult
    }
    catch
    {
        Write-Verbose "An error occurred"
        if ($Log) {Write-LogFile $_.Exception.Message}
        Write-Warning $_.Exception.Message
        $e15mailflowresult = "Fail"
    }

    Write-Verbose "Mail flow test: $e15mailflowresult"
    Write-Verbose "Removing PSSession"
    Remove-PSSession $session.Id

    return $e15mailflowresult
}