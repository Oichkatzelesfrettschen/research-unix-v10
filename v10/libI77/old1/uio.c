/* Origin: /usr/src/libI77/uio.c */
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
uiolen f__reclen;

#ifdef KR_headers
do_us(number,ptr,len) ftnint *number; char *ptr; ftnlen len;
#else
do_us(ftnint *number, char *ptr, ftnlen len)
#endif
{
	if(f__reading)
	{
		f__recpos += *number * len;
		if(f__recpos>f__reclen)
			err(f__elist->ciend, 110, "do_us");
		if (fread(ptr,(int)len,(int)(*number),f__cf) != *number)
			err(f__elist->ciend, EOF, "do_us");
		return(0);
	}
	else
	{
		f__reclen += *number * len;
		(void) fwrite(ptr,(int)len,(int)(*number),f__cf);
		return(0);
	}
}
#ifdef KR_headers
integer do_ud(number,ptr,len) ftnint *number; char *ptr; ftnlen len;
#else
integer do_ud(ftnint *number, char *ptr, ftnlen len)
#endif
{
	f__recpos += *number * len;
	if(f__recpos > f__curunit->url && f__curunit->url!=1)
		err(f__elist->cierr,110,"do_ud");
	if(f__reading)
	{
		if(fread(ptr,(int)len,(int)(*number),f__cf) != *number)
			err(f__elist->cierr,EOF,"do_ud")
		else return(0);
	}
	(void) fwrite(ptr,(int)len,(int)(*number),f__cf);
	return(0);
}
#ifdef KR_headers
integer do_uio(number,ptr,len) ftnint *number; char *ptr; ftnlen len;
#else
integer do_uio(ftnint *number, char *ptr, ftnlen len)
#endif
{
	if(f__sequential)
		return(do_us(number,ptr,len));
	else	return(do_ud(number,ptr,len));
}
