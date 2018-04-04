Function Start-Log {
  <#
  .SYNOPSIS
    Creates a new log file
  .DESCRIPTION
    Creates a log file with the path and name specified in the parameters. Checks if log file exists, and if it does deletes it and creates a new one.
    Once created, writes initial logging data
  .PARAMETER LogPath
    Mandatory. Path of where log is to be created. Example: C:\Windows\Temp
  .PARAMETER LogName
    Mandatory. Name of log file to be created. Example: Test_Script.log
  .PARAMETER ScriptVersion
    Mandatory. Version of the running script which will be written in the log. Example: 1.5
  .PARAMETER ToScreen
    Optional. When parameter specified will display the content to screen as well as write to log file. This provides an additional
    another option to write content to screen as opposed to using debug mode.
  .INPUTS
    Parameters above
  .OUTPUTS
    Log file created
  .NOTES
    Version:        1.0
    Author:         Luca Sturlese
    Creation Date:  10/05/12
    Purpose/Change: Initial function development.
    Version:        1.1
    Author:         Luca Sturlese
    Creation Date:  19/05/12
    Purpose/Change: Added debug mode support.
    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed function name to use approved PowerShell Verbs. Improved help documentation.
    Version:        1.3
    Author:         Luca Sturlese
    Creation Date:  07/09/15
    Purpose/Change: Resolved issue with New-Item cmdlet. No longer creates error. Tested - all ok.
    Version:        1.4
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -ToScreen parameter which will display content to screen as well as write to the log file.
    Author:         Chris Taylor
    Creation Date:  7/16/2016
    Purpose/Change: Added -Append parameter which will not delete the log if already create. Creates log directory if doen't exist.
                    Piped log creation to Out-Null to remove screen output.
    Author:         Chris Taylor
    Creation Date:  9/2/2016
    Purpose/Change: Added verbose output option.
  .LINK
    http://9to5IT.com/powershell-logging-v2-easily-create-log-files
  .EXAMPLE
    Start-Log -LogPath "C:\Windows\Temp\Test_Script.log" -ScriptVersion "1.5" -Append
    Creates a new log file with the file path of C:\Windows\Temp\Test_Script.log. Initialises the log file with
    the date and time the log was created (or the calling script started executing) and the calling script's version.
  #>

  [CmdletBinding()]

  Param (
    [Parameter(Mandatory=$true,Position=0)][string]$LogPath,
    [Parameter(Mandatory=$true,Position=2)][string]$ScriptVersion,
    [Parameter(Mandatory=$false,Position=3)][switch]$ToScreen,
    [Parameter(Mandatory=$false,Position=4)][switch]$Append
  )

  Process {
    $Path = Split-Path -Parent $LogPath

    #Check if directory exists and create if not
    If (-not (Test-Path -Path $Path)) {
      New-Item -ItemType Directory -Force -Path $Path | Out-Null
    }

       #Check if file exists and delete if it does
    If ((Test-Path -Path $LogPath) -eq $true -and $Append -eq $false){
        Remove-Item -Path $LogPath -Force
    }
    else{
        #Create file and start logging
        $null = Out-File $LogPath -Encoding "UTF8" -Force
    }

    $sLogCreated = 1

    Add-Content -Path $LogPath -Value "***************************************************************************************************"
    Add-Content -Path $LogPath -Value "Started processing at [$([DateTime]::Now)]."
    Add-Content -Path $LogPath -Value "***************************************************************************************************"
    Add-Content -Path $LogPath -Value ""
    Add-Content -Path $LogPath -Value "Running script version [$ScriptVersion]."
    Add-Content -Path $LogPath -Value ""
    Add-Content -Path $LogPath -Value "***************************************************************************************************"
    Add-Content -Path $LogPath -Value ""

    #Write to screen for debug mode
    Write-Debug "***************************************************************************************************"
    Write-Debug "Started processing at [$([DateTime]::Now)]."
    Write-Debug "***************************************************************************************************"
    Write-Debug ""
    Write-Debug "Running script version [$ScriptVersion]."
    Write-Debug ""
    Write-Debug "***************************************************************************************************"
    Write-Debug ""

    #Write to screen for Verbose mode
    Write-Verbose "***************************************************************************************************"
    Write-Verbose "Started processing at [$([DateTime]::Now)]."
    Write-Verbose "***************************************************************************************************"
    Write-Verbose ""
    Write-Verbose "Running script version [$ScriptVersion]."
    Write-Verbose ""
    Write-Verbose "***************************************************************************************************"
    Write-Verbose ""


    #Write to scren for ToScreen mode
    If ( $ToScreen -eq $True ) {
      Write-Output "***************************************************************************************************"
      Write-Output "Started processing at [$([DateTime]::Now)]."
      Write-Output "***************************************************************************************************"
      Write-Output ""
      Write-Output "Running script version [$ScriptVersion]."
      Write-Output ""
      Write-Output "***************************************************************************************************"
      Write-Output ""
    }
  }
}
