$upass = Get-Content "C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master\\Tests\\hostname.txt"

# Get the target
$target = Get-Content  "C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master\\Tests\\target.txt"

# Convert upass into secure string
$securestring = ConvertTo-SecureString -String $upass -AsPlainText -Force

# Construct the Credential object
[pscredential]$creds = New-Object System.Management.Automation.PSCredential($username, $securestring) 

# Initial test to see if Pester is working
Describe 'Basic Pester Test'{
    It 'A test should be true'{
        $true | Should -Be $true
    }
}

# Test to see if needed modules and files exist
Describe "Required files"{
    # Test for the Invoke-HostHunterCommand module
    It 'Should Exist'{
        "C:\WindowsForensicsGatherer\CFF_WindowsForensicsGatherer-master\EndpointInteraction\Invoke-HostHunterCommand.psm1" |
        Should -Exist
    }

    # Test for the Target.txt file
    It 'Should Exist'{
        "C:\WindowsForensicsGatherer\CFF_WindowsForensicsGatherer-master\Tests\target.txt" |
        Should -Exist
    }

    # Test for the hostname.txt file
    It 'Should Exist'{
        "C:\WindowsForensicsGatherer\CFF_WindowsForensicsGatherer-master\Tests\hostname.txt" | 
        Should -Exist
    }
}

# Test the credentials to make sure they are a secure string
Describe "Test Credentials"{
    It 'Should be a PSCredential Object'{
        ($creds.GetType()).Name | Should -Be "PSCredential"
    }
}

# Test to confirm WinRM on remote machine works
Describe "Test WinRM"{
    # Test against this endpoint
    It 'Should be turned on'{
        # Test WSMan against this instance
        $winrm = Test-WSMan -ComputerName localhost -ErrorAction SilentlyContinue

        # If WinRM is working, this should return not-null
        $winrm | Should -Not -BeNullOrEmpty
    }

    # Test against a remote endpoint
    It 'Should work on remote endpoints'{
        # Test WSMan against the VM hosting this endpoint
        $winrm = Test-WSMan -ComputerName $target -ErrorAction SilentlyContinue

        # If WinRM is working on remote endpoing this should return not null
        $winrm | Should -Not -BeNullOrEmpty
    }

    # Test the trusted hosts file
    It 'TrustedHosts should be set to none'{
        $trustedhosts = Get-Item WSMan:\localhost\Client\TrustedHosts
        Write-Host $trustedhosts
        $trustedhosts | Should -BeNullOrEmpty
    }
    
}

# Test the Invoke-HostHunterCommand
Describe "Test credential access"{
    # A raw Invoke-Command
    It "Invoke-Command should not work with no credentials"{
        $output = Invoke-Command -ComputerName $target -ScriptBlock{Get-Process} -ErrorAction SilentlyContinue
        $output | Should -BeNullOrEmpty
    }

    # Without changing the TrustedHosts file, this should not work
    It "Invoke-Command should not work without changing the TrustedHosts registry key"{
        $output = Invoke-Command -ComputerName $target -Credential $creds -ScriptBlock{Get-Process} -ErrorAction SilentlyContinue
        $output | Should -BeNullOrEmpty
    }

}



