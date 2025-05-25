/* Origin: /usr/src/libI77/rsfe.c */
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
/*	@(#)rsfe.c	1.2	*/
/*	3.0 SID #	1.2	*/
/* read sequential formatted external */
#include "fio.h"
#include "fmt.h"
extern int x_getc(),rd_ed(),rd_ned();
extern int x_endp(),x_rev(),xrd_SL();
s_rsfe(a) cilist *a; /* start */
{	int n;
	if(!init) f_init();
	if(n=c_sfe(a)) return(n);
	reading=1;
	sequential=1;
	formatted=1;
	external=1;
	elist=a;
	cursor=recpos=0;
	scale=0;
	fmtbuf=a->cifmt;
	curunit= &units[a->ciunit];
	cf=curunit->ufd;
	if(pars_f(fmtbuf)<0) err(a->cierr,100,"startio");
	getn= x_getc;
	doed= rd_ed;
	doned= rd_ned;
	fmt_bg();
	doend=x_endp;
	donewrec=xrd_SL;
	dorevert=x_rev;
	cblank=curunit->ublnk;
	cplus=0;
	if(curunit->uwrt) (void) nowreading(curunit);
	return(0);
}
xrd_SL()
{	int ch;
	if(!curunit->uend)
		while((ch=getc(cf))!='\n' && ch!=EOF);
	cursor=recpos=0;
	return(1);
}
x_getc()
{	int ch;
	if(curunit->uend) return(EOF);
	ch = getc(cf);
	if(ch!=EOF && ch!='\n')
	{	recpos++;
		return(ch);
	}
	if(ch=='\n')
	{	(void) ungetc(ch,cf);
		return(ch);
	}
	if(feof(cf))
	{	errno=0;
		curunit->uend=1;
		return(-1);
	}
	return(-1);
}
x_endp()
{
	(void) xrd_SL();
	return(0);
}
x_rev()
{
	(void) xrd_SL();
	return(0);
}
