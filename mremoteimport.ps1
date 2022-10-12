#region help
<#
.SYNOPSIS
    Script to create a mremote import file from a list of hosts
.DESCRIPTION
    This function uses the exiting mremotetemplate file, list of hosts file and creates mremote import csv file.
    Tested with mremote version 1.76.20 (2019-04-12).
.NOTES
    File Name            : mremoteimport.ps1
    Author               : Ashneil Singh - connect at https://github.com/ashvants
    Requires             : Powershell v3
    Dependencies         : Mremote csv template file path, Hosts list csv file, Mremoteimport csv file path
    Date Created         : 01/06/2021

# USAGE
import - csv "Hosts list csv file" | mremoteimport -MremoteTemplateFile "Mremote csv template file path" -MremoteImportFile "Mremoteimport csv file path"
#>

function mremoteimport {
    [cmdletBinding()]
    param (
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            ValueFromPipelineByPropertyName = $True,
            HelpMessage = "Input a CSV/Array with at least the following cols: ServerName")]
        [array]$InputData,
        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [string]$MremoteTemplate,
        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [string]$MremoteImport
    )
    
    BEGIN {
        # Setup code
        if ($PSCmdlet.ParameterSetName -eq "nopipeline") {
            Write-Host "No pipeline input"
        }
    }

    PROCESS {
        $data += $InputData
         Remove all existing csv files from the output path
         $OutputPath = ([System.IO.Path]::GetDirectoryName($MremoteImport))
         Remove-Item -Path "$OutputPath\*.*" -Include *.csv  
    }

    END {
        foreach ($host in $data.Hostname) {
            $fqdn = ([System.Net.Dns]::GetHostByName($host)).HostName
            # Find the entry Name matched with "server" then replace this with hostname and FQDN
            Import-Csv $MremoteTemplate -Delimiter ";" | Select-Object * | ?{ $_.Name -eq "server" } | ?{ $_.Name -eq "server"; ($_.Name = $host); ($_.Hostname = $fqdn)} `
            | Export-Csv -Path $MremoteImport -Delimiter ";" -NoTypeInformation -Append
        }
        # Find the entry Name matched with "folder" then append this to csv file
        Import-Csv $MremoteTemplate -Delimiter ";" | Select-Object * | ?{ $_.Name -eq "folder" } | Export-Csv -Path $MremoteImport -Delimiter ";" -NoTypeInformation -Append
    }
}