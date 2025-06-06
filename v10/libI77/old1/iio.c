/* Origin: /usr/src/libI77/iio.c */
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
#include "fmt.h"
extern char *f__icptr;
char *f__icend;
extern icilist *f__svic;
int f__icnum;
extern int f__hiwater;
z_getc(Void)
{
	if(f__recpos++ < f__svic->icirlen) {
		if(f__icptr >= f__icend) err(f__svic->iciend,(EOF),"endfile");
		return(*f__icptr++);
		}
	err(f__svic->icierr,110,"recend");
}
#ifdef KR_headers
z_putc(c)
#else
z_putc(int c)
#endif
{
	if(f__icptr >= f__icend) err(f__svic->icierr,110,"inwrite");
	if(f__recpos++ < f__svic->icirlen)
		*f__icptr++ = c;
	else	err(f__svic->icierr,110,"recend");
	return 0;
}
z_rnew(Void)
{
	f__icptr = f__svic->iciunit + (++f__icnum)*f__svic->icirlen;
	f__recpos = 0;
	f__cursor = 0;
	f__hiwater = 0;
	return 1;
}

 static int
z_endp(Void)
{
	(*f__donewrec)();
	return 0;
	}

#ifdef KR_headers
c_si(a) icilist *a;
#else
c_si(icilist *a)
#endif
{
	f__elist = (cilist *)a;
	f__fmtbuf=a->icifmt;
	if(pars_f(f__fmtbuf)<0)
		err(a->icierr,100,"startint");
	fmt_bg();
	f__sequential=f__formatted=1;
	f__external=0;
	f__cblank=f__cplus=f__scale=0;
	f__svic=a;
	f__icnum=f__recpos=0;
	f__cursor = 0;
	f__hiwater = 0;
	f__icptr = a->iciunit;
	f__icend = f__icptr + a->icirlen*a->icirnum;
	f__curunit = 0;
	f__cf = 0;
	return(0);
}
y_ierr(Void)
{
	err(f__elist->cierr, 110, "iio");
}
#ifdef KR_headers
integer s_rsfi(a) icilist *a;
#else
integer s_rsfi(icilist *a)
#endif
{	int n;
	if(n=c_si(a)) return(n);
	f__reading=1;
	f__doed=rd_ed;
	f__doned=rd_ned;
	f__getn=z_getc;
	f__dorevert = y_ierr;
	f__donewrec = z_rnew;
	f__doend = z_endp;
	return(0);
}

z_wnew(Void)
{
	while(f__recpos++ < f__svic->icirlen)
		*f__icptr++ = ' ';
	f__recpos = 0;
	f__cursor = 0;
	f__hiwater = 0;
	f__icnum++;
	return 1;
}
#ifdef KR_headers
integer s_wsfi(a) icilist *a;
#else
integer s_wsfi(icilist *a)
#endif
{	int n;
	if(n=c_si(a)) return(n);
	f__reading=0;
	f__doed=w_ed;
	f__doned=w_ned;
	f__putn=z_putc;
	f__dorevert = y_ierr;
	f__donewrec = z_wnew;
	f__doend = z_endp;
	return(0);
}
integer e_rsfi(Void)
{	int n;
	n = en_fio();
	f__fmtbuf = NULL;
	return(n);
}
integer e_wsfi(Void)
{
	int n;
	n = en_fio();
	f__fmtbuf = NULL;
	if(f__icnum >= f__svic->icirnum)
		return(n);
	while(f__recpos++ < f__svic->icirlen)
		*f__icptr++ = ' ';
	return(n);
}
