/* Origin: /usr/src/libI77/rsli.c */
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
3a4
> #include "fmt.h" /* for f__doend */
12c13
< int i_getc(Void)
---
> static int i_getc(Void)
20c21
< 	if(f__icptr >= f__icend) err(f__svic->iciend,(EOF),"endfile");
---
> 	if(f__icptr >= f__icend) err(f__svic->iciend,(EOF),"internal read");
23a25
>  static
74a77
> 	f__doend = 0;
82c85
< s_rsni(a) icilist *a;
---
> integer s_rsni(a) icilist *a;
86c89
< s_rsni(icilist *a)
---
> integer s_rsni(icilist *a)
