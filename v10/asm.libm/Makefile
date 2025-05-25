# Set CROSS_COMPILE using `source tools/cross-env.sh <arch>`
CROSS_COMPILE ?=
CC ?= $(CROSS_COMPILE)gcc
AR ?= $(CROSS_COMPILE)ar
RANLIB ?= $(CROSS_COMPILE)ranlib
CFLAGS=-O
FILES= asin.o acos.o atan.o hypot.o jn.o j0.o j1.o pow.o gamma.o \
	log.o sin.o sqrt.o tan.o tanh.o sinh.o erf.o exp.o floor.o

libm.a : $(FILES)
       $(AR) rc libm.a $(FILES)

install: libm.a
       mv libm.a ${DESTDIR}/usr/lib
       $(RANLIB) ${DESTDIR}/usr/lib/libm.a

clean:
	rm -f *.o libm.a
