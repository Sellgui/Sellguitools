Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Command Center" Width="1200" Height="750"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent">

    <Border x:Name="MainBorder" CornerRadius="22" Background="#0A120F" BorderBrush="#1A2E24" BorderThickness="1">
        <Border.Effect>
            <DropShadowEffect BlurRadius="30" ShadowDepth="0" Opacity="0.45"/>
        </Border.Effect>

        <Grid>
            <!-- Top Bar -->
            <Border Height="58" Background="#08100D" CornerRadius="22,22,0,0">
                <Grid>
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center" Margin="20,0">
                        <Border Width="36" Height="36" CornerRadius="10" Background="#0F1A16" BorderBrush="#2A4738" BorderThickness="1">
                            <TextBlock Text="⚡" FontSize="18" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <StackPanel Margin="12,0,0,0">
                            <TextBlock Text="Guiss Command Center" FontSize="18" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="All your tools &amp; commands" FontSize="11" Foreground="#7E92A6"/>
                        </StackPanel>
                    </StackPanel>

                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,0,15,0">
                        <Button x:Name="MinButton" Content="—" Width="36" Height="30" Background="Transparent" Foreground="#A0B8C8" BorderThickness="0" FontSize="16"/>
                        <Button x:Name="CloseButton" Content="✕" Width="36" Height="30" Background="Transparent" Foreground="#FF6B6B" BorderThickness="0" FontSize="15"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Main Content -->
            <Grid Margin="0,65,0,15">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="380"/>
                    <ColumnDefinition Width="20"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Left: Scrollable Buttons -->
                <Border Grid.Column="0" Background="#0B1118" CornerRadius="16" BorderBrush="#1A2E24" BorderThickness="1" Padding="15">
                    <ScrollViewer VerticalScrollBarVisibility="Auto">
                        <StackPanel>
                            <TextBlock Text="Commands" FontSize="16" FontWeight="SemiBold" Foreground="#4ADE80" Margin="0,0,0,12"/>

                            <Button Content="🟢  Prime Macro Detector" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🟢  Guiss Launcher" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📁  Open Prefetch Folder" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🖥️  Start AnyDesk" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔍  Quick Macro Scan" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🛡️  Screenshare Tools" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="⚡  CMD Commands" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📊  System Info" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🧹  Clean Temp Files" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔄  Restart Explorer" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📝  Open Notepad" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🌐  Open Chrome" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔧  Services.msc" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📋  Task Manager" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🗂️  Open Downloads" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔒  Lock PC" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔄  Update Guiss Tools" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📈  Performance Monitor" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🧪  Test Command 1" Height="44" Background="#182332" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🧪  Test Command 2" Height="44" Background="#182332" Foreground="White" FontSize="14"/>
                        </StackPanel>
                    </ScrollViewer>
                </Border>

                <!-- Right: Widgets -->
                <Grid Grid.Column="2">
                    <StackPanel>
                        <TextBlock Text="Dashboard" FontSize="20" FontWeight="SemiBold" Foreground="#4ADE80" Margin="0,0,0,15"/>

                        <!-- Widget 1 -->
                        <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1" Margin="0,0,0,15">
                            <StackPanel>
                                <TextBlock Text="LAST SCAN" FontSize="12" Foreground="#4ADE80"/>
                                <TextBlock Text="Today at 18:42" FontSize="22" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="No threats found" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <!-- Widget 2 -->
                        <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1" Margin="0,0,0,15">
                            <StackPanel>
                                <TextBlock Text="SYSTEM STATUS" FontSize="12" Foreground="#4ADE80"/>
                                <TextBlock Text="All Systems Operational" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="CPU: 12%  •  RAM: 41%" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <!-- Widget 3 -->
                        <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                            <StackPanel>
                                <TextBlock Text="QUICK STATS" FontSize="12" Foreground="#4ADE80"/>
                                <TextBlock Text="18 Commands Available" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="3 Tools installed • 2 running" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
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

$CloseButton = $window.FindName("CloseButton")
$MinButton   = $window.FindName("MinButton")
$MainBorder  = $window.FindName("MainBorder")

$MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })
$MinButton.Add_Click({ $window.WindowState = "Minimized" })
$CloseButton.Add_Click({ $window.Close() })

$window.ShowDialog() | Out-Null
