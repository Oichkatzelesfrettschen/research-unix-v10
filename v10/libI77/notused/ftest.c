/* Origin: /usr/src/libI77/ftest.c */
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
/*	@(#)ftest.c	1.2	*/
#include "fio.h"
#define FLOAT double
cilist x,y;
main(argc,argv) char **argv;
{	FLOAT dd[20];
	int ret[22];
	long one=1;
	int i,n,j;
	if(argc<2)
	{	fprintf(stderr,"%s infmt [outfmt] [n]\n",argv[0]);
		exit(1);
	}
	setcilist(&x,5,argv[1],0,1,1);
	argc--;
	argv++;
	if(argc<2 || argv[1][0]!='(')
		setcilist(&y,6,argv[0],0,1,1);
	else
	{	setcilist(&y,6,argv[1],0,1,1);
		argc--;
		argv++;
	}
	if(argc>=2) n=atoi(argv[1]);
	else n=1;
	j=0;
	ret[j++]=s_rsfe(&x);
	for(i=0;i<n;i++)
	{	ret[j++]=do_fio(&one,&dd[i],(long)sizeof(FLOAT));
	}
	ret[j++]=e_rsfe();
	for(i=0;i<j;i++) fprintf(stderr,"%d ",ret[i]);
	putc('\n',stderr);
	j=0;
	ret[j++]=s_wsfe(&y);
	for(i=0;i<n;i++)
		ret[j++]=do_fio(&one,&dd[i],(long)sizeof(FLOAT));
	ret[j++]=e_wsfe();
	for(i=0;i<j;i++) fprintf(stderr,"%d ",ret[i]);
	putc('\n',stderr);
	f_exit();
	exit(0);
}
