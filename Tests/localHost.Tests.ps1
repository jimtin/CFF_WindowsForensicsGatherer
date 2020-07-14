# Confirm that the test administrator account exists
Describe 'TestAdministrator account exists'{
    It 'Should Exist'{
        Get-LocalGroupMember -Group "Administrators" | Where-Object {$_.Name -match "TestAdministrator"} |
        Should -Exist
    }
}