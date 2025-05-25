/* Origin: /usr/src/libI77/wsfe.c */
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
/*write sequential formatted external*/
#include "f2c.h"
#include "fio.h"
#include "fmt.h"
extern int f__hiwater;

#ifdef KR_headers
x_putc(c)
#else
x_putc(int c)
#endif
{
	/* this uses \n as an indicator of record-end */
	if(c == '\n' && f__recpos < f__hiwater) {	/* fseek calls fflush, a loss */
#ifndef NON_UNIX_STDIO
		if(f__cf->_ptr + f__hiwater - f__recpos < buf_end(f__cf))
			f__cf->_ptr += f__hiwater - f__recpos;
		else
#endif
			(void) fseek(f__cf, (long)(f__hiwater - f__recpos), SEEK_CUR);
	}
	f__recpos++;
	return putc(c,f__cf);
}
x_wSL(Void)
{
	(*f__putn)('\n');
	f__recpos=0;
	f__cursor = 0;
	f__hiwater = 0;
	return(1);
}
xw_end(Void)
{
	if(f__nonl == 0)
		(*f__putn)('\n');
	f__hiwater = f__recpos = f__cursor = 0;
	return(0);
}
xw_rev(Void)
{
	if(f__workdone) (*f__putn)('\n');
	f__hiwater = f__recpos = f__cursor = 0;
	return(f__workdone=0);
}

#ifdef KR_headers
integer s_wsfe(a) cilist *a;	/*start*/
#else
integer s_wsfe(cilist *a)	/*start*/
#endif
{	int n;
	if(!f__init) f_init();
	if(n=c_sfe(a)) return(n);
	f__reading=0;
	f__sequential=1;
	f__formatted=1;
	f__external=1;
	f__elist=a;
	f__hiwater = f__cursor=f__recpos=0;
	f__nonl = 0;
	f__scale=0;
	f__fmtbuf=a->cifmt;
	f__curunit = &f__units[a->ciunit];
	f__cf=f__curunit->ufd;
	if(pars_f(f__fmtbuf)<0) err(a->cierr,100,"startio");
	f__putn= x_putc;
	f__doed= w_ed;
	f__doned= w_ned;
	f__doend=xw_end;
	f__dorevert=xw_rev;
	f__donewrec=x_wSL;
	fmt_bg();
	f__cplus=0;
	f__cblank=f__curunit->ublnk;
	if(f__curunit->uwrt != 1 && f__nowwriting(f__curunit))
		err(a->cierr,errno,"write start");
	return(0);
}
