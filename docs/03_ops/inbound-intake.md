# Inbound Intake

This repository treats GitHub Issues as the canonical intake surface for infrastructure work.

## Flow

1. Incoming work is normalized through n8n.
2. A GitHub issue is created before any infrastructure mutation begins.
3. Changes move through a pull request guarded by the PR watcher.
4. Merge stays fail-closed until watcher checks pass.

Tracking issue: `#38`
