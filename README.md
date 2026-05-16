# Built Not Prompted — Power Tools

Claude Code power tools for content creators, built by [Dominic Capaci](https://skool.com/built-not-prompted).

This is the official tool library for the **Built Not Prompted** community. Add it once, and every tool I build shows up in your Claude Code with a single update command.

## Install (one time)

Open Claude Code and run these two commands:

```
/plugin marketplace add dominiccapaci/built-not-prompted-marketplace
/plugin install power-tools@built-not-prompted
```

Then reload so the tools are live:

```
/reload-plugins
```

That's it. You never have to download or move a file.

## Get new tools

Whenever I ship something new, run:

```
/plugin marketplace update built-not-prompted
/reload-plugins
```

Everything new is now installed. Same two commands every time.

## What's inside

| Tool | What it does |
| ---- | ------------ |
| `humanizer` | Strips the tells of AI-written text out of any draft. Catches inflated phrasing, em dash overuse, the rule of three, AI vocabulary, and more, then rewrites it to read like a person wrote it. |

More tools ship regularly. Check the [Power Tools classroom](https://skool.com/built-not-prompted) for a walkthrough video of each one.

## How to use a tool

Once installed, the tools are part of Claude Code. You can either:

- Just ask in plain language ("clean the AI writing out of this draft") and Claude picks the right tool, or
- Call it directly by name: `/power-tools:humanizer`

## Questions

Ask in the Built Not Prompted community. That is the fastest way to get help.
