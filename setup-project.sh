#!/bin/bash

# Prompt for project name
read -p "Enter project name: " project_name

# Check if project name is provided
if [ -z "$project_name" ]; then
    echo "Error: Project name cannot be empty"
    exit 1
fi

# Check if folder exists
if [ -d "$project_name" ]; then
    echo "Folder '$project_name' already exists. Using existing folder."
else
    echo "Creating folder '$project_name'..."
    mkdir "$project_name"
fi

# Change to project directory
cd "$project_name"

echo "Setting up MCPs..."

# Add Context7 MCP
claude mcp add --transport http context7 https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY: ctx7sk-410476ea-6f09-475d-a5f9-1c18052a63cd"

# Add Playwright MCP
claude mcp add playwright npx @playwright/mcp@latest

# Add Shadcn MCP
pnpm dlx shadcn@latest mcp init --client claude

echo "MCPs installed successfully!"
echo "Starting Claude with project setup instructions..."

# Run Claude with initial instructions
claude --dangerously-skip-permissions << 'EOF'
Hi! I need you to help me set up a new project. Please follow these steps:

1. First, create a new GitHub repository for this project
2. Ask me for my main project idea so you can help me create a comprehensive PRD (Product Requirements Document)
3. Push the PRD and any initial setup to GitHub
4. Then ask me if you can start working on implementing the project

Let's begin!
EOF