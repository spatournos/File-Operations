# ------------------------------------------------------------------------
# NAME: clean-new teams-cache.ps1
# AUTHOR: spatournos
# DATE: Apr 2025
#
# COMMENTS: Clears the cache for the new Microsoft Teams application
# ------------------------------------------------------------------------

<#
.SYNOPSIS
  Clears the cache for the new Microsoft Teams application
.DESCRIPTION
  clears the cache for the new Microsoft Teams application
.INPUTS
  
.OUTPUTS
 
.EXAMPLE
  clean-new teams-cache.ps1
#>


$clearCache = Read-Host "Delete the Teams Cache (Y/N)?"
# Define the path to the Teams cache folder
$newTeamsCachePath = "$env:USERPROFILE\appdata\local\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\*"
$teamsCachePath = "$env:APPDATA\Microsoft\Teams"

# Close app before clearing
if ($clearCache.ToUpper() -eq "Y"){
  Write-Host "Closing Teams..." -ForegroundColor Cyan
  
  try{
    if (Get-Process -ProcessName ms-teams -ErrorAction SilentlyContinue) { 
        Stop-Process -Name ms-teams -Force
        Start-Sleep -Seconds 3
        Write-Host "Teams has been closed successfully" -ForegroundColor Green
    }else{
        Write-Host "Teams is already closed" -ForegroundColor Red
    }
  }catch{
      Write-Warning $_
  }

  Write-Host "Starting the process of clearing the Teams cache..." -ForegroundColor Cyan
  # Check if the Teams cache folder exists
  try{
    Remove-Item -Path $newTeamsCachePath -Recurse -Force -Confirm:$false
    Write-Host "Teams cache has been deleted" -ForegroundColor Green
  }catch{
    Write-Warning $_
  }

  Write-Host "Launching Teams..." -ForegroundColor Magenta
  EXPLORER.EXE shell:AppsFolder\MSTeams_8wekyb3d8bbwe!MSTeams
}


