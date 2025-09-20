# Claude Project Setup Script

One-liner to set up a new project with Claude Code and essential MCPs anywhere.

## Quick Start

Run this anywhere to create a new Claude project:

```bash
curl -sSL https://raw.githubusercontent.com/Ruashots/newclaudeproject/main/setup-project.sh | bash
```

The script will prompt you for a project name and set everything up automatically.

## What It Does

Automatically sets up:
- Project folder creation
- 3 essential MCPs (Context7, Playwright, Shadcn)
- Claude launch with GitHub workflow (repo creation → PRD → implementation)

## Requirements

- Claude Code installed
- pnpm installed
- Git configured with GitHub access