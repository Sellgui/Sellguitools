Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Command Center" Width="1250" Height="780"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent">

    <Border x:Name="MainBorder" CornerRadius="24" BorderBrush="#1A2E24" BorderThickness="1">
        
        <!-- Achtergrond met donkere groene strepen + cirkels -->
        <Border.Background>
            <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
                <GradientStop Color="#0A120F" Offset="0"/>
                <GradientStop Color="#0F1A16" Offset="0.5"/>
                <GradientStop Color="#0A120F" Offset="1"/>
            </LinearGradientBrush>
        </Border.Background>

        <!-- Decoratieve groene cirkels -->
        <Ellipse Width="420" Height="420" Fill="#22C55E" Opacity="0.04" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="-120,-100,0,0"/>
        <Ellipse Width="280" Height="280" Fill="#4ADE80" Opacity="0.03" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,-80,-80"/>

        <Border.Effect>
            <DropShadowEffect BlurRadius="35" ShadowDepth="0" Opacity="0.5"/>
        </Border.Effect>

        <Grid>
            <!-- Top Bar -->
            <Border Height="62" Background="#08100D" CornerRadius="24,24,0,0">
                <Grid Margin="25,0">
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Width="38" Height="38" CornerRadius="11" Background="#0F1A16" BorderBrush="#2A4738" BorderThickness="1">
                            <TextBlock Text="⚡" FontSize="19" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <StackPanel Margin="13,0,0,0">
                            <TextBlock Text="Guiss Command Center" FontSize="19" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Professional Tools &amp; Commands" FontSize="11" Foreground="#7E92A6"/>
                        </StackPanel>
                    </StackPanel>

                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                        <Button x:Name="MinButton" Content="—" Width="38" Height="32" Background="Transparent" Foreground="#A0B8C8" BorderThickness="0" FontSize="17"/>
                        <Button x:Name="CloseButton" Content="✕" Width="38" Height="32" Background="Transparent" Foreground="#FF6B6B" BorderThickness="0" FontSize="16"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Content -->
            <Grid Margin="0,70,0,18">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="400"/>
                    <ColumnDefinition Width="18"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Left: Scrollable Commands -->
                <Border Grid.Column="0" Background="#0B1118" CornerRadius="18" BorderBrush="#1A2E24" BorderThickness="1" Padding="16">
                    <ScrollViewer VerticalScrollBarVisibility="Auto">
                        <StackPanel>
                            <TextBlock Text="Commands" FontSize="17" FontWeight="SemiBold" Foreground="#4ADE80" Margin="5,0,0,14"/>

                            <Button Content="🟢  Prime Macro Detector" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🟢  Guiss Launcher" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📁  Open Prefetch Folder" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🖥️  Start AnyDesk" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔍  Quick Macro Scan" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🛡️  Screenshare Tools" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="⚡  CMD Commands" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📊  System Information" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🧹  Clean Temp Files" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔄  Restart Explorer" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📝  Open Notepad" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🌐  Open Chrome" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔧  Services.msc" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📋  Task Manager" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🗂️  Open Downloads" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔒  Lock PC" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🔄  Update Tools" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="📈  Performance Monitor" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🧪  Test Command 1" Height="46" Background="#22C55E" Foreground="White" FontSize="14" Margin="0,0,0,8"/>
                            <Button Content="🧪  Test Command 2" Height="46" Background="#22C55E" Foreground="White" FontSize="14"/>
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
                                <TextBlock Text="CPU: 14%   •   RAM: 38%" FontSize="14" Foreground="#7E92A6" Margin="0,4,0,0"/>
                            </StackPanel>
                        </Border>

                        <!-- Widget 3 (nieuw) -->
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
$MainBorder  = $window.FindName("MainBorder")

$MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })
$MinButton.Add_Click({ $window.WindowState = "Minimized" })
$CloseButton.Add_Click({ $window.Close() })

$window.ShowDialog() | Out-Null
