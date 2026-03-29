#!/bin/bash
# Claude Code Harness - Project Initializer
# Usage: ./init-project.sh <project-path>
# Copies harness templates (.vscode/tasks.json, CLAUDE.md, progress.md) into target project

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-.}"

if [ "$TARGET" = "." ]; then
    echo "Usage: ./init-project.sh <project-path>"
    echo "  Initializes harness auto-boot in the target project."
    echo ""
    echo "Example:"
    echo "  ./init-project.sh ~/projects/my-app"
    exit 1
fi

# Resolve absolute path
TARGET="$(cd "$TARGET" 2>/dev/null && pwd || echo "$TARGET")"

echo "=== Harness Project Init ==="
echo "Target: $TARGET"
echo ""

# Create .vscode directory
mkdir -p "$TARGET/.vscode"

# Copy tasks.json (auto-boot)
if [ -f "$TARGET/.vscode/tasks.json" ]; then
    echo "[!] .vscode/tasks.json already exists. Merging harness task..."
    if grep -q "claude-harness-boot" "$TARGET/.vscode/tasks.json" 2>/dev/null; then
        echo "    -> Harness boot task already present (skipping)"
    else
        echo "    -> WARNING: Please manually add harness-boot task from templates/.vscode/tasks.json"
    fi
else
    cp "$SCRIPT_DIR/.vscode/tasks.json" "$TARGET/.vscode/tasks.json"
    echo "[+] .vscode/tasks.json (auto-boot on folder open)"
fi

# Copy progress.md
if [ ! -f "$TARGET/progress.md" ]; then
    cp "$SCRIPT_DIR/templates/progress.md" "$TARGET/progress.md"
    echo "[+] progress.md (session tracking)"
else
    echo "[=] progress.md already exists (skipping)"
fi

# Copy CLAUDE.md template if none exists
if [ ! -f "$TARGET/CLAUDE.md" ]; then
    cp "$SCRIPT_DIR/templates/CLAUDE.md" "$TARGET/CLAUDE.md"
    echo "[+] CLAUDE.md (project rules template - EDIT THIS!)"
else
    # Check if harness section exists
    if grep -q "Harness Workflow" "$TARGET/CLAUDE.md" 2>/dev/null; then
        echo "[=] CLAUDE.md already has harness section (skipping)"
    else
        echo ""
        echo "[!] CLAUDE.md exists but has no harness section."
        echo "    Consider adding this to the bottom:"
        echo ""
        echo "    ## Harness Workflow"
        echo "    이 프로젝트는 하네스 워크플로우를 사용합니다:"
        echo "    1. /harness-setup — 환경 파악"
        echo "    2. /harness-plan <기능> — 계획 수립"
        echo "    3. /harness-work — 구현"
        echo "    4. /harness-review — 검증"
        echo "    5. /harness-release — 배포"
        echo ""
    fi
fi

echo ""
echo "=== Done ==="
echo ""
echo "Next steps:"
echo "  1. Edit $TARGET/CLAUDE.md with your project details"
echo "  2. Open the folder in VS Code"
echo "  3. Allow automatic tasks when prompted (one-time)"
echo "  4. Claude Code will auto-start with harness prompt!"
echo ""
echo "Tip: Ctrl+Shift+P → 'Tasks: Manage Automatic Tasks' → 'Allow'"
