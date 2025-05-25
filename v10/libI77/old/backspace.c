/* Origin: /usr/src/libI77/backspace.c */
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
/*	@(#)backspace.c	1.3	*/
/*	3.0 SID #	1.2	*/
#include "fio.h"
f_back(a) alist *a;
{	unit *b;
	int n,i;
	long x;
	char buf[32];
	if(a->aunit >= MXUNIT || a->aunit < 0)
		err(a->aerr,101,"backspace")
	b= &units[a->aunit];
	if(b->useek==0) err(a->aerr,106,"backspace")
	if(b->ufd==NULL) err(a->aerr,114,"backspace")
	if(b->uend==1)
	{	b->uend=0;
		return(0);
	}
	if(b->uwrt)
	{	(void) t_runc(b);
		(void) nowreading(b);
	}
	if(b->url>0)
	{	long y;
		x=ftell(b->ufd);
		y = x % b->url;
		if(y == 0) x--;
		x /= b->url;
		x *= b->url;
		(void) fseek(b->ufd,x,0);
		return(0);
	}
	if(b->ufmt==0)
	{	(void) fseek(b->ufd,-(long)sizeof(int),1);
		(void) fread((char *)&n,sizeof(int),1,b->ufd);
		(void) fseek(b->ufd,-(long)n-2*sizeof(int),1);
		return(0);
	}
	for(;;)
	{	long y;
		y = x=ftell(b->ufd);
		if(x<sizeof(buf)) x=0;
		else x -= sizeof(buf);
		(void) fseek(b->ufd,x,0);
		n=fread(buf,1,(int)(y-x), b->ufd);
		for(i=n-2;i>=0;i--)
		{
			if(buf[i]!='\n') continue;
			(void) fseek(b->ufd,(long)(i+1-n),1);
			return(0);
		}
		if(x==0)
			{
			(void) fseek(b->ufd, 0L, 0);
			return(0);
			}
		else if(n<=0) err(a->aerr,(EOF),"backspace")
		(void) fseek(b->ufd, x, 0);
	}
}
