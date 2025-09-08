#!/bin/bash

# Copyright (c) 2025 Fabrice Yopa. All rights reserved.
# get_first_commit.sh - Get the first commit hash and GitHub link for a git repository
#
# Usage: ./get_first_commit.sh [path]
#   path: Path to git repository (optional, defaults to current directory)
# Installation:
# To make this script available system-wide:
#   sudo cp get_first_commit.sh /usr/local/bin/get_first_commit
#   sudo chmod +x /usr/local/bin/get_first_commit
# Then run 'get_first_commit' from anywhere.

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get path from argument or default to current
GIT_PATH=${1:-$(pwd)}

# Check if it's a git repo
if ! git -C "$GIT_PATH" rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}Not a git repository: $GIT_PATH${NC}"
    exit 1
fi

# Get first commit hash
FIRST_COMMIT=$(git -C "$GIT_PATH" log --oneline --reverse | head -1 | awk '{print $1}')
if [ -z "$FIRST_COMMIT" ]; then
    echo -e "${RED}No commits found${NC}"
    exit 1
fi
echo -e "${GREEN}First commit: $FIRST_COMMIT${NC}"

# Get remote origin
REMOTE_URL=$(git -C "$GIT_PATH" remote get-url origin 2>/dev/null)
if [ -z "$REMOTE_URL" ]; then
    echo -e "${YELLOW}No remote origin found${NC}"
    exit 0
fi

# Check if GitHub
if [[ $REMOTE_URL =~ github\.com ]]; then
    # Parse GitHub URL
    if [[ $REMOTE_URL =~ ^https://github\.com/([^/]+)/([^/]+)\.git$ ]]; then
        USER=${BASH_REMATCH[1]}
        REPO=${BASH_REMATCH[2]}
    elif [[ $REMOTE_URL =~ ^git@github\.com:([^/]+)/([^/]+)\.git$ ]]; then
        USER=${BASH_REMATCH[1]}
        REPO=${BASH_REMATCH[2]}
    else
        echo -e "${RED}Could not parse GitHub URL${NC}"
        exit 0
    fi
    LINK="https://github.com/$USER/$REPO/commit/$FIRST_COMMIT"
    echo -e "${BLUE}GitHub link: $LINK${NC}"
else
    echo -e "${YELLOW}Remote is not GitHub${NC}"
fi