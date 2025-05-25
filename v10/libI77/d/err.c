/* Origin: /usr/src/libI77/err.c */
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
1c1
< #ifndef MSDOS
---
> #ifndef NON_UNIX_STDIO
7,8d6
< #include "fcntl.h"
< #include "rawio.h"
9a8
> #include "rawio.h"	/* for fcntl.h, fdopen */
20,22d18
< #ifndef O_WRONLY
< #define O_WRONLY 1
< #endif
79c75,76
< 	"'new' file exists"				/* 128 */
---
> 	"'new' file exists",				/* 128 */
> 	"can't append to file"				/* 129 */
89c86
< #ifdef MSDOS
---
> #ifdef NON_UNIX_STDIO
174,180d170
< #ifdef COMMENTED_OUT
< 	if(isatty(fileno(stderr))) {
< 		extern char *malloc();
< 		setbuf(stderr, malloc(BUFSIZ));
< 		/* setvbuf(stderr, _IOLBF, 0, 0); */
< 	}	/* wastes space, but win for debugging in windows */
< #endif
182c172
< 	setbuf(stderr, malloc(BUFSIZ));
---
> 	setbuf(stderr, (char *)malloc(BUFSIZ));
240a231,234
> #ifdef NON_UNIX_STDIO
> 		if (!(f__cf = x->ufd =
> 				freopen(x->ufnm,f__w_mode[x->ufmt],x->ufd)))
> #else
241a236
> #endif
245a241,244
> #ifdef NON_UNIX_STDIO
> 		if (!(f__cf = x->ufd =
> 			freopen(x->ufnm, f__w_mode[x->ufmt+2], x->ufd)))
> #else
249c248,250
< 		|| (f__cf = x->ufd = fdopen(k,f__w_mode[x->ufmt])) == NULL) {
---
> 		|| (f__cf = x->ufd = fdopen(k,f__w_mode[x->ufmt])) == NULL)
> #endif
> 			{
259a261,274
> 
>  int
> #ifdef KR_headers
> err__fl(f, m, s) int f, m; char *s;
> #else
> err__fl(int f, int m, char *s)
> #endif
> {
> 	if (!f)
> 		f__fatal(m, s);
> 	if (f__doend)
> 		(*f__doend)();
> 	return errno = m;
> 	}
