# pagein() Overview

This document summarizes the high-level logic used by the `pagein()`
routine in the Research UNIX V10 kernel.

## Reclaim logic
When a fault occurs, `pagein()` first checks whether the page is already
allocated but merely invalid.  If so, and the physical page can be
reclaimed, the routine pulls it back into the process's resident set
instead of issuing disk I/O.  The key steps start around the `restart:`
label and include waiting for in-transit text pages and revalidating the
entry if it becomes valid during the wait:

```c
...  /* reclaim or revalidate */
```
(see lines 94–154 of `vmpage.c`)

## Swap read path
If the page is not already present, the routine must read it from the
swap device.  After determining the swap block (`bn`) and possibly
clustering adjacent pages via `kluster()`, the code calls `swap()` to
perform the actual disk read:

```c
swap(p, fsbtodb(dev, bn), ptob(v), klsize * ctob(CLSIZE), B_READ, B_PGIN, dev, 0);
```
(see lines 324–343 of `vmpage.c`)

## Zero-fill on demand
For demand-zero pages, `pagein()` avoids disk I/O by simply clearing the
freshly allocated page frames.  The zero-fill logic clears each page in
the cluster and counts it as a zero-fill fault before skipping the swap
operation entirely:

```c
for (i = 0; i < CLSIZE; i++)
    clearseg(pf + i);
if (type != CTEXT)
    cnt.v_zfod += CLSIZE;
```
(see lines 295–299 of `vmpage.c`)

