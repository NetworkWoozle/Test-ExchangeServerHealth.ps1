#This function is used to test service health for Exchange 2013 CAS-only servers

#Copyright (c) 2015 Paul Cunningham
#A copy of the license can be found bundled with this software or can be found at  https://github.com/NetworkWoozle/Test-ExchangeServerHealth.ps1/blob/master/LICENSE
Function Test-E15CASServiceHealth()
{
    param ( $e15cas )
    
    $e15casservicehealth = $null
    $servicesrunning = @()
    $servicesnotrunning = @()
    $casservices = @(
                    "IISAdmin",
                    "W3Svc",
                    "WinRM",
                    "MSExchangeADTopology",
                    "MSExchangeDiagnostics",
                    "MSExchangeFrontEndTransport",
                    #"MSExchangeHM",
                    "MSExchangeIMAP4",
                    "MSExchangePOP3",
                    "MSExchangeServiceHost",
                    "MSExchangeUMCR"
                    )
        
    try {
        $servicestates = @(Get-WmiObject -ComputerName $e15cas -Class Win32_Service -ErrorAction STOP | Where-Object {$casservices -icontains $_.Name} | Select-Object name,state,startmode)
    }
    catch
    {
        if ($Log) {Write-LogFile $_.Exception.Message}
        Write-Warning $_.Exception.Message
        $e15casservicehealth = "Fail"
    }    
    
    if (!($e15casservicehealth))
    {
        $servicesrunning = @($servicestates | Where-Object {$_.StartMode -eq "Auto" -and $_.State -eq "Running"})
        $servicesnotrunning = @($servicestates | Where-Object {$_.Startmode -eq "Auto" -and $_.State -ne "Running"})
        if ($($servicesnotrunning.Count) -gt 0)
        {
            Write-Verbose "Service health check failed"
            Write-Verbose "Services not running:"
            foreach ($service in $servicesnotrunning)
            {
                Write-Verbose "- $($service.Name)"    
            }
            $e15casservicehealth = "Fail"    
        }
        else
        {
            Write-Verbose "Service health check passed"
            $e15casservicehealth = "Pass"
        }
    }
    return $e15casservicehealth
}