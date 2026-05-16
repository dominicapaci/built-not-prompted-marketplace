#!/usr/bin/env bash
#
# Rebuilds the "power-tools" bundle plugin from every individual tool plugin.
#
# Each tool is its own plugin under plugins/<tool>/ and is the source of truth.
# The power-tools bundle just re-packages all of their skills into one plugin so
# students can one-shot install everything. Its skills/ folder is GENERATED.
#
# Run this whenever you add or change a tool, BEFORE committing:
#   ./sync-bundle.sh
#
set -euo pipefail
cd "$(dirname "$0")"

BUNDLE="plugins/power-tools/skills"
rm -rf "$BUNDLE"
mkdir -p "$BUNDLE"

count=0
for plugin in plugins/*/; do
  name="$(basename "$plugin")"
  [ "$name" = "power-tools" ] && continue
  if [ -d "${plugin}skills" ]; then
    cp -R "${plugin}skills/." "$BUNDLE/"
    echo "  bundled: $name"
    count=$((count + 1))
  fi
done

echo ""
echo "Bundle rebuilt with $count tool(s)."
echo "Next: bump \"version\" in the plugin.json of any tool you changed,"
echo "and in plugins/power-tools/.claude-plugin/plugin.json, then commit."
