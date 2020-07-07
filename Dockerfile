# Set the base image to be Microsoft provided Powershell Core image
FROM mcr.microsoft.com/powershell:7.0.2-windowsservercore-1909

# Change the shell to be Powershell Core by default
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop';"]

# Run the command "Hello World"
RUN Write-Host "Hello World"

# Add in the CFF_WindowsForensicsGatherer to the container
ADD https://github.com/jimtin/CFF_WindowsForensicsGatherer/archive/master.zip /WindowsForensicsGatherer.zip

# Expand the downloaded git repository
RUN Expand-Archive -Path C:\\WindowsForensicsGatherer.zip

# Set the working directory to be where the powershell script is
WORKDIR C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer

# Load powershell commands into memory space then execute the commands on the target
#CMD 
