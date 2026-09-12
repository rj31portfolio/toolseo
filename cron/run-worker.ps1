$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$phpExecutable = 'C:\xampp\php\php.exe'
Set-Location -LiteralPath $projectRoot
& $phpExecutable (Join-Path $PSScriptRoot 'run.php')
exit $LASTEXITCODE
