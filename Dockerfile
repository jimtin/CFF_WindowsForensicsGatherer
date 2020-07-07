# Set the base image to be Microsoft provided Powershell Core image
FROM mcr.microsoft.com/powershell:7.0.2-windowsservercore-1909

# Change the shell to be Powershell Core by default
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop';"]

# Add in the CFF_WindowsForensicsGatherer to the container
ADD https://github.com/jimtin/CFF_WindowsForensicsGatherer/archive/master.zip /WindowsForensicsGatherer.zip

# Expand the downloaded git repository
RUN Expand-Archive -Path C:\\WindowsForensicsGatherer.zip

# Set the working directory to be where the powershell script is
# WORKDIR C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master

# Set up the Environment Variables for Target and Playbook
ENV TARGET NoTarget
ENV PLAYBOOK NoPlaybook

# RUN Get-Content C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master\\runcommand.ps1

# Load powershell commands into memory space then execute the commands on the target
CMD C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master\\runcommand.ps1 Target Playbook
