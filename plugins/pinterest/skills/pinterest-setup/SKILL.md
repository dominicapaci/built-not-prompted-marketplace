---
name: pinterest-setup
description: Guided setup for the Pinterest MCP connection. Walks the user through creating a Pinterest API token and saves it so the Pinterest tools work. Use when the user has installed the Pinterest plugin and needs to connect it, when the Pinterest tools are not working, or when the user asks how to set up or authenticate Pinterest.
---

# Pinterest connection setup

You are walking a content creator, who may not be technical, through connecting the Pinterest MCP server. They have installed the `pinterest` plugin. Your job is to help them get a Pinterest API token and save it so the server can use it.

Be warm, plain-spoken, and patient. Do the technical parts for them. Never make them open or edit a file themselves. Move one step at a time and wait for them before moving on.

## Before you start

Check two things, briefly:

1. Node.js is installed. Run `node --version`. If that fails, stop here and tell them to install Node from https://nodejs.org (the version labeled "LTS"), then come back and run this again.
2. They have a Pinterest account they want to connect.

## Step 1: Get a Pinterest access token

The token is how Pinterest confirms it is really them. Walk them through it one step at a time:

1. Go to https://developers.pinterest.com/apps/ and log in with their Pinterest account.
2. Create an app. Look for a "Create app" or "Connect app" button. Any name works, such as "My Claude Tools".
3. Open the app, find the access token section, and generate an access token.
4. When asked for scopes (permissions), they should pick the ones that match what they want to do. For reading their pins, boards, and analytics, the `read` scopes are enough. For creating pins or managing ads and catalogs, they also need the matching `write` scopes. If they are unsure, selecting all available scopes is fine for personal use.
5. The token they receive starts with `pina_`. Have them copy it.

Pinterest changes this portal from time to time. If what they see does not match these steps, adapt and help them find the equivalent. Note that full ads and catalog write access requires Pinterest "Standard Access", which is a separate approval. A standard generated token still works for reading and for sandbox testing.

Ask them to paste the token into the chat once they have it.

## Step 2: Save the token

Once they paste a token:

1. Confirm it looks like a Pinterest token. It should start with `pina_`. If it clearly does not, point that out and ask them to recheck.
2. Decide where to save it:
   - On macOS or Linux, check their shell by running `echo $SHELL`. For zsh, which is the macOS default, the file is `~/.zshrc`. For bash, use `~/.bashrc`.
   - On Windows, run this in PowerShell: `[Environment]::SetEnvironmentVariable("PINTEREST_ACCESS_TOKEN", "THEIR_TOKEN", "User")`, then go to Step 3.
3. On macOS or Linux, read their shell file. If it already has a `PINTEREST_ACCESS_TOKEN` line from a previous run, replace that line. Otherwise add this block to the end of the file:

   ```
   # Pinterest MCP (added by Built Not Prompted pinterest-setup)
   export PINTEREST_ACCESS_TOKEN="THEIR_TOKEN"
   ```
4. Tell them plainly what you did: that you saved their token to the file, and that they never have to touch that file themselves.

Treat the token as a secret. Do not repeat the full token back in the chat more than you need to.

## Step 3: Restart and verify

The Pinterest server reads the token when Claude Code starts, so the token only takes effect after a restart.

1. Tell them to fully quit Claude Code and open it again from a new terminal window.
2. After the restart, have them run `/mcp` and look for `pinterest` in the connected list.
3. If it is connected, they are done. Suggest a first thing to try, such as asking to see their Pinterest boards.

## If it does not connect

- `/mcp` does not list pinterest at all: the plugin may not be enabled. Have them run `/plugin`, enable `pinterest`, then run `/reload-plugins`.
- pinterest is listed but shows an error: the token is most likely wrong or expired. Run this setup again and generate a fresh token.
- The error mentions `node: command not found`: Node.js is not installed or not on the PATH. Send them back to install Node.

## Optional settings

Two optional environment variables can be set the same way as the token, if they need them:

- `PINTEREST_CONVERSION_TOKEN`: a separate token for Pinterest's Conversions API.
- `PINTEREST_API_BASE_URL`: set this to `https://api-sandbox.pinterest.com/v5` to use Pinterest's sandbox for testing instead of live data.
