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
#include "f2c.h"
#include "fio.h"
extern uiolen f__reclen;
long f__recloc;

#ifdef KR_headers
c_sue(a) cilist *a;
#else
c_sue(cilist *a)
#endif
{
	if(a->ciunit >= MXUNIT || a->ciunit < 0)
		err(a->cierr,101,"startio");
	f__external=f__sequential=1;
	f__formatted=0;
	f__curunit = &f__units[a->ciunit];
	f__elist=a;
	if(f__curunit->ufd==NULL && fk_open(SEQ,UNF,a->ciunit))
		err(a->cierr,114,"sue");
	f__cf=f__curunit->ufd;
	if(f__curunit->ufmt) err(a->cierr,103,"sue")
	if(!f__curunit->useek) err(a->cierr,103,"sue")
	return(0);
}
#ifdef KR_headers
integer s_rsue(a) cilist *a;
#else
integer s_rsue(cilist *a)
#endif
{
	int n;
	if(!f__init) f_init();
	f__reading=1;
	if(n=c_sue(a)) return(n);
	f__recpos=0;
	if(f__curunit->uwrt && f__nowreading(f__curunit))
		err(a->cierr, errno, "read start");
	if(fread((char *)&f__reclen,sizeof(uiolen),1,f__cf)
		!= 1)
	{	if(feof(f__cf))
		{	f__curunit->uend = 1;
			err(a->ciend, EOF, "start");
		}
		clearerr(f__cf);
		err(a->cierr, errno, "start");
	}
	return(0);
}
#ifdef KR_headers
integer s_wsue(a) cilist *a;
#else
integer s_wsue(cilist *a)
#endif
{
	int n;
	if(!f__init) f_init();
	if(n=c_sue(a)) return(n);
	f__reading=0;
	f__reclen=0;
	if(f__curunit->uwrt != 1 && f__nowwriting(f__curunit))
		err(a->cierr, errno, "write start");
	f__recloc=ftell(f__cf);
	(void) fseek(f__cf,(long)sizeof(uiolen),SEEK_CUR);
	return(0);
}
integer e_wsue(Void)
{	long loc;
	(void) fwrite((char *)&f__reclen,sizeof(uiolen),1,f__cf);
	loc=ftell(f__cf);
	(void) fseek(f__cf,f__recloc,SEEK_SET);
	(void) fwrite((char *)&f__reclen,sizeof(uiolen),1,f__cf);
	(void) fseek(f__cf,loc,SEEK_SET);
	return(0);
}
integer e_rsue(Void)
{
	(void) fseek(f__cf,(long)(f__reclen-f__recpos+sizeof(uiolen)),SEEK_CUR);
	return(0);
}
