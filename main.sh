#!/bin/bash

if [ $# -lt 1 ]; then
   echo "Usage: $0 <repository_URL> [\"Author Name 1\" \"Author Name 2\" ...]"
   exit 1
fi

repository_url=$1
shift

temp_dir=$(mktemp -d)
git clone "$repository_url" "$temp_dir" > /dev/null 2>&1 || { echo "Failed to clone repository"; exit 1; }

cd "$temp_dir" || { echo "Failed to change directory to repository"; exit 1; }

if [ $# -eq 0 ]; then
   contributors=$(git shortlog -s -n)
else
   contributors=""
   for author in "$@"; do
      author_contributions=$(git shortlog -s -n --author="$author")
      contributors="$contributors$author_contributions\n"
   done
fi

echo "Contributors and their commit counts for $repository_url:"
echo -e "$contributors"

rm -rf "$temp_dir"