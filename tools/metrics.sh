#!/bin/sh
# Collect repository metrics.
set -e

# Count source lines (crude estimate)
line_count=$(find . -type f \( -name '*.[chsyl]' -o -name '*.sh' \) -print0 | xargs -0 cat | wc -l)
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

