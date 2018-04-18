function Set-LogSettings {
    <#
    .SYNOPSIS
        Saves all needed information to a script level variable so that it can be used later
    .PARAMETER LogPath
        Mandatory. Full path of the log file you want to write to. Example: C:\Windows\Temp\Test_Script.log
        Parameters above
    .OUTPUTS
        None
        .NOTES
        Version:        1.0
        Author:         Chris Taylor
        Creation Date:  4/18/2018
        Purpose/Change: Initial function development.
    .LINK
        christaylor.rocks
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
        [string]$SMTPServer,
        [Parameter(Mandatory=$true)][string]$LogPath,
        [string]$EmailFrom,
        [string]$EmailTo,
        [string]$EmailSubject
    )
    $script:PSLogSettings = @{
        SMTPServer = $SMTPServer
        LogPath = $LogPath
        EmailFrom = $EmailFrom
        EmailTo = $EmailTo
        EmailSubject = $EmailSubject
    }
}
