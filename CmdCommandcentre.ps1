Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Command Center" Width="1280" Height="800"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent">

    <Border x:Name="MainBorder" CornerRadius="24" BorderBrush="#1A2E24" BorderThickness="1">
        <Border.Effect>
            <DropShadowEffect BlurRadius="40" ShadowDepth="0" Opacity="0.55"/>
        </Border.Effect>

        <Grid>
            
            <!-- Achtergrond -->
            <Border Background="#0A120F" CornerRadius="24"/>

            <!-- Decoratieve cirkels (groen + licht wit) -->
            <Ellipse Width="480" Height="480" Fill="#166534" Opacity="0.05" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="-160,-140,0,0"/>
            <Ellipse Width="320" Height="320" Fill="#4ADE80" Opacity="0.035" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,-100,-90"/>
            <Ellipse Width="200" Height="200" Fill="White" Opacity="0.02" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,80,0,0"/>
            <Ellipse Width="140" Height="140" Fill="White" Opacity="0.015" HorizontalAlignment="Left" VerticalAlignment="Bottom" Margin="60,0,0,50"/>

            <!-- Top Bar (Tesla stijl) -->
            <Border Height="68" Background="#08100D" CornerRadius="24,24,0,0">
                <Grid Margin="22,0">
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Width="44" Height="44" CornerRadius="13" Background="#0F1A16" BorderBrush="#2A4738" BorderThickness="1">
                            <TextBlock Text="G" FontSize="24" FontWeight="Bold" Foreground="#4ADE80" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <StackPanel Margin="14,0,0,0">
                            <TextBlock Text="Guiss Command Center" FontSize="20" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Professional Tools &amp; Commands" FontSize="12" Foreground="#7E92A6"/>
                        </StackPanel>
                    </StackPanel>

                    <!-- Top Right Buttons -->
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                        <Button x:Name="InfoButton" Content="ⓘ" Width="38" Height="38" Background="#0F1A16" Foreground="#4ADE80" 
                                BorderThickness="0" FontSize="17" Margin="0,0,8,0"/>
                        <Button x:Name="MinButton" Content="—" Width="42" Height="38" Background="Transparent" Foreground="#A0B8C8" 
                                BorderThickness="0" FontSize="20"/>
                        <Button x:Name="MaxButton" Content="□" Width="42" Height="38" Background="Transparent" Foreground="#A0B8C8" 
                                BorderThickness="0" FontSize="16"/>
                        <Button x:Name="CloseButton" Content="✕" Width="42" Height="38" Background="Transparent" Foreground="#FF6B6B" 
                                BorderThickness="0" FontSize="17"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Main Content -->
            <Grid Margin="0,75,0,20">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="420"/>
                    <ColumnDefinition Width="18"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Left: Scrollable Commands -->
                <Border Grid.Column="0" Background="#0B1118" CornerRadius="18" BorderBrush="#1A2E24" BorderThickness="1" Padding="16">
                    <ScrollViewer VerticalScrollBarVisibility="Auto">
                        <StackPanel>
                            <TextBlock Text="Commands" FontSize="17" FontWeight="SemiBold" Foreground="#4ADE80" Margin="5,0,0,14"/>

                            <Button Content="🟢  Prime Macro Detector" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🟢  Guiss Launcher" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📁  Open Prefetch Folder" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🖥️  Start AnyDesk" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔍  Quick Macro Scan" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🛡️  Screenshare Tools" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="⚡  CMD Commands" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📊  System Information" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🧹  Clean Temp Files" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔄  Restart Explorer" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📝  Open Notepad" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🌐  Open Chrome" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔧  Services.msc" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📋  Task Manager" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🗂️  Open Downloads" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔒  Lock PC" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔄  Update Tools" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📈  Performance Monitor" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🧪  Test Command 1" Height="48" Background="#166534" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🧪  Test Command 2" Height="48" Background="#166534" Foreground="White" FontSize="14"/>
                        </StackPanel>
                    </ScrollViewer>
                </Border>

                <!-- Right: Widgets -->
                <Grid Grid.Column="2">
                    <StackPanel>
                        <TextBlock Text="Dashboard" FontSize="20" FontWeight="SemiBold" Foreground="#4ADE80" Margin="0,0,0,18"/>

                        <!-- Widget 1 -->
                        <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1" Margin="0,0,0,14">
                            <StackPanel>
                                <TextBlock Text="LAST SCAN" FontSize="12" Foreground="#4ADE80"/>
                                <TextBlock Text="Today at 19:14" FontSize="22" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="No threats detected • Clean system" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <!-- Widget 2 -->
                        <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1" Margin="0,0,0,14">
                            <StackPanel>
                                <TextBlock Text="SYSTEM STATUS" FontSize="12" Foreground="#4ADE80"/>
                                <TextBlock Text="All Systems Operational" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="CPU: 14% • RAM: 38%" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <!-- Widget 3 -->
                        <Border Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1" Margin="0,0,0,14">
                            <StackPanel>
                                <TextBlock Text="QUICK STATS" FontSize="12" Foreground="#4ADE80"/>
                                <TextBlock Text="22 Commands Available" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                <TextBlock Text="4 Tools installed • 1 running" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <!-- Widget 4 -->
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

$CloseButton = $window.FindName("CloseButton")
$MinButton   = $window.FindName("MinButton")
$MaxButton   = $window.FindName("MaxButton")
$InfoButton  = $window.FindName("InfoButton")
$MainBorder  = $window.FindName("MainBorder")

$MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })

$MinButton.Add_Click({ $window.WindowState = "Minimized" })
$MaxButton.Add_Click({ 
    if ($window.WindowState -eq "Normal") { 
        $window.WindowState = "Maximized" 
    } else { 
        $window.WindowState = "Normal" 
    } 
})
$CloseButton.Add_Click({ $window.Close() })

$window.ShowDialog() | Out-Null
