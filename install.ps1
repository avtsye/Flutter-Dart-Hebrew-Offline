# Portable installation: run from the extracted kit root.
param([switch]$NoPath)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$flutter = Join-Path $root 'flutter\bin'
if (-not (Test-Path (Join-Path $flutter 'flutter.bat'))) {
  throw 'flutter\bin\flutter.bat was not found. Extract the complete archive before installing.'
}
if (-not $NoPath) {
  $existing = [Environment]::GetEnvironmentVariable('Path','User')
  $parts = @($existing -split ';' | Where-Object { $_ })
  if ($parts -notcontains $flutter) {
    [Environment]::SetEnvironmentVariable('Path', (($parts + $flutter) -join ';'), 'User')
  }
  if (($env:Path -split ';') -notcontains $flutter) { $env:Path += ';' + $flutter }
}
Write-Host 'Flutter and Dart are ready in:' $root
& (Join-Path $flutter 'flutter.bat') --version
Write-Host 'Open a NEW terminal after PATH was updated. Read docs\index.html for next steps.'
Write-Host 'Android/Windows compilation needs separately installed native build tools.'
