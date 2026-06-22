Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml
Add-Type -AssemblyName System.IO.Compression.FileSystem

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$userDir   = [Environment]::GetFolderPath("UserProfile")
$downloads = Join-Path $userDir "Downloads"
$zipPath   = Join-Path $downloads "Guiss-Tools.zip"
$destPath  = Join-Path $downloads "Guiss-Tools"

# === CORRECTE DOWNLOAD URL ===
$toolsZipUrl = "https://github.com/Sellgui/Sellguitools/releases/latest/download/Gui-SS-Tools.zip"

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Launcher" Width="1320" Height="830"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent"
        Opacity="0">

    <Window.Resources>
        <Style x:Key="MainButtonStyle" TargetType="Button">
            <Setter Property="Background" Value="#0F2A1F"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="15"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Height" Value="48"/>
            <Setter Property="Margin" Value="0,0,0,10"/>
            <Setter Property="BorderThickness" Value="1.5"/>
            <Setter Property="BorderBrush" Value="#1A4738"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Border" CornerRadius="12" 
                                Background="{TemplateBinding Background}" 
                                BorderBrush="{TemplateBinding BorderBrush}" 
                                BorderThickness="{TemplateBinding BorderThickness}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Border" Property="BorderBrush" Value="#22D3EE"/>
                                <Setter TargetName="Border" Property="BorderThickness" Value="2"/>
                                <Setter TargetName="Border" Property="Effect">
                                    <Setter.Value>
                                        <DropShadowEffect BlurRadius="14" ShadowDepth="0" Color="#22D3EE" Opacity="0.65"/>
                                    </Setter.Value>
                                </Setter>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Border x:Name="MainBorder" Background="#0A120F" CornerRadius="24" 
            BorderBrush="#1A2E24" BorderThickness="1">
        <Border.Effect>
            <DropShadowEffect BlurRadius="40" ShadowDepth="0" Opacity="0.55"/>
        </Border.Effect>

        <Grid>
            <!-- Decorative Circles -->
            <Canvas>
                <Ellipse x:Name="Circle1" Width="480" Height="480" Fill="#0F2A1F" Opacity="0.22" Canvas.Left="-120" Canvas.Top="-90"/>
                <Ellipse x:Name="Circle2" Width="320" Height="320" Fill="#166534" Opacity="0.18" Canvas.Right="-60" Canvas.Bottom="60"/>
                <Ellipse x:Name="Circle3" Width="180" Height="180" Fill="#4ADE80" Opacity="0.12" Canvas.Left="220" Canvas.Top="180"/>
                <Ellipse x:Name="Circle4" Width="620" Height="620" Fill="#052E16" Opacity="0.15" Canvas.Right="-180" Canvas.Top="-150"/>
                <Ellipse x:Name="Circle5" Width="110" Height="110" Fill="#86EFAC" Opacity="0.25" Canvas.Left="850" Canvas.Top="420"/>
                <Ellipse x:Name="Circle6" Width="250" Height="250" Fill="#166534" Opacity="0.10" Canvas.Left="1050" Canvas.Bottom="80"/>
            </Canvas>

            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="68"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>

                <!-- Top Bar -->
                <Border Grid.Row="0" Background="#08100D" CornerRadius="24,24,0,0">
                    <Grid Margin="25,0">
                        <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                            <Border Width="42" Height="42" CornerRadius="13" Background="#0F1A16" BorderBrush="#2A4738" BorderThickness="1">
                                <TextBlock Text="G" FontSize="22" FontWeight="Bold" Foreground="#4ADE80" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                            </Border>
                            <StackPanel Margin="14,0,0,0">
                                <TextBlock Text="Guiss Launcher" FontSize="20" FontWeight="SemiBold" Foreground="White"/>
                                <TextBlock Text="Guiss Tools" FontSize="12" Foreground="#7E92A6" Margin="0,2,0,0"/>
                            </StackPanel>
                        </StackPanel>
                        <StackPanel HorizontalAlignment="Right" Orientation="Horizontal" VerticalAlignment="Center">
                            <Button x:Name="MinButton" Content="—" Width="40" Height="36" Background="Transparent" Foreground="#A0B8C8" BorderThickness="0" FontSize="20"/>
                            <Button x:Name="CloseButton" Content="✕" Width="40" Height="36" Background="Transparent" Foreground="#FF6B6B" BorderThickness="0" FontSize="17" Margin="8,0,0,0"/>
                        </StackPanel>
                    </Grid>
                </Border>

                <!-- Main Content -->
                <Grid Grid.Row="1" Margin="25,20,40,25">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="300"/>
                    </Grid.ColumnDefinitions>

                    <!-- Left Side -->
                    <StackPanel>
                        <TextBlock Text="Ready" FontSize="32" FontWeight="SemiBold" Foreground="White"/>
                        <TextBlock Text="Everything is ready. Select an action on the right." FontSize="15" Foreground="#7E92A6" Margin="0,8,0,25"/>

                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>

                            <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="SYSTEM STATUS" FontSize="12" Foreground="#4ADE80"/>
                                    <TextBlock Text="All Systems OK" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="1" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1" Margin="12,0">
                                <StackPanel>
                                    <TextBlock Text="LAST SCAN" FontSize="12" Foreground="#4ADE80"/>
                                    <TextBlock Text="Today 19:14" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="2" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="TOOLS" FontSize="12" Foreground="#4ADE80"/>
                                    <TextBlock Text="12" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>
                        </Grid>

                        <TextBlock Text="Activity Console" FontSize="15" FontWeight="SemiBold" Foreground="#4ADE80" Margin="0,25,0,8"/>
                        <Border Background="#0A120F" CornerRadius="12" BorderBrush="#2A4738" BorderThickness="1" Padding="10">
                            <ScrollViewer VerticalScrollBarVisibility="Auto">
                                <TextBox x:Name="ActivityBox" Background="Transparent" Foreground="#A0B8C8" BorderThickness="0" FontSize="13" IsReadOnly="True" TextWrapping="Wrap"/>
                            </ScrollViewer>
                        </Border>
                    </StackPanel>

                    <!-- Right Side -->
                    <Border Grid.Column="1" Background="#0F1A16" CornerRadius="20" BorderBrush="#2A4738" BorderThickness="1" Padding="20" Margin="20,0,0,0">
                        <StackPanel>
                            <TextBlock Text="Control Center" FontSize="18" FontWeight="SemiBold" Foreground="#4ADE80"/>
                            <TextBlock Text="Manage your Guiss Tools" FontSize="13" Foreground="#7E92A6" Margin="0,4,0,20"/>

                            <Button x:Name="InstallButton"    Content="Install / Update Tools"   Style="{StaticResource MainButtonStyle}"/>
                            <Button x:Name="RemoveButton"     Content="Remove Installed Tools"   Background="#3F1F1F" Style="{StaticResource MainButtonStyle}"/>
                            <Button x:Name="OpenFolderButton" Content="Open Install Folder"      Style="{StaticResource MainButtonStyle}"/>
                            <Button x:Name="OpenCmdButton"    Content="CMD Commands"             Style="{StaticResource MainButtonStyle}"/>
                            <Button x:Name="ExitButton"       Content="Exit Launcher"            Style="{StaticResource MainButtonStyle}"/>
                        </StackPanel>
                    </Border>
                </Grid>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

try {
    $reader = New-Object System.Xml.XmlNodeReader $xaml
    $window = [Windows.Markup.XamlReader]::Load($reader)
}
catch {
    Write-Host "FOUT:" $_.Exception.Message -ForegroundColor Red
    Read-Host
    exit
}

$window.Add_Loaded({
    $fade = New-Object System.Windows.Media.Animation.DoubleAnimation
    $fade.From = 0; $fade.To = 1; $fade.Duration = [TimeSpan]::FromMilliseconds(500)
    $window.BeginAnimation([System.Windows.Window]::OpacityProperty, $fade)
})

# Circles + animatie
$circle1 = $window.FindName("Circle1")
$circle2 = $window.FindName("Circle2")
$circle3 = $window.FindName("Circle3")
$circle4 = $window.FindName("Circle4")
$circle5 = $window.FindName("Circle5")
$circle6 = $window.FindName("Circle6")

function Start-PulseAnimation($element, $durationMs, $scaleTo) {
    $scale = New-Object System.Windows.Media.ScaleTransform
    $element.RenderTransform = $scale
    $element.RenderTransformOrigin = "0.5,0.5"
    $sb = New-Object System.Windows.Media.Animation.Storyboard
    $animX = New-Object System.Windows.Media.Animation.DoubleAnimation
    $animX.From = 1; $animX.To = $scaleTo; $animX.Duration = [TimeSpan]::FromMilliseconds($durationMs)
    $animX.AutoReverse = $true; $animX.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever
    $animY = $animX.Clone()
    [System.Windows.Media.Animation.Storyboard]::SetTarget($animX, $element)
    [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($animX, "(UIElement.RenderTransform).(ScaleTransform.ScaleX)")
    [System.Windows.Media.Animation.Storyboard]::SetTarget($animY, $element)
    [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($animY, "(UIElement.RenderTransform).(ScaleTransform.ScaleY)")
    $sb.Children.Add($animX); $sb.Children.Add($animY); $sb.Begin()
}

Start-PulseAnimation $circle1 4500 1.07
Start-PulseAnimation $circle2 3800 1.10
Start-PulseAnimation $circle3 3200 1.15
Start-PulseAnimation $circle4 5200 1.06
Start-PulseAnimation $circle5 2900 1.18
Start-PulseAnimation $circle6 4100 1.09

$CloseButton = $window.FindName("CloseButton")
$MinButton   = $window.FindName("MinButton")
$MainBorder  = $window.FindName("MainBorder")
$ActivityBox = $window.FindName("ActivityBox")

$MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })
$MinButton.Add_Click({ $window.WindowState = "Minimized" })
$CloseButton.Add_Click({ $window.Close() })
$window.FindName("ExitButton").Add_Click({ $window.Close() })

# ====================== INSTALL ======================
$window.FindName("InstallButton").Add_Click({
    $ActivityBox.AppendText("`n[Install] Bezig met downloaden...`n")

    try {
        Invoke-WebRequest -Uri $toolsZipUrl -OutFile $zipPath -UseBasicParsing
        $ActivityBox.AppendText("[Install] Download voltooid.`n")

        if (Test-Path $destPath) {
            Remove-Item $destPath -Recurse -Force
            $ActivityBox.AppendText("[Install] Oude versie verwijderd.`n")
        }

        Expand-Archive -Path $zipPath -DestinationPath $destPath -Force
        $ActivityBox.AppendText("[Install] Uitpakken voltooid!`n")
        $ActivityBox.AppendText("[Install] Tools geïnstalleerd in: $destPath`n")

        Start-Process $destPath
    }
    catch {
        $ActivityBox.AppendText("[Error] Er is iets misgegaan: $($_.Exception.Message)`n")
    }
})

# ====================== REMOVE ======================
$window.FindName("RemoveButton").Add_Click({
    if (Test-Path $destPath) {
        Remove-Item $destPath -Recurse -Force
        $ActivityBox.AppendText("`n[Remove] Alle tools zijn succesvol verwijderd.`n")
    } else {
        $ActivityBox.AppendText("`n[Remove] Geen tools gevonden om te verwijderen.`n")
    }
})

# ====================== OPEN FOLDER ======================
$window.FindName("OpenFolderButton").Add_Click({
    if (Test-Path $destPath) {
        Start-Process $destPath
    } else {
        $ActivityBox.AppendText("`n[Error] Installatiemap niet gevonden.`n")
    }
})

# ====================== OPEN CMD COMMANDS ======================
$window.FindName("OpenCmdButton").Add_Click({
    Start-Process powershell -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-WindowStyle", "Hidden", "-Command", "irm 'https://raw.githubusercontent.com/Sellgui/Sellguitools/refs/heads/main/CmdCommandcentre.ps1' | iex"
})

$window.ShowDialog() | Out-Null
