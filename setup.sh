#!/bin/bash
set -e

TARGET="${1:-.}"
TEMPLATE="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Claude workflows into: $(cd "$TARGET" && pwd)"

# Copy .claude configs
mkdir -p "$TARGET/.claude/commands" "$TARGET/.claude/skills" "$TARGET/.claude/rules"

cp -r "$TEMPLATE/.claude/commands/start.md" "$TARGET/.claude/commands/"
cp -r "$TEMPLATE/.claude/skills/"* "$TARGET/.claude/skills/"
cp -r "$TEMPLATE/.claude/rules/"* "$TARGET/.claude/rules/"

echo "Commands, skills, rules installed"

# Optional: copy GitHub workflows
if [ -d "$TARGET/.github/workflows" ]; then
  cp "$TEMPLATE/.github/workflows/"*.yml "$TARGET/.github/workflows/" 2>/dev/null
  echo "GitHub workflows installed"
else
  echo "Skip GitHub workflows (no .github/workflows/ in target)"
fi

echo ""
echo "Done. Run /start to see the workflow menu."
