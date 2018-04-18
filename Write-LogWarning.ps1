Function Write-LogWarning {
  <#
  .SYNOPSIS
    Writes warning message to specified log file
  .DESCRIPTION
    Appends a new warning message to the specified log file. Automatically prefixes line with WARNING:
  .PARAMETER LogPath
    Mandatory. Full path of the log file you want to write to. Example: C:\Windows\Temp\Test_Script.log
  .PARAMETER Message
    Mandatory. The string that you want to write to the log
  .PARAMETER TimeStamp
    Optional. When parameter specified will append the current date and time to the end of the line. Useful for knowing
    when a task started and stopped.
  .PARAMETER ToScreen
    Optional. When parameter specified will display the content to screen as well as write to log file. This provides an additional
    another option to write content to screen as opposed to using debug mode.
  .INPUTS
    Parameters above
  .OUTPUTS
    None
  .NOTES
    Version:        1.0
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Initial function development.
    Version:        1.1
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -TimeStamp parameter which append a timestamp to the end of the line. Useful for knowing when a task started and stopped.
    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -ToScreen parameter which will display content to screen as well as write to the log file.
    Version:        1.3
    Author:         Chris Taylor
    Creation Date:  4/18/2018
    Purpose/Change: Added support for Set-LogSettings

  .LINK
    http://9to5IT.com/powershell-logging-v2-easily-create-log-files
  .EXAMPLE
    Write-LogWarning -LogPath "C:\Windows\Temp\Test_Script.log" -Message "This is a warning message."
    Writes a new warning log message to a new line in the specified log file.
  #>

  [CmdletBinding()]

  Param (
    [Parameter(Mandatory=$false,Position=0)][string]$LogPath,
    [Parameter(Mandatory=$true,Position=1,ValueFromPipeline=$true)][string]$Message,
    [Parameter(Mandatory=$false,Position=2)][switch]$TimeStamp,
    [Parameter(Mandatory=$false,Position=3)][switch]$ToScreen
  )

  Process {
    if (!$LogPath) {
        if(!$script:PSLogSettings.LogPath) {
            Write-Error "No log path has been provided and one has not been set with, 'Set-LogSettings'"
            break
        }
        $LogPath = $script:PSLogSettings.LogPath
    }

    $Message = "WARNING: $Message"

    #Add TimeStamp to message if specified
    If ( $TimeStamp -eq $True ) {
      $Message = "[$([DateTime]::Now)]: $Message"
    }

    #Write Content to Log
    Add-Content -Path $LogPath -Value "$Message"

    #Write to screen for debug mode
    Write-Debug "$Message"

    #Write to scren for ToScreen mode
    If ( $ToScreen -eq $True ) {
      Write-Host -ForegroundColor Yellow "$Message"
    }
  }
}
