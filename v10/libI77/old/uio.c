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
int reclen;
do_us(number,ptr,len) ftnint *number; ftnlen len; char *ptr;
{
	if(reading)
	{
		recpos += *number * len;
		if(recpos>reclen)
		{
			err(elist->ciend,(-1), "eof/uio");
		}
		(void) fread(ptr,(int)len,(int)(*number),cf);
		return(0);
	}
	else
	{
		reclen += *number * len;
		(void) fwrite(ptr,(int)len,(int)(*number),cf);
		return(0);
	}
}
integer do_uio(number,ptr,len) ftnint *number; ftnlen len; char *ptr;
{
	if(sequential)
		return(do_us(number,ptr,len));
	else	return(do_ud(number,ptr,len));
}
do_ud(number,ptr,len) ftnint *number; ftnlen len; char *ptr;
{
	recpos += *number * len;
	if(recpos > curunit->url && curunit->url!=1)
		err(elist->cierr,110,"eof/uio");
	if(reading)
	{
		if(fread(ptr,(int)len,(int)(*number),cf)
			!= *number)
			err(elist->cierr,27,"eof/uio")
		else return(0);
	}
	(void) fwrite(ptr,(int)len,(int)(*number),cf);
	return(0);
}
