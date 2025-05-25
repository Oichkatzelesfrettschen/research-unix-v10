/* Origin: /usr/src/libI77/setbuf.c */
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
/*	@(#)setbuf.c	2.2	*/
/*	3.0 SID #	1.2	*/
/*LINTLIBRARY*/
#include <stdio.h>

extern void free();
extern int isatty();
extern unsigned char _smbuf[][_SBFSIZ];
#if !u370
extern unsigned char *_stdbuf[];
#else
extern char *malloc();
#endif

void
setbuf(iop, buf)
register FILE *iop;
char	*buf;
{
	register int fno = fileno(iop);  /* file number */

	if(iop->_base != NULL && iop->_flag & _IOMYBUF)
		free((char*)iop->_base);
	iop->_flag &= ~(_IOMYBUF | _IONBF | _IOLBF);
	if((iop->_base = (unsigned char*)buf) == NULL) {
		iop->_flag |= _IONBF; /* file unbuffered except in fastio */
#if u370
		if ( (iop->_base = (unsigned char *) malloc(BUFSIZ+8)) != NULL){
			iop->_flag |= _IOMYBUF;
			_bufend(iop) = iop->_base + BUFSIZ;
		}
#else
		if (fno < 2)  /* for stdin, stdout, use the existing bufs */
			_bufend(iop) = (iop->_base = _stdbuf[fno]) + BUFSIZ;
#endif

		else   /* otherwise, use small buffers reserved for this */
			_bufend(iop) = (iop->_base = _smbuf[fno]) + _SBFSIZ;
	}
	else {  /* regular buffered I/O, standard buffer size */
		_bufend(iop) = iop->_base + BUFSIZ;
		if (isatty(fno))
			iop->_flag |= _IOLBF;
	}
	iop->_ptr = iop->_base;
	iop->_cnt = 0;
}
