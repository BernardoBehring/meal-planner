---
name: email-send-plan
description: Sends the full Plan e-mail of the Week from references/email-template.md. Use at the end of a Plan.
user-invocable: false
---

# Send the Plan e-mail

Get the addresses for the **plan** e-mail with `email-resolve-recipients`, then send with `mcp__claude_ai_Gmail__send_message` following `references/email-template.md`. If it fails, or the Gmail tools are unavailable, record it in the Week file.
