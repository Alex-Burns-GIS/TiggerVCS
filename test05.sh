#!/bin/dash

# ==============================================================================
# test05.sh
# Test a range of usages of tigger-add, tigger-commit and tigger-show, 
# including case sensitivity, duplicate commit files, and preservation of 
# previously committed files when accessing the latest commit.
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

# Add file 'A' to repository staging area (check for case sensitivity)

cat > "$expected_output" <<EOF
tigger-add: error: can not open 'A'
EOF

tigger-add A > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file 'a' to repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file 'a' to repository 

cat > "$expected_output" <<EOF
Committed as commit 0
EOF

tigger-commit -m 'first commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Update file 'b'
echo "Many Worlds" >> b

# Add files 'b' and 'c' to repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add b c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit files 'b' and 'c' to repository 

cat > "$expected_output" <<EOF
Committed as commit 1
EOF

tigger-commit -m 'second commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Print contents of file 'a' in commit 1 (has commit 1 inherited file 'a')

cat > "$expected_output" <<EOF
1
EOF

tigger-show 1:a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file 'a' to repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file 'a' to repository (duplicate file, check for error message) 

cat > "$expected_output" <<EOF
nothing to commit
EOF

tigger-commit -m 'third commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "and more numbers" >> a

# Add file 'a' to repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file 'a' to repository (updated file) 

cat > "$expected_output" <<EOF
Committed as commit 2
EOF

tigger-commit -m 'third commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Print contents of file 'b' in commit 2 (has commit 2 inherited file 'b')

cat > "$expected_output" <<EOF
2
Many Worlds
EOF

tigger-show 2:b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Print contents of file 'c' in commit 0 (check error, file 'c' not present)

cat > "$expected_output" <<EOF
tigger-show: error: 'c' not found in commit 0
EOF

tigger-show 0:c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0