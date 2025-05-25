/* Origin: /usr/src/libI77/open.c */
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
6d5
< #include "fcntl.h"
8,11d6
< #ifndef O_WRONLY
< #define O_RDONLY 0
< #define O_WRONLY 1
< #endif
15d9
< extern FILE *fdopen();
28c22
< char *f__w_mode[2] = {"w", "w"};
---
> char *f__w_mode[4] = {"w", "w", "r+w", "r+w"};
31c25
< char *f__w_mode[2] = {"wb", "w"};
---
> char *f__w_mode[4] = {"wb", "w", "r+b", "r+"};
40c34
< #ifdef MSDOS
---
> #ifdef NON_UNIX_STDIO
79c73,74
< 	char buf[256];
---
> 	integer rv;
> 	char buf[256], *s;
81c76,78
< #ifndef MSDOS
---
> #ifdef NON_UNIX_STDIO
> 	FILE *tf;
> #else
94c91
< #ifdef MSDOS
---
> #ifdef NON_UNIX_STDIO
107c104,105
< 		if((n=f_clos(&x))!=0) return(n);
---
> 		if ((rv = f_clos(&x)) != 0)
> 			return rv;
109c107
< 	b->url=a->orl;
---
> 	b->url = (int)a->orl;
133c131
< #ifdef MSDOS
---
> #ifdef NON_UNIX_STDIO
149,150c147
< 		(void) close(creat(buf, 0666));
< 		break;
---
> 		goto replace;
153c150
< #ifdef MSDOS
---
> #ifdef NON_UNIX_STDIO
161a159,163
>  replace:
> #ifdef NON_UNIX_STDIO
> 		if (tf = fopen(buf,f__w_mode[0]))
> 			fclose(tf);
> #else
163c165
< 		break;
---
> #endif
176,177c178,180
< 		if((b->ufd = fopen(buf, f__r_mode[b->ufmt])) == NULL) {
< 			if ((n = open(buf,O_WRONLY)) >= 0) {
---
> 		if(!(b->ufd = fopen(buf, f__r_mode[b->ufmt]))) {
> #ifdef NON_UNIX_STDIO
> 			if (b->ufd = fopen(buf, f__w_mode[b->ufmt+2]))
179c182,187
< 				}
---
> 			else if (b->ufd = fopen(buf, f__w_mode[b->ufmt]))
> 				b->uwrt = 1;
> 			else
> #else
> 			if ((n = open(buf,O_WRONLY)) >= 0)
> 				b->uwrt = 2;
185a194
> #endif
190c199
< #ifndef MSDOS
---
> #ifndef NON_UNIX_STDIO
194c203,208
< 	if(a->orl && b->useek) rewind(b->ufd);
---
> 	if(b->useek)
> 		if (a->orl)
> 			rewind(b->ufd);
> 		else if ((s = a->oacc) && (*s == 'a' || *s == 'A')
> 			&& fseek(b->ufd, 0L, SEEK_END))
> 				err(a->oerr,129,"open");
