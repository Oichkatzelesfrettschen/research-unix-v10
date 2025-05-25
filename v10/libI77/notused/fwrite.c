/* Origin: /usr/src/libI77/fwrite.c */
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
/*	@(#)fwrite.c	3.6	*/
/*LINTLIBRARY*/
/*
 * This version writes directly to the buffer rather than looping on putc.
 * Ptr args aren't checked for NULL because the program would be a
 * catastrophic mess anyway.  Better to abort than just to return NULL.
 *
 * This version does buffered writes larger than BUFSIZ directly, when
 * the buffer is empty.
 */
#include <stdio.h>
#include "stdiom.h"

#define MIN(x, y)       (x < y ? x : y)

extern char *memcpy();

int
fwrite(ptr, size, count, iop)
char *ptr;
int size, count;
register FILE *iop;
{
	register unsigned nleft;
	register int n;
	register unsigned char *cptr, *bufend;

	if (size <= 0 || count <= 0 || _WRTCHK(iop))
	        return (0);

	bufend = _bufend(iop);
	nleft = count*size;

	/* if the file is unbuffered, or if the iop->ptr = iop->base, and there
	   is > BUFSZ chars to write, we can do a direct write */
	if (iop->_base >= iop->_ptr)  {	/*this covers the unbuffered case, too*/
		if (((iop->_flag & _IONBF) != 0) || (nleft >= BUFSIZ))  {
			if ((n=write(fileno(iop),ptr,nleft)) != nleft)
			    {
				iop->_flag |= _IOERR;
				n = (n >= 0) ? n : 0;
			}
			return n/size;
		}
	}
	/* Put characters in the buffer */
	/* note that the meaning of n when just starting this loop is
	   irrelevant.  It is defined in the loop */
	for (; ; ptr += n) {
	        while ((n = bufend - (cptr = iop->_ptr)) <= 0)  /* full buf */
	                if (_xflsbuf(iop) == EOF)
	                        return (count - (nleft + size - 1)/size);
	        n = MIN(nleft, n);
	        (void) memcpy((char *) cptr, ptr, n);
	        iop->_cnt -= n;
	        iop->_ptr += n;
	        _BUFSYNC(iop);
		/* done; flush if linebuffered with a newline */
	        if ((nleft -= n) == 0)  { 
			if (iop->_flag & (_IOLBF | _IONBF)) {
	               		if ((iop->_flag & _IONBF) || (memchr(iop->_base,
					'\n',count * size) != NULL))  {
				     	(void) _xflsbuf(iop);
				}
			}
	                return (count);
	        }
	}
}
