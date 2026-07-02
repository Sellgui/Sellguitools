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

    <Window.Resources>
        <Style x:Key="MainButtonStyle" TargetType="Button">
            <Setter Property="Background" Value="#166534"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontSize" Value="15"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Height" Value="52"/>
            <Setter Property="Margin" Value="0,8,0,0"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="Border" CornerRadius="12" Background="{TemplateBinding Background}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="Border" Property="Background" Value="#4ADE80"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Border x:Name="MainBorder" CornerRadius="24" BorderBrush="#1A2E24" BorderThickness="1" Background="#0A120F">
        <Border.Effect>
            <DropShadowEffect BlurRadius="50" ShadowDepth="0" Opacity="0.7" Color="#4ADE80"/>
        </Border.Effect>

        <Grid>
            <Canvas Panel.ZIndex="-1">
                <Ellipse Width="520" Height="520" Fill="#052E16" Opacity="0.22" Canvas.Left="-140" Canvas.Top="-100" x:Name="Circle1"/>
                <Ellipse Width="380" Height="380" Fill="#166534" Opacity="0.18" Canvas.Right="-80" Canvas.Bottom="40" x:Name="Circle2"/>
                <Ellipse Width="240" Height="240" Fill="#4ADE80" Opacity="0.15" Canvas.Left="280" Canvas.Top="160" x:Name="Circle3"/>
                <Ellipse Width="680" Height="680" Fill="#0F2A1F" Opacity="0.12" Canvas.Right="-220" Canvas.Top="-180" x:Name="Circle4"/>
                <Ellipse Width="150" Height="150" Fill="#86EFAC" Opacity="0.25" Canvas.Left="920" Canvas.Top="380" x:Name="Circle5"/>
            </Canvas>

            <Grid Margin="30">
                <Grid.RowDefinitions>
                    <RowDefinition Height="70"/>
                    <RowDefinition Height="*"/>
                    <RowDefinition Height="Auto"/>
                </Grid.RowDefinitions>

                <!-- Header -->
                <Grid>
                    <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                        <Border Width="52" Height="52" CornerRadius="14" Background="#0F1A16" BorderBrush="#4ADE80" BorderThickness="3" x:Name="LogoBorder">
                            <Border.Effect>
                                <DropShadowEffect x:Name="LogoGlow" Color="#4ADE80" BlurRadius="30" ShadowDepth="0" Opacity="0.95"/>
                            </Border.Effect>
                            <TextBlock Text="G" FontSize="32" FontWeight="Bold" Foreground="#4ADE80" HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <StackPanel Margin="18,0,0,0" VerticalAlignment="Center">
                            <TextBlock Text="Guiss Launcher" FontSize="24" FontWeight="SemiBold" Foreground="White"/>
                            <TextBlock Text="Guiss Tools" FontSize="13" Foreground="#7E92A6"/>
                        </StackPanel>
                    </StackPanel>

                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
                        <Button x:Name="MinButton" Content="—" Width="44" Height="36" Background="Transparent" Foreground="#A0B8C8" BorderThickness="0" FontSize="22"/>
                        <Button x:Name="CloseButton" Content="✕" Width="44" Height="36" Background="Transparent" Foreground="#FF6B6B" BorderThickness="0" FontSize="18" Margin="8,0,0,0"/>
                    </StackPanel>
                </Grid>

                <Grid Grid.Row="1">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="420"/>
                        <ColumnDefinition Width="30"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>

                    <!-- Left Panel -->
                    <Border Background="#0F1A16" CornerRadius="18" BorderBrush="#2A4738" BorderThickness="1" Padding="20">
                        <StackPanel>
                            <TextBlock Text="SYSTEM STATUS" FontSize="13" Foreground="#4ADE80" FontWeight="SemiBold"/>
                            <TextBlock Text="All Systems OK" FontSize="22" FontWeight="SemiBold" Foreground="White" Margin="0,8,0,0"/>
                            <Border Background="#1A2E24" CornerRadius="10" Padding="12" Margin="0,20,0,0">
                                <TextBlock Text="Ready for use" FontSize="14" Foreground="#86EFAC"/>
                            </Border>
                        </StackPanel>
                    </Border>

                    <!-- Activity Console -->
                    <Border Grid.Column="2" Background="#0F1A16" CornerRadius="18" BorderBrush="#2A4738" BorderThickness="1" Padding="20">
                        <StackPanel>
                            <TextBlock Text="Activity Console" FontSize="15" FontWeight="SemiBold" Foreground="#4ADE80"/>
                            <TextBox x:Name="ActivityBox" Height="420" Background="#0A120F" Foreground="#86EFAC" BorderThickness="0" FontFamily="Consolas" FontSize="13" VerticalScrollBarVisibility="Auto" IsReadOnly="True" Margin="0,12,0,0" Padding="12"/>
                        </StackPanel>
                    </Border>
                </Grid>

                <!-- Control Panel -->
                <Border Grid.Row="2" Background="#0F1A16" CornerRadius="18" BorderBrush="#2A4738" BorderThickness="1" Padding="20" Margin="0,20,0,0">
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="*"/>
                        </Grid.ColumnDefinitions>
                        <Button x:Name="InstallButton" Content="Install / Update Tools" Style="{StaticResource MainButtonStyle}" Margin="0,0,10,0"/>
                        <Button x:Name="RemoveButton" Content="Remove Installed Tools" Style="{StaticResource MainButtonStyle}" Background="#7F1D1D" Margin="10,0,10,0"/>
                        <Button x:Name="OpenFolderButton" Content="Open Install Folder" Style="{StaticResource MainButtonStyle}" Margin="10,0,0,0"/>
                    </Grid>
                </Border>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

try {
    $reader = New-Object System.Xml.XmlNodeReader $xaml
    $window = [Windows.Markup.XamlReader]::Load($reader)

    $window.Opacity = 1

    $LogoBorder = $window.FindName("LogoBorder")
    $ActivityBox = $window.FindName("ActivityBox")
    $CloseButton = $window.FindName("CloseButton")
    $MinButton = $window.FindName("MinButton")
    $InstallButton = $window.FindName("InstallButton")
    $RemoveButton = $window.FindName("RemoveButton")
    $OpenFolderButton = $window.FindName("OpenFolderButton")

    $MainBorder = $window.FindName("MainBorder")

    $MainBorder.Add_MouseLeftButtonDown({ $window.DragMove() })
    $MinButton.Add_Click({ $window.WindowState = "Minimized" })

    $CloseButton.Add_Click({
        $fadeOut = New-Object System.Windows.Media.Animation.DoubleAnimation
        $fadeOut.From = 1; $fadeOut.To = 0; $fadeOut.Duration = [TimeSpan]::FromMilliseconds(250)
        $window.BeginAnimation([System.Windows.Window]::OpacityProperty, $fadeOut)
        Start-Sleep -Milliseconds 280
        $window.Close()
    })

    # Groene glow pulse op logo
    $glowAnim = New-Object System.Windows.Media.Animation.DoubleAnimation
    $glowAnim.From = 20; $glowAnim.To = 40; $glowAnim.Duration = [TimeSpan]::FromMilliseconds(1600)
    $glowAnim.AutoReverse = $true
    $glowAnim.RepeatBehavior = "Forever"
    $LogoBorder.Effect.BeginAnimation([System.Windows.Media.Effects.DropShadowEffect]::BlurRadiusProperty, $glowAnim)

    # Fade-in venster
    $fadeIn = New-Object System.Windows.Media.Animation.DoubleAnimation
    $fadeIn.From = 0; $fadeIn.To = 1; $fadeIn.Duration = [TimeSpan]::FromMilliseconds(700)
    $window.BeginAnimation([System.Windows.Window]::OpacityProperty, $fadeIn)

    # Install / Update Tools
    $InstallButton.Add_Click({
        $ActivityBox.AppendText("[Install] Installatie gestart...`n")
        try {
            if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
            $ActivityBox.AppendText("[Install] Downloaden van GitHub...`n")
            Invoke-WebRequest -Uri $toolsZipUrl -OutFile $zipPath
            $ActivityBox.AppendText("[Install] Download completed.`n")
            if (Test-Path $destPath) { Remove-Item $destPath -Recurse -Force }
            $ActivityBox.AppendText("[Install] Extracting files...`n")
            Expand-Archive -Path $zipPath -DestinationPath $destPath -Force
            $ActivityBox.AppendText("[Install] Extraction successful!`n")
            $ActivityBox.AppendText("[Install] Tools installed in: $destPath`n")
            Start-Process $destPath
        } catch {
            $ActivityBox.AppendText("[Error] Something went wrong: $($_.Exception.Message)`n")
        }
    })

    # Remove Tools
    $RemoveButton.Add_Click({
        if (Test-Path $destPath) {
            Remove-Item $destPath -Recurse -Force
            $ActivityBox.AppendText("`n[Remove] Tools removed successfully.`n")
        } else {
            $ActivityBox.AppendText("`n[Remove] No tools found.`n")
        }
    })

    # Open Folder
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
