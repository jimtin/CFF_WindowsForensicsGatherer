# Set the base image to be Microsoft provided Powershell Core image
FROM mcr.microsoft.com/powershell:7.0.2-windowsservercore-1809

# Change the shell to be Powershell Core by default
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop';"]

# Add in the CFF_WindowsForensicsGatherer to the container
ADD https://github.com/jimtin/CFF_WindowsForensicsGatherer/archive/Invoke-HostHunterCommandTests.zip /WindowsForensicsGatherer.zip

# Expand the downloaded git repository
RUN Expand-Archive -Path C:\\WindowsForensicsGatherer.zip

# Rename the file to be the original name
RUN Rename-Item -Path "C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-Invoke-HostHunterCommandTests" -NewName "CFF_WindowsForensicsGatherer-master"

# Enable Powershell Remoting
RUN Enable-PSRemoting -Force

# Ensure Pester is installed
RUN Install-Module Pester -Force

# Set up the Environment Variables for Target and Playbook
ENV TARGET NoTarget
ENV PLAYBOOK NoPlaybook

# Load powershell commands into memory space then execute the commands on the target
CMD C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master\\runcommand.ps1 Target Playbook
