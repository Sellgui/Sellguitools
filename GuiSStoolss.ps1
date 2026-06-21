Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$dest = Join-Path $env:USERPROFILE "Downloads\Guiss-Tools"

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Launcher" Width="1320" Height="830"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent">

    <Border x:Name="MainBorder" CornerRadius="24" BorderBrush="#1A2E24" BorderThickness="1">
        <Border.Effect>
            <DropShadowEffect BlurRadius="40" ShadowDepth="0" Opacity="0.55"/>
        </Border.Effect>

        <Grid>
            
            <!-- Achtergrond + decoratieve cirkels -->
            <Border Background="#0A120F" CornerRadius="24"/>
            
            <!-- Donker groene cirkels -->
            <Ellipse Width="520" Height="520" Fill="#166534" Opacity="0.06" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="-180,-160,0,0"/>
            <Ellipse Width="380" Height="380" Fill="#4ADE80" Opacity="0.04" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,0,-120,-100"/>
            
            <!-- 2 lichte witte cirkels -->
            <Ellipse Width="220" Height="220" Fill="White" Opacity="0.025" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,120,0,0"/>
            <Ellipse Width="160" Height="160" Fill="White" Opacity="0.02" HorizontalAlignment="Left" VerticalAlignment="Bottom" Margin="80,0,0,60"/>

            <!-- Top Bar (Tesla stijl) -->
            <Border Height="68" Background="#08100D" CornerRadius="24,24,0,0">
                <Grid Margin="22,0">
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Width="44" Height="44" CornerRadius="13" Background="#0F1A16" BorderBrush="#2A4738" BorderThickness="1">
                            <TextBlock Text="G" FontSize="24" FontWeight="Bold" Foreground="#4ADE80" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <StackPanel Margin="14,0,0,0">
                            <TextBlock Text="Guiss Launcher" FontSize="20" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Guiss Tools" FontSize="12" Foreground="#7E92A6"/>
                        </StackPanel>
                    </StackPanel>

                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                        <Button x:Name="InfoButton" Content="ⓘ" Width="36" Height="36" Background="#0F1A16" Foreground="#4ADE80" BorderThickness="0" FontSize="16" Margin="0,0,8,0"/>
                        <Button x:Name="MinButton" Content="—" Width="40" Height="36" Background="Transparent" Foreground="#A0B8C8" BorderThickness="0" FontSize="20"/>
                        <Button x:Name="CloseButton" Content="✕" Width="40" Height="36" Background="Transparent" Foreground="#FF6B6B" BorderThickness="0" FontSize="17"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Main Content -->
            <Grid Margin="0,75,0,20">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="20"/>
                    <ColumnDefinition Width="300"/>
                </Grid.ColumnDefinitions>

                <!-- Left Content -->
                <Grid Grid.Column="0" Margin="25,0,0,0">
                    <StackPanel>
                        <TextBlock x:Name="StatusText" Text="Ready" FontSize="32" FontWeight="SemiBold" Foreground="White"/>
                        <TextBlock x:Name="SubStatusText" Text="Everything is ready. Select an action on the right." FontSize="15" Foreground="#9DB1C4" Margin="0,8,0,25"/>

                        <!-- Widgets -->
                        <Grid Margin="0,0,0,25">
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="15"/>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="15"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>

                            <Border Grid.Column="0" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="SYSTEM STATUS" FontSize="11" Foreground="#4ADE80"/>
                                    <TextBlock x:Name="StepText" Text="All Systems OK" FontSize="18" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="2" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="LAST SCAN" FontSize="11" Foreground="#4ADE80"/>
                                    <TextBlock x:Name="ProgressLabel" Text="Today 19:14" FontSize="18" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="4" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="TOOLS" FontSize="11" Foreground="#4ADE80"/>
                                    <TextBlock x:Name="ToolCountText" Text="12" FontSize="18" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>
                        </Grid>

                        <!-- Activity Console -->
                        <Border Background="#0F1A16" CornerRadius="18" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                            <StackPanel>
                                <TextBlock Text="Activity Console" FontSize="16" FontWeight="SemiBold" Foreground="#4ADE80"/>
                                <TextBox x:Name="ActivityBox" Height="280" Background="#08100D" Foreground="#D8E8F5" 
                                         FontFamily="Consolas" FontSize="13" IsReadOnly="True" 
                                         VerticalScrollBarVisibility="Auto" TextWrapping="Wrap"/>
                            </StackPanel>
                        </Border>
                    </StackPanel>
                </Grid>

                <!-- Control Center (Right) -->
                <Border Grid.Column="2" Background="#0B1118" CornerRadius="20" BorderBrush="#1A2E24" BorderThickness="1" Padding="22">
                    <StackPanel>
                        <TextBlock Text="Control Center" FontSize="20" FontWeight="SemiBold" Foreground="#4ADE80"/>
                        <TextBlock Text="Manage your Guiss Tools" TextWrapping="Wrap" Margin="0,6,0,25" Foreground="#8EA2B6" FontSize="13"/>

                        <!-- Knoppen met donkergroene kleur -->
                        <Button x:Name="InstallButton" Content="Install / Update Tools" Height="52" Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>
                        <Button x:Name="DeleteButton" Content="Remove Installed Tools" Height="52" Background="#3A2028" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>
                        <Button x:Name="OpenFolderButton" Content="Open Install Folder" Height="52" Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold" Margin="0,0,0,12"/>
                        <Button x:Name="ExitButton" Content="Exit Launcher" Height="52" Background="#166534" Foreground="White" FontSize="15" FontWeight="SemiBold"/>
                    </StackPanel>
                </Border>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

$CloseButton      = $window.FindName("CloseButton")
$MinButton        = $window.FindName("MinButton")
$InfoButton       = $window.FindName("InfoButton")
$InstallButton    = $window.FindName("InstallButton")
$DeleteButton     = $window.FindName("DeleteButton")
$OpenFolderButton = $window.FindName("OpenFolderButton")
$ExitButton       = $window.FindName("ExitButton")
$StatusText       = $window.FindName("StatusText")
$SubStatusText    = $window.FindName("SubStatusText")
$StepText         = $window.FindName("StepText")
$ProgressLabel    = $window.FindName("ProgressLabel")
$ToolCountText    = $window.FindName("ToolCountText")
$ActivityBox      = $window.FindName("ActivityBox")
$MainBorder       = $window.FindName("MainBorder")

$MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })
$MinButton.Add_Click({ $window.WindowState = "Minimized" })
$CloseButton.Add_Click({ $window.Close() })
$ExitButton.Add_Click({ $window.Close() })

$InstallButton.Add_Click({
    $ActivityBox.AppendText("`n[Install] Starting Guiss Tools installation...`n")
})

$DeleteButton.Add_Click({
    $ActivityBox.AppendText("`n[Remove] Removing tools...`n")
})

$OpenFolderButton.Add_Click({
    if (Test-Path $dest) { Start-Process $dest }
})

$window.ShowDialog() | Out-Null
