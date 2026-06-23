Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$userDir   = [Environment]::GetFolderPath("UserProfile")
$downloads = Join-Path $userDir "Downloads"
$destPath  = Join-Path $downloads "Guiss-Tools"

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Command Center" Width="1320" Height="830"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent"
        Opacity="0">

    <Window.Resources>
        <Style x:Key="RoundButtonStyle" TargetType="Button">
            <Setter Property="Background" Value="#0F1A16"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Height" Value="55"/>
            <Setter Property="Margin" Value="0,0,0,8"/>
            <Setter Property="BorderThickness" Value="1.5"/>
            <Setter Property="BorderBrush" Value="#2A4738"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Border" CornerRadius="14" 
                                Background="{TemplateBinding Background}" 
                                BorderBrush="{TemplateBinding BorderBrush}" 
                                BorderThickness="{TemplateBinding BorderThickness}">
                            <ContentPresenter HorizontalAlignment="Left" VerticalAlignment="Center" Margin="16,0,0,0"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Border" Property="BorderBrush" Value="#22D3EE"/>
                                <Setter TargetName="Border" Property="BorderThickness" Value="2"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Border x:Name="MainBorder" CornerRadius="24" BorderBrush="#1A2E24" BorderThickness="1" Background="#0A120F">
        <Border.Effect>
            <DropShadowEffect BlurRadius="45" ShadowDepth="0" Opacity="0.6"/>
        </Border.Effect>

        <Grid>
            <!-- Decorative Circles -->
            <Canvas Panel.ZIndex="-1">
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

                <Grid Grid.Row="1" Margin="20,15,20,20">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="420"/>
                        <ColumnDefinition Width="18"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>

                    <!-- Left: Commands -->
                    <Border Grid.Column="0" Background="#0F1A16" CornerRadius="18" BorderBrush="#2A4738" BorderThickness="1" Padding="12">
                        <ScrollViewer VerticalScrollBarVisibility="Hidden">
                            <StackPanel>
                                <TextBlock Text="Commands" FontSize="17" FontWeight="SemiBold" Foreground="#4ADE80" Margin="8,0,0,12"/>
                                
                                <Button x:Name="BtnAnydesk" Style="{StaticResource RoundButtonStyle}" Content="💻 Anydesk Install"/>
                                <Button x:Name="BtnCyemer" Style="{StaticResource RoundButtonStyle}" Content="🔍 Cyemer Scanner"/>
                                <Button x:Name="BtnDqrkis" Style="{StaticResource RoundButtonStyle}" Content="💀 DQRKIS-FUCKER"/>
                                <Button x:Name="BtnGhostFinder" Style="{StaticResource RoundButtonStyle}" Content="👻 Ghost Client Finder"/>
                                <Button x:Name="BtnInjector" Style="{StaticResource RoundButtonStyle}" Content="💉 Injector Detector"/>
                                <Button x:Name="BtnMeow" Style="{StaticResource RoundButtonStyle}" Content="🐱 Meow Mod Analyzer"/>
                                <Button x:Name="BtnAppData" Style="{StaticResource RoundButtonStyle}" Content="📁 Open AppData"/>
                                <Button x:Name="BtnPowerShellHistory" Style="{StaticResource RoundButtonStyle}" Content="📜 Open PowerShell History"/>
                                <Button x:Name="BtnPrefetch" Style="{StaticResource RoundButtonStyle}" Content="🗂️ Open Prefetch"/>
                                <Button x:Name="BtnPrimeMacro" Style="{StaticResource RoundButtonStyle}" Content="🛡️ Prime Macro Detector"/>
                                <Button x:Name="BtnQuickcheck" Style="{StaticResource RoundButtonStyle}" Content="⚡ Quickcheck Scanner"/>
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
                                    <TextBlock Text="22 Commands Available" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                    <TextBlock Text="4 Tools installed • 1 running" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
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
        </Grid>
    </Border>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

$CloseButton = $window.FindName("CloseButton")
$MinButton   = $window.FindName("MinButton")
$MainBorder  = $window.FindName("MainBorder")

$MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })
$MinButton.Add_Click({ $window.WindowState = "Minimized" })
$CloseButton.Add_Click({ $window.Close() })

# ====================== BUTTON ACTIES ======================
$window.FindName("BtnAnydesk").Add_Click({ Start-Process "$destPath\AnyDesk.exe" })
$window.FindName("BtnCyemer").Add_Click({ Start-Process "$destPath\CyemerScanner.exe" })
$window.FindName("BtnDqrkis").Add_Click({ Start-Process "$destPath\DQRKIS-FUCKER.exe" })
$window.FindName("BtnGhostFinder").Add_Click({ Start-Process "$destPath\Ghostclientfinder.exe" })
$window.FindName("BtnInjector").Add_Click({ Start-Process "$destPath\Injector Scanner.exe" })
$window.FindName("BtnMeow").Add_Click({ Start-Process "$destPath\MeowModAnalyzer.exe" })
$window.FindName("BtnAppData").Add_Click({ Start-Process $env:APPDATA })
$window.FindName("BtnPowerShellHistory").Add_Click({ Start-Process "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine" })
$window.FindName("BtnPrefetch").Add_Click({ Start-Process "$env:SystemRoot\Prefetch" })
$window.FindName("BtnPrimeMacro").Add_Click({ Start-Process "$destPath\PrimeMacroDetector.exe" })
$window.FindName("BtnQuickcheck").Add_Click({ Start-Process "$destPath\Quickcheck.exe" })

$window.ShowDialog() | Out-Null
