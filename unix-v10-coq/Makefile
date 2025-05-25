COQFILES := $(shell find theories -name '*.v')

all: vo

vo: _CoqProject $(COQFILES)
	coq_makefile -f _CoqProject -o Makefile.coq
	$(MAKE) -f Makefile.coq

clean:
	$(MAKE) -f Makefile.coq clean || true
	rm -f Makefile.coq

.PHONY: all vo clean
