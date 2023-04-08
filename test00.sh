#!/bin/dash

# ==============================================================================
# test00.sh
# Test initial error messages from tigger-init, tigger-add, tigger-log, 
# tigger-commit, and tigger-show commands. 
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

# Test commands before .tigger initialized 

cat > "$expected_output" <<EOF
tigger-add: error: tigger repository directory .tigger not found
EOF

tigger-add > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

cat > "$expected_output" <<EOF
tigger-log: error: tigger repository directory .tigger not found
EOF

tigger-log > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

cat > "$expected_output" <<EOF
tigger-commit: error: tigger repository directory .tigger not found
EOF

tigger-commit> "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

cat > "$expected_output" <<EOF
tigger-show: error: tigger repository directory .tigger not found
EOF

tigger-show > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Create tigger repository

cat > "$expected_output" <<EOF
Initialized empty tigger repository in .tigger
EOF

tigger-init > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test initial error messages: tigger-init
cat > "$expected_output" <<EOF
tigger-init: error: .tigger already exists
EOF

tigger-init > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test initial error messages: tigger-add
 
cat > "$expected_output" <<EOF
usage: tigger-add <filenames>
EOF

tigger-add > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test initial error messages: tigger-log

cat > "$expected_output" <<EOF
EOF

tigger-log > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test initial error messages: tigger-commit (incorrect syntax)

cat > "$expected_output" <<EOF
usage: tigger-commit [-a] -m commit-message
EOF

tigger-commit > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test initial error messages: tigger-commit (correct syntax)

cat > "$expected_output" <<EOF
nothing to commit
EOF

tigger-commit -m 'first commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Test initial error messages: tigger-show

cat > "$expected_output" <<EOF
usage: tigger-show <commit>:<filename>
EOF

tigger-show> "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0
