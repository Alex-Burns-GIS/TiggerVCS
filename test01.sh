#!/bin/dash

# ==============================================================================
# test01.sh
# Test tigger-add with more than 10 files. Test tigger-commit with more than
# 10 files. Test tigger-log with more than 10 commits (testing counter with 
# double digit numbers). 
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

# Create 12 simple files

echo "1" > a
echo "2" > b
echo "3" > c
echo "4" > d
echo "5" > e
echo "6" > f
echo "7" > g
echo "8" > h
echo "9" > i
echo "10" > j
echo "11" > k
echo "12" > l

# Add file a to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add a > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file a to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 0
EOF

tigger-commit -m 'first commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file b to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add b > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file b to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 1
EOF

tigger-commit -m 'second commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file c to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add c > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file c to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 2
EOF

tigger-commit -m 'third commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file d to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add d > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file d to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 3
EOF

tigger-commit -m 'fourth commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file e to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add e > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file e to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 4
EOF

tigger-commit -m 'fifth commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file f to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add f > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file f to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 5
EOF

tigger-commit -m 'sixth commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file g to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add g > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file g to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 6
EOF

tigger-commit -m 'seventh commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file h to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add h > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file h to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 7
EOF

tigger-commit -m 'eighth commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file i to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add i > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file i to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 8
EOF

tigger-commit -m 'ninth commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file j to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add j > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file j to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 9
EOF

tigger-commit -m 'tenth commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file k to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add k > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file k to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 10
EOF

tigger-commit -m 'eleventh commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Add file l to the repository staging area

cat > "$expected_output" <<EOF
EOF

tigger-add l > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Commit file l to the .tigger repository 

cat > "$expected_output" <<EOF
Committed as commit 11
EOF

tigger-commit -m 'twelfth commit' > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Run tigger-log

cat > "$expected_output" <<EOF
11 twelfth commit
10 eleventh commit
9 tenth commit
8 ninth commit
7 eighth commit
6 seventh commit
5 sixth commit
4 fifth commit
3 fourth commit
2 third commit
1 second commit
0 first commit
EOF

tigger-log > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0