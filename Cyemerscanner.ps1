#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = "SilentlyContinue"

# =========================
# Global config / patterns
# =========================
$script:DebugMode = $false
$script:RecentDeletions = @{}
$script:USNSearched = $false

$script:CyemerNeedles = @(
    "com/slither/cyemer",
    "com.slither.cyemer",
    "CyemerClient",
    "com/slither/cyemer/Cyemer.class",
    "com/slither/cyemer/CyemerClient.class",

    "cyemer.client.mixins.json",
    "assets/dynamic_fps/textures/cyemer.png",
    "assets/dynamic_fps/font/cyemer.json",
    "dynamic_fps",

    "AimAssist",
    "TriggerBot",
    "AutoCrystal",
    "AutoAnchor",
    "AutoShieldBreak",
    "BowAimbot",
    "ESP",
    "Effectesp",
    "Fakelag",
    "Blink",
    "WTap",
    "Fly",
    "FastPlace",
    "AutoTotem",
    "SelfDestruct",
    "AuthenticationScreen",
    "ConfigHubManager",
    "RemoteConfig",
    "CustomCapeUploadScreen",
    "TotemPopManager",
    "ReachHudElement",
    "TargetHudElement",
    "sqlite-jdbc",
    "esp_surface.fsh",
    "esp_surface.vsh",

    "com/slither/cyemer/module/implementation/combat/",
    "com/slither/cyemer/module/implementation/movement/",
    "com/slither/cyemer/module/implementation/render/",
    "com/slither/cyemer/mixin/",
    "com/slither/cyemer/gui/new_ui/",
    "com/slither/cyemer/config/hub/"
)

$script:StrongNeedles = @(
    "com/slither/cyemer",
    "CyemerClient",
    "cyemer.client.mixins.json",
    "assets/dynamic_fps/textures/cyemer.png",
    "AuthenticationScreen",
    "RemoteConfig"
)

$script:SelfDestructKeywords = @(
    "cyemer", "client", "ghost", "inject", "loader", "launch", "minecraft",
    "mc", "cheat", "hack", "clicker", "autoclick", "bypass", "destruct",
    "selfdestruct", "crystal", "aim", "trigger", "esp"
)

# =========================
# Native decompressor
# =========================
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class NtdllDecompressor {
    [DllImport("ntdll.dll")]
    public static extern uint RtlDecompressBufferEx(
        ushort CompressionFormat,
        byte[] UncompressedBuffer,
        int UncompressedBufferSize,
        byte[] CompressedBuffer,
        int CompressedBufferSize,
        out int FinalUncompressedSize,
        IntPtr WorkSpace
    );

    [DllImport("ntdll.dll")]
    public static extern uint RtlGetCompressionWorkSpaceSize(
        ushort CompressionFormat,
        out uint CompressBufferWorkSpaceSize,
        out uint CompressFragmentWorkSpaceSize
    );

    public static byte[] Decompress(byte[] compressed) {
        if (compressed.Length < 8) return null;
        if (compressed[0] != 0x4D || compressed[1] != 0x41 || compressed[2] != 0x4D) {
            return null;
        }

        int uncompSize = BitConverter.ToInt32(compressed, 4);
        uint wsComp, wsFrag;
        if (RtlGetCompressionWorkSpaceSize(4, out wsComp, out wsFrag) != 0) return null;

        IntPtr workspace = Marshal.AllocHGlobal((int)wsFrag);
        byte[] result = new byte[uncompSize];

        try {
            int finalSize;
            byte[] compData = new byte[compressed.Length - 8];
            Array.Copy(compressed, 8, compData, 0, compData.Length);

            uint status = RtlDecompressBufferEx(4, result, uncompSize,
                compData, compData.Length, out finalSize, workspace);

            if (status != 0) return null;
            return result;
        }
        finally {
            Marshal.FreeHGlobal(workspace);
        }
    }
}
"@

# =========================
# UI helpers
# =========================
function Show-Banner {
    Clear-Host
    $banner = @"
 ██████╗██╗   ██╗███████╗███╗   ███╗███████╗██████╗ 
██╔════╝╚██╗ ██╔╝██╔════╝████╗ ████║██╔════╝██╔══██╗
██║      ╚████╔╝ █████╗  ██╔████╔██║█████╗  ██████╔╝
██║       ╚██╔╝  ██╔══╝  ██║╚██╔╝██║██╔══╝  ██╔══██╗
╚██████╗   ██║   ███████╗██║ ╚═╝ ██║███████╗██║  ██║
 ╚═════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
"@
    Write-Host $banner -ForegroundColor Red
    Write-Host ""
    Write-Host "                         CYEMER FORENSIC SCANNER" -ForegroundColor White
    Write-Host "                    Prefetch + JAR + USN Investigation" -ForegroundColor Cyan
    Write-Host ""
    Write-Host ("=" * 88) -ForegroundColor DarkGray
    Write-Host ""
}

function Write-Separator { Write-Host ("=" * 88) -ForegroundColor DarkGray }
function Write-SubSeparator { Write-Host ("-" * 88) -ForegroundColor DarkGray }

function Write-Stat {
    param(
        [string]$Label,
        [string]$Value,
        [ConsoleColor]$ValueColor = [ConsoleColor]::White
    )
    $Label = $Label.PadRight(24)
    Write-Host "  $Label : " -NoNewline -ForegroundColor DarkGray
    Write-Host $Value -ForegroundColor $ValueColor
}

function Test-Administrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# =========================
# General helpers
# =========================
function Test-ZipMagicBytes {
    param([string]$Path)
    try {
        $fs = [System.IO.File]::OpenRead($Path)
        $br = New-Object System.IO.BinaryReader($fs)
        if ($fs.Length -lt 2) { $br.Close(); $fs.Close(); return $false }
        $b1 = $br.ReadByte()
        $b2 = $br.ReadByte()
        $br.Close()
        $fs.Close()
        return ($b1 -eq 0x50 -and $b2 -eq 0x4B)
    } catch {
        return $false
    }
}

function Get-NTFSDrives {
    $ntfsDrives = @()
    $drives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -match '^[A-Z]:\\$' }
    foreach ($drive in $drives) {
        try {
            $letter = $drive.Root.Substring(0, 1)
            $vol = Get-Volume -DriveLetter $letter
            if ($vol -and $vol.FileSystem -eq 'NTFS') {
                $ntfsDrives += $letter
            }
        } catch {}
    }
    return $ntfsDrives
}

function Search-BytePattern {
    param(
        [byte[]]$Data,
        [byte[]]$Pattern
    )
    $pLen = $Pattern.Length
    $dLen = $Data.Length
    for ($i = 0; $i -le ($dLen - $pLen); $i++) {
        $match = $true
        for ($j = 0; $j -lt $pLen; $j++) {
            if ($Data[$i + $j] -ne $Pattern[$j]) {
                $match = $false
                break
            }
        }
        if ($match) { return $true }
    }
    return $false
}

function Find-SingleLetterClasses {
    param([string]$Path)
    $hits = @()
    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $jar = [System.IO.Compression.ZipFile]::OpenRead($Path)
        foreach ($entry in $jar.Entries) {
            if ($entry.FullName -like "*.class") {
                $parts = $entry.FullName -split '/'
                $file = $parts[-1] -replace '\.class$',''
                if ($file -match '^[a-zA-Z]$') {
                    $hits += $entry.FullName
                }
            }
        }
        $jar.Dispose()
    } catch {}
    return $hits
}

# =========================
# Prefetch parsing
# =========================
function Get-PrefetchVersion {
    param([byte[]]$Data)
    if ($Data.Length -lt 8) { return 0 }
    $sig = [System.Text.Encoding]::ASCII.GetString($Data, 4, 4)
    if ($sig -ne "SCCA") { return 0 }
    return [BitConverter]::ToUInt32($Data, 0)
}

function Get-SystemIndexes {
    param([string]$FilePath)

    try {
        $data = [System.IO.File]::ReadAllBytes($FilePath)

        $isCompressed = ($data[0] -eq 0x4D -and $data[1] -eq 0x41 -and $data[2] -eq 0x4D)
        if ($isCompressed) {
            $data = [NtdllDecompressor]::Decompress($data)
            if ($null -eq $data) { return @() }
        }

        if ($data.Length -lt 108) { return @() }
        $sig = [System.Text.Encoding]::ASCII.GetString($data, 4, 4)
        if ($sig -ne "SCCA") { return @() }

        $version = Get-PrefetchVersion -Data $data
        $stringsOffset = [BitConverter]::ToUInt32($data, 100)
        $stringsSize   = [BitConverter]::ToUInt32($data, 104)

        if ($stringsOffset -eq 0 -or $stringsSize -eq 0) { return @() }
        if ($stringsOffset -ge $data.Length -or ($stringsOffset + $stringsSize) -gt $data.Length) { return @() }

        $filenames = @()
        $pos = $stringsOffset
        $endPos = $stringsOffset + $stringsSize

        while ($pos -lt $endPos -and $pos -lt ($data.Length - 2)) {
            $nullPos = $pos
            while ($nullPos -lt ($data.Length - 1)) {
                if ($data[$nullPos] -eq 0 -and $data[$nullPos + 1] -eq 0) { break }
                $nullPos += 2
            }

            if ($nullPos -gt $pos) {
                $strLen = $nullPos - $pos
                if ($strLen -gt 0 -and $strLen -lt 4096) {
                    try {
                        $filename = [System.Text.Encoding]::Unicode.GetString($data, $pos, $strLen)
                        if ($filename.Length -gt 0) { $filenames += $filename }
                    } catch {}
                }
            }

            $pos = $nullPos + 2
            if ($filenames.Count -gt 3000) { break }
        }

        return $filenames
    } catch {
        return @()
    }
}

# =========================
# USN Journal
# =========================
function Get-RecentDeletionsFromUSN {
    param(
        [string[]]$DriveLetters,
        [int]$MinutesBack = 90
    )

    if ($script:USNSearched) { return $script:RecentDeletions }

    $allRecent = @{}
    $cutoff = (Get-Date).AddMinutes(-$MinutesBack)

    foreach ($drive in $DriveLetters) {
        try {
            $usnOutput = & fsutil usn readjournal "$drive`:" 2>$null
            if ($LASTEXITCODE -ne 0 -or -not $usnOutput) { continue }

            $currentFile = ""
            $currentTime = $null
            $currentReason = ""

            foreach ($line in $usnOutput) {
                if ([string]::IsNullOrWhiteSpace($line)) { continue }

                if ($line -match 'File name\s+:\s*(.+)$') {
                    $currentFile = $Matches[1].Trim()
                }
                elseif ($line -match 'Time stamp\s+:\s*(.+)$') {
                    try { $currentTime = [DateTime]::Parse($Matches[1].Trim()) } catch { $currentTime = $null }
                }
                elseif ($line -match 'Reason\s+:\s*(.+)$') {
                    $currentReason = $Matches[1].Trim()
                    if ($currentFile -and $currentTime -and $currentTime -gt $cutoff) {
                        $fullKey = "$drive`:\$currentFile"
                        if (-not $allRecent.ContainsKey($fullKey) -or $allRecent[$fullKey].Timestamp -lt $currentTime) {
                            $allRecent[$fullKey] = @{
                                Timestamp = $currentTime
                                Reason    = $currentReason
                                Drive     = $drive
                            }
                        }
                    }
                    $currentFile = ""
                    $currentTime = $null
                    $currentReason = ""
                }
            }
        } catch {}
    }

    $script:RecentDeletions = $allRecent
    $script:USNSearched = $true
    return $allRecent
}

function Test-RecentlyDeleted {
    param([string]$FilePath)

    if ($script:RecentDeletions.ContainsKey($FilePath)) {
        return $script:RecentDeletions[$FilePath]
    }

    $fileName = [System.IO.Path]::GetFileName($FilePath)
    foreach ($key in $script:RecentDeletions.Keys) {
        if ($key -like "*\$fileName") {
            return $script:RecentDeletions[$key]
        }
    }

    return $null
}

# =========================
# Cyemer detection
# =========================
function Test-CyemerClient {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $result = [PSCustomObject]@{
        IsDetected          = $false
        Confidence          = "NONE"
        MatchCount          = 0
        StrongMatchCount    = 0
        Matches             = @()
        SingleLetterClasses = @()
        IsRenamedJar        = $false
        Error               = $null
    }

    if (-not (Test-Path $Path -PathType Leaf)) {
        $result.Error = "File not found"
        return $result
    }

    try {
        $ext = [System.IO.Path]::GetExtension($Path).ToLower()
        $hasPK = Test-ZipMagicBytes -Path $Path

        if ($hasPK -and $ext -ne ".jar") {
            $result.IsRenamedJar = $true
        }

        if (-not $hasPK) {
            $result.Error = "Not a ZIP/JAR"
            return $result
        }

        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $jar = [System.IO.Compression.ZipFile]::OpenRead($Path)

        [System.Collections.Generic.List[byte]]$allBytesList = New-Object 'System.Collections.Generic.List[byte]'

        foreach ($entry in $jar.Entries) {
            $entryNameBytes = [System.Text.Encoding]::ASCII.GetBytes($entry.FullName)
            [void]$allBytesList.AddRange($entryNameBytes)

            if ($entry.FullName -like "*.class" -or
                $entry.FullName -like "*.json"  -or
                $entry.FullName -like "*.png"   -or
                $entry.FullName -like "*.fsh"   -or
                $entry.FullName -like "*.vsh"   -or
                $entry.FullName -like "META-INF/MANIFEST.MF" -or
                $entry.FullName -like "fabric.mod.json") {

                try {
                    $stream = $entry.Open()
                    $reader = New-Object System.IO.BinaryReader($stream)
                    $bytes = $reader.ReadBytes([int]$entry.Length)
                    [void]$allBytesList.AddRange($bytes)
                    $reader.Close()
                    $stream.Close()
                } catch {}
            }
        }

        $jar.Dispose()

        $allBytes = $allBytesList.ToArray()

        foreach ($needle in $script:CyemerNeedles) {
            $needleBytes = [System.Text.Encoding]::ASCII.GetBytes($needle)
            if (Search-BytePattern -Data $allBytes -Pattern $needleBytes) {
                $result.Matches += $needle
            }
        }

        foreach ($needle in $script:StrongNeedles) {
            $needleBytes = [System.Text.Encoding]::ASCII.GetBytes($needle)
            if (Search-BytePattern -Data $allBytes -Pattern $needleBytes) {
                $result.StrongMatchCount++
            }
        }

        $result.SingleLetterClasses = Find-SingleLetterClasses -Path $Path
        $result.MatchCount = $result.Matches.Count

        if ($result.StrongMatchCount -ge 3) {
            $result.IsDetected = $true
            $result.Confidence = "HIGH"
        }
        elseif ($result.StrongMatchCount -ge 2 -and $result.MatchCount -ge 6) {
            $result.IsDetected = $true
            $result.Confidence = "HIGH"
        }
        elseif ($result.MatchCount -ge 10) {
            $result.IsDetected = $true
            $result.Confidence = "HIGH"
        }
        elseif ($result.MatchCount -ge 6) {
            $result.IsDetected = $true
            $result.Confidence = "MEDIUM"
        }
        elseif ($result.MatchCount -ge 3) {
            $result.IsDetected = $true
            $result.Confidence = "LOW"
        }

        if ($result.IsRenamedJar -and $result.IsDetected -and $result.Confidence -eq "LOW") {
            $result.Confidence = "MEDIUM"
        }
    }
    catch {
        $result.Error = $_.Exception.Message
    }

    return $result
}

# =========================
# Self-destruct suspicion
# =========================
function Test-SelfDestructSuspicion {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [string]$SourceFile = "",
        $RecentDeletion = $null
    )

    $result = [PSCustomObject]@{
        IsSuspicious = $false
        Confidence   = "NONE"
        Score        = 0
        Reasons      = @()
        FileName     = [System.IO.Path]::GetFileName($Path)
        Extension    = [System.IO.Path]::GetExtension($Path).ToLower()
        Path         = $Path
    }

    $lowerPath = $Path.ToLower()
    $lowerName = $result.FileName.ToLower()

    if ($result.Extension -in @(".jar", ".exe", ".dll", ".bin", ".dat")) {
        $result.Score += 2
        $result.Reasons += "Java-referenced executable/container extension"
    }

    if ($result.Extension -ne ".jar" -and (Test-ZipMagicBytes -Path $Path)) {
        $result.Score += 4
        $result.Reasons += "Renamed JAR-style payload"
    }

    $keywordHits = @($script:SelfDestructKeywords | Where-Object { $lowerName -like "*$_*" })
    if ($keywordHits.Count -gt 0) {
        $result.Score += [Math]::Min(4, $keywordHits.Count + 1)
        $result.Reasons += "Suspicious filename keywords: $($keywordHits -join ', ')"
    }

    if ($lowerPath -match '\\downloads\\|\\desktop\\|\\documents\\|\\appdata\\roaming\\|\\appdata\\local\\|\\temp\\|\\tmp\\|\\minecraft\\|\\mods\\|\\versions\\|\\libraries\\') {
        $result.Score += 2
        $result.Reasons += "Stored in user/mod/temp-related path"
    }

    if ($SourceFile -match '^JAVA.*\.pf$') {
        $result.Score += 2
        $result.Reasons += "Referenced by Java prefetch"
    }

    if ($RecentDeletion) {
        $result.Score += 3
        $result.Reasons += "Recently removed or modified according to USN Journal"

        if ($RecentDeletion.Reason -match 'FILE_DELETE|CLOSE|RENAME|DATA_TRUNCATION') {
            $result.Score += 2
            $result.Reasons += "USN reason suggests delete/rename/truncation"
        }
    }

    if ($lowerPath -match '\\minecraft\\|\\mods\\|\\versions\\|\\libraries\\') {
        $result.Score += 3
        $result.Reasons += "Missing Java artifact from suspicious Minecraft-related path"
    }

    if ($lowerName -match '^(cyemer|loader|client|ghost|inject|launch|mod|hack|cheat)[a-z0-9_\-]*\.(jar|exe|dll|bin|dat)$') {
        $result.Score += 2
        $result.Reasons += "Payload-style filename"
    }

    if ($result.Score -ge 10) {
        $result.IsSuspicious = $true
        $result.Confidence = "HIGH"
    }
    elseif ($result.Score -ge 7) {
        $result.IsSuspicious = $true
        $result.Confidence = "MEDIUM"
    }
    elseif ($result.Score -ge 4) {
        $result.IsSuspicious = $true
        $result.Confidence = "LOW"
    }

    return $result
}

# =========================
# Views
# =========================
function Show-Summary {
    param(
        [hashtable]$Stats,
        [array]$Detections,
        [array]$DeletedFiles,
        [array]$SelfDestructFindings
    )

    Show-Banner
    Write-Host "  SUMMARY" -ForegroundColor Cyan
    Write-Separator

    $high = ($Detections | Where-Object { $_.Confidence -eq "HIGH" }).Count
    $medium = ($Detections | Where-Object { $_.Confidence -eq "MEDIUM" }).Count
    $low = ($Detections | Where-Object { $_.Confidence -eq "LOW" }).Count

    if ($Detections.Count -gt 0) {
        Write-Stat "Scan Status" "DETECTIONS FOUND" Red
    } else {
        Write-Stat "Scan Status" "CLEAN" Green
    }

    Write-Stat "Windows Version" $Stats.WindowsVersion White
    Write-Stat "Java Prefetch Files" "$($Stats.JavaPrefetchCount)" White
    Write-Stat "Parsed Prefetch Files" "$($Stats.SuccessfulParsing) / $($Stats.ProcessedFiles)" White
    Write-Stat "Extracted Paths" "$($Stats.TotalIndexes)" White
    Write-Stat "Unique Paths" "$($Stats.UniquePaths)" White
    Write-Stat "Existing Files" "$($Stats.ExistingFiles)" White
    Write-Stat "Files Scanned" "$($Stats.FilesScanned)" White
    Write-Stat "Files Skipped" "$($Stats.FilesSkipped)" White
    Write-Stat "Missing Files" "$($Stats.MissingFiles)" $(if ($Stats.MissingFiles -gt 0) { "Yellow" } else { "Green" })
    Write-Stat "Detections" "$($Detections.Count)" $(if ($Detections.Count -gt 0) { "Red" } else { "Green" })
    Write-Stat "Self-Destruct Hits" "$($SelfDestructFindings.Count)" $(if ($SelfDestructFindings.Count -gt 0) { "Red" } else { "Green" })

    Write-Host ""
    Write-SubSeparator
    Write-Host "  CONFIDENCE BREAKDOWN" -ForegroundColor White
    Write-SubSeparator
    Write-Host ""
    Write-Stat "HIGH" "$high" $(if ($high -gt 0) { "Red" } else { "Green" })
    Write-Stat "MEDIUM" "$medium" $(if ($medium -gt 0) { "Yellow" } else { "Green" })
    Write-Stat "LOW" "$low" $(if ($low -gt 0) { "Gray" } else { "Green" })
    Write-Host ""
}

function Show-Detections {
    param([array]$Detections)

    Show-Banner
    Write-Host "  DETECTIONS" -ForegroundColor Cyan
    Write-Separator

    if ($Detections.Count -eq 0) {
        Write-Host "  Geen Cyemer-detecties gevonden." -ForegroundColor Green
        return
    }

    $i = 1
    foreach ($d in $Detections) {
        Write-Host "  [$i] $($d.Path)" -ForegroundColor White
        Write-Host ""
        Write-Stat "Source File" $d.SourceFile Cyan
        Write-Stat "Index Number" "#$($d.IndexNumber)" White
        Write-Stat "Confidence" $d.Confidence $(switch ($d.Confidence) { "HIGH" {"Red"} "MEDIUM" {"Yellow"} "LOW" {"Gray"} default {"White"} })
        Write-Stat "Renamed JAR" $(if ($d.IsRenamedJar) { "YES" } else { "NO" }) $(if ($d.IsRenamedJar) { "Red" } else { "Green" })
        Write-Stat "Match Count" "$($d.MatchCount)" White
        Write-Stat "Strong Matches" "$($d.StrongMatchCount)" White
        Write-Host "  Matches:" -ForegroundColor White
        foreach ($m in $d.Matches) {
            Write-Host "    - $m" -ForegroundColor DarkGray
        }
        Write-Host ""
        Write-SubSeparator
        $i++
    }
}

function Show-DeletedFiles {
    param([array]$DeletedFiles)

    Show-Banner
    Write-Host "  DELETED / MISSING FILES" -ForegroundColor Cyan
    Write-Separator

    if ($DeletedFiles.Count -eq 0) {
        Write-Host "  Geen verdachte deleted/missing files gevonden." -ForegroundColor Green
        return
    }

    $i = 1
    foreach ($f in $DeletedFiles) {
        Write-Host "  [$i] $($f.Path)" -ForegroundColor White
        Write-Host ""
        Write-Stat "Source Prefetch" $f.SourceFile Cyan
        Write-Stat "Last Activity" $(if ($f.DeletionTime) { $f.DeletionTime } else { "Unknown" }) White
        Write-Stat "USN Reason" $(if ($f.Reason) { $f.Reason } else { "Unavailable" }) White
        Write-Stat "Self-Destruct" $(if ($f.Suspicious) { $f.SuspicionConfidence } else { "NO" }) $(if ($f.Suspicious) { if ($f.SuspicionConfidence -eq "HIGH") {"Red"} elseif ($f.SuspicionConfidence -eq "MEDIUM") {"Yellow"} else {"Gray"} } else { "Green" })
        Write-Stat "Suspicion Score" "$($f.SuspicionScore)" White
        Write-Host ""
        Write-SubSeparator
        $i++
    }
}

function Show-SelfDestruct {
    param([array]$Findings)

    Show-Banner
    Write-Host "  SELF-DESTRUCT ANALYSIS" -ForegroundColor Cyan
    Write-Separator

    if ($Findings.Count -eq 0) {
        Write-Host "  Geen duidelijke self-destruct indicators gevonden." -ForegroundColor Green
        return
    }

    $i = 1
    foreach ($item in $Findings) {
        Write-Host "  [$i] $($item.Path)" -ForegroundColor White
        Write-Host ""
        Write-Stat "Source Prefetch" $item.SourceFile Cyan
        Write-Stat "Confidence" $item.Confidence $(switch ($item.Confidence) { "HIGH" {"Red"} "MEDIUM" {"Yellow"} "LOW" {"Gray"} default {"White"} })
        Write-Stat "Suspicion Score" "$($item.Score)" White
        Write-Stat "Last Activity" $(if ($item.DeletionTime) { $item.DeletionTime } else { "Unknown" }) White
        Write-Stat "USN Reason" $(if ($item.Reason) { $item.Reason } else { "Unavailable" }) White
        Write-Host "  Indicators:" -ForegroundColor White
        foreach ($r in $item.Reasons) {
            Write-Host "    - $r" -ForegroundColor DarkGray
        }
        Write-Host ""
        Write-SubSeparator
        $i++
    }
}

function Read-Choice {
    Write-Host ""
    Write-Host "  [1] Summary    [2] Detections    [3] Deleted Files    [4] Self-Destruct    [Q] Exit" -ForegroundColor Cyan
    Write-Separator
    Write-Host ""
    Write-Host "  Select option: " -NoNewline -ForegroundColor White
    return (Read-Host).Trim().ToUpper()
}

function Show-Dashboard {
    param(
        [hashtable]$Stats,
        [array]$Detections,
        [array]$DeletedFiles,
        [array]$SelfDestructFindings
    )

    $tab = "1"
    while ($true) {
        switch ($tab) {
            "1" { Show-Summary -Stats $Stats -Detections $Detections -DeletedFiles $DeletedFiles -SelfDestructFindings $SelfDestructFindings }
            "2" { Show-Detections -Detections $Detections }
            "3" { Show-DeletedFiles -DeletedFiles $DeletedFiles }
            "4" { Show-SelfDestruct -Findings $SelfDestructFindings }
            default { Show-Summary -Stats $Stats -Detections $Detections -DeletedFiles $DeletedFiles -SelfDestructFindings $SelfDestructFindings }
        }

        $choice = Read-Choice
        switch ($choice) {
            "1" { $tab = "1" }
            "2" { $tab = "2" }
            "3" { $tab = "3" }
            "4" { $tab = "4" }
            "Q" { break }
        }
    }
}

# =========================
# Main scan flow
# =========================
function Start-CyemerScan {
    param([switch]$Debug)

    $script:DebugMode = $Debug
    Show-Banner

    if (-not (Test-Administrator)) {
        Write-Host "  ERROR: Administrator privileges required." -ForegroundColor Red
        Write-Host ""
        Write-Host "  Start PowerShell as Administrator." -ForegroundColor Yellow
        return
    }

    $osVersion = [System.Environment]::OSVersion.Version
    Write-Host "[*] Windows Version: $($osVersion.Major).$($osVersion.Minor) Build $($osVersion.Build)" -ForegroundColor Cyan
    Write-Host ""

    $prefetchPath = "C:\Windows\Prefetch"
    if (-not (Test-Path $prefetchPath)) {
        Write-Host "[!] Prefetch directory not found." -ForegroundColor Red
        return
    }

    $javaFiles = Get-ChildItem -Path $prefetchPath -Filter "JAVA*.EXE-*.pf" -ErrorAction SilentlyContinue
    if ($javaFiles.Count -eq 0) {
        Write-Host "[!] No JAVA prefetch files found." -ForegroundColor Yellow
        return
    }

    Write-Host "[+] Found $($javaFiles.Count) JAVA prefetch file(s)" -ForegroundColor Green
    Write-Host ""

    $allPaths = @()
    $fileMetadata = @{}
    $processedFiles = 0
    $successfulParsing = 0

    foreach ($pf in $javaFiles) {
        $processedFiles++
        Write-Progress -Activity "Extracting Indexes" -Status "Processing $processedFiles / $($javaFiles.Count)" -PercentComplete (($processedFiles / $javaFiles.Count) * 100)

        $indexes = Get-SystemIndexes -FilePath $pf.FullName
        if ($indexes.Count -eq 0) { continue }
        $successfulParsing++

        $indexNum = 0
        foreach ($index in $indexes) {
            $indexNum++

            if ($index -match '\\VOLUME\{[^\}]+\}\\(.*)$') {
                $resolved = "C:\$($Matches[1])"
                $allPaths += $resolved
                if (-not $fileMetadata.ContainsKey($resolved)) {
                    $fileMetadata[$resolved] = @{
                        SourceFile  = $pf.Name
                        IndexNumber = $indexNum
                        OriginalPath = $index
                    }
                }
            } else {
                $allPaths += $index
                if (-not $fileMetadata.ContainsKey($index)) {
                    $fileMetadata[$index] = @{
                        SourceFile  = $pf.Name
                        IndexNumber = $indexNum
                        OriginalPath = $index
                    }
                }
            }
        }
    }

    Write-Progress -Activity "Extracting Indexes" -Completed

    $uniquePaths = $allPaths | Select-Object -Unique
    Write-Host "[+] Parsed prefetch files: $successfulParsing / $processedFiles" -ForegroundColor Green
    Write-Host "[+] Total extracted paths: $($allPaths.Count)" -ForegroundColor Green
    Write-Host "[+] Unique paths: $($uniquePaths.Count)" -ForegroundColor Green
    Write-Host ""

    $existingPaths = @{}
    $missingPaths = @()
    $outsideRangeCount = 0
    $resolvedToDifferentDrive = 0

    $allDrives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -match '^[A-Z]:\\$' } | ForEach-Object { $_.Root.Substring(0,1) }

    foreach ($path in $uniquePaths) {
        $foundPath = $null

        if (Test-Path $path -PathType Leaf) {
            $foundPath = $path
        } elseif ($path -match '^[A-Z]:\\(.*)$') {
            $relative = $Matches[1]
            foreach ($drive in $allDrives) {
                $candidate = "$drive`:\$relative"
                if (Test-Path $candidate -PathType Leaf) {
                    $foundPath = $candidate
                    $resolvedToDifferentDrive++
                    break
                }
            }
        }

        if ($foundPath) {
            try {
                $size = (Get-Item $foundPath).Length
                if ($size -ge 50KB -and $size -le 50MB) {
                    $existingPaths[$path] = $foundPath
                } else {
                    $outsideRangeCount++
                }
            } catch {
                $missingPaths += $path
            }
        } else {
            $missingPaths += $path
        }
    }

    Write-Host "[+] Existing files in scan range: $($existingPaths.Count)" -ForegroundColor Green
    if ($resolvedToDifferentDrive -gt 0) {
        Write-Host "[+] Resolved on different drives: $resolvedToDifferentDrive" -ForegroundColor Cyan
    }
    Write-Host "[!] Files outside range: $outsideRangeCount" -ForegroundColor Gray
    Write-Host "[!] Missing paths: $($missingPaths.Count)" -ForegroundColor Yellow
    Write-Host ""

    $deletedFilesForUi = @()
    $selfDestructFindings = @()

    if ($missingPaths.Count -gt 0) {
        $ntfsDrives = Get-NTFSDrives
        if ($ntfsDrives.Count -gt 0) {
            Get-RecentDeletionsFromUSN -DriveLetters $ntfsDrives -MinutesBack 90 | Out-Null
        }

        foreach ($missingPath in $missingPaths) {
            if ($missingPath -match '\\TEMP\\|\\TMP\\|HSPERFDATA|\.TMP$|JNA\d+\.DLL') { continue }
            if ($missingPath -notmatch '\.(JAR|EXE|DLL|BIN|DAT)$') { continue }

            $recentDeletion = Test-RecentlyDeleted -FilePath $missingPath
            $deletionTime = $null
            $reason = $null

            if ($recentDeletion) {
                $deletionTime = $recentDeletion.Timestamp
                $reason = $recentDeletion.Reason
            }

            $sourcePf = ""
            if ($fileMetadata.ContainsKey($missingPath)) {
                $sourcePf = $fileMetadata[$missingPath].SourceFile
            }

            $sd = Test-SelfDestructSuspicion -Path $missingPath -SourceFile $sourcePf -RecentDeletion $recentDeletion

            $deletedFilesForUi += [PSCustomObject]@{
                Path                = $missingPath
                SourceFile          = $sourcePf
                DeletionTime        = if ($deletionTime) { $deletionTime.ToString("yyyy-MM-dd HH:mm:ss") } else { $null }
                Reason              = $reason
                Suspicious          = $sd.IsSuspicious
                SuspicionConfidence = $sd.Confidence
                SuspicionScore      = $sd.Score
                SuspicionReasons    = ($sd.Reasons -join " | ")
            }

            if ($sd.IsSuspicious) {
                $selfDestructFindings += [PSCustomObject]@{
                    Path         = $missingPath
                    SourceFile   = $sourcePf
                    Confidence   = $sd.Confidence
                    Score        = $sd.Score
                    DeletionTime = if ($deletionTime) { $deletionTime.ToString("yyyy-MM-dd HH:mm:ss") } else { $null }
                    Reason       = $reason
                    Reasons      = $sd.Reasons
                }
            }
        }
    }

    Write-Host "[*] Scanning existing files for Cyemer..." -ForegroundColor Cyan
    Write-Host ""

    $detections = @()
    $scanned = 0
    $skipped = 0

    foreach ($assumedPath in $existingPaths.Keys) {
        $actualPath = $existingPaths[$assumedPath]
        $scanned++

        Write-Progress -Activity "Scanning for Cyemer" -Status "[$scanned/$($existingPaths.Count)]" -PercentComplete (($scanned / $existingPaths.Count) * 100)

        $result = Test-CyemerClient -Path $actualPath
        if ($result.Error) {
            $skipped++
            continue
        }

        if ($result.IsDetected) {
            $detections += [PSCustomObject]@{
                Path                = $actualPath
                SourceFile          = $fileMetadata[$assumedPath].SourceFile
                IndexNumber         = $fileMetadata[$assumedPath].IndexNumber
                Confidence          = $result.Confidence
                IsRenamedJar        = $result.IsRenamedJar
                MatchCount          = $result.MatchCount
                StrongMatchCount    = $result.StrongMatchCount
                Matches             = $result.Matches
            }

            Write-Host "[!] DETECTION: $actualPath" -ForegroundColor Red
            Write-Host "    Confidence: $($result.Confidence)" -ForegroundColor Yellow
            Write-Host "    Matches: $($result.MatchCount) | Strong: $($result.StrongMatchCount)" -ForegroundColor DarkGray
            Write-Host ""
        }
    }

    Write-Progress -Activity "Scanning for Cyemer" -Completed

    $stats = @{
        WindowsVersion    = "$($osVersion.Major).$($osVersion.Minor) Build $($osVersion.Build)"
        JavaPrefetchCount = $javaFiles.Count
        SuccessfulParsing = $successfulParsing
        ProcessedFiles    = $processedFiles
        TotalIndexes      = $allPaths.Count
        UniquePaths       = $uniquePaths.Count
        ExistingFiles     = $existingPaths.Count
        FilesScanned      = $scanned
        FilesSkipped      = $skipped
        MissingFiles      = $missingPaths.Count
    }

    Show-Dashboard -Stats $stats -Detections $detections -DeletedFiles $deletedFilesForUi -SelfDestructFindings $selfDestructFindings
}

Start-CyemerScan