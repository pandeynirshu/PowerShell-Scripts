# Get-CimInstance Win32_PhysicalMemory | select @{n='MemoryType';e={$_.CreationClassName}},SerialNumber,@{n='Memory_GB';e={($_.capacity)/ 1GB}}

# Get-PSDrive

# Get-PhysicalDisk | select MediaType, OperationalStatus, HealthStatus, @{n='Memory_Space_TB';e={$_.Size/ 1TB}}, Usage | Format-Table -AutoSize