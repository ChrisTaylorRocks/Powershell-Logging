function Update-LogSettings {
    <#
    .SYNOPSIS
        Updates log settings
    .PARAMETER SMTPServer
        Mandatory. FQDN of the SMTP server used to send the email. Example: smtp.google.com
    .PARAMETER LogPath
        Mandatory. Full path of the log file you want to email. Example: C:\Windows\Temp\Test_Script.log
    .PARAMETER EmailFrom
        Mandatory. The email addresses of who you want to send the email from. Example: "admin@9to5IT.com"
    .PARAMETER EmailTo
        Mandatory. The email addresses of where to send the email to. Seperate multiple emails by ",". Example: "admin@9to5IT.com, test@test.com"
    .PARAMETER EmailSubject
        Mandatory. The subject of the email you want to send. Example: "Cool Script - [" + (Get-Date).ToShortDateString() + "]"
    .PARAMETER Status
        Will output the status on Stop-Log
    
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
        Update-LogSettings -Staus 'Failed'
        Will change the log status to failed and will be flagged as so when 'Stop-Log' is called.
    #>
    [CmdletBinding()]
    Param (
        [string]$SMTPServer,
        [string]$LogPath,
        [string]$EmailFrom,
        [string]$EmailTo,
        [string]$EmailSubject,
        [string]$Status
    )

    foreach($i in $PsBoundParameters.GetEnumerator()){
            $script:PSLogSettings[$i.Key] = $i.value
    }
}
