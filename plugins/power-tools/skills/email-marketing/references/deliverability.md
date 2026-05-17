# Getting to the inbox

A polished email is worthless if it lands in spam. Most of the technical side is handled by your email platform. This is what you actually control.

## Authentication, set once

Three DNS records prove your email is really from you. Your platform gives you the values, you add them to your domain once.

- SPF lists the servers allowed to send for your domain.
- DKIM is a signature that proves the email was not altered in transit.
- DMARC tells inboxes what to do if a message fails the checks. Start it in monitoring mode, then tighten it.

Since 2024, Gmail and Yahoo require all three from anyone sending in volume. Without them, you do not reach the inbox.

## Sender reputation

Inbox providers score you on behavior over time. What raises the score: people opening, clicking, and replying. What sinks it: bounces, spam complaints, hitting dead addresses, and sudden spikes in volume.

On a brand-new domain or sending platform, warm up. Send only to your most engaged subscribers at first, at a steady volume, and grow it over a few weeks rather than blasting your whole list on day one.

## List hygiene

- Remove hard bounces right away.
- Sunset subscribers who have not opened or clicked in 90-plus days. Send a short win-back sequence first, then drop the ones who do not respond.
- Honor unsubscribes instantly.

A smaller engaged list beats a large stale one on every metric that matters.

## Spam triggers to avoid

- Subject lines in all caps or stuffed with punctuation.
- Words like "FREE" and "ACT NOW," and anything misleading.
- An email that is one big image with almost no text.
- Broken HTML, link shorteners, hidden text.

## One thing that changed

Apple Mail and others now pre-load images, which fires a fake open. Open rates are directional at best now. Judge your email on clicks and replies, not opens.
