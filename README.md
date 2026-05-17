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

## Skills

Skills are lightweight. Install one and it works right away, nothing to set up.

| Skill | Install | What it does |
| ---- | ------- | ------------ |
| humanizer | `/plugin install humanizer@built-not-prompted` | Rewrites robotic, AI-sounding text so it sounds like you. |
| email-marketing | `/plugin install email-marketing@built-not-prompted` | Writes emails, newsletters, and full sequences, and helps fix open rates, deliverability, and list strategy. |
| tiktok-account-analysis | `/plugin install tiktok-account-analysis@built-not-prompted` | Scrapes any TikTok account and gives you a content report you can keep asking questions about. Tells you the scraping cost first. Uses the Apify connector. |
| linkedin-profile-scraper | `/plugin install linkedin-profile-scraper@built-not-prompted` | Scrapes a LinkedIn profile's posts and exports them as a CSV with engagement scores. Uses the Apify connector. |
| skill-creator | `/plugin install skill-creator@built-not-prompted` | Anthropic's tool for building and improving your own Claude Code skills. Apache-2.0. |
| mcp-builder | `/plugin install mcp-builder@built-not-prompted` | Anthropic's tool for building MCP servers. Apache-2.0. |

To grab every skill above in one install, use the bundle: `/plugin install power-tools@built-not-prompted`.

## MCPs

MCPs connect Claude to an outside service. They do more, and they take a little setup. The classroom walks you through it.

| MCP | Install | What it does |
| ---- | ------- | ------------ |
| pinterest | `/plugin install pinterest@built-not-prompted` | Connects your Pinterest account to Claude. Pull your numbers, write pins, and more. After installing, run `/pinterest:pinterest-setup` and Claude connects your account for you. |

## Using a tool

Once a tool is installed, just ask Claude in plain language. Say "clean up the writing in this draft" and it uses the humanizer. Nothing to memorize.

## Questions

Post in the Built Not Prompted community.
