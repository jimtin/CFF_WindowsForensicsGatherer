$version = Get-InstalledModule -Name Pester
Write-Host $version

# Initial basic test
Describe 'Basic Pester Test'{
    It 'Should Be true'{
        $true | Should -Be $true
    }
}

# Confirm the version of Pester installed on the base server
Describe "Pester Version"{
    It 'Should Be Version 5'{
        $version = Get-InstalledModule -Name Pester
        $version = $version.Version
        $version | Should -BeGreaterOrEqual 5.0.0
    }
}

# Confirm that the test administrator account exists
Describe 'TestAdministrator account exists'{
    It 'Should Exist'{
        $admin = Get-LocalGroupMember -Group "Administrators" | Where-Object {$_.Name -match "TestAdministrator"}
        $admin | Should -Not -BeNullOrEmpty
    }
}