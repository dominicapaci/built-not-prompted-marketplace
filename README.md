# Built Not Prompted — Power Tools

Claude Code power tools for content creators, built by [Dominic Capaci](https://skool.com/built-not-prompted).

This is the official tool library for the **Built Not Prompted** community. Add it once, then pull in tools as you need them.

## Step 1 — Add the marketplace (one time)

Open Claude Code and run:

```
/plugin marketplace add dominiccapaci/built-not-prompted-marketplace
```

This just tells Claude Code where the library is. It doesn't load any tools yet.

## Step 2 — Install what you want

You have two doors.

**One tool at a time** (recommended — keeps your context clean):

```
/plugin install humanizer@built-not-prompted
```

**Or the whole bundle** in one shot:

```
/plugin install power-tools@built-not-prompted
```

Pick one path. Don't install the bundle *and* the individual tools, or you'll load duplicates.

Then reload so the tools are live:

```
/reload-plugins
```

## Keep tools scoped to the right projects

A tool only loads where you switch it on. Enable a plugin per project in that
project's `.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "humanizer@built-not-prompted": true
  }
}
```

Where a plugin isn't enabled, it costs you zero context. This is the point:
load the tools the project needs, nothing else. The Power Tools classroom has a
full walkthrough.

## Get new tools

When something new ships, run:

```
/plugin marketplace update built-not-prompted
/reload-plugins
```

## What's inside

| Tool | Install | What it does |
| ---- | ------- | ------------ |
| `humanizer` | `/plugin install humanizer@built-not-prompted` | Strips the tells of AI-written text out of any draft. Catches inflated phrasing, em dash overuse, the rule of three, AI vocabulary, and more, then rewrites it to read like a person wrote it. |
| `power-tools` | `/plugin install power-tools@built-not-prompted` | The full bundle. Every tool above in a single install. |

More tools ship regularly. Each one gets a walkthrough video in the [Power Tools classroom](https://skool.com/built-not-prompted).

## Using a tool

Once installed and enabled, either ask in plain language ("clean the AI writing
out of this draft") and Claude picks the tool, or call it directly:
`/humanizer:humanizer`.

## For maintainers

Each tool is its own plugin under `plugins/<tool>/` and is the source of truth.
The `power-tools` bundle re-packages every tool's skills so students can install
everything at once — its `skills/` folder is generated. After adding or editing
a tool, run `./sync-bundle.sh`, bump the relevant `version` fields, and commit.

## Questions

Ask in the Built Not Prompted community. That's the fastest way to get help.
