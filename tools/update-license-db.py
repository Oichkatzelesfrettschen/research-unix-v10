#!/usr/bin/env python3
"""Scan repository files for license headers and emit a CSV database."""
import csv
import os
import re
import subprocess
import sys

# Patterns for common licenses
LICENSE_PATTERNS = {
    "Bell Labs": re.compile(r"(Bell Labs|Bell Laboratories|AT&T)", re.I),
    "BSD": re.compile(r"Redistribution and use in source and binary forms", re.I),
    "MIT": re.compile(r"Permission is hereby granted, free of charge", re.I),
    "GPL": re.compile(r"GNU General Public License|This program is free software", re.I),
    "Apache": re.compile(r"Licensed under the Apache License", re.I),
}

# Patterns to find a file's original location if noted in comments
ORIG_PATH_PATTERNS = [
    re.compile(r"original\s+path(?:name)?[:\s-]+(\S+)", re.I),
    re.compile(r"from\s+(/[^\s]+)", re.I),
]


def detect_license(text: str) -> str:
    header = text[:1000]
    for name, pat in LICENSE_PATTERNS.items():
        if pat.search(header):
            return name
    return "Unknown"


def detect_original_path(text: str) -> str:
    for pat in ORIG_PATH_PATTERNS:
        m = pat.search(text)
        if m:
            return m.group(1)
    return ""


def main() -> None:
    repo_root = (
        subprocess.run(["git", "rev-parse", "--show-toplevel"], capture_output=True, text=True)
        .stdout.strip()
    )
    files = (
        subprocess.run(["git", "ls-files"], capture_output=True, text=True).stdout.splitlines()
    )

    entries = []
    for path in files:
        try:
            with open(path, "r", errors="ignore") as f:
                data = f.read()
        except Exception:
            continue
        license_name = detect_license(data)
        orig_path = detect_original_path(data)
        entries.append((path, orig_path, license_name))

    output = os.path.join(repo_root, "licenses.csv")
    with open(output, "w", newline="") as out:
        writer = csv.writer(out)
        writer.writerow(["path", "original_path", "license"])
        writer.writerows(entries)


if __name__ == "__main__":
    main()
