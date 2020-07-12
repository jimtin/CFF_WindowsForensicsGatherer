# Get the target
$target = Get-Content  "C:\\WindowsForensicsGatherer\\CFF_WindowsForensicsGatherer-master\\Tests\\target.txt"
Write-Host $target

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

