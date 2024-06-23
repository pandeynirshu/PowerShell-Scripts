Function Enter-VotingSystem {

$LogPath = "C:\Users\NPandey2\Documents\"
$LogFile = "VotingLog-"+ (Get-Date -Format "MM-dd-yyyy")
$File = $LogPath + "$logfile" + ".log"

function get-logging {
    param (
        [parameter(Mandatory = $true)]
        [string]$Message,
        [parameter(Mandatory = $true)] [ValidateSet("Warning", "Error","Info")]
        [string]$type
    )
        $date = (get-date).ToString()
        $output = Write-output "$date $type $Message"
        $output
} $output | Out-File -FilePath $File -Append 

# Script to check eligibility for voting

get-logging -Type Info -Message "Reading Input from user" | Out-File $File -Append
[string]$name = Read-Host "Enter your Name"
[int]$Age = Read-Host "Enter your Age"
[string[]]$AcceptedID = @("aadhar","pan","voterID")
if ($Age -ge 18) {

    $out = Write-output "Hey! $($name), Congratulations you are eligible for Voting"
    $out
    get-logging -type Info -Message $out | Out-File $File -Append

    # Check for ID Card
    get-logging -type Info -Message "Checking ID Card" | Out-File $File -Append
    [string]$UserID = Read-Host "Please select your ID card (AADHAR, PAN, VoterID) ?"
    
            if ($AcceptedID -contains $UserID) { 
                $ID_check = Write-Output "This ID card is an acceptable identity, you can proceed for Voting"
                $ID_check
                get-logging -type Info -Message "ID was successfully validated and user advised to proceed for voting process" | Out-File $File -Append

            Write-Host "Lets enter into Voting system" -ForegroundColor Yellow
            Write-Host "Please cast your vote properly and ensure to check final message of your successfull voting" -ForegroundColor Cyan

            Start-Sleep -Seconds 2

            $Title = "**********Welcome to Election 2024 **********"
            $Info = "Please select party you want to vote"
  
            $options = [System.Management.Automation.Host.ChoiceDescription[]] @("Party-A", "Party-B",  "Party-C", "Party-D", "NOTA")
            [int]$defaultchoice = 4
            $opt = $host.UI.PromptForChoice($Title , $Info , $Options,$defaultchoice)
            switch($opt)
            {
                        0 { Write-Host "Congrats you have successfully voted for Party-B" -ForegroundColor Green}
                        1 { Write-Host "Congrats you have successfully voted for Party-A" -ForegroundColor Green}
                        2 { Write-Host "Congrats you have successfully voted for Party-D" -ForegroundColor Green}
                        3 { Write-Host "Congrats you have successfully voted for Party-C" -ForegroundColor Green}
                        4 { Write-Host "OOPS...its NOTA" -ForegroundColor Green}
            }


            } else {
                    $ID_checkFail = Write-Output "Please enter a valid ID card" -Verbose
                    $ID_checkFail
                    get-logging -type Error -Message "User didn't have a valid ID card" | Out-File $File -Append
            }


            

    


} else {

   $out = Write-Output "Sorry!! $name, You are not eligible for voting"
   $out
   get-logging -type Info -Message $out | Out-File $File -Append
}

}



