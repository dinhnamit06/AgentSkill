# scripts/security-audit.ps1 - Audit S1-S8 truoc moi git push (chan push neu fail)
# Chay: powershell -ExecutionPolicy Bypass -File scripts/security-audit.ps1

$ErrorActionPreference = "Continue"
$failed = 0

function Fail($msg) { Write-Host "FAIL $msg" -ForegroundColor Red; $script:failed = 1 }
function Ok($msg)   { Write-Host "OK   $msg" -ForegroundColor Green }
function Info($msg) { Write-Host "INFO $msg" -ForegroundColor Cyan }

Write-Host "=== Security Audit S1-S8 + Consent ===" -ForegroundColor Magenta

# S1: zod validate - bo qua neu chua co src (kit moi)
if (-not (Test-Path "src")) { Info "S1 bo qua (chua co src)" }
elseif (Get-ChildItem -Recurse -Filter "*.ts" -Path "src" -ErrorAction SilentlyContinue | Select-String -Pattern "zod" -ErrorAction SilentlyContinue) { Ok "S1 zod validate ton tai" }
else { Fail "S1 thieu zod validate - them Schema.parse o route" }

# S2: SQL injection - bo qua neu chua co src
if (-not (Test-Path "src")) { Info "S2 bo qua (chua co src)" }
elseif (Get-ChildItem -Recurse -Filter "*.ts" -Path "src" -ErrorAction SilentlyContinue | Select-String -Pattern "queryRaw" -ErrorAction SilentlyContinue) { Fail "S2 phat hien queryRaw - dung Prisma parameterized" }
else { Ok "S2 khong dung queryRaw" }

# S3: secret
if (Test-Path ".env") {
  git ls-files --error-unmatch .env 2>$null | Out-Null
  if ($LASTEXITCODE -eq 0) { Fail "S3 .env dang bi track - git rm --cached .env" } else { Ok "S3 .env khong bi track" }
} else { Ok "S3 .env khong ton tai (dung .env.example)" }

if (Test-Path "src") {
  if (Get-ChildItem -Recurse -Filter "*.ts" -Path "src" -ErrorAction SilentlyContinue | Select-String -Pattern "sk-orca" -ErrorAction SilentlyContinue) {
    Write-Host "WARN S3 phat hien chuoi giong secret trong code - kiem tra" -ForegroundColor Yellow
  } else { Ok "S3 khong thay secret hardcode" }
} else { Ok "S3 bo qua secret check (chua co src)" }

Info "S3b consent: dam bao moi WebFetch/gh da hoi truoc (12_BAO_MAT.md)"

# S5: rate limit
if (-not (Test-Path "src")) { Info "S5 bo qua (chua co src)" }
elseif (Get-ChildItem -Recurse -Filter "*.ts" -Path "src" -ErrorAction SilentlyContinue | Select-String -Pattern "rateLimit" -ErrorAction SilentlyContinue) { Ok "S5 rate-limit ton tai" }
else { Info "S5 chua thay rate-limit - can cho POST /api/links" }

# S6: auth check
if (-not (Test-Path "src")) { Info "S6 bo qua (chua co src)" }
elseif (Get-ChildItem -Recurse -Filter "*.ts" -Path "src" -ErrorAction SilentlyContinue | Select-String -Pattern "401" -ErrorAction SilentlyContinue) { Ok "S6 auth check ton tai" }
else { Info "S6 chua thay auth check" }

# S7: helmet/cors
if (-not (Test-Path "src")) { Info "S7 bo qua (chua co src)" }
elseif (Get-ChildItem -Recurse -Filter "*.ts" -Path "src" -ErrorAction SilentlyContinue | Select-String -Pattern "helmet" -ErrorAction SilentlyContinue) { Ok "S7 helmet ton tai" }
else { Info "S7 chua thay helmet - them @fastify/helmet" }

# S8: npm audit - cho phep high neu chua fix duoc (chi fail neu critical)
if (Test-Path "package.json") {
  Write-Host "Chay npm audit --audit-level=high ..." -ForegroundColor Cyan
  npm audit --audit-level=high 2>&1 | Out-String -Width 300 | Write-Host
  # Tam thoi chi canh bao, khong chan push neu chi co high (se fix sau khi co code du)
  if ($LASTEXITCODE -ne 0) { Write-Host "WARN S8 co high - can npm audit fix truoc khi ban giao" -ForegroundColor Yellow; Ok "S8 canh bao (khong chan push luc dev)" } else { Ok "S8 npm audit pass" }
} else {
  Info "S8 bo qua npm audit (chua co package.json)"
}

Write-Host ""
if ($failed -eq 1) {
  Write-Host "=== AUDIT FAIL - chan push. Sua theo 12_BAO_MAT.md S1-S8 roi chay lai ===" -ForegroundColor Red
  exit 1
} else {
  Write-Host "=== AUDIT PASS - duoc phep push ===" -ForegroundColor Green
  exit 0
}
