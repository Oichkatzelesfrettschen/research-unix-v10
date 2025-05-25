/* Origin: /usr/src/libI77/ftell.c */
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
/*	@(#)ftell.c	1.2	*/
/*	3.0 SID #	1.2	*/
/*LINTLIBRARY*/
/*
 * Return file offset.
 * Coordinates with buffering.
 */
#include <stdio.h>

extern long lseek();

long
ftell(iop)
FILE	*iop;
{
	long	tres;
	register int adjust;

	if(iop->_cnt < 0)
		iop->_cnt = 0;
	if(iop->_flag & _IOREAD)
		adjust = - iop->_cnt;
	else if(iop->_flag & (_IOWRT | _IORW)) {
		adjust = 0;
		if(iop->_flag & _IOWRT && iop->_base &&
					(iop->_flag & _IONBF) == 0)
			adjust = iop->_ptr - iop->_base;
	} else
		return(-1);
	tres = lseek(fileno(iop), 0L, 1);
	if(tres >= 0)
		tres += (long)adjust;
	return(tres);
}
