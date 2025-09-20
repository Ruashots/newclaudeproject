#!/bin/bash

# Prompt for project name
echo "Enter project name: " >&2
read project_name

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
echo ""
echo "Project setup complete! You can now:"
echo "1. cd $project_name"
echo "2. claude"
echo ""
echo "Claude will help you:"
echo "- Create a GitHub repository"
echo "- Develop a Product Requirements Document"
echo "- Implement your project"