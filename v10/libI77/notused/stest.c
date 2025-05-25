/* Origin: /usr/src/libI77/stest.c */
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
/*	@(#)stest.c	1.2	*/
#include "fio.h"
#define out(a,b) {n=b;if(n==0) fprintf(stderr,"%s:%d\n",a,errno);else \
		fprintf(stderr,"%s:%d %d\n",a,errno,n);}
extern errno;
olist xopen;
cllist xclose;
alist xaux;
cilist xio;
long one = 1;
char xx[] = "1234";
char yy[] = "terrible junk";
main()
{
	int n;
	setolist(&xopen,9,"junk","o","u",0,NULL,0);
	out("open",f_open(&xopen));
	setalist(&xaux,9,0);
	out("rew",f_rew(&xaux));
	setcilist(&xio,9,NULL,0,0,0);
	out("start",s_wsue(&xio));
	out("io",do_uio(&one,xx,(long)sizeof(xx)-1));
	out("endw",e_wsue());
	out("enf",f_end(&xaux));
	out("bck",f_back(&xaux));
	out("bck",f_back(&xaux));
	out("startr",s_rsue(&xio));
	out("rio",do_uio(&one,yy,(long)sizeof(xx)-1));
	out("endr",e_rsue());
	fprintf(stdout,"yy: %s\n",yy);
}
