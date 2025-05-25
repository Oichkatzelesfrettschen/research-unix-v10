# Unix v10 Coq Framework

This directory contains a minimal Coq skeleton for reasoning
about the migration of Research Unix v10 code to modern C23.
The structure mirrors the high level design proposed in the
project documentation.  Modules for the `lambda`, `pi`, `mu`
and `nu` calculi are provided with placeholder definitions,
together with a simple migration functor and a preservation
lemma.

Build the Coq files using:

```
make -C unix-v10-coq
```

