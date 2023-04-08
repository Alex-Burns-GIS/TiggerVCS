#!/bin/dash

# ==============================================================================
# test02.sh
# Test a range of usages of tigger-add, including updating previously 
# added files, re-adding, and using tigger-show to check for correct 
# output. 
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

echo "Hello" > a
echo "Brave" > b
echo "New" > c

# Add files 'a','b', and 'c' to to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add a b c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Print contents of file 'c' in the staging area
 
cat > "$expected_output" <<EOF
New
EOF

tigger-show :c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Update file 'c'

echo "World by Aldous Huxley" >> c

# Add file 'c' to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Print updated contents of file 'c' in the staging area
cat > "$expected_output" <<EOF
New
World by Aldous Huxley
EOF

tigger-show :c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Update file 'c' again

echo "Is not the title" >> c

# Add file 'c' to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Print updated contents of file 'c' in the staging area
cat > "$expected_output" <<EOF
New
World by Aldous Huxley
Is not the title
EOF

tigger-show :c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Replace contents of file 'c'

echo "It's Brave New World" > c

# Add file 'c' to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Print correct contents of file 'c' in the staging area
cat > "$expected_output" <<EOF
It's Brave New World
EOF

tigger-show :c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Print correct contents of file 'a' in the staging area
cat > "$expected_output" <<EOF
Hello
EOF

tigger-show :a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0
