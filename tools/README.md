# Tools

This directory contains helper scripts used for working with the repository.

## update-license-db.py

Scan the repository for license headers and generate `licenses.csv`.
Run it from the repository root:

```sh
python3 tools/update-license-db.py
```

The script searches all files tracked by Git, attempts to identify common
license headers, and notes any "original path" comments found in the files.
The resulting CSV has three columns:

```
path,original_path,license
```

`licenses.csv` will be written to the repository root.
