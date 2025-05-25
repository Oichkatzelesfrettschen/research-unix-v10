/* Origin: /usr/src/libI77/sue.c */
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
/*	@(#)sue.c	1.2	*/
/*	3.0 SID #	1.2	*/
#include "fio.h"
extern int reclen;
long recloc;
s_rsue(a) cilist *a;
{
	int n;
	if(!init) f_init();
	reading=1;
	if(n=c_sue(a)) return(n);
	recpos=0;
	if(curunit->uwrt) (void) nowreading(curunit);
	if(fread((char *)&reclen,sizeof(int),1,cf)
		!= 1)
	{	if(feof(cf))
		{	curunit->uend = 1;
			err(a->ciend, EOF, "start");
		}
		clearerr(cf);
		err(a->cierr, errno, "start");
	}
	return(0);
}
s_wsue(a) cilist *a;
{
	int n;
	if(!init) f_init();
	if(n=c_sue(a)) return(n);
	reading=0;
	reclen=0;
	if(!curunit->uwrt) (void) nowwriting(curunit);
	recloc=ftell(cf);
	(void) fseek(cf,(long)sizeof(int),1);
	return(0);
}
c_sue(a) cilist *a;
{
	if(a->ciunit >= MXUNIT || a->ciunit < 0)
		err(a->cierr,101,"startio");
	external=sequential=1;
	formatted=0;
	curunit = &units[a->ciunit];
	elist=a;
	if(curunit->ufd==NULL && fk_open(SEQ,UNF,a->ciunit))
		err(a->cierr,114,"sue");
	cf=curunit->ufd;
	if(curunit->ufmt) err(a->cierr,103,"sue")
	if(!curunit->useek) err(a->cierr,103,"sue")
	return(0);
}
e_wsue()
{	long loc;
	(void) fwrite((char *)&reclen,sizeof(int),1,cf);
	loc=ftell(cf);
	(void) fseek(cf,recloc,0);
	(void) fwrite((char *)&reclen,sizeof(int),1,cf);
	(void) fseek(cf,loc,0);
	return(0);
}
e_rsue()
{
	(void) fseek(cf,(long)(reclen-recpos+sizeof(int)),1);
	return(0);
}
