#!/bin/bash

# Colors for prettier output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to print styled messages
print_header() {
    echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}${BLUE}                        🚀 Claude Project Setup 🚀${NC}"
    echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}" >&2
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

print_prompt() {
    echo -e "${PURPLE}${BOLD}🎯 $1${NC}"
}

# Function to get project name with retry logic
get_project_name() {
    while true; do
        if [ ! -t 0 ]; then
            # Non-interactive mode (piped from curl)
            print_error "When running via curl, provide the project name as an argument:"
            echo -e "${CYAN}curl -sSL https://raw.githubusercontent.com/Ruashots/newclaudeproject/main/setup-project.sh | bash -s 'your-project-name'${NC}" >&2
            echo "" >&2
            print_info "Or download and run locally:"
            echo -e "${CYAN}curl -O https://raw.githubusercontent.com/Ruashots/newclaudeproject/main/setup-project.sh${NC}" >&2
            echo -e "${CYAN}chmod +x setup-project.sh${NC}" >&2
            echo -e "${CYAN}./setup-project.sh${NC}" >&2
            exit 1
        fi

        print_prompt "Enter your project name:"
        echo -ne "${BOLD}${CYAN}📝 Project name: ${NC}"
        read project_name

        # Check if project name is empty
        if [ -z "$project_name" ]; then
            print_error "Project name cannot be empty. Please try again."
            echo ""
            continue
        fi

        # Check if folder already exists
        if [ -d "$project_name" ]; then
            echo ""
            print_warning "Directory '$project_name' already exists!"
            echo ""
            print_prompt "What would you like to do?"
            echo -e "  ${BOLD}1)${NC} Choose a different name"
            echo -e "  ${BOLD}2)${NC} Exit setup"
            echo ""
            echo -ne "${BOLD}${CYAN}👉 Enter your choice (1 or 2): ${NC}"
            read choice

            case $choice in
                1)
                    echo ""
                    continue
                    ;;
                2)
                    echo ""
                    print_info "Setup cancelled. Goodbye! 👋"
                    exit 0
                    ;;
                *)
                    echo ""
                    print_error "Invalid choice. Please enter 1 or 2."
                    echo ""
                    continue
                    ;;
            esac
        else
            # Valid project name that doesn't exist
            break
        fi
    done
}

# Print header
print_header

# Check if project name is provided as argument
if [ $# -gt 0 ]; then
    project_name="$1"

    # Check if folder already exists when provided as argument
    if [ -d "$project_name" ]; then
        echo ""
        print_error "Directory '$project_name' already exists!"
        print_info "Please choose a different name or remove the existing directory."
        exit 1
    fi
else
    # Interactive mode
    get_project_name
fi

echo ""
print_info "Creating project directory '$project_name'..."
mkdir "$project_name"

# Change to project directory
cd "$project_name"

echo ""
print_info "Setting up MCPs..."
echo ""

# Add Context7 MCP
print_info "Installing Context7 MCP (Documentation & Code Examples)..."
claude mcp add --transport http context7 https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY: ctx7sk-410476ea-6f09-475d-a5f9-1c18052a63cd"

# Add Playwright MCP
print_info "Installing Playwright MCP (Browser Automation)..."
claude mcp add playwright npx @playwright/mcp@latest

# Add Shadcn MCP
print_info "Installing Shadcn MCP (UI Components)..."
pnpm dlx shadcn@latest mcp init --client claude

echo ""
print_success "MCPs installed successfully!"
echo ""

# Print completion message with styled output
echo -e "${BOLD}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${GREEN}                        🎉 Setup Complete! 🎉${NC}"
echo -e "${BOLD}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
print_info "Claude will help you:"
echo -e "  ${BOLD}•${NC} Create a GitHub repository"
echo -e "  ${BOLD}•${NC} Develop a Product Requirements Document"
echo -e "  ${BOLD}•${NC} Implement your project"
echo ""
print_info "Starting Claude in your new project..."
echo ""

# Start Claude with skip permissions in the project directory
exec claude --dangerously-skip-permissions