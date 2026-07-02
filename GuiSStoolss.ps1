Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml
Add-Type -AssemblyName System.IO.Compression.FileSystem

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$userDir = [Environment]::GetFolderPath("UserProfile")
$downloads = Join-Path $userDir "Downloads"
$zipPath = Join-Path $downloads "Guiss-Tools.zip"
$destPath = Join-Path $downloads "Guiss-Tools"

$toolsZipUrl = "https://github.com/Sellgui/Sellguitools/releases/latest/download/Guiss-Tools.zip"

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Guiss Launcher" Width="1320" Height="830"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent"
        Opacity="0">

    <Border x:Name="MainBorder" CornerRadius="22" BorderBrush="#1A2E24" BorderThickness="1" Background="#0A120F">
        <Border.Effect>
            <DropShadowEffect BlurRadius="40" ShadowDepth="0" Opacity="0.6"/>
        </Border.Effect>

        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="380"/>
                <ColumnDefinition Width="30"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <!-- Left - System Status -->
            <Border Grid.Column="0" Background="#0F1A16" CornerRadius="16" BorderBrush="#2A4738" BorderThickness="1" Margin="25" Padding="20">
                <StackPanel>
                    <TextBlock Text="SYSTEM STATUS" FontSize="13" Foreground="#4ADE80" FontWeight="SemiBold"/>
                    <TextBlock Text="All Systems OK" FontSize="26" FontWeight="SemiBold" Foreground="White" Margin="0,12,0,0"/>
                    <Border Background="#1A2E24" CornerRadius="10" Padding="12" Margin="0,20,0,0">
                        <TextBlock Text="Ready for use" FontSize="14" Foreground="#86EFAC"/>
                    </Border>
                </StackPanel>
            </Border>

            <!-- Right - Activity Console -->
            <Border Grid.Column="2" Background="#0F1A16" CornerRadius="16" BorderBrush="#2A4738" BorderThickness="1" Margin="25" Padding="20">
                <StackPanel>
                    <TextBlock Text="Activity Console" FontSize="15" FontWeight="SemiBold" Foreground="#4ADE80"/>
                    <TextBox x:Name="ActivityBox" Height="380" Background="#0A120F" Foreground="#86EFAC" BorderThickness="0" FontFamily="Consolas" FontSize="13" VerticalScrollBarVisibility="Auto" IsReadOnly="True" Margin="0,12,0,0" Padding="12"/>
                </StackPanel>
            </Border>

            <!-- Bottom Button -->
            <Border Grid.ColumnSpan="3" Background="#0F1A16" CornerRadius="16" BorderBrush="#2A4738" BorderThickness="1" Margin="25,0,25,25" Padding="20" VerticalAlignment="Bottom">
                <Button x:Name="OpenFolderButton" Content="Open Install Folder" Background="#166534" Foreground="White" FontSize="16" FontWeight="SemiBold" Height="58" CornerRadius="12"/>
            </Border>
        </Grid>
    </Border>
</Window>
"@

try {
    $reader = New-Object System.Xml.XmlNodeReader $xaml
    $window = [Windows.Markup.XamlReader]::Load($reader)

    $window.Opacity = 1
    $ActivityBox = $window.FindName("ActivityBox")
    $OpenFolderButton = $window.FindName("OpenFolderButton")

    $window.Add_MouseLeftButtonDown({ $window.DragMove() })

    $OpenFolderButton.Add_Click({
        if (Test-Path $destPath) {
            Start-Process $destPath
        } else {
            $ActivityBox.AppendText("`n[Error] Install folder not found.`n")
        }
    })

    $window.ShowDialog() | Out-Null

} catch {
    Write-Host "Fout: $($_.Exception.Message)" -ForegroundColor Red
    Read-Host
}
