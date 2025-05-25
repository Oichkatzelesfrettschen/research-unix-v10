/* Origin: /usr/src/libI77/endfile.c */
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
/*	@(#)endfile.c	1.3	*/

#include "fio.h"
static alist *ax;
extern char *mktemp(), *strcpy();
f_end(a) alist *a;
{
	unit *b;
	if(a->aunit>=MXUNIT || a->aunit<0) err(a->aerr,101,"endfile");
	b = &units[a->aunit];
	if(b->ufd==NULL) return(0);
	b->uend=1;
	if( b->useek==0) return(0);
	ax=a;
	if(b->uwrt) (void) nowreading(b);
	return(t_runc(b));
}
t_runc(b) unit *b;
{
	char buf[128],nm[16];
	FILE *tmp;
	int n,m;
	long loc,len;
	if(b->url) return(0);	/*don't truncate direct files*/
	loc=ftell(b->ufd);
	(void) fseek(b->ufd,0L,2);
	len=ftell(b->ufd);
	if(loc==len || b->useek==0 || b->ufnm==NULL) return(0);
	(void) strcpy(nm,"tmp.FXXXXXX");
	if(b->uwrt) (void) nowreading(b);
	(void) mktemp(nm);
	tmp=fopen(nm,"w");
	if(!tmp)
		printf("hey %s\n", nm);
	(void) fseek(b->ufd,0L,0);
	for(;loc>0;)
	{
		n=fread(buf,1,loc>128?128:(int)loc,b->ufd);
		if(n>loc) n=loc; else if (n<=0) break;
		loc -= n;
		(void) fwrite(buf,1,n,tmp);
	}
	(void) fflush(tmp);
	for(n=0;n<10;n++)
	{
		if((m=fork())==-1) continue;
		else if(m==0)
		{
			(void) execl("/bin/cp","cp",nm,b->ufnm,0);
			(void) execl("/usr/bin/cp","cp",nm,b->ufnm,0);
			fprintf(stdout,"no cp\n");
			exit(1);
		}
		(void) wait(&m);
		if(m!=0) err(ax->aerr,111,"endfile");
		(void) fclose(tmp);
		(void) unlink(nm);
		return(0);
	}
	err(ax->aerr,111,"endfile");
}
