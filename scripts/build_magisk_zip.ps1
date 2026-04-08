param(
    [Parameter(Mandatory=$true)]
    [string]$VendorRoot,
    [string]$OutDir = (Join-Path $PSScriptRoot '..\dist')
)

$VendorRoot = (Resolve-Path $VendorRoot).Path
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Template = Join-Path $RepoRoot 'template'
$Stage = Join-Path $OutDir 'stage'
$ZipPath = Join-Path $OutDir 'RK3588_Rock5B_HEVC10bit_SDR_Fix.zip'

$required = @(
    (Join-Path $VendorRoot 'lib64\libmpp.so'),
    (Join-Path $VendorRoot 'lib\libmpp.so'),
    (Join-Path $VendorRoot 'lib64\libcodec2_rk_component.so'),
    (Join-Path $VendorRoot 'lib\libcodec2_rk_component.so')
)

$missing = $required | Where-Object { -not (Test-Path $_) }
if ($missing) {
    Write-Error "Missing required files:`n$($missing -join "`n")"
    exit 1
}

if (Test-Path $Stage) { Remove-Item -Recurse -Force $Stage }
New-Item -ItemType Directory -Force $OutDir | Out-Null
Copy-Item -Recurse -Force $Template $Stage
New-Item -ItemType Directory -Force (Join-Path $Stage 'system\vendor\lib64') | Out-Null
New-Item -ItemType Directory -Force (Join-Path $Stage 'system\vendor\lib') | Out-Null
Copy-Item (Join-Path $VendorRoot 'lib64\libmpp.so') (Join-Path $Stage 'system\vendor\lib64\libmpp.so')
Copy-Item (Join-Path $VendorRoot 'lib\libmpp.so') (Join-Path $Stage 'system\vendor\lib\libmpp.so')
Copy-Item (Join-Path $VendorRoot 'lib64\libcodec2_rk_component.so') (Join-Path $Stage 'system\vendor\lib64\libcodec2_rk_component.so')
Copy-Item (Join-Path $VendorRoot 'lib\libcodec2_rk_component.so') (Join-Path $Stage 'system\vendor\lib\libcodec2_rk_component.so')
if (Test-Path $ZipPath) { Remove-Item -Force $ZipPath }
Compress-Archive -Path (Join-Path $Stage '*') -DestinationPath $ZipPath -CompressionLevel Optimal
Get-FileHash -Algorithm SHA256 $ZipPath | Format-Table Path,Hash -AutoSize
Write-Host "Built $ZipPath"
