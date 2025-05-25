/* Origin: /usr/src/libI77/setvbuf.c */
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
/*	@(#)setvbuf.c	1.2			*/
/*LINTLIBRARY*/
#include "stdio.h"

extern void free();
extern int isatty();

int
setvbuf(iop, type, buf, size)
register FILE *iop;
register int type;
register char	*buf;
register int size;
{
	char *malloc();

	if(iop->_base != NULL && iop->_flag & _IOMYBUF)
		free((char*)iop->_base);
	iop->_flag &= ~(_IOMYBUF | _IONBF | _IOLBF);
	switch (type)  {
	    /*note that the flags are the same as the possible values for type*/
	    case _IONBF:
		/* file is unbuffered */
		iop->_flag |= _IONBF;
		_bufend(iop) = iop->_base = NULL;
		break;
	    case _IOLBF:
	    case _IOFBF:
		iop->_flag |= type;
		size = (size == 0) ? BUFSIZ : size;
		if ((size > BUFSIZ) || (iop->_base == NULL))
			iop->_base = (unsigned char *)
				     malloc((unsigned)(size + 8));
		_bufend(iop) = iop->_base + size;
		break;
	    default:
		return -1;
	}
	iop->_ptr = iop->_base;
	iop->_cnt = 0;
	return 0;
}
