param([ValidateSet('core','android','both')][string]$Target = 'android')
$ErrorActionPreference = 'Stop'
$root = Resolve-Path (Join-Path $PSScriptRoot '..')
$stage = Join-Path $root 'dist\\kit'
if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory $stage -Force | Out-Null
$flutterCmd = (Get-Command flutter.bat -ErrorAction Stop).Source
$flutterRoot = Split-Path (Split-Path $flutterCmd -Parent) -Parent
Copy-Item $flutterRoot (Join-Path $stage 'flutter') -Recurse
Copy-Item (Join-Path $root 'docs') (Join-Path $stage 'docs') -Recurse
Copy-Item (Join-Path $root 'samples') (Join-Path $stage 'samples') -Recurse
Copy-Item (Join-Path $root 'scripts\\install.ps1') (Join-Path $stage 'install.ps1')
Set-Content (Join-Path $stage 'install.cmd') '@echo off' -Encoding ascii
Add-Content (Join-Path $stage 'install.cmd') 'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"' -Encoding ascii
if (Test-Path $env:PUB_CACHE) { Copy-Item $env:PUB_CACHE (Join-Path $stage 'pub-cache') -Recurse }
if ($Target -ne 'core') {
  if (-not $env:ANDROID_HOME) { throw 'ANDROID_HOME not set' }
  $sdkOut = Join-Path $stage 'android-sdk'
  New-Item -ItemType Directory $sdkOut -Force | Out-Null
  foreach ($folder in @('cmdline-tools','platform-tools','platforms','build-tools','licenses')) {
    $source = Join-Path $env:ANDROID_HOME $folder
    if (Test-Path $source) { Copy-Item $source $sdkOut -Recurse }
  }
}
Set-Content (Join-Path $stage 'edition.txt') $Target -Encoding utf8
$destination = Join-Path $root "dist\\Flutter-Dart-Hebrew-$Target.zip"
if (Test-Path $destination) { Remove-Item $destination -Force }
Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $destination -CompressionLevel Optimal
Write-Host "Created $destination"
