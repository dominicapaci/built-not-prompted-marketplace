---
name: tiktok-account-analysis
description: Scrape a TikTok account and produce a focused content-strategy report the user can ask follow-up questions about. Use when the user wants to analyze a TikTok account, audit another creator's content, study a competitor, or understand what is working on a specific TikTok profile. Estimates the scraping cost and gets confirmation before spending anything.
argument-hint: '<@account> "<what you want analyzed>"'
---

# TikTok account analysis

Scrape one TikTok account and turn it into a single, focused report that answers a specific question, then stay available for follow-up questions about that account. This is a standalone tool. It does not build dashboards and it does not write multi-file pipelines.

## What you need from the user

Two things, usually passed in when the skill is invoked:

1. A TikTok account (a username or a profile URL).
2. A description of what they want to learn. For example: "what hooks work best for them", "should I copy their posting schedule", or "why are their last 10 videos flopping".

If either is missing, ask for it before doing anything else.

## Step 1: Check that Apify is connected

This skill scrapes through Apify. Confirm the Apify MCP tools are available (the tools for searching actors, fetching actor details, calling an actor, and getting actor output).

If they are not available, stop. Tell the user they need the Apify connector installed in Claude, and point them to the classroom lesson on connecting Apify. Do not continue until it is connected.

## Step 2: Decide the scope

You cannot price a scrape without knowing how many posts you are pulling. Ask the user one question:

> Do you want their most recent posts, or their whole history? If recent, how many?

Guide them to a number. A capped count, like the most recent 100 posts, gives a predictable cost. "Whole history" means the cost scales with however many videos they have posted, which you cannot know in advance, so if they pick that, give them a likely range and let them set a maximum.

Land on a concrete post count, N, before moving on.

Then read their analysis description and decide whether comments are needed:

- Comments ARE needed for: audience sentiment, what viewers are saying, purchase intent, unanswered questions, how people react.
- Comments are NOT needed for: hooks, captions, posting times, video length, formats, hashtags, music, raw performance numbers.

Comments cost several times more than posts, so only include them when the analysis genuinely needs them.

## Step 3: Estimate the cost and get confirmation

Look up the live price. Use the Apify "fetch actor details" tool on the actors you plan to run and read their current pricing. Do not rely on hardcoded prices, they drift. The same call also returns the current input schema, so use it to confirm parameter names before you run anything.

Actors this skill uses:

- Posts: `clockworks/tiktok-profile-scraper`. Pulls a profile's videos with engagement metrics, captions, hashtags, music, and subtitles. Roughly $0.004 per video at the time of writing.
- Comments, only if needed: `clockworks/tiktok-comments-scraper`. Roughly $0.03 per post at the time of writing.

If a named actor is unavailable, use the actor search tool to find the closest equivalent, and prefer ones with high user counts and success rates. Apify may also charge a small fee per actor run, so include that if the pricing shows it.

Present an itemized estimate, like this:

> Estimated cost to analyze @account:
> Posts: 100 videos at $0.004 each = $0.40
> Comments: not needed for this analysis
> Total: about $0.40
> This is an estimate. The real cost depends on how much data Apify returns.

Then ask plainly: "Want me to run it?" Do not scrape until the user clearly says yes.

## Step 4: Scrape

Once confirmed, create a working folder in the current directory: `tiktok-analysis/<account>/raw_data/`.

### Posts

Run `clockworks/tiktok-profile-scraper` with:

- `profiles`: the username with no @ symbol
- `resultsPerPage`: N, the agreed post count
- `profileSorting`: "latest", or "popular" if the user wants the account's best work
- `shouldDownloadSubtitles`: true, so you get transcripts for hook analysis

Save the results to `raw_data/posts.json`.

The clockworks output nests some fields. Normalize them as you read:

- `hashtags` is an array of objects with a `name` field. Flatten to plain strings.
- Music info is under `musicMeta`: `musicName`, `musicAuthor`, `musicOriginal`.
- Duration and subtitle links are under `videoMeta`: `videoMeta.duration`, `videoMeta.subtitleLinks`.
- Key metrics: `diggCount` is likes, `playCount` is views, plus `shareCount`, `commentCount`, and `collectCount` (saves).

Transcripts: posts with speech have `videoMeta.subtitleLinks`, and each link has a `downloadLink` pointing to Apify's key-value store. Download the WebVTT text for each so you can analyze hooks and scripts.

### Comments (only if Step 2 decided they are needed)

Run `clockworks/tiktok-comments-scraper` with:

- `postURLs`: the video URLs from posts.json
- `commentsPerPost`: 100 is usually enough
- `maxRepliesPerComment`: 3

Save to `raw_data/comments.json`.

Heads up: the "get actor output" tool truncates large datasets. For comments, fetch the full dataset directly with WebFetch on `https://api.apify.com/v2/datasets/<datasetId>/items?format=json` so you do not silently analyze only a fraction of the data.

## Step 5: Analyze and write the report

Do the analysis directly. Do not require pandas or any installed library. If you need to crunch numbers, write a short script using only the Python standard library, but for most accounts you can reason over the JSON directly.

Compute engagement rate per post as `(likes + shares + comments + saves) / views`.

Pick the analyses that match what the user asked for. Run only what answers their question, not all of these every time:

- Hooks: the first few seconds of speech from transcripts, grouped by type (question, bold claim, personal intro, story, problem). Which hook types pair with high engagement.
- Captions and language: caption length, questions versus statements, calls to action, words that show up in top performers.
- Themes: group posts by topic and compare performance. Which themes drive views versus saves versus comments.
- Format and timing: video length buckets, day and time of posting, posting frequency, video versus photo slideshow.
- Hashtags and music: which tags and sounds line up with better performance.
- Comments: sentiment, recurring questions, what the audience asks for. Only if comments were scraped.
- Top and bottom posts: the clear winners and the flops, with the likely reason for each.

Write ONE markdown report to `tiktok-analysis/<account>/report.md`, structured as:

1. A short summary: the account, how many posts were analyzed, the date range, and the headline finding.
2. The answer to their actual question, up front, with the data behind it.
3. The supporting analysis sections you ran.
4. A few specific, concrete recommendations.

Keep it readable. Real numbers, plain language, no filler. Then show the user the key findings in the chat and tell them where the full report is saved.

## Step 6: Follow-up questions

The scraped data stays in `tiktok-analysis/<account>/raw_data/`. After the report, the user will usually ask more, like "what were their top 5 by saves", "did they post more in the morning", or "show me every video over a minute long". Answer those from the saved data. Do not scrape again unless they ask for a different account or a wider date range.
