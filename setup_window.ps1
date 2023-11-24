#Run This If Error: Set-ExecutionPolicy RemoteSigned -Scope CurrentUser


# ========== Function ========== 
function Write-Start {
	param($msg)
	Write-Host (">> " + $msg) -ForegroundColor Green
}

function Write-Done {
	Write-Host ("DONE!") -ForegroundColor Blue
}

function Write-Error {
	param($msg)
	Write-Host (">> " + $msg) -ForegroundColor Red
}

# ========== Start ==========
Start-Process -Wait powershell -verb runas -ArgumentList "Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0"

Write-Start -msg "Initilalizing Scoop..."
if (Get-Command scoop -errorAction SilentlyContinue)
{
	Write-Warning "Scoop already installed"
}
else 
{
	Set-ExecutionPolity RemoteSigned -Scope CurrentUser
	irm set.scoop.sh | iex
}
Write-Done


Write-Start -msg "Initilalizing Chocolatey..."
if (Get-Command choco -errorAction SilentlyContinue)
{
	Write-Warning "Scoop already installed"
}
else 
{
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

Write-Done

Write-Start -msg "Installing Scoop Pakages..."
	scoop bucket add java 	
	scoop bucket add main
	scoop bucket add extras
	scoop install googlechrome
	scoop install neofetch which 
	scoop install neovim vscode gcc nodejs openjdk python
	scoop install notepadplusplus
	scoop install extras/sublime-text
	scoop install extras/postman
	scoop install main/docker
	scoop install 7zip

Write-Start -msg "Installing Chocolatey Pakages..."
	choco install git
	choco install unikey
	choco install discord
	choco install zalopc


Write-Done



Write-Start -msg "Configuring VSCode"
	code --install-extension ritwickdey.LiveServer --force
	code --install-extension dracula-theme.theme-dracula --force	
Write-Done

write-start -msg "Configuring Git"
	git config --global --foce user.name "Haruto Nguyen"
	git config --global --foce user.email "quanmcvn656@gmail.com"
Write-Done

#Write-Start -msg "Enable Virtualization"
#Start-Process -Wait powershell -verb runas -ArgumentList @"

Write-Start -msg "Installing WSL"
if (!(wsl -l -v)) 
{
	wsl --install
	wsl --update
	wsl --install --no-launch --web-download -d Ubuntu
}
else  
{
	Write-Warning "WSL Already Installed"
}
Write-Done

Write-Start -msg "Install Spotify Crack"
	powershell .\SpotX\Install.ps1
Write-Done
