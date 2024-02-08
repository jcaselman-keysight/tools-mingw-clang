# Set-ExecutionPolicy Bypass -Scope Process -Force;
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# download gitlab-runner
New-Item -Path "C:\" -Name "GitLab-Runner" -ItemType "directory"
Invoke-WebRequest "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/latest/binaries/gitlab-runner-windows-amd64.exe" -Outfile "C:\Gitlab-Runner\gitlab-runner.exe"

# MSYS2, the work environment
choco install -y msys2 git

# Add msys2 staging database
$pacman_conf_path = "C:\tools\msys64\etc\pacman.conf"
$staging_directive = "[staging]`nServer = https://repo.msys2.org/staging/`nSigLevel = Never`n`n"
$(
    $staging_directive
    Get-Content -Raw $pacman_conf_path
) | Set-Content $pacman_conf_path

# Download staging database
C:\tools\msys64\usr\bin\bash --login -c 'pacman -Sy'

# Install Ansible
C:\tools\msys64\usr\bin\bash --login -c 'pacman -S --needed --noconfirm ansible'

# Run the provisioning playbook locally
& 'C:\tools\msys64\usr\bin\bash.exe' --login -c 'ansible-playbook --connection=local --inventory 127.0.0.1, --limit 127.0.0.1 /c/vagrant/playbook.yml'