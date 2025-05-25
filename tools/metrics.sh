#!/bin/sh
# Collect repository metrics.
set -e

# Directories that hold binary artifacts; skip them when counting lines
# docs/vol2/anim includes prebuilt object code used in the documentation and
# similar binary blobs appear in several other subdirectories.
EXCLUDE_DIRS="docs/vol2/anim docs/vol2/Ped docs/vol2/sam docs/vol2/pi docs/man/man1"

# Build prune expression for find
prune=""
for d in $EXCLUDE_DIRS; do
    prune="$prune -path ./$(printf %s "$d") -o"
done
prune=${prune% -o}

# Count source lines (crude estimate) while excluding the binary directories
line_count=$(eval "find . \( $prune \) -prune -o -type f \( -name '*.[chsyl]' -o -name '*.sh' \) -print0" | xargs -0 cat | wc -l)
echo "Total source lines: $line_count"

type file >/dev/null 2>&1 && {
    echo "Generating file type summary..."
    find . -type f -exec file --brief --mime-type {} + | sort | uniq -c | sort -nr > file_type_summary.txt
}

type cloc >/dev/null 2>&1 && {
    echo "Running cloc..."
    cloc . --csv --out=language_breakdown.csv
}

type tokei >/dev/null 2>&1 && {
    echo "Running tokei..."
    tokei . --output json > token_analysis.json
}

