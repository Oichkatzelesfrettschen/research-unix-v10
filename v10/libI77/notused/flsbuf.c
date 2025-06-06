/* Origin: /usr/src/libI77/flsbuf.c */
/*
 * Copyright 1990, 1991, 1992, 1993
 *      AT&T Bell Laboratories and Bellcore.
 *
 * Permission to use, copy, modify, and distribute this software
 * and its documentation for any purpose and without fee is hereby
 * granted, provided that the above copyright notice appear in all
 * copies and that both the copyright notice and this permission
 * notice and warranty disclaimer appear in supporting documentation,
 * and that the names of AT&T Bell Laboratories or Bellcore or any of
 * their entities not be used in advertising or publicity pertaining to
 * distribution of the software without specific, written prior permission.
 *
 * AT&T and Bellcore disclaim all warranties with regard to this
 * software, including all implied warranties of merchantability
 * and fitness.  In no event shall AT&T or Bellcore be liable for
 * any special, indirect or consequential damages or any damages
 * whatsoever resulting from loss of use, data or profits, whether
 * in an action of contract, negligence or other tortious action,
 * arising out of or in connection with the use or performance of
 * this software.
 */
/*	@(#)flsbuf.c	2.8	*/
/*LINTLIBRARY*/
#include <stdio.h>
#include "stdiom.h"
#include <errno.h>

extern void free();
extern int errno, write(), close(), isatty();
extern char *malloc();
extern FILE *_lastbuf;
#if !u370
extern unsigned char *_stdbuf[];
#endif
extern unsigned char _smbuf[][_SBFSIZ];

/*
 * Flush buffers on exit
 */

void
_cleanup()
{
	register FILE *iop;

	for(iop = _iob; iop < _lastbuf; iop++)
		(void) fclose(iop);
}
/*
	fclose() will flush (output) buffers for a buffered open
	FILE and then issue a system close on the _fileno.  The
	_base field will be reset to NULL for any but stdin and
	stdout, the _ptr field will be set the same as the _base
	field. The _flags and the _cnt field will be zeroed.
	If buffers had been obtained via malloc(), the space will
	be free()'d.  In case the FILE was not open, or fflush()
	or close() failed, an EOF will be returned, otherwise the
	return value is 0.
 */

int
fclose(iop)
register FILE *iop;
{
	register int rtn=EOF;

	if(iop == NULL)
		return(rtn);
	if(iop->_flag & (_IOREAD | _IOWRT | _IORW)) {
		rtn = (iop->_flag & _IONBF)? 0: fflush(iop);
		if(close(fileno(iop)) < 0) {
			rtn = EOF;
			errno = ENOENT;
		}
	}
	if(iop->_flag & _IOMYBUF) {
		free((char*)iop->_base);
		iop->_base = NULL;
	}
	iop->_flag = 0;
	iop->_cnt = 0;
	iop->_ptr = iop->_base;
	return(rtn);
}

/*
	The fflush() routine must take care because of the
	possibility for recursion. The calling program might
	do IO in an interupt catching routine that is likely
	to interupt the write() call within fflush()
 */

int
fflush(iop)
register FILE *iop;
{
	if (!(iop->_flag & _IOWRT)) {
		iop->_cnt = 0;
		return(0);
	}
	while(!(iop->_flag & _IONBF) && (iop->_flag & _IOWRT) &&
			(iop->_base != NULL) && (iop->_ptr > iop->_base) )
		(void) _xflsbuf(iop);
	return(ferror(iop) ? EOF : 0);
}

/* The routine _flsbuf may or may not actually flush the output buffer.  If
 * the file is line-buffered, the fact that iop->_cnt has run below zero
 * is meaningless: it is always kept below zero so that invocations of putc
 * will consistently give control to _flsbuf, even if the buffer is far from
 * full.  _flsbuf, on seeing the "line-buffered" flag, determines whether the
 * buffer is actually full by comparing iop->_ptr to the end-of-buffer pointer
 * _bufend(iop).  If it is full, or if an output line is completed (with a
 * newline), the buffer is flushed.  (Note: the character argument to _flsbuf
 * is not flushed with the current buffer if the buffer is actually full--
 * it goes into the buffer after flushing.)
 */

int
_flsbuf(c, iop)
unsigned char c;
register FILE *iop;
{
    unsigned char c1;

    do {
	/* check for linebuffered with write perm, but no EOF */
	if ( (iop->_flag & (_IOLBF | _IOWRT | _IOEOF)) == (_IOLBF | _IOWRT) ) {
		if ( iop->_ptr >= _bufend(iop) )  /* if buffer full, */
			break;		    /* exit do-while, and flush buf. */
		if ( (*iop->_ptr++ = c) != '\n' )
			return(c);
		return(_xflsbuf(iop) == EOF ? EOF : c);
	}
	/* write out an unbuffered file, if have write perm, but no EOF */
	if ( (iop->_flag & (_IONBF | _IOWRT | _IOEOF)) == (_IONBF | _IOWRT) ) {
		c1 = c;
		iop->_cnt = 0;
		if (write(fileno(iop), (char *) &c1, 1) == 1)
			return(c);
		iop->_flag |= _IOERR;
		return(EOF);
	}
	/* The _wrtchk call is here rather than at the top of _flsbuf to re- */
	/* duce overhead for line-buffered I/O under normal circumstances.  */

	if (_WRTCHK(iop))			/* is writing legitimate? */
		return(EOF);
    } while ( (iop->_flag & (_IONBF | _IOLBF)) );


    (void) _xflsbuf(iop);   /* full buffer:  flush buffer */
    (void) putc((char) c, iop);  /* then put "c" in newly emptied buf */
			/* (which, because of signals, may NOT be empty) */
    return( ferror(iop) ? EOF : c);
}

/* The function _xflsbuf writes out the current contents of the output
 * buffer delimited by iop->_base and iop->_ptr.
 * iop->_cnt is reset appropriately, but its value on entry to _xflsbuf
 * is ignored.
 *
 * The following code is not strictly correct.  If a signal is raised,
 * invoking a signal-handler which generates output into the same buffer
 * being flushed, a peculiar output sequence may result (for example,
 * the output generated by the signal-handler may appear twice).  At
 * present no means has been found to guarantee correct behavior without
 * resorting to the disabling of signals, a means considered too expensive.
 * For now the code has been written with the intent of reducing the
 * probability of strange effects and, when they do occur, of confining
 * the damage.  Except under extremely pathological circumstances, this
 * code should be expected to respect buffer boundaries even in the face
 * of interrupts and other signals.
 */

int
_xflsbuf(iop)
register FILE *iop;
{
	register unsigned char *base;
	register int n;

	n = iop->_ptr - (base = iop->_base);
	iop->_ptr = base;
	iop->_cnt = (iop->_flag &(_IONBF | _IOLBF)) ? 0 : _bufsiz(iop);
	_BUFSYNC(iop);
	if (n > 0 && n != write(fileno(iop),(char*)base,(unsigned)n) )  {
		iop->_flag |= _IOERR;
		return(EOF);
	}
	return(0);
}

/* The function _wrtchk checks to see whether it is legitimate to write
 * to the specified device.  If it is, _wrtchk sets flags in iop->_flag for
 * writing, assures presence of a buffer, and returns 0.  If writing is not
 * legitimate, EOF is returned.
 */

int
_wrtchk(iop)
register FILE *iop;
{
	if ( (iop->_flag & (_IOWRT | _IOEOF)) != _IOWRT ) {
		if (!(iop->_flag & (_IOWRT | _IORW)))
			return(EOF);  /* bogus call--read-only file */
		iop->_flag = iop->_flag & ~_IOEOF | _IOWRT; /* fix flags */
	}
	if (iop->_base == NULL)    /* this is first I/O to file--get buffer */
		_findbuf(iop);
	if (iop->_ptr == iop->_base && !(iop->_flag & (_IONBF | _IOLBF)) )  {
		iop->_cnt = _bufsiz(iop); /* first write since seek--set cnt */
		_BUFSYNC(iop);
	}
	return(0);
}

/*
 * _findbuf, called only when iop->_base == NULL, locates a predefined buffer
 * or allocates a buffer using malloc.  If a buffer is obtained from malloc,
 * the _IOMYBUF flag is set in iop->_flag.
 */

_findbuf(iop)
register FILE *iop;
{	extern int errno;
	int sverr;
	register int fno = fileno(iop); /* file number */

	/* allocate a small block for unbuffered, large for buffered */
	if (iop->_flag & _IONBF)  {
		_bufend(iop) = (iop->_base = _smbuf[fno]) + _SBFSIZ;
	}  else  {
#if !u370
		if (fno < 2)  /* use existing bufs for stdin, stdout */
			_bufend(iop) = (iop->_base = _stdbuf[fno]) + BUFSIZ;
		else 
#endif
		if ((iop->_base = (unsigned char *) malloc(BUFSIZ+8)) != NULL) {
			/* if  we got a buffer */
			iop->_flag |= _IOMYBUF;
			_bufend(iop) = iop->_base + BUFSIZ;
		} else
			/* if no room for buffer, use small buffer */
			_bufend(iop) = (iop->_base = _smbuf[fno]) + _SBFSIZ;
	}
	iop->_ptr = iop->_base;
	sverr = errno;
	if ( isatty(fno) && !(iop->_flag & _IONBF) )
		iop->_flag |= _IOLBF;
	errno = sverr;		/* isatty may set errno to ENOTTY */
}

/* The function _bufsync is called because interrupts and other signals
 * which occur in between the decrementing of iop->_cnt and the incrementing
 * of iop->_ptr, or in other contexts as well, may upset the synchronization
 * of iop->_cnt and iop->ptr.  If this happens, calling _bufsync should
 * resynchronize the two quantities (this is not always possible).  Resyn-
 * chronization guarantees that putc invocations will not write beyond
 * the end of the buffer.  Note that signals during _bufsync can cause
 * _bufsync to do the wrong thing, but usually with benign effects.
 */

_bufsync(iop)
register FILE *iop;
{
	register int spaceleft;

	if ((spaceleft = _bufend(iop) - iop->_ptr) < 0)
		iop->_ptr = _bufend(iop);
	else if (spaceleft < iop->_cnt)
		iop->_cnt = spaceleft;
}
