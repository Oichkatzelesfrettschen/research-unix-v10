/* Origin: /usr/src/libI77/due.c */
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
/*	@(#)due.c	1.2	*/
/*	3.0 SID #	1.2	*/
#include "fio.h"
s_rdue(a) cilist *a;
{
	int n;
	if(n=c_due(a)) return(n);
	reading=1;
	if(curunit->uwrt) (void) nowreading(curunit);
	return(0);
}
s_wdue(a) cilist *a;
{
	int n;
	if(n=c_due(a)) return(n);
	reading=0;
	if(!curunit->uwrt) (void) nowwriting(curunit);
	return(0);
}
c_due(a) cilist *a;
{
	if(!init) f_init();
	if(a->ciunit>=MXUNIT || a->ciunit<0)
		err(a->cierr,101,"startio");
	recpos=sequential=formatted=0;
	external=1;
	curunit = &units[a->ciunit];
	elist=a;
	if(curunit->ufd==NULL && fk_open(DIR,UNF,a->ciunit) ) err(a->cierr,104,"due");
	cf=curunit->ufd;
	if(curunit->ufmt) err(a->cierr,102,"cdue")
	if(!curunit->useek) err(a->cierr,104,"cdue")
	if(curunit->ufd==NULL) err(a->cierr,114,"cdue")
	(void) fseek(cf,(long)(a->cirec-1)*curunit->url,0);
	curunit->uend = 0;
	return(0);
}
e_rdue()
{
	if(curunit->url==1 || recpos==curunit->url)
		return(0);
	(void) fseek(cf,(long)(curunit->url-recpos),1);
	if(ftell(cf)%curunit->url)
		err(elist->cierr,200,"syserr");
	return(0);
}
e_wdue()
{
	return(e_rdue());
}
