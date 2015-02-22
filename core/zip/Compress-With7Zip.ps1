<#
The MIT License (MIT)

Copyright (c) 2015 Objectivity Bespoke Software Specialists

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#>

function Compress-With7Zip {
    <#
    .SYNOPSIS
    Compresses files using 7-zip

    .PARAMETER PathsToCompress
    Array of paths to compress. Can use 7zip's wildcards format.

    .PARAMETER Include
    List of file / directory to include. Will be passed to -i! switches.

    .PARAMETER IncludeRecurse
    Recurse type for Include rules (if set, wildcards will be matched recursively).

    .PARAMETER Exclude
    List of file / directory to exclude. Will be passed to -x! switches.

    .PARAMETER ExcludeRecurse
    Recurse type for Include rules (if set, wildcards will be matched recursively).

    .PARAMETER OutputFile
    Output archive file.

    .PARAMETER WorkingDirectory
    Working directory to switch to before running 7-zip.

    .PARAMETER ArchiveFormat
    Format of archive. Available values: zip, gzip, bzip2, 7z, xz. Default: zip.

    .PARAMETER CompressionLevel
    Compression level to use. Available values: 0 (copy), 1 (fastest), 3, 5, 7, 9 (ultra). 

    .PARAMETER Password
    PSCredential object that stores the password used to encrypt the archive.

    .EXAMPLE
    Compress-With7Zip -PathsToCompress "C:\directory\to\compress" -OutputFile "C:\archive.zip"
    #>
    [CmdletBinding()]
    [OutputType([void])]
    param(
        [Parameter(Mandatory=$true)]
        [string[]]
        $PathsToCompress,
        
        [Parameter(Mandatory=$false)]
        [string[]] 
        $Include,

        [Parameter(Mandatory=$false)]
        [switch] 
        $IncludeRecurse,
         
        [Parameter(Mandatory=$false)]
        [string[]] 
        $Exclude,

        [Parameter(Mandatory=$false)]
        [switch] 
        $ExcludeRecurse,

        [Parameter(Mandatory=$true)]
        [string] 
        $OutputFile, 

        [Parameter(Mandatory=$false)]
        [string] 
        $WorkingDirectory, 

        [Parameter(Mandatory=$false)]
        [ValidateSet("zip", "gzip", "bzip2", "7z", "xz")]
        [string] 
        $ArchiveFormat = "zip", 

        [Parameter(Mandatory=$false)]
        [ValidateSet("copy", "fast", "medium", "good", "ultra")]
        [string] 
        $CompressionLevel = "good",

        [Parameter(Mandatory=$false)]
        [System.Management.Automation.PSCredential]
        $Password
    )

    $cmdLine = New-Object System.Text.StringBuilder

    $7zipPath = Add-QuotesToPaths (Get-PathTo7Zip -FailIfNotFound)
    [void]($cmdLine.Append($7zipPath))

    if (([uri]$WorkingDirectory).IsUnc) {
        Write-Log -Critical "Working directory '$WorkingDirectory' is an unc path. 7-zip does not support that."
    }
    if (!$WorkingDirectory) {
        $WorkingDirectory = Get-Location | Select-Object -ExpandProperty Path
    }

    # wrap in quotes if needed
    $OutputFile = Add-QuotesToPaths $OutputFile
    $PathsToCompress = Add-QuotesToPaths $PathsToCompress
    $compressionSwitch = switch ($CompressionLevel) {
        "copy" { "0" }
        "fast" { "3" }
        "medium" { "5" }
        "good" { "7" }
        "ultra" { "9" }
    }
    [void]($cmdLine.Append(" a $OutputFile "))
    [void]($cmdLine.Append(($PathsToCompress -join " ")))
    [void]($cmdLine.Append(" -r -t$ArchiveFormat -mx$compressionSwitch"))
    if ($Password) {
        $cmdLine.Append(" -p$($Password.GetNetworkCredential().Password)")
    }
        
    if ($Include) {
        foreach ($wildcard in $Include) {
            if ($IncludeRecurse) {
               [void]($cmdLine.Append(" -ir!$wildcard"))
            } else {
               [void]($cmdLine.Append(" -i!$wildcard"))
            }
        }
    }
        
    if ($Exclude) {
        foreach ($wildcard in $Exclude) {
            if ($ExcludeRecurse) {
              [void]($cmdLine.Append(" -xr!$wildcard"))
            } else {
               [void]($cmdLine.Append(" -x!$wildcard"))
            }
        }
    }

    try { 
        Push-Location -Path $WorkingDirectory
        Write-Log -_Debug "Invoking 7zip at directory '$WorkingDirectory'"
        [void](Invoke-ExternalCommand -Command ($cmdLine.ToString()) -Quiet)
    } finally {
        Pop-Location
    }
    
}