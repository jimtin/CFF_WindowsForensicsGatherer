# Get the password
$upass = $env:UPASS

# Get the target
$target = $env:TARGET

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
    # Test that the module manifest exists
    It "Module manifest should exist"{
        $content = Get-Content C:\WindowsForensicGatherer\CFF_WindowsForensicsGatherer-master\manifest.txt
        $content | Should -Not -BeNullOrEmpty
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
    
}

# Test the Invoke-HostHunterCommand
Describe "Test credential access"{
    # A raw Invoke-Command
    It "Invoke-Command should not work with no credentials"{
        $output = Invoke-Command -ComputerName $target -ScriptBlock{Get-Process} -ErrorAction SilentlyContinue
        $output | Should -BeNullOrEmpty
    }

    # Without changing the TrustedHosts Registry Key, this should not work
    It "Invoke-Command should not work without changing the TrustedHosts registry key"{
        $output = Invoke-Command -ComputerName $target -Credential $creds -ScriptBlock{Get-Process} -ErrorAction SilentlyContinue
        $output | Should -BeNullOrEmpty
    }

    # If the TrustedHosts Registry is manually updated, the connection should work
    It "Invoke-Command should work if the TrustedHosts Registry key is set to *"{
        Set-Item WSMan:\localhost\Client\TrustedHosts * -Force
        $output = Invoke-Command -ComputerName $target -Credential $creds -ScriptBlock{Get-Process}
        $output | Should -Not -BeNullOrEmpty
        Set-Item WSMan:\localhost\Client\TrustedHosts - -Force
    }

}

# Test the creation of a session
Describe "HostHunterSession creation"{
    # Check that module was loaded
    It "Module should be loaded"{
        Get-Module -Name "New-HostHunterSession" | Should -Exist
    }

    # Check that no current sessions exist
    It "No current sessions should exist"{
        Get-PSSession | Should -BeNullOrEmpty
    }

    # Run the New-HostHunterSession module and confirm it has returned true
    It "Should create a session"{
        $session = New-HostHunterSession -ComputerName $env:TARGET -Credential $creds
        $session.SessionCreationOutcome | Should -Be $true
    }

    # A session should now have been created
    It "A session should now exist"{
        Get-PSSession | Should -Not -BeNullOrEmpty
    }

    # The trusted hosts registry key should have been updated with this target
    It "Trusted hosts should be updated with current target"{
        $trustedhosts = Get-Item WSMan:\localhost\Client\TrustedHosts
        $trustedhosts | Should -Be $env:TARGET
    }
}



