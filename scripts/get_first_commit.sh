#!/bin/bash

# Copyright (c) 2025 Fabrice Yopa. All rights reserved.
# get_first_commit.sh - Get the first commit hash and GitHub link for a git repository
#
# Usage: ./get_first_commit.sh [path|url]
#   path: Path to git repository (optional, defaults to current directory)
#   url: GitHub repository URL (https or ssh format)
# Installation:
# To make this script available system-wide:
#   sudo cp get_first_commit.sh /usr/local/bin/get_first_commit
#   sudo chmod +x /usr/local/bin/get_first_commit
# Then run 'get_first_commit' from anywhere.

set -euo pipefail

# Color definitions
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Global variables
IS_TEMP_REPO=false
TEMP_DIR=""

# Utility functions
print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_warning() {
    echo -e "${YELLOW}Warning: $1${NC}"
}

print_info() {
    echo -e "${BLUE}$1${NC}" >&2
}

# Check if URL is a GitHub repository URL
is_github_url() {
    local url="$1"
    [[ $url =~ ^https://github\.com/ ]] || [[ $url =~ ^git@github\.com: ]]
}

# Normalize GitHub URL by ensuring it ends with .git
normalize_github_url() {
    local url="$1"
    if [[ ! $url =~ \.git$ ]]; then
        url="${url}.git"
    fi
    echo "$url"
}

# Clone repository to temporary directory
clone_repository() {
    local url="$1"
    local temp_dir

    temp_dir=$(mktemp -d)
    print_info "Cloning repository..."

    if git clone "$url" "$temp_dir" >/dev/null 2>&1; then
        TEMP_DIR="$temp_dir"
        IS_TEMP_REPO=true
        echo "$temp_dir"
    else
        print_error "Failed to clone repository: $url"
        rm -rf "$temp_dir"
        exit 1
    fi
}

# Validate if path is a git repository
validate_git_repository() {
    local repo_path="$1"

    if ! git -C "$repo_path" rev-parse --git-dir >/dev/null 2>&1; then
        print_error "Not a git repository: $repo_path"
        return 1
    fi

    return 0
}

# Get the first commit hash from repository
get_first_commit() {
    local repo_path="$1"
    local first_commit

    first_commit=$(git -C "$repo_path" log --oneline --reverse | head -1 | awk '{print $1}')

    if [[ -z "$first_commit" ]]; then
        print_error "No commits found in repository"
        return 1
    fi

    echo "$first_commit"
}

# Get remote origin URL
get_remote_url() {
    local repo_path="$1"
    local remote_url

    remote_url=$(git -C "$repo_path" remote get-url origin 2>/dev/null)

    if [[ -z "$remote_url" ]]; then
        print_warning "No remote origin found"
        return 1
    fi

    echo "$remote_url"
}

# Parse GitHub URL to extract user and repository
parse_github_url() {
    local remote_url="$1"
    local user repo

    if [[ $remote_url =~ ^https://github\.com/([^/]+)/([^/]+)\.git$ ]]; then
        user="${BASH_REMATCH[1]}"
        repo="${BASH_REMATCH[2]}"
    elif [[ $remote_url =~ ^git@github\.com:([^/]+)/([^/]+)\.git$ ]]; then
        user="${BASH_REMATCH[1]}"
        repo="${BASH_REMATCH[2]}"
    else
        print_error "Could not parse GitHub URL: $remote_url"
        return 1
    fi

    echo "$user $repo"
}

# Generate GitHub commit link
generate_github_link() {
    local user="$1"
    local repo="$2"
    local commit_hash="$3"

    echo "https://github.com/$user/$repo/commit/$commit_hash"
}

# Cleanup temporary directory
cleanup_temp_dir() {
    if $IS_TEMP_REPO && [[ -n "$TEMP_DIR" ]]; then
        rm -rf "$TEMP_DIR"
    fi
}

# Main function
main() {
    local repo_path=""
    local input_arg="${1:-}"

    # Determine repository path
    if [[ -n "$input_arg" ]]; then
        if is_github_url "$input_arg"; then
            local normalized_url
            normalized_url=$(normalize_github_url "$input_arg")
            repo_path=$(clone_repository "$normalized_url")
        else
            repo_path="$input_arg"
        fi
    else
        repo_path=$(pwd)
    fi

    # Validate repository
    if ! validate_git_repository "$repo_path"; then
        cleanup_temp_dir
        exit 1
    fi

    # Get first commit
    local first_commit
    if ! first_commit=$(get_first_commit "$repo_path"); then
        cleanup_temp_dir
        exit 1
    fi

    print_success "First commit: $first_commit"

    # Get and process remote URL
    local remote_url
    if remote_url=$(get_remote_url "$repo_path"); then
        if [[ $remote_url =~ github\.com ]]; then
            local user repo github_link
            if user_repo=$(parse_github_url "$remote_url"); then
                read -r user repo <<< "$user_repo"
                github_link=$(generate_github_link "$user" "$repo" "$first_commit")
                print_info "GitHub link: $github_link"
            fi
        else
            print_warning "Remote is not GitHub"
        fi
    fi

    # Cleanup
    cleanup_temp_dir
}

# Run main function with all arguments
main "$@"