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
    It 'Should be turned on'{
        # Run the Test-WSMan Command
        $winrm = Test-WSMan -ComputerName $target -ErrorAction SilentlyContinue

        # If WinRM is working, this should return not-null
        $winrm | Should -Not -BeNullOrEmpty
    }
}

