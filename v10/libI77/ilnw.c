/* Origin: /usr/src/libI77/ilnw.c */
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
extern char *f__icptr;
extern char *f__icend;
extern icilist *f__svic;
extern int f__icnum;
#ifdef KR_headers
extern int z_putc();
#else
extern int z_putc(int);
#endif

 static int
z_wSL(Void)
{
	while(f__recpos < f__svic->icirlen)
		z_putc(' ');
	return z_rnew();
	}

 VOID
#ifdef KR_headers
c_liw(a) icilist *a;
#else
c_liw(icilist *a)
#endif
{
	f__reading = 0;
	f__external = 0;
	f__formatted = 1;
	f__putn = z_putc;
	L_len = a->icirlen;
	f__donewrec = z_wSL;
	f__svic = a;
	f__icnum = f__recpos = 0;
	f__cursor = 0;
	f__cf = 0;
	f__curunit = 0;
	f__icptr = a->iciunit;
	f__icend = f__icptr + a->icirlen*a->icirnum;
	f__elist = (cilist *)a;
	}

 integer
#ifdef KR_headers
s_wsni(a) icilist *a;
#else
s_wsni(icilist *a)
#endif
{
	cilist ca;

	c_liw(a);
	ca.cifmt = a->icifmt;
	x_wsne(&ca);
	z_wSL();
	return 0;
	}

 integer
#ifdef KR_headers
s_wsli(a) icilist *a;
#else
s_wsli(icilist *a)
#endif
{
	f__lioproc = l_write;
	c_liw(a);
	return(0);
	}

integer e_wsli(Void)
{
	z_wSL();
	return(0);
	}
