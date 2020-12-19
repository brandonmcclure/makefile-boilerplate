[CmdletBinding()]
param(
	[Parameter(mandatory=$true)]$ExtensionName,
	[Parameter(mandatory=$true)]$Publisher,
	[Parameter(mandatory=$true)]$version
)
. $PSScriptRoot\BuildFunctions.ps1

Foreach ($file in $(Get-MyExtensionFiles)){
    $relPath = Resolve-Path -Path "$($file.FullName)" -Relative 
    $destPath = "$env:USERPROFILE/.vscode/extensions/$($Publisher.ToLower()).$ExtensionName-$version/$($relPath)"

    if(-not(Test-Path (Split-PAth $destPath -parent) )){
        New-Item (Split-PAth $destPath -parent) -ItemType Directory -Force
    }
    Copy-Item -path $file.FullName -Destination $destPath -Force 
}