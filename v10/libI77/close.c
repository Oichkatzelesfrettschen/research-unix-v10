/* Origin: /usr/src/libI77/close.c */
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
#ifdef KR_headers
integer f_clos(a) cllist *a;
#else
#undef abs
#undef min
#undef max
#include "stdlib.h"
#ifdef NON_UNIX_STDIO
#ifndef unlink
#define unlink remove
#endif
#else
#ifdef MSDOS
#include "io.h"
#else
#ifdef __cplusplus
extern "C" int unlink(const char*);
#else
extern int unlink(const char*);
#endif
#endif
#endif

integer f_clos(cllist *a)
#endif
{	unit *b;

	if(a->cunit >= MXUNIT) return(0);
	b= &f__units[a->cunit];
	if(b->ufd==NULL)
		goto done;
	if (!a->csta)
		if (b->uscrtch == 1)
			goto Delete;
		else
			goto Keep;
	switch(*a->csta) {
		default:
	 	Keep:
		case 'k':
		case 'K':
			if(b->uwrt == 1)
				t_runc((alist *)a);
			if(b->ufnm) {
				fclose(b->ufd);
				free(b->ufnm);
				}
			break;
		case 'd':
		case 'D':
		Delete:
			if(b->ufnm) {
				fclose(b->ufd);
				unlink(b->ufnm); /*SYSDEP*/
				free(b->ufnm);
				}
		}
	b->ufd=NULL;
 done:
	b->uend=0;
	b->ufnm=NULL;
	return(0);
	}
 void
#ifdef KR_headers
f_exit()
#else
f_exit(void)
#endif
{	int i;
	static cllist xx;
	if (!xx.cerr) {
		xx.cerr=1;
		xx.csta=NULL;
		for(i=0;i<MXUNIT;i++)
		{
			xx.cunit=i;
			(void) f_clos(&xx);
		}
	}
}
 int
#ifdef KR_headers
flush_()
#else
flush_(void)
#endif
{	int i;
	for(i=0;i<MXUNIT;i++)
		if(f__units[i].ufd != NULL && f__units[i].uwrt)
			fflush(f__units[i].ufd);
#ifdef __cplusplus
return 0;
#endif
}
