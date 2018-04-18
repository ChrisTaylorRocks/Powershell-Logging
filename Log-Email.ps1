Function Send-Log {
  <#
  .SYNOPSIS
    Emails completed log file to list of recipients
  .DESCRIPTION
    Emails the contents of the specified log file to a list of recipients
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
  .INPUTS
    Parameters above
  .OUTPUTS
    Email sent to the list of addresses specified
  .NOTES
    Version:        1.0
    Author:         Luca Sturlese
    Creation Date:  05.10.12
    Purpose/Change: Initial function development.
    Version:        1.1
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed function name to use approved PowerShell Verbs. Improved help documentation.
    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Added SMTPServer parameter to pass SMTP server as oppposed to having to set it in the function manually.
    Version:        1.3
    Author:         Chris Taylor
    Creation Date:  9/2/2016
    Purpose/Change: Added verbose output option.
    Version:        1.4
    Author:         Chris Taylor
    Creation Date:  4/18/2018
    Purpose/Change: Added support for Set-LogSettings

  .LINK
    http://9to5IT.com/powershell-logging-v2-easily-create-log-files
  .EXAMPLE
    Send-Log -SMTPServer "smtp.google.com" -LogPath "C:\Windows\Temp\Test_Script.log" -EmailFrom "admin@9to5IT.com" -EmailTo "admin@9to5IT.com, test@test.com" -EmailSubject "Cool Script"
    Sends an email with the contents of the log file as the body of the email. Sends the email from admin@9to5IT.com and sends
    the email to admin@9to5IT.com and test@test.com email addresses. The email has the subject of Cool Script. The email is
    sent using the smtp.google.com SMTP server.
  #>

  [CmdletBinding()]

  Param (
    [Parameter(Position=0)][string]$SMTPServer,
    [Parameter(Position=1)][string]$LogPath,
    [Parameter(Position=2)][string]$EmailFrom,
    [Parameter(Position=3)][string]$EmailTo,
    [Parameter(Position=4)][string]$EmailSubject
  )

  Process {
    Try {
        if (!$LogPath) {
            if(!$script:PSLogSettings.LogPath) {
                Write-Error "No log path has been provided and one has not been set with, 'Set-LogSettings'"
                break
            }
            $LogPath = $script:PSLogSettings.LogPath
        }
        if (!$SMTPServer) {
            if(!$script:PSLogSettings.SMTPServer) {
                Write-Error "No SMTPServer has been provided and one has not been set with, 'Set-LogSettings'"
                break
            }
            $SMTPServer = $script:PSLogSettings.SMTPServer
        }
        if (!$EmailFrom) {
            if(!$script:PSLogSettings.EmailFrom) {
                Write-Error "No EmailFrom has been provided and one has not been set with, 'Set-LogSettings'"
                break
            }
            $EmailFrom = $script:PSLogSettings.EmailFrom
        }
        if (!$EmailTo) {
            if(!$script:PSLogSettings.EmailTo) {
                Write-Error "No EmailTo has been provided and one has not been set with, 'Set-LogSettings'"
                break
            }
            $EmailTo = $script:PSLogSettings.EmailTo
        }
        if (!$EmailSubject) {
            if(!$script:PSLogSettings.EmailSubject) {
                Write-Error "No EmailSubject has been provided and one has not been set with, 'Set-LogSettings'"
                break
            }
            $EmailSubject = $script:PSLogSettings.EmailSubject
        }

        $sBody = ( Get-Content $LogPath | Out-String )

        #Create SMTP object and send email
        $oSmtp = new-object Net.Mail.SmtpClient($SMTPServer)
        $oSmtp.Send($EmailFrom,$EmailTo,$EmailSubject,$sBody)
        Write-Verbose "Server: $SMTPServer"
        Write-Verbose "From: $EmailFrom"
        Write-Verbose "To: $EmailTo"
        Write-Verbose "Subject: $EmailSubject"
        Write-Verbose "Body: $sBody"
        Exit 0
    }

    Catch {
      Exit 1
    }
  }
}
