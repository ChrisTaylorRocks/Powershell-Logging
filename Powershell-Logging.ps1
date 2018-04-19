    #This will load all Powershell-Logging functions
    #https://github.com/ChrisTaylorRocks/Powershell-Logging
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Log-Email.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Start-Log.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Stop-Log.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Write-LogError.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Write-LogInfo.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Write-LogWarning.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Set-LogSettings.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Update-LogSettings.ps1") | iex
