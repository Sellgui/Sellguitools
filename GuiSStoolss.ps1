Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Command Center" Width="1100" Height="700"
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
                            <TextBlock Text="All your tools in one place" FontSize="11" Foreground="#7E92A6"/>
                        </StackPanel>
                    </StackPanel>

                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,0,15,0">
                        <Button x:Name="MinButton" Content="—" Width="36" Height="30" Background="Transparent" Foreground="#A0B8C8" BorderThickness="0" FontSize="16"/>
                        <Button x:Name="CloseButton" Content="✕" Width="36" Height="30" Background="Transparent" Foreground="#FF6B6B" BorderThickness="0" FontSize="15"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Content -->
            <Grid Margin="0,65,0,20">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="280"/>
                    <ColumnDefinition Width="20"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <!-- Sidebar -->
                <Border Grid.Column="0" Background="#0B1118" CornerRadius="16" BorderBrush="#1A2E24" BorderThickness="1" Padding="18">
                    <StackPanel>
                        <TextBlock Text="Categories" FontSize="16" FontWeight="SemiBold" Foreground="White" Margin="0,0,0,15"/>

                        <Button Content="🔍 Macro Detection" Tag="macro" Style="{StaticResource ActionButtonStyle}"/>
                        <Button Content="🛡️ Screenshare Tools" Tag="ss" Style="{StaticResource ActionButtonStyle}"/>
                        <Button Content="⚡ Quick Commands" Tag="quick" Style="{StaticResource ActionButtonStyle}"/>
                        <Button Content="🧰 All Tools" Tag="all" Style="{StaticResource ActionButtonStyle}"/>
                    </StackPanel>
                </Border>

                <!-- Main Commands Area -->
                <Border Grid.Column="2" Background="#0F1A16" CornerRadius="16" BorderBrush="#2A4738" BorderThickness="1" Padding="20">
                    <StackPanel>
                        <TextBlock Text="Available Commands" FontSize="18" FontWeight="SemiBold" Foreground="White" Margin="0,0,0,15"/>

                        <Button x:Name="BtnMacro" Content="🟢  Prime Macro Detector" Height="48" Background="#182332" Foreground="White" FontSize="15" Margin="0,0,0,10"/>
                        <Button x:Name="BtnGuiss" Content="🟢  Guiss Launcher" Height="48" Background="#182332" Foreground="White" FontSize="15" Margin="0,0,0,10"/>
                        <Button x:Name="BtnCmd" Content="🟢  CMD Commands (Old)" Height="48" Background="#182332" Foreground="White" FontSize="15" Margin="0,0,0,10"/>
                        <Button x:Name="BtnPrefetch" Content="📁  Open Prefetch Folder" Height="48" Background="#182332" Foreground="White" FontSize="15" Margin="0,0,0,10"/>
                        <Button x:Name="BtnAnyDesk" Content="🖥️  Start AnyDesk" Height="48" Background="#182332" Foreground="White" FontSize="15"/>
                    </StackPanel>
                </Border>
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

$BtnMacro   = $window.FindName("BtnMacro")
$BtnGuiss   = $window.FindName("BtnGuiss")
$BtnCmd     = $window.FindName("BtnCmd")
$BtnPrefetch = $window.FindName("BtnPrefetch")
$BtnAnyDesk = $window.FindName("BtnAnyDesk")

# Drag + minimize + close
$MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })
$MinButton.Add_Click({ $window.WindowState = "Minimized" })
$CloseButton.Add_Click({ $window.Close() })

# Commands
$BtnMacro.Add_Click({
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/Sellgui/Sellguitools/refs/heads/main/GuiSStoolss.ps1 | iex`""
})

$BtnGuiss.Add_Click({
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/Sellgui/Sellguitools/refs/heads/main/GuissLauncher.ps1 | iex`""
})

$BtnCmd.Add_Click({
    # Hier kun je je oude CMD command plakken
    [System.Windows.MessageBox]::Show("CMD Commands button clicked!", "Guiss Command Center")
})

$BtnPrefetch.Add_Click({
    Start-Process "$env:SystemRoot\Prefetch"
})

$BtnAnyDesk.Add_Click({
    Start-Process "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" -ErrorAction SilentlyContinue
})

$window.ShowDialog() | Out-Null
