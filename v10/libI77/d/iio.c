/* Origin: /usr/src/libI77/iio.c */
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
15a16,18
> #ifdef __cplusplus
> 	return 0;
> #endif
68a72
> 
71a76,78
> #ifdef __cplusplus
> 	return 0;
> #endif
72a80,89
> 
>  int
> iw_rev(Void)
> {
> 	if(f__workdone)
> 		z_endp();
> 	f__hiwater = f__recpos = f__cursor = 0;
> 	return(f__workdone=0);
> 	}
> 
111c128
< 	f__dorevert = y_ierr;
---
> 	f__dorevert = iw_rev;
