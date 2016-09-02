Function Write-LogInfo {
  <#
  .SYNOPSIS
    Writes informational message to specified log file
  .DESCRIPTION
    Appends a new informational message to the specified log file
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
    Creation Date:  02/09/15
    Purpose/Change: Changed parameter name from LineValue to Message to improve consistency across functions.
    Version:        1.4
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -TimeStamp parameter which append a timestamp to the end of the line. Useful for knowing when a task started and stopped.
    Version:        1.5
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -ToScreen parameter which will display content to screen as well as write to the log file.
    Author:         Chris Taylor
    Creation Date:  9/2/2016
    Purpose/Change: Added verbose output option.

  .LINK
    http://9to5IT.com/powershell-logging-v2-easily-create-log-files
  .EXAMPLE
    Write-LogInfo -LogPath "C:\Windows\Temp\Test_Script.log" -Message "This is a new line which I am appending to the end of the log file."
    Writes a new informational log message to a new line in the specified log file.
  #>

  [CmdletBinding()]

  Param (
    [Parameter(Mandatory=$true,Position=0)][string]$LogPath,
    [Parameter(Mandatory=$true,Position=1,ValueFromPipeline=$true)][string]$Message,
    [Parameter(Mandatory=$false,Position=2)][switch]$TimeStamp,
    [Parameter(Mandatory=$false,Position=3)][switch]$ToScreen
  )

  Process {
    #Add TimeStamp to message if specified
    If ( $TimeStamp -eq $True ) {
      $Message = "[$([DateTime]::Now)]: $Message"
    }

    #Write Content to Log
    Add-Content -Path $LogPath -Value $Message

    #Write to screen for debug mode
    Write-Debug $Message

    #Write to screen for Verbose mode
    Write-Verbose $Message

    #Write to scren for ToScreen mode
    If ( $ToScreen -eq $True ) {
      Write-Output $Message
    }
  }
}
