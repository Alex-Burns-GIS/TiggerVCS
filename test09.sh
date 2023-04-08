#!/bin/dash

# ==============================================================================
# test09.sh
# Repurpose previous test commands to check for exit status errors. 
#
#
# Written by: Alexander Burns <z5118440>
# Date: 11-07-2022
# For COMP2041/9044 Assignment 1
#
# Note, the structue of this script was sourced from an example test script 
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

# Check exit status for tigger-init already initialized error

cat > "$expected_output" <<EOF
1
EOF

tigger-init > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Check exit status for tigger-log error

cat > "$expected_output" <<EOF
1
EOF

tigger-log 'arg' > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Create 3 simple files

echo "1" > a
echo "2" > b
echo "3" > c

# Check exit status for tigger-add error

cat > "$expected_output" <<EOF
1
EOF

tigger-add a bee cee > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi


# Check exit status for tigger-add error

cat > "$expected_output" <<EOF
1
EOF

tigger-add d > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Check exit status for successful tigger-add

cat > "$expected_output" <<EOF
0
EOF

tigger-add a > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Check exit status for unsuccessful tigger-commit

cat > "$expected_output" <<EOF
1
EOF

tigger-commit 'first commit' > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Check exit status for successful tigger-commit

cat > "$expected_output" <<EOF
0
EOF

tigger-commit -m 'first commit' > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Check exit status for unsuccessful tigger-show

cat > "$expected_output" <<EOF
1
EOF

tigger-show : > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Check exit status for unsuccessful tigger-show

cat > "$expected_output" <<EOF
1
EOF

tigger-show :b > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Check exit status for unsuccessful tigger-show

cat > "$expected_output" <<EOF
1
EOF

tigger-show 1:b > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Check exit status for unsuccessful tigger-show

cat > "$expected_output" <<EOF
1
EOF

tigger-show 3:a > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

# Check exit status for successful tigger-show

cat > "$expected_output" <<EOF
0
EOF

tigger-show 0:a > /dev/null 2>&1
echo $? > "$actual_output" 2>&1

if ! diff "$expected_output" "$actual_output"; then
    echo "Failed test"
    exit 1
fi

echo "Passed test"
exit 0