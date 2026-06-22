Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$dest = Join-Path $env:USERPROFILE "Downloads\Gui-SS-Tools"
$zipPath = Join-Path $env:USERPROFILE "Downloads\Gui-SS-Tools.zip"

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Launcher" Width="1320" Height="830"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent"
        Opacity="0">

    <Border x:Name="MainBorder" CornerRadius="24" BorderBrush="#1A2E24" BorderThickness="1">
        <Border.Effect>
            <DropShadowEffect BlurRadius="45" ShadowDepth="0" Opacity="0.6"/>
        </Border.Effect>

        <Grid>
            <Grid.RowDefinitions>
                <RowDefinition Height="68"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>

            <Border Grid.Row="0" Grid.RowSpan="2" Background="#0A120F" CornerRadius="24"/>

            <!-- Decoratieve Cirkels -->
            <Ellipse x:Name="Circle1" Grid.Row="0" Grid.RowSpan="2" Width="520" Height="520" 
                     Fill="#166534" Opacity="0.07" HorizontalAlignment="Left" VerticalAlignment="Top" 
                     Margin="-180,-160,0,0"/>
            <Ellipse x:Name="Circle2" Grid.Row="0" Grid.RowSpan="2" Width="380" Height="380" 
                     Fill="#4ADE80" Opacity="0.055" HorizontalAlignment="Right" VerticalAlignment="Bottom" 
                     Margin="0,0,-120,-100"/>
            <Ellipse x:Name="Circle3" Grid.Row="0" Grid.RowSpan="2" Width="240" Height="240" 
                     Fill="White" Opacity="0.03" HorizontalAlignment="Center" VerticalAlignment="Top" 
                     Margin="0,60,0,0"/>
            <Ellipse x:Name="Circle4" Grid.Row="0" Grid.RowSpan="2" Width="180" Height="180" 
                     Fill="White" Opacity="0.025" HorizontalAlignment="Left" VerticalAlignment="Bottom" 
                     Margin="40,0,0,40"/>

            <!-- Top Bar -->
            <Border Grid.Row="0" Background="#08100D" CornerRadius="24,24,0,0" BorderBrush="#162232" BorderThickness="0,0,0,1">
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
            <Grid Grid.Row="1" Margin="20,15,20,20">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="20"/>
                    <ColumnDefinition Width="300"/>
                </Grid.ColumnDefinitions>

                <!-- Left Content -->
                <Grid Grid.Column="0">
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

                            <Border Grid.Column="0" Background="#0F1A16" CornerRadius="16" Padding="18">
                                <Border.Effect>
                                    <DropShadowEffect BlurRadius="10" ShadowDepth="0" Opacity="0.2"/>
                                </Border.Effect>
                                <StackPanel>
                                    <TextBlock Text="SYSTEM STATUS" FontSize="11" Foreground="#4ADE80"/>
                                    <TextBlock x:Name="StepText" Text="All Systems OK" FontSize="18" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="2" Background="#0F1A16" CornerRadius="16" Padding="18">
                                <Border.Effect>
                                    <DropShadowEffect BlurRadius="10" ShadowDepth="0" Opacity="0.2"/>
                                </Border.Effect>
                                <StackPanel>
                                    <TextBlock Text="LAST SCAN" FontSize="11" Foreground="#4ADE80"/>
                                    <TextBlock x:Name="ProgressLabel" Text="Today 19:14" FontSize="18" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="4" Background="#0F1A16" CornerRadius="16" Padding="18">
                                <Border.Effect>
                                    <DropShadowEffect BlurRadius="10" ShadowDepth="0" Opacity="0.2"/>
                                </Border.Effect>
                                <StackPanel>
                                    <TextBlock Text="TOOLS" FontSize="11" Foreground="#4ADE80"/>
                                    <TextBlock x:Name="ToolCountText" Text="12" FontSize="18" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>
                        </Grid>

                        <Border Background="#0F1A16" CornerRadius="18" Padding="18">
                            <Border.Effect>
                                <DropShadowEffect BlurRadius="12" ShadowDepth="0" Opacity="0.25"/>
                            </Border.Effect>
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
                <Border Grid.Column="2" Background="#0F1A16" CornerRadius="20" Padding="22">
                    <Border.Effect>
                        <DropShadowEffect BlurRadius="15" ShadowDepth="0" Opacity="0.3"/>
                    </Border.Effect>
                    <StackPanel>
                        <TextBlock Text="Control Center" FontSize="20" FontWeight="SemiBold" Foreground="#4ADE80"/>
                        <TextBlock Text="Manage your Guiss Tools" TextWrapping="Wrap" Margin="0,6,0,25" Foreground="#8EA2B6" FontSize="13"/>

                        <Button x:Name="InstallButton" Content="Install / Update Tools" Height="52" 
                                Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>

                        <Button x:Name="DeleteButton" Content="Remove Installed Tools" Height="52" 
                                Background="#3A2028" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>

                        <Button x:Name="OpenFolderButton" Content="Open Install Folder" Height="52" 
                                Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>

                        <Button x:Name="OpenCmdButton" Content="Open CMD Commands" Height="52" 
                                Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>

                        <Button x:Name="ExitButton" Content="Exit Launcher" Height="52" 
                                Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold"/>
                    </StackPanel>
                </Border>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

# Fade-in animatie
$fadeIn = New-Object System.Windows.Media.Animation.DoubleAnimation
$fadeIn.From = 0
$fadeIn.To = 1
$fadeIn.Duration = [System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(450))
$window.BeginAnimation([System.Windows.Window]::OpacityProperty, $fadeIn)

# Circle animaties
$Circle1 = $window.FindName("Circle1")
$Circle2 = $window.FindName("Circle2")
$Circle3 = $window.FindName("Circle3")
$Circle4 = $window.FindName("Circle4")

function Start-CircleAnimation {
    param($Ellipse, [double]$FromOpacity, [double]$ToOpacity, [int]$DurationMs)
    $animation = New-Object System.Windows.Media.Animation.DoubleAnimation
    $animation.From = $FromOpacity
    $animation.To = $ToOpacity
    $animation.Duration = [System.Windows.Duration]::new([TimeSpan]::FromMilliseconds($DurationMs))
    $animation.AutoReverse = $true
    $animation.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever
    $Ellipse.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $animation)
}

Start-CircleAnimation -Ellipse $Circle1 -FromOpacity 0.05 -ToOpacity 0.11 -DurationMs 6200
Start-CircleAnimation -Ellipse $Circle2 -FromOpacity 0.04 -ToOpacity 0.09 -DurationMs 5400
Start-CircleAnimation -Ellipse $Circle3 -FromOpacity 0.025 -ToOpacity 0.055 -DurationMs 6800
Start-CircleAnimation -Ellipse $Circle4 -FromOpacity 0.02 -ToOpacity 0.05 -DurationMs 5900

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

$InstallButton.Add_Click({
    try {
        if (!(Test-Path $zipPath)) {
            $window.FindName("ActivityBox").AppendText("`n[Error] ZIP bestand niet gevonden in Downloads.`n")
            return
        }

        if (Test-Path $dest) {
            Remove-Item $dest -Recurse -Force -ErrorAction SilentlyContinue
        }

        New-Item -ItemType Directory -Path $dest -Force | Out-Null
        [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $dest)

        Start-Process $dest
        $window.FindName("ActivityBox").AppendText("`n[Install] Tools succesvol geïnstalleerd!`n")
    }
    catch {
        $window.FindName("ActivityBox").AppendText("`n[Error] Uitpakken mislukt: $($_.Exception.Message)`n")
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
    }
})

$OpenCmdButton.Add_Click({
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/Sellgui/Sellguitools/refs/heads/main/CmdCommandcentre.ps1 | iex`""
})

$window.ShowDialog() | Out-Null
