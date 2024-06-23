$user = "xyz.com\nirshu"
# Function to convert domain\username to username@domain
function ConvertToEmailAddressFormat {
    param(
        [string]$username
    )

    # Split the username into domain and username
    $parts = $username -split '\\'

    # Check if domain\username format is used
    if ($parts.Length -eq 2) {
        $domain = $parts[0]
        $username = $parts[1]
        return "$username@$domain"
    } else {
        return $username
    }
}

# Test the function
$username = $user
$convertedUsername = ConvertToEmailAddressFormat -username $username
Write-Output $convertedUsername
