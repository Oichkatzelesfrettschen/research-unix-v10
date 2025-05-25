/* Origin: /usr/src/libI77/wsne.c */
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
#include "f2c.h"
#include "fio.h"
#include "lio.h"

 integer
#ifdef KR_headers
s_wsne(a) cilist *a;
#else
s_wsne(cilist *a)
#endif
{
	int n;
	extern integer e_wsle(Void);

	if(!f__init)
		f_init();
	if(n=c_le(a))
		return(n);
	f__reading=0;
	f__external=1;
	f__formatted=1;
	f__putn = t_putc;
	L_len = LINE;
	f__donewrec = x_wSL;
	if(f__curunit->uwrt != 1 && f__nowwriting(f__curunit))
		err(a->cierr, errno, "namelist output start");
	x_wsne(a);
	return e_wsle();
	}
