#!/bin/bash

# Copyright (c) 2025 Fabrice Yopa. All rights reserved.
#
# Script to select and set default Java version using SDKMAN and fzf
# Requires: sdkman, fzf

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if SDKMAN is installed and source init if needed
if ! command -v sdk &> /dev/null; then
    # Try to source SDKMAN init script
    if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
        source "$HOME/.sdkman/bin/sdkman-init.sh"
    else
        echo -e "${RED}Error: SDKMAN is not installed or not in PATH. Please install SDKMAN first.${NC}"
        exit 1
    fi
fi

# Verify sdk command is now available
if ! command -v sdk &> /dev/null; then
    echo -e "${RED}Error: Unable to initialize SDKMAN.${NC}"
    exit 1
fi

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo -e "${RED}Error: fzf is not installed. Please install fzf first.${NC}"
    exit 1
fi

# Get list of installed Java versions from SDKMAN
# sdk list java shows all versions, we filter for installed ones
installed_versions=$(sdk list java | grep "installed" | awk '{print $NF}' | sed 's/|//g' | tr -d ' ')

if [ -z "$installed_versions" ]; then
    echo -e "${YELLOW}No Java versions are currently installed via SDKMAN.${NC}"
    exit 1
fi

# Use fzf to let user select a version
selected_version=$(echo "$installed_versions" | fzf --prompt="Select Java version to set as default: " --height=10)

if [ -z "$selected_version" ]; then
    echo -e "${YELLOW}No version selected. Exiting.${NC}"
    exit 0
fi

# Set the selected version as default
echo -e "${BLUE}Setting Java version $selected_version as default...${NC}"
sdk default java "$selected_version"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Successfully set Java $selected_version as default.${NC}"
    echo -e "${BLUE}Current default Java version:${NC}"
    java -version
else
    echo -e "${RED}Error: Failed to set Java $selected_version as default.${NC}"
    exit 1
fi