#!/bin/bash
# Claude Code Harness - Installer
# Usage: ./install.sh

set -e

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Claude Code Harness Installer ==="
echo ""

# Check Claude Code directory exists
if [ ! -d "$CLAUDE_DIR" ]; then
    echo "ERROR: ~/.claude directory not found. Is Claude Code installed?"
    exit 1
fi

# Create directories if needed
mkdir -p "$CLAUDE_DIR/rules"
mkdir -p "$CLAUDE_DIR/commands"

# Copy rules
echo "[1/3] Installing rules..."
cp "$SCRIPT_DIR/rules/harness.md" "$CLAUDE_DIR/rules/harness.md"
echo "  -> ~/.claude/rules/harness.md"

# Copy commands
echo "[2/3] Installing commands..."
for cmd in harness-setup harness-plan harness-work harness-review harness-release; do
    cp "$SCRIPT_DIR/commands/${cmd}.md" "$CLAUDE_DIR/commands/${cmd}.md"
    echo "  -> ~/.claude/commands/${cmd}.md"
done

# Add safety hooks to settings.json
echo "[3/3] Configuring safety hooks..."
SETTINGS="$CLAUDE_DIR/settings.json"

if [ -f "$SETTINGS" ]; then
    # Check if hooks already exist
    if grep -q "harness safety hook" "$SETTINGS" 2>/dev/null; then
        echo "  -> Safety hooks already configured (skipping)"
    else
        echo "  -> WARNING: Please manually add hooks to $SETTINGS"
        echo "     See README.md for hook configuration details"
    fi
else
    echo "  -> WARNING: settings.json not found. Please create it manually."
fi

# Install shared harness prompt
echo "[4/5] Installing shared harness prompt..."
HARNESS_DIR="$HOME/.claude-harness"
mkdir -p "$HARNESS_DIR"
cp "$SCRIPT_DIR/templates/harness-prompt.txt" "$HARNESS_DIR/prompt.txt"
echo "  -> ~/.claude-harness/prompt.txt"

# Copy project initializer
echo "[5/5] Installing project initializer..."
cp "$SCRIPT_DIR/init-project.sh" "$HARNESS_DIR/init-project.sh"
chmod +x "$HARNESS_DIR/init-project.sh" 2>/dev/null || true
cp -r "$SCRIPT_DIR/.vscode" "$HARNESS_DIR/.vscode-template"
cp -r "$SCRIPT_DIR/templates" "$HARNESS_DIR/templates"
echo "  -> ~/.claude-harness/init-project.sh"
echo "  -> ~/.claude-harness/templates/"

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Available commands:"
echo "  /harness-setup    - Initialize project environment"
echo "  /harness-plan     - Create implementation plan"
echo "  /harness-work     - Implement approved plan"
echo "  /harness-review   - Multi-perspective code review"
echo "  /harness-release  - Commit and release"
echo ""
echo "Auto-boot setup:"
echo "  To add harness auto-boot to any project:"
echo "    ~/.claude-harness/init-project.sh <project-path>"
echo ""
echo "  Then in VS Code:"
echo "    Ctrl+Shift+P -> 'Tasks: Manage Automatic Tasks' -> 'Allow'"
echo ""
echo "Start with: /harness-setup"
