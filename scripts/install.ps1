$ErrorActionPreference = 'Stop'
$source = Split-Path -Parent $MyInvocation.MyCommand.Path
$edition = (Get-Content (Join-Path $source 'edition.txt') -Raw).Trim()
$default = Join-Path $env:LOCALAPPDATA 'FlutterDartHebrew'
Write-Host "Flutter Dart Hebrew Offline - $edition"
$target = Read-Host "Installation directory (Enter for $default)"
if ([string]::IsNullOrWhiteSpace($target)) { $target = $default }
$target = [IO.Path]::GetFullPath($target.Trim('"'))
if ($target.StartsWith($source + [IO.Path]::DirectorySeparatorChar,[StringComparison]::OrdinalIgnoreCase) -or $target -eq $source) {
  throw 'Select a folder outside the extracted kit'
}
New-Item -ItemType Directory $target -Force | Out-Null
foreach ($item in Get-ChildItem -LiteralPath $source) {
  if ($item.Name -eq 'install.ps1' -or $item.Name -eq 'install.cmd') { continue }
  Copy-Item $item.FullName -Destination $target -Recurse -Force
}
$paths = @((Join-Path $target 'flutter\\bin'))
if (Test-Path (Join-Path $target 'android-sdk')) {
  $paths += (Join-Path $target 'android-sdk\\platform-tools')
  [Environment]::SetEnvironmentVariable('ANDROID_HOME',(Join-Path $target 'android-sdk'),'User')
  [Environment]::SetEnvironmentVariable('ANDROID_SDK_ROOT',(Join-Path $target 'android-sdk'),'User')
}
if (Test-Path (Join-Path $target 'pub-cache')) {
  [Environment]::SetEnvironmentVariable('PUB_CACHE',(Join-Path $target 'pub-cache'),'User')
}
$old = [Environment]::GetEnvironmentVariable('Path','User')
$existing = @($old -split ';' | Where-Object { $_ })
$combined = @($existing)
foreach ($p in $paths) { if ($p -notin $combined) { $combined += $p } }
[Environment]::SetEnvironmentVariable('Path',($combined -join ';'),'User')
Write-Host "Files copied to $target; open a new terminal and run flutter doctor -v."
Write-Host "Local Hebrew guide: $target\\docs\\index.html"
Read-Host 'Press Enter to finish' | Out-Null
