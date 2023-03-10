# ------------------------------------------------------------------------
# NAME: massrename.ps1
# AUTHOR: spatournos
# DATE: Jan 2023
#
# COMMENTS: This script renames given files in a folder by replacing their
# extension (so it changes file type) or adding extension if they don't have one.
# ------------------------------------------------------------------------

<#
.SYNOPSIS
  Add/Replace file extension in given files in a folder
.DESCRIPTION
  Mass change file extension for selected files in a folder and log changes
.INPUTS
  
.OUTPUTS
  renamed.log
.EXAMPLE
  massrename.ps1
#>
#rename only specific files with same name and new extension and write log file

$logpath = ".\logs\"
$logfile = $logpath + "renamed.log"
$logtime = (Get-Date)
#new extension you want to add/replace in files
$extension = ".csv"
#filter files to change. Leave * to add/replace extension in all files 
$onlychange = "*.tiff"    
#set counter
$i = 0
#create log dir
if (!(Test-Path "$logpath")) 
	{
		mkdir $logpath -Force
		Write-Host Creating Log Directory ... | Out-Null
	}
else{Write-Host Log Directory Exists}

Write-Host Initiating files renamimg....
Add-Content -path $logfile "Files Renamed"
Add-Content -path $logfile "-----------------------------------------"

gci -filter $onlychange | ?{!$_.PsIsContainer} | 
			%{
				$newname = $_.BaseName + $extension
                                ren $_ -new $newname -f 
                                $i++
                                
                                Write-Host Old Name:"$_" --> New Name: "$newname" -BackgroundColor DarkMagenta
                                Write-Output "Old Name:$_ --> New Name: $newname" | Out-File  $logfile -Append ascii
			}#end of rename loop
                                
Write-Host $i files renamed $logtime -BackgroundColor Green
Add-Content -path $logfile -value "`r`n$i files renamed $logtime`r`n"

#calculate execution time
$timetoexecute = (Get-Date)-$logtime 
Write-Host Renaming completed in $timetoexecute.Seconds secs and $timetoexecute.Milliseconds msecs -BackgroundColor Cyan
ii $logfile	
