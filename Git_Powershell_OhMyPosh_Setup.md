#https://www.hanselman.com/blog/take-your-windows-terminal-and-powershell-to-the-next-level-with-terminal-icons
- >> Install-Module -Name Terminal-Icons -Repository PSGallery
- >> notepad++ $profile
#Add following line.
- >> Import-Module -Name Terminal-Icons


#https://www.hanselman.com/blog/how-to-make-a-pretty-prompt-in-windows-terminal-with-powerline-nerd-fonts-cascadia-code-wsl-and-ohmyposh
- >> Install-Module posh-git -Scope CurrentUser
- >> Install-Module oh-my-posh -Scope CurrentUser
  * oh-my-posh : The term 'oh-my-posh' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again. At line:1 char:1
    + oh-my-posh init pwsh | Invoke-Expression
    + CategoryInfo          : ObjectNotFound: (oh-my-posh:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException

  * For installation you have to install it via admin rights powershell - 
  ` Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))` 
and not via Windows Store as it only installs on the CurrentUser privilege.

- >> Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
- >> notepad $PROFILE
# Add these lines before Import-Module -Name Terminal-Icons
- Import-Module posh-git
- Import-Module oh-my-posh
- Set-PoshPrompt -Theme Paradox
- Install the font: https://www.nerdfonts.com/font-downloads (Cascadia Code, Nerd Font)


*********
Powershell Profile

#Import the modules
- Import-Module -Name Terminal-Icons
- Import-Module posh-git
- -Module oh-my-posh
- #Set-PoshPrompt -Theme Paradox
- Set-PoshPrompt C:\Users\DEV\Documents\PowerShell\Themes\npatel.omp.json
  - https://github.com/nirajp82/Powershell_Util/blob/main/theme/npatel.omp.json
- # Produce UTF-8 by default
- # https://news.ycombinator.com/item?id=12991690
- $PSDefaultParameterValues["Out-File:Encoding"] = "utf8"
- # bash-style completion
- Set-PSReadlineKeyHandler -Key Tab -Function Complete
- #Change directory
- #cd c:\source\projects

# Font
* https://github.com/microsoft/cascadia-code/releases
* https://github.com/nirajp82/cascadia-code

