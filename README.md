# Built Not Prompted: Power Tools

The tools I build for the Built Not Prompted community live here. They plug into Claude Code and do real work for you, like cleaning up your writing or pulling your social numbers. New ones get added over time.

The Power Tools classroom walks through all of this on video. This page is just the quick reference.

## Connect the toolbox (one time)

In Claude Code, type:

```
/plugin marketplace add dominicapaci/built-not-prompted-marketplace
```

That connects your Claude Code to the toolbox. You do this once.

## Install a tool

Pick a tool from the list and type its install line, like:

```
/plugin install humanizer@built-not-prompted
```

then `/reload-plugins`.

When you install, Claude Code asks where to keep the tool. Pick the project you're working in rather than "everywhere," so Claude stays focused.

To grab everything at once, install the bundle: `/plugin install power-tools@built-not-prompted`.

## Get new tools later

When something new is added, type `/plugin marketplace update built-not-prompted`, then `/reload-plugins`. You're current.

## The tools

| Tool | Install | What it does |
| ---- | ------- | ------------ |
| humanizer | `/plugin install humanizer@built-not-prompted` | Rewrites robotic, AI-sounding text so it sounds like you. |
| pinterest | `/plugin install pinterest@built-not-prompted` | Connects your Pinterest account to Claude. Pull your numbers, write pins, and more. Has a short setup, covered in the classroom. |
| power-tools | `/plugin install power-tools@built-not-prompted` | Every skill tool in one install. |

## Using a tool

Once a tool is installed, just ask Claude in plain language. Say "clean up the writing in this draft" and it uses the humanizer. Nothing to memorize.

## Questions

Post in the Built Not Prompted community.
