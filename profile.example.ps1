Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module from current directory
Import-Module .\posh-git

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git


# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
    $m = 45 # maximum prompt length
    $str = $pwd.Path

    if ($str.length -ge $m)
    {
        $str = "..." + $str.substring($str.length - $m + 4)
    }

    Write-Host $str -nonewline -ForegroundColor "magenta"

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    Write-Host
    return "> "
}

Enable-GitColors

Pop-Location

Start-SshAgent -Quiet
