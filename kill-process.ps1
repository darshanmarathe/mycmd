param(
    [Parameter(Mandatory=$true)]
    [int]$Port
)

Write-Host "Searching for processes using port $Port..." -ForegroundColor Cyan

# Get all connections on the specified port
$connections = netstat -ano | Select-String ":$Port\s"

if (-not $connections) {
    Write-Host "No processes found using port $Port" -ForegroundColor Yellow
    exit 0
}

# Extract unique PIDs
$pids = $connections | ForEach-Object {
    if ($_ -match '\s+(\d+)\s*$') {
        $matches[1]
    }
} | Where-Object { $_ -ne '0' } | Select-Object -Unique

if (-not $pids) {
    Write-Host "No active processes found using port $Port" -ForegroundColor Yellow
    exit 0
}

Write-Host "`nFound processes:" -ForegroundColor Green
foreach ($pid in $pids) {
    $process = Get-Process -Id $pid -ErrorAction SilentlyContinue
    if ($process) {
        Write-Host "  PID: $pid - $($process.ProcessName)" -ForegroundColor White
    }
}

# Kill the processes
Write-Host "`nTerminating processes..." -ForegroundColor Red
foreach ($pid in $pids) {
    try {
        Stop-Process -Id $pid -Force -ErrorAction Stop
        Write-Host "  Killed PID: $pid" -ForegroundColor Green
    } catch {
        Write-Host "  Failed to kill PID: $pid - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nDone!" -ForegroundColor Cyan
