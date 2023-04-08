#!/bin/dash

# ==============================================================================
# test07.sh
# Test error output for incorrect usage of tigger-commit.
# 
# Written by: Alexander Burns <z5118440>
# Date: 10-07-2022
# For COMP2041/9044 Assignment 1
#
# Note, the structure of this script was sourced from an example test script 
# located at: https://cgi.cse.unsw.edu.au/~cs2041/22T2/tut/05/answers
# ==============================================================================

# add the current directory to the PATH so scripts
# can still be executed from it after we cd

PATH="$PATH:$(pwd)"

# Create a temporary directory for the test.
test_dir="$(mktemp -d)"
cd "$test_dir" || exit 1

# Create some files to hold output.

expected_output="$(mktemp)"
actual_output="$(mktemp)"

# Remove the temporary directory when the test is done.

trap 'rm "$expected_output" "$actual_output" -rf "$test_dir"' INT HUP QUIT TERM EXIT

# Create tigger repository

cat > "$expected_output" <<EOF
Initialized empty tigger repository in .tigger
EOF

tigger-init > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Create 3 simple files

echo "1" > a
echo "2" > b
echo "3" > c

# Add file 'a' to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Incorrectly commit file 'a' (no -m flag, no message)

cat > "$expected_output" <<EOF
usage: tigger-commit [-a] -m commit-message
EOF

tigger-commit  > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Incorrectly commit file 'a' (no -m flag)

cat > "$expected_output" <<EOF
usage: tigger-commit [-a] -m commit-message
EOF

tigger-commit 'first commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Incorrectly commit file 'a' (-n flag instead of -m flag)

cat > "$expected_output" <<EOF
usage: tigger-commit [-a] -m commit-message
EOF

tigger-commit -n 'first commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Incorrectly commit file 'a' (duplicate -m flags)

cat > "$expected_output" <<EOF
usage: tigger-commit [-a] -m commit-message
EOF

tigger-commit -m -m 'first commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Incorrectly commit file 'a' (too many arguments)

cat > "$expected_output" <<EOF
usage: tigger-commit [-a] -m commit-message
EOF

tigger-commit -m so many messages > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Incorrectly commit file 'a' (too many arguments)

cat > "$expected_output" <<EOF
usage: tigger-commit [-a] -m commit-message
EOF

tigger-commit -m 'first commit' 'so many messages' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Correctly commit file 'a' 

cat > "$expected_output" <<EOF
Committed as commit 0
EOF

tigger-commit -m 'first commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Check for file 'a' in commit 0

cat > "$expected_output" <<EOF
1
EOF

tigger-show 0:a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0