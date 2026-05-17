# Maintaining this marketplace

Notes for me. Students never need this file.

## Layout

- Each tool is its own plugin under `plugins/<tool>/` and is the source of truth.
- `plugins/power-tools/` is a generated bundle of every skill tool. Its `skills/` folder is built by `sync-bundle.sh`, not edited by hand.
- MCP plugins (any plugin with a `.mcp.json`) are kept out of the bundle on purpose.

## Adding or changing a skill tool

1. Add or edit the plugin under `plugins/<tool>/`.
2. Run `./sync-bundle.sh` to rebuild the `power-tools` bundle.
3. Bump the `version` in the changed plugin's `.claude-plugin/plugin.json`, and in `plugins/power-tools/.claude-plugin/plugin.json`.
4. Validate, commit, and push.

## The pinterest plugin

`plugins/pinterest/` carries a bundled copy of the Pinterest MCP server at `server/index.mjs`. The server source lives in the separate `Pinterest-mcp` project.

To rebuild it after changing the server source:

```
npx esbuild src/index.ts --bundle --platform=node --target=node18 --format=esm \
  --outfile=<this-repo>/plugins/pinterest/server/index.mjs
```

Then bump the `pinterest` plugin version, commit, and push.

## Validate before pushing

```
claude plugin validate .
```

## Names worth remembering

- Marketplace name is `built-not-prompted` (set in `.claude-plugin/marketplace.json`).
- Plugin `source` paths must be explicit, like `./plugins/humanizer`. The `metadata.pluginRoot` shorthand fails validation.
- Students add the marketplace with `dominicapaci/built-not-prompted-marketplace` (the GitHub repo name).
