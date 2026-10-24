# logs RAPL counters ("Energy Meter", pWh) to CSV until the Stop file appears
# PKG - whole CPU, PP0 - cores, PP1 - GPU
param([string]$Out, [string]$Stop, [int]$IntervalMs = 100)

$domains = 'RAPL_Package0_PKG', 'RAPL_Package0_PP0', 'RAPL_Package0_PP1'
$ctr = $domains | ForEach-Object { New-Object Diagnostics.PerformanceCounter('Energy Meter', 'Energy', $_) }

$w = New-Object IO.StreamWriter($Out)
$w.AutoFlush = $true
$w.WriteLine('unix_ms,pkg_pwh,pp0_pwh,pp1_pwh')
while (-not (Test-Path $Stop)) {
    $t = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
    $w.WriteLine("$t," + (($ctr | ForEach-Object { $_.RawValue }) -join ','))
    Start-Sleep -Milliseconds $IntervalMs
}
$w.Close()
