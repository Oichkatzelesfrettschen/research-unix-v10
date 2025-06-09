"""Analyze spinlock usage in the repository.

This script scans source files for occurrences of spin_lock and spin_unlock
and reports the count of each per file. The goal is to provide an overview
of where locking is employed across the code base.
"""

from __future__ import annotations

import os
from pathlib import Path
from collections import defaultdict

# Directory to scan
ROOT = Path(__file__).resolve().parents[1]

# File extensions considered as source code
EXTS = {".c", ".h", ".s", ".S", ".cc"}


def scan_file(path: Path) -> tuple[int, int]:
    """Return the number of spin_lock and spin_unlock calls in a file."""
    lock_count = 0
    unlock_count = 0
    try:
        with path.open("r", encoding="utf-8", errors="ignore") as f:
            for line in f:
                if "spin_lock(" in line:
                    lock_count += 1
                if "spin_unlock(" in line:
                    unlock_count += 1
    except OSError:
        return 0, 0
    return lock_count, unlock_count


def main() -> None:
    """Scan the repository and print counts grouped by file."""
    counts = defaultdict(lambda: {"lock": 0, "unlock": 0})

    for path in ROOT.rglob("*"):
        if path.suffix in EXTS:
            lock, unlock = scan_file(path)
            if lock or unlock:
                rel = path.relative_to(ROOT)
                counts[str(rel)]["lock"] += lock
                counts[str(rel)]["unlock"] += unlock

    for file, data in sorted(counts.items()):
        print(f"{file}: lock={data['lock']} unlock={data['unlock']}")


if __name__ == "__main__":
    main()
