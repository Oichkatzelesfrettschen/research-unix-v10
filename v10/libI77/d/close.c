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
9a10,14
> #ifdef NON_UNIX_STDIO
> #ifndef unlink
> #define unlink remove
> #endif
> #else
18a24
> #endif
39c45
< 				(void) t_runc((alist *)a);
---
> 				t_runc((alist *)a);
41c47
< 				(void) fclose(b->ufd);
---
> 				fclose(b->ufd);
49,50c55,56
< 				(void) fclose(b->ufd);
< 				(void) unlink(b->ufnm); /*SYSDEP*/
---
> 				fclose(b->ufd);
> 				unlink(b->ufnm); /*SYSDEP*/
78c84
<  void
---
>  int
87a94,96
> #ifdef __cplusplus
> return 0;
> #endif
