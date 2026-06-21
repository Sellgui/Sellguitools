Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$dest = Join-Path $env:USERPROFILE "Downloads\Guiss-Tools"

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Launcher" Width="1320" Height="830"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent">

    <Border x:Name="MainBorder" CornerRadius="24" BorderBrush="#1A2E24" BorderThickness="1">
        <Border.Effect>
            <DropShadowEffect BlurRadius="40" ShadowDepth="0" Opacity="0.55"/>
        </Border.Effect>

        <Grid>
            <Border Background="#0A120F" CornerRadius="24"/>

            <!-- Top Bar -->
            <Border Height="68" Background="#08100D" CornerRadius="24,24,0,0" BorderBrush="#162232" BorderThickness="0,0,0,1">
                <Grid Margin="20,0,20,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="Auto"/>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>

                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Width="42" Height="42" CornerRadius="13" Background="#0F1A16" BorderBrush="#2A4738" BorderThickness="1">
                            <TextBlock Text="G" FontSize="22" FontWeight="Bold" Foreground="#4ADE80" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <StackPanel Margin="14,0,0,0">
                            <TextBlock Text="Guiss Launcher" FontSize="19" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Guiss Tools" FontSize="12" Foreground="#7E92A6" Margin="0,2,0,0"/>
                        </StackPanel>
                    </StackPanel>

                    <StackPanel Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center">
                        <Button x:Name="MinButton" Content="—" Width="40" Height="36" Background="Transparent" Foreground="#A0B8C8" BorderThickness="0" FontSize="20"/>
                        <Button x:Name="CloseButton" Content="✕" Width="40" Height="36" Background="Transparent" Foreground="#FF6B6B" BorderThickness="0" FontSize="17" Margin="8,0,0,0"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Main Content -->
            <Grid Margin="0,75,0,20">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="20"/>
                    <ColumnDefinition Width="300"/>
                </Grid.ColumnDefinitions>

                <!-- Left Content -->
                <Grid Grid.Column="0" Margin="25,0,0,0">
                    <StackPanel>
                        <TextBlock x:Name="StatusText" Text="Ready" FontSize="32" FontWeight="SemiBold" Foreground="White"/>
                        <TextBlock x:Name="SubStatusText" Text="Everything is ready. Select an action on the right." FontSize="15" Foreground="#9DB1C4" Margin="0,8,0,25"/>

                        <Grid Margin="0,0,0,25">
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="15"/>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="15"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>

                            <Border Grid.Column="0" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="SYSTEM STATUS" FontSize="11" Foreground="#4ADE80"/>
                                    <TextBlock x:Name="StepText" Text="All Systems OK" FontSize="18" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="2" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="LAST SCAN" FontSize="11" Foreground="#4ADE80"/>
                                    <TextBlock x:Name="ProgressLabel" Text="Today 19:14" FontSize="18" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="4" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="TOOLS" FontSize="11" Foreground="#4ADE80"/>
                                    <TextBlock x:Name="ToolCountText" Text="12" FontSize="18" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>
                        </Grid>

                        <Border Background="#0F1A16" CornerRadius="18" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                            <StackPanel>
                                <TextBlock Text="Activity Console" FontSize="16" FontWeight="SemiBold" Foreground="#4ADE80"/>
                                <TextBox x:Name="ActivityBox" Height="280" Background="#08100D" Foreground="#D8E8F5" 
                                         FontFamily="Consolas" FontSize="13" IsReadOnly="True" 
                                         VerticalScrollBarVisibility="Auto" TextWrapping="Wrap"/>
                            </StackPanel>
                        </Border>
                    </StackPanel>
                </Grid>

                <!-- Control Center -->
                <Border Grid.Column="2" Background="#0F1A16" CornerRadius="20" BorderBrush="#1A2E24" BorderThickness="1" Padding="22">
                    <StackPanel>
                        <TextBlock Text="Control Center" FontSize="20" FontWeight="SemiBold" Foreground="#4ADE80"/>
                        <TextBlock Text="Manage your Guiss Tools" TextWrapping="Wrap" Margin="0,6,0,25" Foreground="#8EA2B6" FontSize="13"/>

                        <Button x:Name="InstallButton" Content="Install / Update Tools" Height="52" Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>
                        <Button x:Name="DeleteButton" Content="Remove Installed Tools" Height="52" Background="#3A2028" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>
                        <Button x:Name="OpenFolderButton" Content="Open Install Folder" Height="52" Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>
                        <Button x:Name="OpenCmdButton" Content="Open CMD Commands" Height="52" Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>
                        <Button x:Name="ExitButton" Content="Exit Launcher" Height="52" Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold"/>
                    </StackPanel>
                </Border>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

$CloseButton      = $window.FindName("CloseButton")
$MinButton        = $window.FindName("MinButton")
$InstallButton    = $window.FindName("InstallButton")
$DeleteButton     = $window.FindName("DeleteButton")
$OpenFolderButton = $window.FindName("OpenFolderButton")
$OpenCmdButton    = $window.FindName("OpenCmdButton")
$ExitButton       = $window.FindName("ExitButton")
$MainBorder       = $window.FindName("MainBorder")

$MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })
$MinButton.Add_Click({ $window.WindowState = "Minimized" })
$CloseButton.Add_Click({ $window.Close() })
$ExitButton.Add_Click({ $window.Close() })

# === Install / Update Tools ===
$InstallButton.Add_Click({
    try {
        if (!(Test-Path $dest)) {
            New-Item -ItemType Directory -Path $dest -Force | Out-Null
            $window.FindName("ActivityBox").AppendText("`n[Install] Map aangemaakt: $dest`n")
        }
        Start-Process $dest
        $window.FindName("ActivityBox").AppendText("`n[Install] Map geopend.`n")
        $window.FindName("ActivityBox").AppendText("`n[Info] Zet al je .exe bestanden (JournalTrace, WinPrefetchView, etc.) in deze map.`n")
    }
    catch {
        $window.FindName("ActivityBox").AppendText("`n[Error] Kon de map niet openen.`n")
    }
})

$DeleteButton.Add_Click({
    if (Test-Path $dest) {
        Remove-Item $dest -Recurse -Force
        $window.FindName("ActivityBox").AppendText("`n[Remove] Map verwijderd.`n")
    }
})

$OpenFolderButton.Add_Click({
    if (Test-Path $dest) {
        Start-Process $dest
    } else {
        $window.FindName("ActivityBox").AppendText("`n[Info] Map bestaat nog niet. Klik eerst op 'Install / Update Tools'.`n")
    }
})

$OpenCmdButton.Add_Click({
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/Sellgui/Sellguitools/refs/heads/main/CmdCommandcentre.ps1 | iex`""
})

$window.ShowDialog() | Out-Null
