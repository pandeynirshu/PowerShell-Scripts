function Get-UpdateId {
    [CmdletBinding()]  
    Param (   
        [string]$env:COMPUTERNAME = $env:COMPUTERNAME
    ) 

    # First get the Windows HotFix history as array of 'KB' id's
    Write-Verbose "Retrieving Windows HotFix history on '$($env:COMPUTERNAME)'.."

    $result = Get-HotFix -ComputerName $env:COMPUTERNAME | Select-Object -ExpandProperty HotFixID
    # or use:
    # $hotfix = Get-WmiobjectGet-WmiObject -Namespace 'root\cimv2' -Class Win32_QuickFixEngineering -ComputerName $ComputerName | Select-Object -ExpandProperty HotFixID

    # Next get the Windows Update history
    Write-Verbose "Retrieving Windows Update history on '$($ComputerName)'.."

    if ($ComputerName -eq $env:COMPUTERNAME) {
        # Local computer
        $updateSession = New-Object -ComObject Microsoft.Update.Session
    }
    else {
        # Remote computer (the last parameter $true enables exception being thrown if an error occurs while loading the type)
        $updateSession = [activator]::CreateInstance([type]::GetTypeFromProgID("Microsoft.Update.Session", $ComputerName, $true))
    }

    $updateSearcher = $updateSession.CreateUpdateSearcher()
    $historyCount   = $updateSearcher.GetTotalHistoryCount()

    if ($historyCount -gt 0) {
        $result += ($updateSearcher.QueryHistory(0, $historyCount) | ForEach-Object { [regex]::match($_.Title,'(KB\d+)').Value })
    }

    # release the Microsoft.Update.Session COM object
    try {
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($updateSession) | Out-Null
        Remove-Variable updateSession
    }
    catch {}

    # remove empty items from the combined $result array, uniquify and return the results
    $result | Where-Object { $_ -match '\S' } | Sort-Object -Unique
}

function Get-LastBootTime {
    [CmdletBinding()]  
    Param (   
        [string]$ComputerName = $env:COMPUTERNAME
    ) 
    try {
        $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $env:COMPUTERNAME 
        $os.ConvertToDateTime($os.LastBootupTime)
    } 
    catch {
        Write-Error $_.Exception.Message    
    }
}

# Enter all list of update to validate

$KBList = "KB5032393", "KB5033055", "KB5032007"
$ComputerName = $env:COMPUTERNAME
$Computers | ForEach-Object {
    $updates = Get-UpdateId -env:COMPUTERNAME
    # Now check each KBid in your list to see if it is installed or not
    foreach ($item in $KBList) {
        [PSCustomObject] @{
            'Computer'       = $env:COMPUTERNAME
            'LastBootupTime' = Get-LastBootTime -ComputerName $env:COMPUTERNAME
            'UpdateID'       = $item
            'Installed'      = if ($updates -contains $item) { 'Yes' } else { 'No' }
        }
    }
}