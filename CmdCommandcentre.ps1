Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Command Center" Width="1320" Height="830"
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

            <!-- Main Content (Commands + Dashboard) -->
            <Grid Margin="0,75,0,20">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="420"/>
                    <ColumnDefinition Width="18"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Left: Commands -->
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
