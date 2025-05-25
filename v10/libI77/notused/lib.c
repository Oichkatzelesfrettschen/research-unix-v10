/* Origin: /usr/src/libI77/lib.c */
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
/*	@(#)lib.c	1.2	*/
#include "fio.h"
setcilist(x,u,fmt,rec,xerr,end) cilist *x;
char *fmt;
{
	x->ciunit=u;
	x->cifmt=fmt;
	x->cirec=rec;
	x->cierr=xerr;
	x->ciend=end;
}
setolist(x,xunit,fname,sta,fm,rl,blnk,oerr) olist *x;
	char *fname,*sta,*fm,*blnk;
{
	x->oerr=oerr;
	x->ounit=xunit;
	x->ofnm=fname;
	x->ofnmlen=strlen(fname);
	x->osta=sta;
	x->ofm=fm;
	x->orl=rl;
	x->oblnk=blnk;
}
stcllist(x,xunit,stat,cerr) cllist *x; char *stat;
{
	x->cerr=cerr;
	x->cunit=xunit;
	x->csta=stat;
}
setalist(x,xunit,aerr) alist *x;
{
	x->aunit=xunit;
	x->aerr=aerr;
}
