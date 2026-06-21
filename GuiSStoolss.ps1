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

    <Border x:Name="MainBorder" CornerRadius="24" Background="#0A120F" BorderBrush="#1A2E24" BorderThickness="1">
        <Border.Effect>
            <DropShadowEffect BlurRadius="30" ShadowDepth="0" Opacity="0.5"/>
        </Border.Effect>

        <Grid>
            <!-- Top Bar -->
            <Border Height="64" Background="#08100D" CornerRadius="24,24,0,0">
                <Grid Margin="20,0">
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Width="42" Height="42" CornerRadius="13" Background="#0F1A16" BorderBrush="#2A4738" BorderThickness="1">
                            <TextBlock Text="G" FontSize="22" FontWeight="Bold" Foreground="#4ADE80" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <StackPanel Margin="14,0,0,0">
                            <TextBlock Text="Guiss Launcher" FontSize="20" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Guiss Tools • Professional Edition" FontSize="11" Foreground="#7E92A6"/>
                        </StackPanel>
                    </StackPanel>

                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                        <Button x:Name="MinButton" Content="—" Width="40" Height="34" Background="Transparent" Foreground="#A0B8C8" BorderThickness="0" FontSize="18"/>
                        <Button x:Name="CloseButton" Content="✕" Width="40" Height="34" Background="Transparent" Foreground="#FF6B6B" BorderThickness="0" FontSize="16"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Main Content -->
            <Grid Margin="0,70,0,20">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="20"/>
                    <ColumnDefinition Width="300"/>
                </Grid.ColumnDefinitions>

                <!-- Left Content -->
                <Grid Grid.Column="0" Margin="25,0,0,0">
                    <StackPanel>
                        <TextBlock x:Name="StatusText" Text="Ready" FontSize="30" FontWeight="SemiBold" Foreground="White"/>
                        <TextBlock x:Name="SubStatusText" Text="Everything is ready. Select an action on the right." FontSize="14" Foreground="#9DB1C4" Margin="0,8,0,30"/>

                        <!-- Mini Stats -->
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="15"/>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="15"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>

                            <Border Grid.Column="0" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Current Step" FontSize="12" Foreground="#7C93A8"/>
                                    <TextBlock x:Name="StepText" Text="Waiting" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="2" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Progress" FontSize="12" Foreground="#7C93A8"/>
                                    <TextBlock x:Name="ProgressLabel" Text="0%" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="4" Background="#0F1A16" CornerRadius="16" Padding="18" BorderBrush="#2A4738" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Tools Detected" FontSize="12" Foreground="#7C93A8"/>
                                    <TextBlock x:Name="ToolCountText" Text="0" FontSize="20" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                                </StackPanel>
                            </Border>
                        </Grid>

                        <!-- Activity Console -->
                        <Border Margin="0,30,0,0" Background="#0F1A16" CornerRadius="16" Padding="16" BorderBrush="#2A4738" BorderThickness="1">
                            <StackPanel>
                                <TextBlock Text="Activity Console" FontSize="15" FontWeight="SemiBold" Foreground="White"/>
                                <TextBox x:Name="ActivityBox" Height="150" Background="#08100D" Foreground="#D8E8F5" 
                                         FontFamily="Consolas" FontSize="12" IsReadOnly="True" 
                                         VerticalScrollBarVisibility="Auto" TextWrapping="Wrap"/>
                            </StackPanel>
                        </Border>
                    </StackPanel>
                </Grid>

                <!-- Control Center (Right) -->
                <Border Grid.Column="2" Background="#0B1118" CornerRadius="20" BorderBrush="#1A2E24" BorderThickness="1" Padding="22">
                    <StackPanel>
                        <TextBlock Text="Control Center" FontSize="20" FontWeight="SemiBold" Foreground="White"/>
                        <TextBlock Text="Manage your Guiss Tools" TextWrapping="Wrap" Margin="0,6,0,25" Foreground="#8EA2B6" FontSize="13"/>

                        <Button x:Name="InstallButton" Content="Install / Update Tools" Tag="&#xE898;" Style="{StaticResource ActionButtonStyle}" Background="#22C55E"/>
                        <Button x:Name="DeleteButton" Content="Remove Installed Tools" Tag="&#xE74D;" Style="{StaticResource ActionButtonStyle}" Background="#3A2028"/>
                        <Button x:Name="OpenFolderButton" Content="Open Install Folder" Tag="&#xE838;" Style="{StaticResource ActionButtonStyle}"/>
                        <Button x:Name="ExitButton" Content="Exit Launcher" Tag="&#xE8BB;" Style="{StaticResource ActionButtonStyle}"/>
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
