# File management

$log = Get-Content -Path "C:\Users\NPandey\Documents\VotingLog-02-06-2024"
$snippet = $log[5..($log.count)]
$snippet | Out-File -FilePath "C:\Users\NPandey\Documents\VotingLog-02-06-2024"


#Remove-Item -Path "C:\Users\NPandey\Documents\VotingLog-02-06-2024"


[int]$i
for($i=1; $i -le 10; $i++) {
Write-Host "A"  # Out-File -FilePath "C:\Users\NPandey\Documents\VotingLog-02-06-2024" -Append
}
