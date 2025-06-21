#!/bin/bash

# Config
author_name="Manasvin Shrimali"
author_email="manasvinshimali@gmail.com"
start_date="2024-06-01"
end_date="2024-06-07"
total_commits=100
file_name="manasvin.txt"

# Ensure file exists
touch $file_name

# Calculate seconds range
start_epoch=$(date -d "$start_date" +%s)
end_epoch=$(date -d "$end_date +1 day" +%s) # include full June 7
range=$((end_epoch - start_epoch))

# Function to convert number to ordinal
ordinal() {
  n=$1
  if [[ "$n" -eq 1 ]]; then echo "First"
  elif [[ "$n" -eq 2 ]]; then echo "Second"
  elif [[ "$n" -eq 3 ]]; then echo "Third"
  else echo "${n}th"
  fi
}

# Generate commits
for i in $(seq 1 $total_commits); do
  commit_time=$((start_epoch + RANDOM % range))
  commit_date=$(date -d "@$commit_time" "+%Y-%m-%dT%H:%M:%S")

  message="$(ordinal $i) change"

  echo "$message at $commit_date" >> $file_name
  git add $file_name

  GIT_AUTHOR_NAME="$author_name" \
  GIT_AUTHOR_EMAIL="$author_email" \
  GIT_AUTHOR_DATE="$commit_date" \
  GIT_COMMITTER_DATE="$commit_date" \
  git commit -m "$message"
done
