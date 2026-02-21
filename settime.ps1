try {
    Write-Host "Trying Method 3: Windows Time Service..." -ForegroundColor Cyan
    # Force Windows Time Service to sync
    w32tm /resync /force
    Start-Sleep -Seconds 3
    
    # Check if sync was successful by comparing with a reasonable time range
    $currentDate = Get-Date
    if ($currentDate.Year -ge 2024) {
        Write-Host "✅ SUCCESS: Time synced via Windows Time Service: $currentDate" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Method 3 failed: $($_.Exception.Message)" -ForegroundColor Red
}

try {
    Write-Host "Trying Method 2: timeapi.io..." -ForegroundColor Cyan
    $webTime = Invoke-RestMethod -Uri "https://timeapi.io/api/Time/current/zone?timeZone=Asia/Kolkata" -TimeoutSec 10
    if ($webTime -and $webTime.dateTime) {
        $currentTime = [DateTime]::Parse($webTime.dateTime)
        Set-Date $currentTime
        Write-Host "✅ SUCCESS: Time updated to IST: $(Get-Date)" -ForegroundColor Green
        exit 0
    }
} catch {
    Write-Host "❌ Method 2 failed: $($_.Exception.Message)" -ForegroundColor Red
}

try {
    Write-Host "Trying Method 1: worldtimeapi.org (HTTPS)..." -ForegroundColor Cyan
    $webTime = Invoke-RestMethod -Uri "https://worldtimeapi.org/api/timezone/Asia/Kolkata" -TimeoutSec 10
    if ($webTime -and $webTime.datetime) {
        $currentTime = [DateTime]::Parse($webTime.datetime)
        Set-Date $currentTime
        Write-Host "✅ SUCCESS: Time updated to IST: $(Get-Date)" -ForegroundColor Green
        exit 0
    }
} catch {
    Write-Host "❌ Method 1 failed: $($_.Exception.Message)" -ForegroundColor Red
}

try {
    Write-Host "Trying Method 4: worldtimeapi.org with TLS fix..." -ForegroundColor Cyan
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    $webTime = Invoke-WebRequest -Uri "https://worldtimeapi.org/api/timezone/Asia/Kolkata" -UseBasicParsing -TimeoutSec 10
    $jsonData = $webTime.Content | ConvertFrom-Json
    if ($jsonData -and $jsonData.datetime) {
        $currentTime = [DateTime]::Parse($jsonData.datetime)
        Set-Date $currentTime
        Write-Host "✅ SUCCESS: Time updated to IST: $(Get-Date)" -ForegroundColor Green
        exit 0
    }
} catch {
    Write-Host "❌ Method 4 failed: $($_.Exception.Message)" -ForegroundColor Red
}
