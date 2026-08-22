param(
  [string]$StateFile = "docs/workflow-state.json"
)

$ErrorActionPreference = "Stop"
$requiredStates = @("DRAFT", "APPROVED", "PLANNED", "IMPLEMENTING", "VERIFIED", "REVIEWED", "DONE")

if (-not (Test-Path $StateFile)) {
  Write-Output "WORKFLOW CHECK: no state file; create $StateFile before tracking a task."
  exit 0
}

$state = Get-Content $StateFile -Raw -Encoding utf8 | ConvertFrom-Json
if ($requiredStates -notcontains $state.state) {
  throw "Invalid workflow state: $($state.state)"
}

if ($state.state -eq "DONE") {
  foreach ($gate in @("tests", "build", "typecheck", "security", "review", "learning")) {
    if ($state.$gate -ne "pass") {
      throw "DONE requires $gate=pass"
    }
  }
}

Write-Output "WORKFLOW CHECK: $($state.task) is $($state.state)"
