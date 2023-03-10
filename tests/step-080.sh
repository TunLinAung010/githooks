#!/bin/sh
# Test:
#   Cli tool: add/update README

if ! sh /var/lib/githooks/install.sh; then
    echo "! Failed to execute the install script"
    exit 1
fi

mkdir -p /tmp/not/a/git/repo && cd /tmp/not/a/git/repo || exit 1

if git hooks readme add; then
    echo "! Expected to fail"
    exit 2
fi

mkdir -p /tmp/test080 && cd /tmp/test080 && git init || exit 3

git hooks readme update &&
    [ -f .githooks/README.md ] &&
    grep -q '## Brief summary' .githooks/README.md ||
    exit 4

if git hooks readme add; then
    echo "! Expected to fail"
    exit 5
fi

# Check the Git alias
rm -f .githooks/README.md &&
    git hooks readme add &&
    [ -f .githooks/README.md ] &&
    grep -q '## Brief summary' .githooks/README.md ||
    exit 6
