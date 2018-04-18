Function Write-LogError {
  <#
  .SYNOPSIS
    Writes error message to specified log file
  .DESCRIPTION
    Appends a new error message to the specified log file. Automatically prefixes line with ERROR:
  .PARAMETER LogPath
    Mandatory. Full path of the log file you want to write to. Example: C:\Windows\Temp\Test_Script.log
  .PARAMETER Message
    Mandatory. The description of the error you want to pass (pass your own or use $_.Exception)
  .PARAMETER TimeStamp
    Optional. When parameter specified will append the current date and time to the end of the line. Useful for knowing
    when a task started and stopped.
  .PARAMETER ExitGracefully
    Optional. If parameter specified, then runs Stop-Log and then exits script
  .PARAMETER ToScreen
    Optional. When parameter specified will display the content to screen as well as write to log file. This provides an additional
    another option to write content to screen as opposed to using debug mode.
  .PARAMETER Email
    Optional. If parameter specified and ExitGracefully set it will email the log.

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
    Purpose/Change: Added debug mode support. Added -ExitGracefully parameter functionality.
    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed function name to use approved PowerShell Verbs. Improved help documentation.
    Version:        1.3
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed parameter name from ErrorDesc to Message to improve consistency across functions.
    Version:        1.4
    Author:         Luca Sturlese
    Creation Date:  03/09/15
    Purpose/Change: Improved readability and cleaniness of error writing.
    Version:        1.5
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Changed -ExitGracefully parameter to switch type so no longer need to specify $True or $False (see example for info).
    Version:        1.6
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -TimeStamp parameter which append a timestamp to the end of the line. Useful for knowing when a task started and stopped.
    Version:        1.7
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -ToScreen parameter which will display content to screen as well as write to the log file.
    Version:        1.8
    Author:         Chris Taylor
    Creation Date:  4/18/2018
    Purpose/Change: Added support for Set-LogSettings and -Email
  .LINK
    http://9to5IT.com/powershell-logging-v2-easily-create-log-files
  .EXAMPLE
    Write-LogError -LogPath "C:\Windows\Temp\Test_Script.log" -Message $_.Exception -ExitGracefully
    Writes a new error log message to a new line in the specified log file. Once the error has been written,
    the Stop-Log function is excuted and the calling script is exited.
  .EXAMPLE
    Write-LogError -LogPath "C:\Windows\Temp\Test_Script.log" -Message $_.Exception
    Writes a new error log message to a new line in the specified log file, but does not execute the Stop-Log
    function, nor does it exit the calling script. In other words, the only thing that occurs is an error message
    is written to the log file and that is it.
    Note: If you don't specify the -ExitGracefully parameter, then the script will not exit on error.
  #>

  [CmdletBinding()]

  Param (
    [Parameter(Position=0)][string]$LogPath,
    [Parameter(Mandatory=$true,Position=1,ValueFromPipeline=$true)][string]$Message,
    [Parameter(Mandatory=$false,Position=3)][switch]$TimeStamp,
    [Parameter(Mandatory=$false,Position=4)][switch]$ExitGracefully,
    [Parameter(Mandatory=$false,Position=5)][switch]$ToScreen,
    [Parameter(Mandatory=$false,Position=5)][switch]$Email    
  )

  Process {

    if (!$LogPath) {
        if(!$script:PSLogSettings.LogPath) {
            Write-Error "No log path has been provided and one has not been set with, 'Set-LogSettings'"
            break
        }
        $LogPath = $script:PSLogSettings.LogPath
    }

    $Message = "ERROR: $Message"

    #Add TimeStamp to message if specified
    If ( $TimeStamp -eq $True ) {
      $Message = "[$([DateTime]::Now)]: $Message"
    }

    #Write Content to Log
    Add-Content -Path $LogPath -Value $Message

    #Write to screen for debug mode
    Write-Debug $Message

    #Write to scren for ToScreen mode
    If ( $ToScreen -eq $True ) {   
      #Write-Output $Message
      Write-Host -ForegroundColor Red $Message
    }

    #If $ExitGracefully = True then run Log-Finish and exit script
    If ( $ExitGracefully -eq $True ){
      Add-Content -Path $LogPath -Value " "
      Stop-Log -LogPath $LogPath -Status 'Failed'
      If ($Email) {
        Send-Log  
      }
      Break
    }
  }
}
