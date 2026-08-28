# ViMusic Bug Fixes Deployment Script
# This script pushes your fixes to your GitHub account
# GitHub Username: rahil729

$username = "rahil729"
$branch = "rahil729-vimusic-task"
$repo = "ViMusic"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ViMusic Bug Fixes - GitHub Deployment" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "GitHub Username: $username" -ForegroundColor Cyan
Write-Host "Branch: $branch" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check if fork exists
Write-Host "[Step 1] Checking GitHub fork..." -ForegroundColor Yellow
Write-Host ""
Write-Host "To proceed, you need to:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Go to: https://github.com/vfsfitvnm/ViMusic"
Write-Host "2. Click the `"Fork`" button (top-right)"
Write-Host "3. GitHub will create: github.com/$username/ViMusic"
Write-Host ""

$response = Read-Host "Have you forked the repository? (yes/no)"
if ($response -ne "yes") {
    Write-Host ""
    Write-Host "Please fork first, then run this script again." -ForegroundColor Yellow
    exit
}

# Step 2: Update remote
Write-Host ""
Write-Host "[Step 2] Updating remote repository URL..." -ForegroundColor Yellow
$remoteUrl = "https://github.com/$username/$repo.git"
git remote set-url origin $remoteUrl
Write-Host "✅ Remote updated to: $remoteUrl" -ForegroundColor Green
Write-Host ""

# Step 3: Push to fork
Write-Host "[Step 3] Pushing changes to your fork..." -ForegroundColor Yellow
Write-Host "This may take a minute..." -ForegroundColor Cyan
Write-Host ""

git push origin $branch -v

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  ✅ DEPLOYMENT SUCCESSFUL!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your bug fixes are now online at:" -ForegroundColor Cyan
    $liveUrl = "https://github.com/$username/$repo/tree/$branch"
    Write-Host $liveUrl -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Visit the URL above to see your branch"
    Write-Host "2. Share the link with anyone who wants the fixes"
    Write-Host "3. They can clone it:"
    Write-Host "   git clone -b $branch $remoteUrl"
    Write-Host ""
    Write-Host "Or they can view the code, create pull requests, etc." -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  ⚠️  DEPLOYMENT FAILED" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Troubleshooting:" -ForegroundColor Yellow
    Write-Host "1. Make sure you've forked the repo first"
    Write-Host "2. Check your internet connection"
    Write-Host "3. Verify GitHub credentials"
    Write-Host ""
    exit 1
}
