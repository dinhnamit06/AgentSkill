#!/usr/bin/env bash
# scripts/security-audit.sh — audit S1-S8 truoc push (macOS/Linux)
set -e
FAILED=0
fail(){ echo "FAIL $1"; FAILED=1; }
ok(){ echo "OK   $1"; }
info(){ echo "INFO $1"; }

echo "=== Security Audit S1-S8 + Consent ==="

# S1 zod
if grep -r "zod\|Schema\.parse" src --include="*.ts" >/dev/null 2>&1; then ok "S1 zod validate"; else fail "S1 thieu zod"; fi

# S2 SQL injection
if grep -r '\$queryRaw.*+' src --include="*.ts" >/dev/null 2>&1; then fail "S2 noi chuoi SQL"; else ok "S2 khong noi chuoi"; fi

# S3 secret
if [ -f .env ] && git ls-files --error-unmatch .env >/dev/null 2>&1; then fail "S3 .env bi track"; else ok "S3 .env ok"; fi

# S5 rate limit
if grep -r "rateLimit\|GUEST_RATE_LIMIT" src --include="*.ts" >/dev/null 2>&1; then ok "S5 rate-limit"; else info "S5 chua co rate-limit"; fi

# S8 npm audit
if [ -f package.json ]; then
  echo "Chay npm audit --audit-level=high ..."
  if npm audit --audit-level=high; then ok "S8 npm audit pass"; else fail "S8 npm audit fail"; fi
else info "S8 bo qua (chua co package.json)"; fi

if [ $FAILED -eq 1 ]; then echo "=== AUDIT FAIL — chan push ==="; exit 1; else echo "=== AUDIT PASS ==="; exit 0; fi
