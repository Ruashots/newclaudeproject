# Claude Project Setup Script

A quick setup script for creating new projects with Claude Code and essential MCPs (Model Context Protocols) pre-configured.

## What This Script Does

This script automates the entire project setup process:

1. **Project Creation**: Prompts for a project name and creates the folder (or uses existing)
2. **MCP Installation**: Automatically installs three essential MCPs:
   - **Context7**: Up-to-date documentation and code examples for any library
   - **Playwright**: Browser automation and web testing capabilities
   - **Shadcn**: UI component library integration
3. **Claude Launch**: Starts Claude with a pre-configured workflow that:
   - Creates a GitHub repository
   - Helps you create a comprehensive PRD (Product Requirements Document)
   - Pushes initial setup to GitHub
   - Asks permission before starting implementation

## Usage

### From Proxmox Terminal

```bash
# Clone this repository
git clone https://github.com/Ruashots/newclaudeproject.git
cd newclaudeproject

# Run the setup script
./setup-project.sh
```

### The Script Will:

1. Ask you for a project name
2. Create/navigate to the project folder
3. Install all MCPs automatically
4. Launch Claude with the workflow instructions

### What Happens After Claude Starts:

Claude will automatically:
1. Create a GitHub repository for your project
2. Ask for your main project idea
3. Help create a detailed PRD
4. Push everything to GitHub
5. Ask if you want to start implementation

## MCPs Included

### Context7
- **Purpose**: Access up-to-date documentation for any library/framework
- **API Key**: Pre-configured (ctx7sk-410476ea-6f09-475d-a5f9-1c18052a63cd)
- **Usage**: Get current docs, examples, and best practices

### Playwright
- **Purpose**: Browser automation and web testing
- **Usage**: Create tests, automate web interactions, take screenshots

### Shadcn
- **Purpose**: Modern UI component library
- **Usage**: Quick component setup and styling

## Requirements

- Claude Code installed
- Git configured
- pnpm installed (for Shadcn MCP)
- GitHub account (for repository creation)

## File Structure After Setup

```
your-project/
├── .git/                 # Git repository
├── [project files]       # Your actual project files
└── .claude/             # Claude configuration with MCPs
```

## Notes

- The script uses `--dangerously-skip-permissions` for seamless automation
- All MCPs are configured to work together seamlessly
- GitHub repository creation happens automatically through Claude
- The workflow is designed for rapid prototyping and development