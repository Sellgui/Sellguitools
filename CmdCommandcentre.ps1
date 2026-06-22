Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Command Center" Width="1320" Height="830"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent"
        Opacity="0">

    <Window.Resources>
        <Style x:Key="RoundButtonStyle" TargetType="Button">
            <Setter Property="Background" Value="#0D3B24"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="Height" Value="46"/>
            <Setter Property="Margin" Value="0,0,0,6"/>
            <Setter Property="BorderThickness" Value="1.5"/>
            <Setter Property="BorderBrush" Value="#0F3D1F"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border CornerRadius="14" 
                                Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}">
                            <ContentPresenter HorizontalAlignment="Left" 
                                              VerticalAlignment="Center"
                                              Margin="14,0,0,0"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

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
                            <TextBlock Text="Guiss Command Center" FontSize="19" FontWeight="SemiBold" Foreground="White"/>
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
                    <ColumnDefinition Width="420"/>
                    <ColumnDefinition Width="18"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Left: Commands -->
                <Border Grid.Column="0" Background="#0B1118" CornerRadius="18" BorderBrush="#2A4738" BorderThickness="1" Padding="12">
                    <ScrollViewer VerticalScrollBarVisibility="Hidden">
                        <StackPanel>
                            <TextBlock Text="Commands" FontSize="17" FontWeight="SemiBold" Foreground="#4ADE80" Margin="8,0,0,12"/>

                            <Button x:Name="BtnAnydesk"           Style="{StaticResource RoundButtonStyle}" Content="Anydesk Install"/>
                            <Button x:Name="BtnPowerShellHistory" Style="{StaticResource RoundButtonStyle}" Content="Open PowerShell History"/>
                            <Button x:Name="BtnAppData"           Style="{StaticResource RoundButtonStyle}" Content="Open AppData"/>
                            <Button x:Name="BtnPrefetch"          Style="{StaticResource RoundButtonStyle}" Content="Open Prefetch"/>

                            <Button x:Name="BtnPrimeMacro"   Style="{StaticResource RoundButtonStyle}" Content="Prime Macro Detector"/>
                            <Button x:Name="BtnQuickcheck"   Style="{StaticResource RoundButtonStyle}" Content="Quickcheck Scanner"/>
                            <Button x:Name="BtnGhostFinder"  Style="{StaticResource RoundButtonStyle}" Content="Ghost Client Finder"/>
                            <Button x:Name="BtnCyemer"       Style="{StaticResource RoundButtonStyle}" Content="Cyemer Scanner"/>
                            <Button x:Name="BtnInjector"     Style="{StaticResource RoundButtonStyle}" Content="Injector Detector"/>
                            <Button x:Name="BtnMeow"         Style="{StaticResource RoundButtonStyle}" Content="Meow Mod Analyzer"/>
                            <Button x:Name="BtnDqrkis"       Style="{StaticResource RoundButtonStyle}" Content="DQRKIS-FUCKER"/>
                        </StackPanel>
                    </ScrollViewer>
                </Border>

                <!-- Right: Dashboard -->
                <Grid Grid.Column="2">
                    <StackPanel>
                        <TextBlock Text="Dashboard" FontSize="20" FontWeight="SemiBold" Foreground="#4ADE80" Margin="0,0,0,18"/>

                        <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1" Margin="0,0,0,14">
                            <StackPanel>
                                <TextBlock Text="LAST SCAN" FontSize="12" Foreground="#4ADE80"/>
                                <TextBlock Text="Today at 19:14" FontSize="22" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="No threats detected • Clean system" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1" Margin="0,0,0,14">
                            <StackPanel>
                                <TextBlock Text="SYSTEM STATUS" FontSize="12" Foreground="#4ADE80"/>
                                <TextBlock Text="All Systems Operational" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="CPU: 14% • RAM: 38%" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1" Margin="0,0,0,14">
                            <StackPanel>
                                <TextBlock Text="QUICK STATS" FontSize="12" Foreground="#4ADE80"/>
                                <TextBlock Text="11 Tools Available" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="Clean & Focused" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                            <StackPanel>
                                <TextBlock Text="GUISS TOOLS" FontSize="12" Foreground="#4ADE80"/>
                                <TextBlock Text="Version 3.3 • Up to date" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="Last update: Today" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>
                    </StackPanel>
                </Grid>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

$fadeIn = New-Object System.Windows.Media.Animation.DoubleAnimation
$fadeIn.From = 0
$fadeIn.To = 1
$fadeIn.Duration = [System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(450))
$window.BeginAnimation([System.Windows.Window]::OpacityProperty, $fadeIn)

$CloseButton = $window.FindName("CloseButton")
$MinButton = $window.FindName("MinButton")
$MainBorder = $window.FindName("MainBorder")

$MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })
$MinButton.Add_Click({ $window.WindowState = "Minimized" })
$CloseButton.Add_Click({ $window.Close() })

# === KNOPPEN ===

$window.FindName("BtnAnydesk").Add_Click({ Start-Process "https://download.anydesk.com/AnyDesk.exe" })
$window.FindName("BtnPowerShellHistory").Add_Click({ Start-Process "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine" })
$window.FindName("BtnAppData").Add_Click({ Start-Process $env:APPDATA })
$window.FindName("BtnPrefetch").Add_Click({ Start-Process "$env:SystemRoot\Prefetch" })

$window.FindName("BtnPrimeMacro").Add_Click({ Start-Process cmd -ArgumentList "/k powershell -NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/Sellgui/Javamacrodetector/refs/heads/main/Macro%20Detector.ps1 | iex`"" })
$window.FindName("BtnQuickcheck").Add_Click({ Start-Process cmd -ArgumentList "/k powershell Set-ExecutionPolicy Bypass -Scope Process; iex (irm https://pastebin.com/raw/HGLwy7XA)" })
$window.FindName("BtnGhostFinder").Add_Click({ Start-Process cmd -ArgumentList "/k powershell -NoProfile -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Sellgui/Ghostclientfinder/refs/heads/main/Ghostclientfinder.ps1' -UseBasicParsing).Content`"" })
$window.FindName("BtnCyemer").Add_Click({ Start-Process cmd -ArgumentList "/k powershell -ExecutionPolicy Bypass -NoProfile -Command `"irm 'https://raw.githubusercontent.com/Sellgui/Sellguitools/main/Cyemerscanner.ps1' | iex`"" })
$window.FindName("BtnInjector").Add_Click({ Start-Process cmd -ArgumentList "/k powershell -ExecutionPolicy Bypass -NoProfile -Command `"iwr 'https://raw.githubusercontent.com/Sellgui/Injectdetect/refs/heads/main/Injector%20Scanner.ps1' -UseBasicParsing | iex`"" })
$window.FindName("BtnMeow").Add_Click({ Start-Process cmd -ArgumentList "/k powershell -ExecutionPolicy Bypass -NoProfile -Command `"Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/refs/heads/main/MeowModAnalyzer.ps1' | Invoke-Expression`"" })
$window.FindName("BtnDqrkis").Add_Click({ Start-Process cmd -ArgumentList "/k powershell -ExecutionPolicy Bypass -NoProfile -Command `"Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1' | Invoke-Expression`"" })

$window.ShowDialog() | Out-Null
