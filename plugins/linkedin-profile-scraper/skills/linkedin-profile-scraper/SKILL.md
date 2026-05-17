---
name: linkedin-profile-scraper
description: Scrape a LinkedIn profile's posts with Apify and export them as a structured CSV. Use when the user wants to pull LinkedIn post metrics, analyze LinkedIn content performance, scrape a LinkedIn profile's posts, or export LinkedIn engagement data.
disable-model-invocation: true
argument-hint: [linkedin-profile-url]
version: 1.0.0
---

# LinkedIn profile post scraper

Scrape a LinkedIn profile's posts through Apify and export the results as a clean, analysis-ready CSV.

## Step 1: Check that Apify is connected

This skill scrapes through Apify. Confirm the Apify MCP tools are available (the tools for searching actors, fetching actor details, calling an actor, and getting actor output).

If they are not available, stop. Tell the user they need the Apify connector installed in Claude, and point them to the classroom lesson on connecting Apify. Do not continue until it is connected.

## Step 2: Validate inputs

1. Confirm a valid LinkedIn profile URL was provided as the argument. It should match `https://www.linkedin.com/in/...`. If it is missing or malformed, ask for it.
2. Ask how many posts to scrape if the user did not say. Default to 50.

## Step 3: Estimate the cost and confirm

LinkedIn scraping costs Apify credits, so price it before running anything.

1. Use the Apify "fetch actor details" tool on `curious_coder/linkedin-profile-post-scraper` to read its current pricing and input schema. Do not rely on hardcoded prices, they drift.
2. Tell the user the rough cost for the post count they chose. Note that Apify's free tier covers small runs.
3. Get a clear yes before scraping.

## Step 4: Run the actor

Call `curious_coder/linkedin-profile-post-scraper` through the Apify "call actor" tool. Typical input:

- `profileUrls`: a list containing the one LinkedIn profile URL
- `maxPosts`: the agreed post count

Confirm the exact parameter names against the input schema you pulled in Step 3, since actors change their schemas. Wait for the run to finish, then get the results with the "get actor output" tool.

If the output looks truncated, fetch the full dataset directly with WebFetch on `https://api.apify.com/v2/datasets/<datasetId>/items?format=json`.

## Step 5: Transform into CSV

Parse the JSON output and map it to these columns:

| Column | Source field | Notes |
|---|---|---|
| Date | `postedAt` or `postedDate` | Format as YYYY-MM-DD |
| Post URL | `postUrl` or `url` | Full LinkedIn post URL |
| Post Type | `type` | Normalize to: text, image, linkedinVideo, article, document, poll |
| Likes | `likeCount` or `numLikes` | Integer, default 0 if missing |
| Comments | `commentCount` or `numComments` | Integer, default 0 if missing |
| Shares | `shareCount` or `numShares` | Integer, default 0 if missing |
| Engagement Score | calculated | See Step 6 |
| Post Text (first 300 chars) | `text` or `postText` | Truncate to 300 characters. Escape commas and newlines so the CSV stays valid |

Apify actor output schemas drift over time. The field names above are common variants. Inspect the actual JSON keys returned and map accordingly. If a field is missing entirely, warn the user and default to 0 for numbers or "N/A" for text.

## Step 6: Calculate the engagement score

Use a weighted formula, then normalize to a 0 to 10 scale.

```
Raw Score = (Likes x 1) + (Comments x 3) + (Shares x 2)
```

- Comments are weighted 3x. They take the most effort and signal genuine interest.
- Shares are weighted 2x. They extend reach and imply endorsement.
- Likes are weighted 1x as baseline engagement.

After computing raw scores for every post, normalize each one:

```
Engagement Score = (Raw Score / highest Raw Score in the dataset) x 10
```

Round to one decimal place. The top post scores 10.0 and the rest are relative to it. If every post has zero engagement, set all scores to 0.

## Step 7: Export and deliver

1. Write the CSV to the current working directory as `linkedin-posts-YYYY-MM-DD.csv`, using today's date.
2. Sort rows by date, newest first.
3. Print a summary: total posts scraped, the date range, the average engagement score, and the top 3 posts by engagement score (date, type, score, and the first 80 characters of text).
4. Tell the user where the file was saved.

## Troubleshooting

- Apify tools not available: the Apify connector is not installed. Send the user to the connector lesson.
- Empty dataset: the actor may have failed. Check the run log URL from the run response and share it with the user. LinkedIn scrapers also break often when LinkedIn changes its site, so try again later, or use the actor search tool to find another LinkedIn post scraper.
- Missing fields in the output: actors update their schemas. Inspect the raw JSON and adapt the field mapping. Do not fail hard, default the missing values and warn the user.
- Large runs: 200-plus posts can take several minutes. Let the user know it is running.
