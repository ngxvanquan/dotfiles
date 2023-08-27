#Run This If Error: Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

function Write-Start {
	param($msg)
	Write-Host (">> " + $msg) -ForegroundColor Green
}

function Write-Done {
	Write-Host ("DONE!") -ForegroundColor Blue
}

# Start
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

Write-Start -msg "Installing Scoop Pakages..."
	scoop bucket add java 	
	scoop bucket add main
	scoop bucket add extras
	scoop install firefox brave googlechrome
	scoop install neofetch which 
	scoop install neovim vscode gcc nodejs openjdk python
	scoop install notepadplusplus
	scoop install 7zip

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
