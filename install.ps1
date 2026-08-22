# install.ps1 - Cai Vibe Coding Kit vao du an moi (PowerShell 5.1+)
# Usage: .\install.ps1 -Target "C:\path\to\NewProject" [-ProjectName "MyApp"] [-Stack ts-react-node-postgres]
# Or run in-place: .\install.ps1
# Dry run: .\install.ps1 -DryRun

param(
  [string]$Target = ".",
  [string]$ProjectName = "",
  [string]$Stack = "",
  [switch]$DryRun,
  [switch]$Lean
)

$ErrorActionPreference = "Stop"
$KitRoot = $PSScriptRoot

function Write-Step($msg) { Write-Host "-> $msg" -ForegroundColor Cyan }
function Write-Ok($msg)   { Write-Host "OK $msg" -ForegroundColor Green }
function Write-Warn($msg) { Write-Host "!! $msg" -ForegroundColor Yellow }

if (-not $ProjectName) {
  $resolved = Resolve-Path $Target -ErrorAction SilentlyContinue
  if ($resolved) { $ProjectName = Split-Path -Leaf $resolved.Path } else { $ProjectName = Split-Path -Leaf $Target }
  if (-not $ProjectName -or $ProjectName -eq "." ) { $ProjectName = "MyProject" }
}

Write-Host ""
Write-Host "=== Vibe Coding Kit Installer v1.0 ===" -ForegroundColor Magenta
Write-Host "Kit: $KitRoot"
Write-Host "Target: $Target"
Write-Host "Project: $ProjectName"
if ($Lean) { Write-Host "Mode: LEAN (8 files) - daily vibe, under 500 lines" -ForegroundColor Yellow } else { Write-Host "Mode: FULL (28 files) - hoc + ban giao" }
if ($DryRun) { Write-Warn "DRY RUN - preview only, no files written" }

# IDE universal — luon copy de moi IDE deu doc dung
$IdeItems = @(".cursorrules",".windsurfrules",".cursor",".github")
$ItemsToCopy = @("AGENTS.md","CLAUDE.md","opencode.json","docs",".opencode","mcp-server",".cursorrules",".windsurfrules",".github",".cursor",".env.example",".gitignore",".gitmessage")
if ($Lean) {
  # Lean: chi copy 8 files core — AI <500 lines, doc nhanh
  $ItemsToCopy = @("AGENTS.md","CLAUDE.md","opencode.json",".opencode","mcp-server",".cursorrules",".windsurfrules",".github",".cursor")
}

foreach ($item in $ItemsToCopy) {
  $src = Join-Path $KitRoot $item
  $dst = Join-Path $Target $item
  if (-not (Test-Path -LiteralPath $src)) { Write-Warn "Skip (not found): $item"; continue }
  if ($DryRun) {
    Write-Step "[DRY] Copy $item -> $dst"
  } else {
    if (Test-Path -LiteralPath $dst) { Write-Warn "Exists, will overwrite: $dst" }
    $parent = Split-Path $dst -Parent
    if ($parent -and -not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    Copy-Item -Recurse -Force -LiteralPath $src -Destination $dst
    Write-Ok "Copied $item"
  }
}

if (-not $DryRun) {
  $filesToPatch = @(
    (Join-Path $Target "AGENTS.md"),
    (Join-Path $Target "CLAUDE.md"),
    (Join-Path $Target "docs\_meta\PROJECT_CONTEXT.md")
  )
  foreach ($f in $filesToPatch) {
    if (Test-Path -LiteralPath $f) {
      $content = Get-Content -LiteralPath $f -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
      if ($content -and $content.Contains("{{PROJECT_NAME}}")) {
        $content = $content.Replace("{{PROJECT_NAME}}", $ProjectName)
        Set-Content -LiteralPath $f -Value $content -Encoding UTF8
        Write-Ok "Patched {{PROJECT_NAME}} -> $ProjectName in $(Split-Path $f -Leaf)"
      }
    }
  }
  if ($Stack) {
    $preset = Join-Path $KitRoot "docs\_meta\STACK_PRESETS\$Stack.md"
    if (-not $preset.EndsWith(".md")) { $preset += ".md" }
    if (Test-Path -LiteralPath $preset) {
      Write-Ok "Stack preset: $Stack (see docs/_meta/STACK_PRESETS/$Stack.md)"
    } else {
      Write-Warn "Preset not found: $preset"
    }
  }
  # Cai pre-push hook bao mat
  try { & git config core.hooksPath .githooks 2>$null | Out-Null } catch {}
  $today = Get-Date -Format "yyyy-MM-dd"
  $worklogPath = Join-Path $Target "docs\07_WORKLOG\$today.md"
  if (-not (Test-Path -LiteralPath $worklogPath)) {
    $dir = Split-Path $worklogPath -Parent
    if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    $worklogContent = "# Worklog $today - $ProjectName`r`n`r`n## Da lam`r`n- [ ] Cai Vibe Coding Kit v1.0`r`n- [ ] Dien docs/_meta/PROJECT_CONTEXT.md`r`n- [ ] Chon stack trong docs/01_TECH_STACK.md`r`n`r`n## Hoc duoc`r`n-`r`n`r`n## Quyet dinh`r`n-`r`n`r`n## Tiep theo`r`n- Chay /mattpocock-requirements cho feature dau tien`r`n"
    Set-Content -LiteralPath $worklogPath -Value $worklogContent -Encoding UTF8
    Write-Ok "Created $worklogPath"
  }
}

Write-Host ""
Write-Host "=== Done ===" -ForegroundColor Green
Write-Host "Next:"
Write-Host "  1. Dien docs/_meta/PROJECT_CONTEXT.md (bat buoc)"
Write-Host "  2. Doc docs/00_WORKFLOW.md"
Write-Host "  3. Chay skill /mattpocock-requirements cho feature dau tien"
if ($DryRun) { Write-Host "  (DryRun - run again without -DryRun to install)" -ForegroundColor Yellow }
