    #This will load all Powershell-Logging functions
    #https://github.com/ChrisTaylorRocks/Powershell-Logging
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Log-Start.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Log-Write.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Log-Error.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Log-Finish.ps1") | iex
    (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ChrisTaylorRocks/Powershell-Logging/master/Log-Email.ps1") | iex