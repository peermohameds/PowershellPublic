$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\..\Source\Public\$sut"

Describe "Add-Number" {
    It "does something useful" {
        $true | Should -Be $true
    }
}
