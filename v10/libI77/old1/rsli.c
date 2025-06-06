/* Origin: /usr/src/libI77/rsli.c */
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

extern flag f__lquit;
extern int f__lcount;
extern char *f__icptr;
extern char *f__icend;
extern icilist *f__svic;
extern int f__icnum, f__recpos;

int i_getc(Void)
{
	if(f__recpos >= f__svic->icirlen) {
		if (f__recpos++ == f__svic->icirlen)
			return '\n';
		z_rnew();
		}
	f__recpos++;
	if(f__icptr >= f__icend) err(f__svic->iciend,(EOF),"endfile");
	return(*f__icptr++);
	}

#ifdef KR_headers
int i_ungetc(ch, f) int ch; FILE *f;
#else
int i_ungetc(int ch, FILE *f)
#endif
{
	if (--f__recpos == f__svic->icirlen)
		return '\n';
	if (f__recpos < -1)
		err(f__svic->icierr,110,"recend");
	/* *--icptr == ch, and icptr may point to read-only memory */
	return *--f__icptr /* = ch */;
	}

 static void
#ifdef KR_headers
c_lir(a) icilist *a;
#else
c_lir(icilist *a)
#endif
{
	extern int l_eof;
	f__reading = 1;
	f__external = 0;
	f__formatted = 1;
	f__svic = a;
	L_len = a->icirlen;
	f__recpos = -1;
	f__icnum = f__recpos = 0;
	f__cursor = 0;
	l_getc = i_getc;
	l_ungetc = i_ungetc;
	l_eof = 0;
	f__icptr = a->iciunit;
	f__icend = f__icptr + a->icirlen*a->icirnum;
	f__cf = 0;
	f__curunit = 0;
	f__elist = (cilist *)a;
	}


#ifdef KR_headers
integer s_rsli(a) icilist *a;
#else
integer s_rsli(icilist *a)
#endif
{
	f__lioproc = l_read;
	f__lquit = 0;
	f__lcount = 0;
	c_lir(a);
	return(0);
	}

integer e_rsli(Void)
{ return 0; }

#ifdef KR_headers
s_rsni(a) icilist *a;
#else
extern int x_rsne(cilist*);

s_rsni(icilist *a)
#endif
{
	cilist ca;
	ca.ciend = a->iciend;
	ca.cierr = a->icierr;
	ca.cifmt = a->icifmt;
	c_lir(a);
	return x_rsne(&ca);
	}
