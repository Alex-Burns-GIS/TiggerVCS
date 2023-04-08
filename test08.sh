#!/bin/dash

# ==============================================================================
# test08.sh
# Test error output for incorrect usage of tigger-show.
# 
# Written by: Alexander Burns <z5118440>
# Date: 11-07-2022
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

# Add files 'a','b', and 'c' to repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add a b c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit files 'a','b', and 'c' to repository 

cat > "$expected_output" <<EOF
Committed as commit 0
EOF

tigger-commit -m 'first commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test error output from incorrect usage of tigger-show (no argument)

cat > "$expected_output" <<EOF
usage: tigger-show <commit>:<filename>
EOF

tigger-show > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test error output from incorrect usage of tigger-show (single arg, no colon)

cat > "$expected_output" <<EOF
tigger-show: error: invalid object 0
EOF

tigger-show 0 > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test error output from incorrect usage of tigger-show (two arg, no colon)

cat > "$expected_output" <<EOF
usage: tigger-show <commit>:<filename>
EOF

tigger-show 0 a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test error output from incorrect usage of tigger-show (just colon)

cat > "$expected_output" <<EOF
tigger-show: error: invalid filename ''
EOF

tigger-show : > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test error output from incorrect usage of tigger-show (no file)

cat > "$expected_output" <<EOF
tigger-show: error: invalid filename ''
EOF

tigger-show 0: > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test error output from incorrect usage of tigger-show (non existent file)

cat > "$expected_output" <<EOF
tigger-show: error: 'd' not found in index
EOF

tigger-show :d > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test error output from incorrect usage of tigger-show (non existent commit
# and non existent file)

cat > "$expected_output" <<EOF
tigger-show: error: unknown commit '5'
EOF

tigger-show 5:d > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test error output from incorrect usage of tigger-show (non existent commit)

cat > "$expected_output" <<EOF
tigger-show: error: unknown commit '5'
EOF

tigger-show 5: > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test error output from incorrect usage of tigger-show (extra argument)

cat > "$expected_output" <<EOF
usage: tigger-show <commit>:<filename>
EOF

tigger-show 0:a extra > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test correct usage of tigger-show 

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