/* Origin: /usr/src/libI77/rewind.c */
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
/*	@(#)rewind.c	1.2	*/
/*	3.0 SID #	1.2	*/
#include "fio.h"
f_rew(a) alist *a;
{
	unit *b;
	if(a->aunit>=MXUNIT || a->aunit<0) err(a->aerr,101,"rewind");
	b = &units[a->aunit];
	if(b->ufd == NULL) return(0);
	if(!b->useek) err(a->aerr,106,"rewind")
	if(b->uwrt)
	{	(void) nowreading(b);
		(void) t_runc(b);
	}
	rewind(b->ufd);
	b->uend=0;
	return(0);
}
