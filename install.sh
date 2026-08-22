#!/usr/bin/env bash
# install.sh — Cài Vibe Coding Kit vào dự án mới (macOS/Linux)
# Dùng: ./install.sh [target_dir] [project_name] [stack]
# Ví dụ: ./install.sh ../MyNewApp MyNewApp ts-react-node-postgres
set -e
KIT_ROOT="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-.}"
PROJECT_NAME="${2:-$(basename "$(realpath "$TARGET" 2>/dev/null || echo "$TARGET")")}"
STACK="${3:-}"
DRY_RUN="${DRY_RUN:-0}"

echo "=== Vibe Coding Kit Installer v1.0 ==="
echo "Kit: $KIT_ROOT"
echo "Target: $TARGET"
echo "Project: $PROJECT_NAME"
[[ "$DRY_RUN" == "1" ]] && echo "!!! DRY RUN"

ITEMS=("AGENTS.md" "CLAUDE.md" "opencode.json" "docs" ".opencode")

for item in "${ITEMS[@]}"; do
  src="$KIT_ROOT/$item"
  dst="$TARGET/$item"
  if [[ ! -e "$src" ]]; then echo "! Skip (không tìm thấy): $item"; continue; fi
  if [[ "$DRY_RUN" == "1" ]]; then
    echo "→ [DRY] Copy $item -> $dst"
  else
    mkdir -p "$(dirname "$dst")"
    cp -R "$src" "$dst"
    echo "✓ Copied $item"
  fi
done

if [[ "$DRY_RUN" != "1" ]]; then
  for f in "$TARGET/AGENTS.md" "$TARGET/CLAUDE.md" "$TARGET/docs/_meta/PROJECT_CONTEXT.md"; do
    [[ -f "$f" ]] && sed -i.bak "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$f" && rm -f "$f.bak" && echo "✓ Patched $f"
  done
  if [[ -n "$STACK" ]]; then
    echo "✓ Stack preset: $STACK (xem docs/_meta/STACK_PRESETS/$STACK.md)"
  fi
  TODAY=$(date +%Y-%m-%d)
  mkdir -p "$TARGET/docs/07_WORKLOG"
  if [[ ! -f "$TARGET/docs/07_WORKLOG/$TODAY.md" ]]; then
    cat > "$TARGET/docs/07_WORKLOG/$TODAY.md" <<EOF
# Worklog $TODAY — $PROJECT_NAME

## Đã làm
- [ ] Cài Vibe Coding Kit v1.0
- [ ] Điền docs/_meta/PROJECT_CONTEXT.md

## Tiếp theo
- Chạy /mattpocock-requirements cho feature đầu tiên
EOF
    echo "✓ Created docs/07_WORKLOG/$TODAY.md"
  fi
fi

echo "=== Xong ==="
echo "Tiếp theo: 1) Điền docs/_meta/PROJECT_CONTEXT.md  2) Đọc docs/00_WORKFLOW.md  3) /mattpocock-requirements"
