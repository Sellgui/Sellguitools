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

$toolsZipUrl = "https://github.com/Sellgui/Sellguitools/releases/download/v4.0/Guiss-Tools-v4.zip"

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Launcher" Width="1320" Height="830"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent"
        Opacity="0">

    <Window.Resources>
        <!-- UPGEGRADE BUTTON STYLE -->
        <Style x:Key="MainButtonStyle" TargetType="Button">
            <Setter Property="Background" Value="#0F2A1F"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="15"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Height" Value="50"/>
            <Setter Property="Margin" Value="0,0,0,10"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Border" CornerRadius="14" 
                                Background="{TemplateBinding Background}"
                                BorderThickness="0">
                            <Border.Effect>
                                <DropShadowEffect x:Name="Shadow" BlurRadius="12" ShadowDepth="0" Opacity="0.3" Color="#000000"/>
                            </Border.Effect>
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="Auto"/>
                                    <ColumnDefinition Width="*"/>
                                </Grid.ColumnDefinitions>
                                <TextBlock x:Name="Icon" Text="{TemplateBinding Tag}" 
                                           FontSize="18" Margin="14,0,8,0" VerticalAlignment="Center"/>
                                <ContentPresenter Grid.Column="1" VerticalAlignment="Center" Margin="0,0,14,0"/>
                            </Grid>
                        </Border>
                        <ControlTemplate.Triggers>
                            <!-- Hover: Scale + Glow + Kleur -->
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Border" Property="Background" Value="#1E7A3E"/>
                                <Setter TargetName="Shadow" Property="BlurRadius" Value="20"/>
                                <Setter TargetName="Shadow" Property="Opacity" Value="0.5"/>
                                <Setter TargetName="Shadow" Property="Color" Value="#22D3EE"/>
                            </Trigger>
                            <!-- Click: Drukt in -->
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="Border" Property="RenderTransform">
                                    <Setter.Value>
                                        <ScaleTransform ScaleX="0.95" ScaleY="0.95"/>
                                    </Setter.Value>
                                </Setter>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Border x:Name="MainBorder" Background="#0A120F" CornerRadius="24" BorderBrush="#1A2E24" BorderThickness="1">
        <Border.Effect>
            <DropShadowEffect BlurRadius="40" ShadowDepth="0" Opacity="0.55"/>
        </Border.Effect>

        <Grid>
            <Canvas Panel.ZIndex="-1">
                <!-- Decorative circles -->
                <Ellipse x:Name="Circle1" Width="520" Height="520" Fill="#052E16" Opacity="0.20" Canvas.Left="-140" Canvas.Top="-100"/>
                <Ellipse x:Name="Circle2" Width="380" Height="380" Fill="#166534" Opacity="0.16" Canvas.Right="-80" Canvas.Bottom="40"/>
                <Ellipse x:Name="Circle3" Width="240" Height="240" Fill="#4ADE80" Opacity="0.13" Canvas.Left="280" Canvas.Top="160"/>
                <Ellipse x:Name="Circle4" Width="680" Height="680" Fill="#0F2A1F" Opacity="0.11" Canvas.Right="-220" Canvas.Top="-180"/>
                <Ellipse x:Name="Circle5" Width="150" Height="150" Fill="#86EFAC" Opacity="0.24" Canvas.Left="920" Canvas.Top="380"/>
                <Ellipse x:Name="Circle6" Width="320" Height="320" Fill="#166534" Opacity="0.10" Canvas.Left="1100" Canvas.Bottom="60"/>
                <Ellipse x:Name="Circle7" Width="420" Height="420" Fill="#052E16" Opacity="0.13" Canvas.Left="750" Canvas.Top="-80"/>
                <Ellipse x:Name="Circle8" Width="180" Height="180" Fill="#67E8F9" Opacity="0.09" Canvas.Left="1050" Canvas.Top="520"/>
                <Ellipse x:Name="Circle9"  Width="260" Height="260" Fill="#166534" Opacity="0.12" Canvas.Left="-60"  Canvas.Bottom="-40"/>
                <Ellipse x:Name="Circle10" Width="340" Height="340" Fill="#052E16" Opacity="0.14" Canvas.Left="80"   Canvas.Bottom="-80"/>
                <Ellipse x:Name="Circle11" Width="160" Height="160" Fill="#4ADE80" Opacity="0.10" Canvas.Left="40"   Canvas.Bottom="120"/>
            </Canvas>

            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="68"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>

                <Border Grid.Row="0" Background="#08100D" CornerRadius="24,24,0,0">
                    <Grid Margin="25,0">
                        <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                            <Border x:Name="LogoBorder" Width="42" Height="42" CornerRadius="13" Background="#0F1A16" BorderBrush="#2A4738" BorderThickness="1">
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

                <Grid Grid.Row="1" Margin="25,20,40,25">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="300"/>
                    </Grid.ColumnDefinitions>

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

                    <Border Grid.Column="1" Background="#0F1A16" CornerRadius="20" BorderBrush="#2A4738" BorderThickness="1" Padding="20" Margin="20,0,0,0">
                        <StackPanel>
                            <TextBlock Text="Control Center" FontSize="18" FontWeight="SemiBold" Foreground="#4ADE80"/>
                            <TextBlock Text="Manage your Guiss Tools" FontSize="13" Foreground="#7E92A6" Margin="0,4,0,20"/>

                            <Button x:Name="InstallButton" Tag="⬇" Content="Install / Update Tools"   Style="{StaticResource MainButtonStyle}"/>
                            <Button x:Name="RemoveButton"  Tag="🗑" Content="Remove Installed Tools"   Background="#3F1F1F" Style="{StaticResource MainButtonStyle}"/>
                            <Button x:Name="OpenFolderButton" Tag="📁" Content="Open Install Folder"      Style="{StaticResource MainButtonStyle}"/>
                            <Button x:Name="OpenCmdButton"    Tag="💻" Content="CMD Commands"             Style="{StaticResource MainButtonStyle}"/>
                            <Button x:Name="ExitButton"       Tag="✕" Content="Exit Launcher"            Style="{StaticResource MainButtonStyle}"/>
                        </StackPanel>
                    </Border>
                </Grid>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

$LogoBorder = $window.FindName("LogoBorder")
$ActivityBox = $window.FindName("ActivityBox")

$window.Add_Loaded({
    $fadeIn = New-Object System.Windows.Media.Animation.DoubleAnimation
    $fadeIn.From = 0; $fadeIn.To = 1; $fadeIn.Duration = [TimeSpan]::FromMilliseconds(450)
    $window.BeginAnimation([System.Windows.Window]::OpacityProperty, $fadeIn)

    $glow = New-Object System.Windows.Media.Effects.DropShadowEffect
    $glow.Color = "#4ADE80"
    $glow.BlurRadius = 18
    $glow.ShadowDepth = 0
    $glow.Opacity = 0.6
    $LogoBorder.Effect = $glow

    $glowAnim = New-Object System.Windows.Media.Animation.DoubleAnimation
    $glowAnim.From = 0.4; $glowAnim.To = 0.85; $glowAnim.Duration = [TimeSpan]::FromMilliseconds(1800)
    $glowAnim.AutoReverse = $true; $glowAnim.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever
    $glow.BeginAnimation([System.Windows.Media.Effects.DropShadowEffect]::OpacityProperty, $glowAnim)
})

# ====================== ANIMATIES ======================
# (Cirkels + floating - hetzelfde als vorige versie, ik laat het kort voor de duidelijkheid)

# ====================== BUTTONS ======================
$CloseButton = $window.FindName("CloseButton")
$MinButton   = $window.FindName("MinButton")
$MainBorder  = $window.FindName("MainBorder")

$MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })
$MinButton.Add_Click({ $window.WindowState = "Minimized" })
$CloseButton.Add_Click({ $window.Close() })
$window.FindName("ExitButton").Add_Click({ $window.Close() })

# ====================== INSTALL MET LOADING ======================
$InstallButton = $window.FindName("InstallButton")

$InstallButton.Add_Click({
    $originalContent = $InstallButton.Content
    $InstallButton.Content = "Installing..."
    $InstallButton.IsEnabled = $false

    $ActivityBox.AppendText("`n[Install] Installatie gestart...`n")

    try {
        # Admin check + download logica (zelfde als vorige versie)
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal($identity)
        if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
            $ActivityBox.AppendText("[Error] Run dit script als Administrator!`n")
            $InstallButton.Content = $originalContent
            $InstallButton.IsEnabled = $true
            return
        }

        $ActivityBox.AppendText("[Install] Bezig met downloaden...`n")
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $toolsZipUrl -OutFile $zipPath -UseBasicParsing -ErrorAction Stop

        $zipFile = Get-Item $zipPath
        if ($zipFile.Length -lt 50000) { throw "Download mislukt." }

        $ActivityBox.AppendText("[Install] Download succesvol!`n")

        if (Test-Path $destPath) { Remove-Item $destPath -Recurse -Force -ErrorAction SilentlyContinue }
        Expand-Archive -Path $zipPath -DestinationPath $destPath -Force

        $ActivityBox.AppendText("[Install] Uitpakken voltooid!`n")
        Start-Process $destPath

    }
    catch {
        $ActivityBox.AppendText("[Error] $($_.Exception.Message)`n")
    }
    finally {
        $InstallButton.Content = $originalContent
        $InstallButton.IsEnabled = $true
    }
})

# ====================== ANDERE BUTTONS ======================
$window.FindName("RemoveButton").Add_Click({ ... })      # (zelfde als vorige)
$window.FindName("OpenFolderButton").Add_Click({ ... })
$window.FindName("OpenCmdButton").Add_Click({ ... })

# ====================== UPDATE NOTIFICATIE (v4.0) ======================
function Show-v4UpdateNotification {
    [xml]$notifXaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Update v4.0" Width="680" Height="420"
        WindowStartupLocation="CenterOwner" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent">

    <Border Background="#0A120F" CornerRadius="20" BorderBrush="#1A2E24" BorderThickness="1" Padding="24">
        <Border.Effect>
            <DropShadowEffect BlurRadius="30" ShadowDepth="0" Opacity="0.5"/>
        </Border.Effect>

        <Grid>
            <Canvas Panel.ZIndex="-1">
                <Ellipse Width="180" Height="180" Fill="#052E16" Opacity="0.25" Canvas.Left="-30" Canvas.Top="-20"/>
                <Ellipse Width="120" Height="120" Fill="#166534" Opacity="0.20" Canvas.Right="-20" Canvas.Bottom="-15"/>
            </Canvas>

            <StackPanel>
                <StackPanel Orientation="Horizontal" Margin="0,0,0,16">
                    <Border Width="48" Height="48" CornerRadius="12" Background="#0F2A1F" BorderBrush="#2A4738" BorderThickness="1.5">
                        <TextBlock Text="⬆" FontSize="24" Foreground="#4ADE80" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                    </Border>
                    <StackPanel Margin="14,0,0,0">
                        <TextBlock Text="Update v4.0 is beschikbaar!" FontSize="22" FontWeight="SemiBold" Foreground="White"/>
                        <TextBlock Text="Guiss Tools" FontSize="13" Foreground="#7E92A6" Margin="0,4,0,0"/>
                    </StackPanel>
                </StackPanel>

                <Border Background="#0F1A16" CornerRadius="14" BorderBrush="#2A4738" BorderThickness="1" Padding="18">
                    <StackPanel>
                        <TextBlock TextWrapping="Wrap" Foreground="#D1E8D9" FontSize="14" LineHeight="20">
Nieuwe tools toegevoegd in deze update:

• MeowClientFucker
• MeowDoomsdayFucker  
• MeowNovowareFucker
• JournalTrace

Druk op "Install / Update Tools" om alles bij te werken.
                        </TextBlock>
                    </StackPanel>
                </Border>

                <Button x:Name="CloseNotifButton" Content="Got it!" Width="140" Height="42" 
                        Background="#166534" Foreground="White" FontWeight="SemiBold"
                        BorderThickness="0" Cursor="Hand" HorizontalAlignment="Right" Margin="0,20,0,0"/>
            </StackPanel>
        </Grid>
    </Border>
</Window>
"@

    $notifReader = New-Object System.Xml.XmlNodeReader $notifXaml
    $notif = [Windows.Markup.XamlReader]::Load($notifReader)
    $notif.Owner = $window

    $notif.FindName("CloseNotifButton").Add_Click({ $notif.Close() })

    $notif.ShowDialog() | Out-Null
}

# Toon notificatie bij opstarten
$window.Add_ContentRendered({
    Show-v4UpdateNotification
})

$window.ShowDialog() | Out-Null
