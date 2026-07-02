Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml
Add-Type -AssemblyName System.IO.Compression.FileSystem

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$userDir = [Environment]::GetFolderPath("UserProfile")
$downloads = Join-Path $userDir "Downloads"
$zipPath = Join-Path $downloads "Guiss-Tools.zip"
$destPath = Join-Path $downloads "Guiss-Tools"

$toolsZipUrl = "https://github.com/Sellgui/Sellguitools/releases/latest/download/Guiss-Tools.zip"

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Launcher" Width="1320" Height="830"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent"
        Opacity="0">

    <Border x:Name="MainBorder" CornerRadius="22" BorderBrush="#1A2E24" BorderThickness="1" Background="#0A120F">
        <Border.Effect>
            <DropShadowEffect BlurRadius="40" ShadowDepth="0" Opacity="0.65"/>
        </Border.Effect>

        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="70"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>

            <!-- Header -->
            <Border Background="#08100D" CornerRadius="22,22,0,0">
                <Grid Margin="25,0">
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Width="46" Height="46" CornerRadius="12" Background="#0F1A16" BorderBrush="#4ADE80" BorderThickness="2">
                            <TextBlock Text="G" FontSize="28" FontWeight="Bold" Foreground="#4ADE80" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <StackPanel Margin="16,0,0,0">
                            <TextBlock Text="Guiss Launcher" FontSize="22" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Guiss Tools" FontSize="13" Foreground="#7E92A6"/>
                        </StackPanel>
                    </StackPanel>

                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                        <Button x:Name="MinButton" Content="—" Width="44" Height="36" Background="Transparent" Foreground="#A0B8C8" BorderThickness="0" FontSize="20"/>
                        <Button x:Name="CloseButton" Content="✕" Width="44" Height="36" Background="Transparent" Foreground="#FF6B6B" BorderThickness="0" FontSize="18" Margin="10,0,0,0"/>
                    </StackPanel>
                </Grid>
            </Border>

            <Grid Grid.Row="1" Margin="25">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="380"/>
                    <ColumnDefinition Width="30"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Left Status -->
                <Border Background="#0F1A16" CornerRadius="16" BorderBrush="#2A4738" BorderThickness="1" Padding="20">
                    <StackPanel>
                        <TextBlock Text="SYSTEM STATUS" FontSize="13" Foreground="#4ADE80" FontWeight="SemiBold"/>
                        <TextBlock Text="All Systems OK" FontSize="26" FontWeight="SemiBold" Foreground="White" Margin="0,12,0,0"/>
                        <Border Background="#1A2E24" CornerRadius="10" Padding="12" Margin="0,20,0,0">
                            <TextBlock Text="Ready for use" FontSize="14" Foreground="#86EFAC"/>
                        </Border>
                    </StackPanel>
                </Border>

                <!-- Activity Console -->
                <Border Grid.Column="2" Background="#0F1A16" CornerRadius="16" BorderBrush="#2A4738" BorderThickness="1" Padding="20">
                    <StackPanel>
                        <TextBlock Text="Activity Console" FontSize="15" FontWeight="SemiBold" Foreground="#4ADE80"/>
                        <TextBox x:Name="ActivityBox" Height="380" Background="#0A120F" Foreground="#86EFAC" BorderThickness="0" FontFamily="Consolas" FontSize="13" VerticalScrollBarVisibility="Auto" IsReadOnly="True" Margin="0,12,0,0" Padding="12"/>
                    </StackPanel>
                </Border>
            </Grid>

            <!-- Control Panel -->
            <Border Grid.Row="1" Margin="25,0,25,25" Background="#0F1A16" CornerRadius="16" BorderBrush="#2A4738" BorderThickness="1" Padding="25" VerticalAlignment="Bottom">
                <Grid>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <Button x:Name="InstallButton" Content="Install / Update Tools" Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold" Height="58" CornerRadius="12" Margin="0,0,10,0"/>
                    <Button x:Name="RemoveButton" Content="Remove Installed Tools" Background="#7F1D1D" Foreground="White" FontSize="15" FontWeight="SemiBold" Height="58" CornerRadius="12" Margin="10,0,10,0"/>
                    <Button x:Name="OpenFolderButton" Content="Open Install Folder" Background="#1F3A2A" Foreground="White" FontSize="15" FontWeight="SemiBold" Height="58" CornerRadius="12" Margin="10,0,0,0"/>
                </Grid>
            </Border>
        </Grid>
    </Border>
</Window>
"@

try {
    $reader = New-Object System.Xml.XmlNodeReader $xaml
    $window = [Windows.Markup.XamlReader]::Load($reader)

    $window.Opacity = 1
    $ActivityBox = $window.FindName("ActivityBox")
    $CloseButton = $window.FindName("CloseButton")
    $MinButton = $window.FindName("MinButton")
    $InstallButton = $window.FindName("InstallButton")
    $RemoveButton = $window.FindName("RemoveButton")
    $OpenFolderButton = $window.FindName("OpenFolderButton")

    $window.Add_MouseLeftButtonDown({ $window.DragMove() })
    $MinButton.Add_Click({ $window.WindowState = "Minimized" })

    $CloseButton.Add_Click({
        $fadeOut = New-Object System.Windows.Media.Animation.DoubleAnimation
        $fadeOut.From = 1; $fadeOut.To = 0; $fadeOut.Duration = [TimeSpan]::FromMilliseconds(250)
        $window.BeginAnimation([System.Windows.Window]::OpacityProperty, $fadeOut)
        Start-Sleep -Milliseconds 280
        $window.Close()
    })

    # Install / Update
    $InstallButton.Add_Click({
        $ActivityBox.AppendText("[Install] Installatie gestart...`n")
        try {
            if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
            $ActivityBox.AppendText("[Install] Downloaden van GitHub...`n")
            Invoke-WebRequest -Uri $toolsZipUrl -OutFile $zipPath
            $ActivityBox.AppendText("[Install] Download completed.`n")
            if (Test-Path $destPath) { Remove-Item $destPath -Recurse -Force }
            $ActivityBox.AppendText("[Install] Extracting files...`n")
            Expand-Archive -Path $zipPath -DestinationPath $destPath -Force
            $ActivityBox.AppendText("[Install] Extraction successful!`n")
            $ActivityBox.AppendText("[Install] Tools installed in: $destPath`n")
            Start-Process $destPath
        } catch {
            $ActivityBox.AppendText("[Error] $($_.Exception.Message)`n")
        }
    })

    # Remove
    $RemoveButton.Add_Click({
        if (Test-Path $destPath) {
            Remove-Item $destPath -Recurse -Force
            $ActivityBox.AppendText("`n[Remove] Tools removed successfully.`n")
        } else {
            $ActivityBox.AppendText("`n[Remove] No tools found.`n")
        }
    })

    # Open Folder
    $OpenFolderButton.Add_Click({
        if (Test-Path $destPath) {
            Start-Process $destPath
        } else {
            $ActivityBox.AppendText("`n[Error] Install folder not found.`n")
        }
    })

    $window.ShowDialog() | Out-Null

} catch {
    Write-Host "Fout: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host
}
