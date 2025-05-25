# Research UNIX V10 Source Archive

These files were pared from a 1995 snapshot of the source code for post-Tenth-Edition Research UNIX, as used in the Computing Science Research Center at Bell Labs. It is in no sense a formal distribution, and it is unlikely that it can be made into a working system without a fair amount of hand-waving, not to mention obsolete hardware; rather it is meant as a piece of the historic record. The code is historical and may not compile on modern systems without effort.

It has been trimmed in several ways:
- It was habit at the time to put a copy of all source code that seemed interesting in /usr/src, even if it came from outside and required little or no surgery to make work, and in some cases even if it was never used or even consistently installed. None of these seem an important part of the history of this system; most cases, especially large ones, have been expunged.
- Some programs were in some sense part of the system, but encumbered in one way or another so that it is (even more) unclear whether it is fair to redistribute them. They have been set aside as well. Some marginal cases that are key to the system (e.g. the pcc2 C compiler, modified by Research from code that came from the System III/System V developers) remain.

There remain parts that ought to be thought of as encumbered, especially the documentation (which was published as a copyrighted book); and the overall system was never released save under single-target letter agreements. As of this writing (March 2003) it is not obvious that it is covered by extant Ancient Systems license agreements.

The files were originally stored in three GNU-compressed tar archives:

- **secombe.gz** (the heavy one) – source for UNIX proper, including commands, libraries and the OS kernel. Originally rooted at `/usr/src`.
- **milligan.gz** (the eclectic high-flying one) – source and perhaps some binaries for the AT&T 5620 (Jerq) code. Originally rooted at `/usr`, i.e. directory `jerq` in the archive was `/usr/jerq`.
- **sellers.gz** (the well-dressed one) – documentation. Originally rooted in `/usr/src`, but it would make as much sense in `/usr`. Subdirectory `man` is Volume 1 of the manual with tools used to produce the printed version; subdirectory `vol2` is Volume 2.

## Repository contents

- `v10` – UNIX commands, libraries and kernel sources.
- `jerq` – AT&T 5620 "Jerq" software and demo programs.
- `docs` – manual pages and other documentation.
- `r70` – headers and notes related to the r70 port.
- `tools` – helper scripts such as `metrics.sh`.
- `metrics_results.log` – sample output from the metrics script.

## Using the metrics script

A helper script in `tools/metrics.sh` collects simple repository statistics. Run it from the repository root:

```sh
sh tools/metrics.sh
```

If `cloc` or `tokei` are installed the script writes `language_breakdown.csv` and `token_analysis.json` with a breakdown of the source. You can capture the output in a log file:

```sh
sh tools/metrics.sh > metrics_results.log
```

## Building sample programs

Several directories contain Makefiles for demonstration programs. For example the Jerq demos under `jerq/demo/src` may be built with:

```sh
cd jerq/demo/src/cent
make
```

A compatible toolchain and libraries from the original system are required, so expect to make adjustments or encounter build errors on a modern host.

