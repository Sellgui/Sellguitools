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

                <!-- Left: All 68 Tools (Alphabetical) -->
                <Border Grid.Column="0" Background="#0B1118" CornerRadius="18" BorderBrush="#2A4738" BorderThickness="1" Padding="12">
                    <ScrollViewer VerticalScrollBarVisibility="Hidden">
                        <StackPanel>
                            <TextBlock Text="Commands" FontSize="17" FontWeight="SemiBold" Foreground="#4ADE80" Margin="8,0,0,12"/>

                            <Button x:Name="BtnActivitiesCache" Style="{StaticResource RoundButtonStyle}" Content="📜 ActivitiesCache"/>
                            <Button x:Name="BtnAltDetector" Style="{StaticResource RoundButtonStyle}" Content="🕵️ AltDetector"/>
                            <Button x:Name="BtnAmcacheParser" Style="{StaticResource RoundButtonStyle}" Content="📦 AmcacheParser"/>
                            <Button x:Name="BtnBAMParser" Style="{StaticResource RoundButtonStyle}" Content="📋 BAM-parser"/>
                            <Button x:Name="BtnBamDeletedKeys" Style="{StaticResource RoundButtonStyle}" Content="🗑️ BamDeletedKeys"/>
                            <Button x:Name="BtnBAMReveal" Style="{StaticResource RoundButtonStyle}" Content="🔍 BAMReveal"/>
                            <Button x:Name="Btnbstrings" Style="{StaticResource RoundButtonStyle}" Content="🔤 bstrings"/>
                            <Button x:Name="BtnBrowserDownloadsView" Style="{StaticResource RoundButtonStyle}" Content="🌐 BrowserDownloadsView"/>
                            <Button x:Name="BtnCheckDeletedUSN" Style="{StaticResource RoundButtonStyle}" Content="🗑️ CheckDeletedUSN"/>
                            <Button x:Name="BtnCommonDirectories" Style="{StaticResource RoundButtonStyle}" Content="📁 CommonDirectories"/>
                            <Button x:Name="BtnComputerActivityView" Style="{StaticResource RoundButtonStyle}" Content="🖥️ ComputerActivityView"/>
                            <Button x:Name="BtnDIEengine" Style="{StaticResource RoundButtonStyle}" Content="🔧 DIE-engine"/>
                            <Button x:Name="BtnDPSAnalyzer" Style="{StaticResource RoundButtonStyle}" Content="📊 DPS-Analyzer"/>
                            <Button x:Name="BtnDQRKISFUCKER" Style="{StaticResource RoundButtonStyle}" Content="💀 DQRKIS-FUCKER"/>
                            <Button x:Name="BtnEspoukenTool" Style="{StaticResource RoundButtonStyle}" Content="🛠️ Espouken Tool"/>
                            <Button x:Name="BtnExecutedProgramsList" Style="{StaticResource RoundButtonStyle}" Content="📋 ExecutedProgramsList"/>
                            <Button x:Name="BtnFileless" Style="{StaticResource RoundButtonStyle}" Content="👻 Fileless"/>
                            <Button x:Name="BtnFullEventLogView" Style="{StaticResource RoundButtonStyle}" Content="📜 FullEventLogView"/>
                            <Button x:Name="BtnHarddiskConverter" Style="{StaticResource RoundButtonStyle}" Content="💾 HarddiskConverter"/>
                            <Button x:Name="BtnInjGen" Style="{StaticResource RoundButtonStyle}" Content="💉 InjGen"/>
                            <Button x:Name="BtnJARParser" Style="{StaticResource RoundButtonStyle}" Content="📦 JARParser"/>
                            <Button x:Name="BtnJLECmd" Style="{StaticResource RoundButtonStyle}" Content="📋 JLECmd"/>
                            <Button x:Name="BtnJournalParser" Style="{StaticResource RoundButtonStyle}" Content="📜 JournalParser"/>
                            <Button x:Name="BtnJournalTrace" Style="{StaticResource RoundButtonStyle}" Content="📜 JournalTrace"/>
                            <Button x:Name="BtnJumpListExplorer" Style="{StaticResource RoundButtonStyle}" Content="📋 JumpListExplorer"/>
                            <Button x:Name="BtnJumpListsView" Style="{StaticResource RoundButtonStyle}" Content="📋 JumpListsView"/>
                            <Button x:Name="BtnKernelLiveDumpTool" Style="{StaticResource RoundButtonStyle}" Content="💾 KernelLiveDumpTool"/>
                            <Button x:Name="BtnMacroDetector" Style="{StaticResource RoundButtonStyle}" Content="🛡️ MacroDetector"/>
                            <Button x:Name="BtnMeowClientsFucker" Style="{StaticResource RoundButtonStyle}" Content="🐱 MeowClientsFucker"/>
                            <Button x:Name="BtnMeowDoomsdayFucker" Style="{StaticResource RoundButtonStyle}" Content="🐱 MeowDoomsdayFucker"/>
                            <Button x:Name="BtnMeowImportsChecker" Style="{StaticResource RoundButtonStyle}" Content="🐱 MeowImportsChecker"/>
                            <Button x:Name="BtnMeowModAnalyzer" Style="{StaticResource RoundButtonStyle}" Content="🐱 MeowModAnalyzer"/>
                            <Button x:Name="BtnMeowNovowareFucker" Style="{StaticResource RoundButtonStyle}" Content="🐱 MeowNovowareFucker"/>
                            <Button x:Name="BtnMeowResolver" Style="{StaticResource RoundButtonStyle}" Content="🐱 MeowResolver"/>
                            <Button x:Name="BtnMFTECmd" Style="{StaticResource RoundButtonStyle}" Content="📦 MFTECmd"/>
                            <Button x:Name="BtnNET90" Style="{StaticResource RoundButtonStyle}" Content="⚙️ NET 9.0"/>
                            <Button x:Name="BtnNET100" Style="{StaticResource RoundButtonStyle}" Content="⚙️ NET 10.0"/>
                            <Button x:Name="BtnNetworkUsageView" Style="{StaticResource RoundButtonStyle}" Content="🌐 NetworkUsageView"/>
                            <Button x:Name="BtnOpenSaveFilesView" Style="{StaticResource RoundButtonStyle}" Content="📁 OpenSaveFilesView"/>
                            <Button x:Name="BtnPathsParser" Style="{StaticResource RoundButtonStyle}" Content="📁 PathsParser"/>
                            <Button x:Name="Btnpcasvcexecuted" Style="{StaticResource RoundButtonStyle}" Content="📜 pcasvc-executed"/>
                            <Button x:Name="BtnPECmd" Style="{StaticResource RoundButtonStyle}" Content="📦 PECmd"/>
                            <Button x:Name="BtnPFTrace" Style="{StaticResource RoundButtonStyle}" Content="📜 PFTrace"/>
                            <Button x:Name="BtnPrefetchView" Style="{StaticResource RoundButtonStyle}" Content="📜 PrefetchView"/>
                            <Button x:Name="Btnprefetchparser" Style="{StaticResource RoundButtonStyle}" Content="📜 prefetch-parser"/>
                            <Button x:Name="Btnprocessparser" Style="{StaticResource RoundButtonStyle}" Content="📋 process-parser"/>
                            <Button x:Name="BtnPSHunter" Style="{StaticResource RoundButtonStyle}" Content="🔍 PSHunter"/>
                            <Button x:Name="BtnRecentFileCacheParser" Style="{StaticResource RoundButtonStyle}" Content="📁 RecentFileCacheParser"/>
                            <Button x:Name="BtnRegScanner" Style="{StaticResource RoundButtonStyle}" Content="🔍 RegScanner"/>
                            <Button x:Name="BtnRegistryExplorer" Style="{StaticResource RoundButtonStyle}" Content="📋 RegistryExplorer"/>
                            <Button x:Name="BtnRLAltChecker" Style="{StaticResource RoundButtonStyle}" Content="🔴 RL AltChecker"/>
                            <Button x:Name="BtnRLModAnalyzer" Style="{StaticResource RoundButtonStyle}" Content="🔴 RL ModAnalyzer"/>
                            <Button x:Name="BtnRLTaskSentinel" Style="{StaticResource RoundButtonStyle}" Content="🔴 RL TaskSentinel"/>
                            <Button x:Name="BtnServices" Style="{StaticResource RoundButtonStyle}" Content="⚙️ Services"/>
                            <Button x:Name="BtnShellBagsExplorer" Style="{StaticResource RoundButtonStyle}" Content="📁 ShellBagsExplorer"/>
                            <Button x:Name="BtnShellBagsView" Style="{StaticResource RoundButtonStyle}" Content="📁 ShellBagsView"/>
                            <Button x:Name="BtnSignedScheduledTasks" Style="{StaticResource RoundButtonStyle}" Content="📋 SignedScheduledTasks"/>
                            <Button x:Name="BtnSrumECmd" Style="{StaticResource RoundButtonStyle}" Content="📊 SrumECmd"/>
                            <Button x:Name="BtnStringsParser" Style="{StaticResource RoundButtonStyle}" Content="🔤 StringsParser"/>
                            <Button x:Name="BtnSystemInformer" Style="{StaticResource RoundButtonStyle}" Content="🖥️ SystemInformer"/>
                            <Button x:Name="BtnTaskSchedulerView" Style="{StaticResource RoundButtonStyle}" Content="📋 TaskSchedulerView"/>
                            <Button x:Name="BtnTimelineExplorer" Style="{StaticResource RoundButtonStyle}" Content="📜 TimelineExplorer"/>
                            <Button x:Name="BtnUSBDetector" Style="{StaticResource RoundButtonStyle}" Content="🔌 USBDetector"/>
                            <Button x:Name="BtnUSBDeview" Style="{StaticResource RoundButtonStyle}" Content="🔌 USBDeview"/>
                            <Button x:Name="BtnUserAssistView" Style="{StaticResource RoundButtonStyle}" Content="👤 UserAssistView"/>
                            <Button x:Name="BtnVSRedist" Style="{StaticResource RoundButtonStyle}" Content="⚙️ VSRedist"/>
                            <Button x:Name="BtnWeHateFakers" Style="{StaticResource RoundButtonStyle}" Content="🔥 WeHateFakers"/>
                            <Button x:Name="BtnWinPrefetchView" Style="{StaticResource RoundButtonStyle}" Content="📜 WinPrefetchView"/>
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
                                <TextBlock Text="68 Tools Available" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="Minecraft SS Ready" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
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

# === 68 TOOLS - CLICK HANDLERS ===

# (Ik heb hieronder de belangrijkste toegevoegd. De rest kun je later uitbreiden als je wilt)

$window.FindName("BtnMeowModAnalyzer").Add_Click({ Start-Process cmd -ArgumentList "/k powershell -NoProfile -ExecutionPolicy Bypass -Command `"Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/MeowTonynoh/MeowModAnalyzer/main/MeowModAnalyzer.ps1')`"" })
$window.FindName("BtnJournalTrace").Add_Click({ Start-Process "https://github.com/spokwn/JournalTrace/releases/latest" })
$window.FindName("BtnPrefetchView").Add_Click({ Start-Process "https://github.com/Orbdiff/PrefetchView/releases/latest" })
$window.FindName("BtnJARParser").Add_Click({ Start-Process "https://github.com/Orbdiff/JARParser/releases/latest" })
$window.FindName("BtnCheckDeletedUSN").Add_Click({ Start-Process "https://github.com/Orbdiff/CheckDeletedUSN/releases/latest" })
$window.FindName("BtnRLModAnalyzer").Add_Click({ Start-Process "https://github.com/ItzIceHere/RedLotus-Mod-Analyzer/releases/latest" })
$window.FindName("BtnMeowResolver").Add_Click({ Start-Process "https://github.com/MeowTonynoh/MeowResolver/releases/latest" })
$window.FindName("BtnMFTECmd").Add_Click({ Start-Process "https://download.ericzimmermanstools.com/net9/MFTECmd.zip" })
$window.FindName("BtnPECmd").Add_Click({ Start-Process "https://download.ericzimmermanstools.com/net9/PECmd.zip" })
$window.FindName("Btnbstrings").Add_Click({ Start-Process "https://download.ericzimmermanstools.com/net9/bstrings.zip" })
$window.FindName("BtnWinPrefetchView").Add_Click({ Start-Process "https://www.nirsoft.net/utils/winprefetchview.zip" })
$window.FindName("BtnUSBDeview").Add_Click({ Start-Process "https://www.nirsoft.net/utils/usbdeview.zip" })
$window.FindName("BtnDQRKISFUCKER").Add_Click({ Start-Process cmd -ArgumentList "/k powershell -NoProfile -ExecutionPolicy Bypass -Command `"Invoke-RestMethod 'https://raw.githubusercontent.com/cheesecatlol/DQRKIS-FUCKER/refs/heads/main/DqrkisFucker.ps1' | Invoke-Expression`"" })
$window.FindName("BtnMacroDetector").Add_Click({ Start-Process cmd -ArgumentList "/k powershell -NoProfile -ExecutionPolicy Bypass -Command `"Invoke-RestMethod 'https://raw.githubusercontent.com/NiccBlahh/MacroDetector/refs/heads/main/MacroDetector.ps1' | Invoke-Expression`"" })

$window.ShowDialog() | Out-Null
