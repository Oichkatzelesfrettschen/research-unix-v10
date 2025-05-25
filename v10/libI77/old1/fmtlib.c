/* Origin: /usr/src/libI77/fmtlib.c */
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
/*	@(#)fmtlib.c	1.2	*/
#define MAXINTLENGTH 23
#ifdef __cplusplus
extern "C" {
#endif
#ifdef KR_headers
char *f__icvt(value,ndigit,sign, base) long value; int *ndigit,*sign;
 register int base;
#else
char *f__icvt(long value, int *ndigit, int *sign, int base)
#endif
{	static char buf[MAXINTLENGTH+1];
	register int i;
	if(value>0) *sign=0;
	else if(value<0)
	{	value = -value;
		*sign= 1;
	}
	else
	{	*sign=0;
		*ndigit=1;
		buf[MAXINTLENGTH]='0';
		return(&buf[MAXINTLENGTH]);
	}
	for(i=MAXINTLENGTH-1;value>0;i--)
	{	*(buf+i)=(int)(value%base)+'0';
		value /= base;
	}
	*ndigit=MAXINTLENGTH-1-i;
	return(&buf[i+1]);
}
#ifdef __cplusplus
	}
#endif
