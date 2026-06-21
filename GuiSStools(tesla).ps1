# === Tesla Launcher - Gefixte versie voor directe CMD uitvoering ===

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml
Add-Type -AssemblyName System.IO.Compression.FileSystem

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Zorg dat we in de juiste map zitten
$scriptPath = $MyInvocation.MyCommand.Path
if ($scriptPath) { Set-Location (Split-Path $scriptPath -Parent) }

$userDir   = [Environment]::GetFolderPath("UserProfile")
$downloads = Join-Path $userDir "Downloads"
$url       = "https://github.com/TeslaPros/TeslaPro-s-SS-Tools/releases/latest/download/SS.TeslaPro.zip"
$zip       = Join-Path $downloads "SS.TeslaPro.zip"
$dest      = Join-Path $downloads "TeslaPro-Tools"
$version   = "3.3"

# ... (de rest van je originele code blijft hetzelfde) ...

# Aan het einde van het script, vervang de laatste regel door dit:
$window.Add_ContentRendered({
    Apply-StartupState
    Show-AppMessage $announcementTitle $announcementMessage "Info"
})

$window.ShowDialog() | Out-Null
