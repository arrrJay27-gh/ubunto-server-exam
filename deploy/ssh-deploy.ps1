# Deploy POS to your Ubuntu server using your SSH key.
# Usage:
#   .\deploy\ssh-deploy.ps1 -Server "ubuntu@192.168.1.50"
#
# Or with a custom SSH key:
#   .\deploy\ssh-deploy.ps1 -Server "user@10.0.0.5" -IdentityFile "$env:USERPROFILE\.ssh\id_ed25519"

param(
    [Parameter(Mandatory = $true)]
    [string] $Server,

    [string] $IdentityFile = ""
)

$setupUrl = "https://raw.githubusercontent.com/arrrJay27-gh/ubunto-server-exam/main/deploy/ubuntu-setup.sh"
$remoteCmd = "curl -fsSL $setupUrl | bash"

$sshArgs = @()
if ($IdentityFile -ne "") {
    $sshArgs += "-i", $IdentityFile
}
$sshArgs += $Server, $remoteCmd

Write-Host "Connecting to $Server and running setup..." -ForegroundColor Cyan
& ssh @sshArgs

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Deploy finished. Open: http://<your-server-ip>/" -ForegroundColor Green
} else {
    Write-Host "SSH failed (exit $LASTEXITCODE). Check user, IP, key, and that the server is online." -ForegroundColor Red
    exit $LASTEXITCODE
}
