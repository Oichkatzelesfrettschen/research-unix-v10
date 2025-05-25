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
4d3
< #include "fcntl.h"
6,8d4
< #ifndef O_RDONLY
< #define O_RDONLY 0
< #endif
19a16,24
> #ifdef NON_UNIX_STDIO
> #ifndef unlink
> #define unlink remove
> #endif
> #else
> #ifdef MSDOS
> #include "io.h"
> #endif
> #endif
20a26,29
> #ifdef NON_UNIX_STDIO
> extern char *f__r_mode[], *f__w_mode[];
> #endif
> 
32a42,47
> #ifdef NON_UNIX_STDIO
> 		{ FILE *tf;
> 			if (tf = fopen(nbuf, f__w_mode[0]))
> 				fclose(tf);
> 			}
> #else
33a49
> #endif
40a57
> #ifdef NON_UNIX_STDIO
43a61,78
> copy(FILE *from, register long len, FILE *to)
> #endif
> {
> 	int k, len1;
> 	char buf[BUFSIZ];
> 
> 	while(fread(buf, len1 = len > BUFSIZ ? BUFSIZ : (int)len, 1, from)) {
> 		if (!fwrite(buf, len1, 1, to))
> 			return 1;
> 		if ((len -= len1) <= 0)
> 			break;
> 		}
> 	return 0;
> 	}
> #else
> #ifdef KR_headers
> copy(from, len, to) char *from, *to; register long len;
> #else
64a100
> #endif
79a116,120
> #ifdef NON_UNIX_STDIO
> 	FILE *bf, *tf;
> #else
> 	FILE *bf;
> #endif
83,86c124,128
< 	if(b->url) return(0);	/*don't truncate direct files*/
< 	loc=ftell(b->ufd);
< 	(void) fseek(b->ufd,0L,SEEK_END);
< 	len=ftell(b->ufd);
---
> 	if(b->url)
> 		return(0);	/*don't truncate direct files*/
> 	loc=ftell(bf = b->ufd);
> 	fseek(bf,0L,SEEK_END);
> 	len=ftell(bf);
89c131
< #ifdef MSDOS
---
> #ifdef NON_UNIX_STDIO
94a137,139
> #ifdef NON_UNIX_STDIO
> 		if (!(bf = fopen(b->ufnm, f__w_mode[b->ufmt])))
> #else
96c141
< #ifdef MSDOS
---
> #endif
98,100d142
< 		goto done;
< #else
< 			{ rc = 1; goto done; }
103,104c145
< 		return 0;
< #endif
---
> 		goto done;
109,110c150,151
< 	(void) strcpy(nm,"tmp.FXXXXXX");
< 	(void) mktemp(nm);
---
> 	strcpy(nm,"tmp.FXXXXXX");
> 	mktemp(nm);
111a153,182
> #ifdef NON_UNIX_STDIO
> 	if (!(bf = fopen(b->ufnm, f__r_mode[0]))) {
>  bad:
> 		rc = 1;
> 		goto done;
> 		}
> 	if (!(tf = fopen(nm, f__w_mode[0])))
> 		goto bad;
> 	if (copy(bf, loc, tf)) {
>  bad1:
> 		rc = 1;
> 		goto done1;
> 		}
> 	if (!(bf = freopen(b->ufnm, f__w_mode[0], bf)))
> 		goto bad1;
> 	if (!(tf = freopen(nm, f__r_mode[0], tf)))
> 		goto bad1;
> 	if (copy(tf, loc, bf))
> 		goto bad1;
> 	if (f__w_mode[0] != f__w_mode[b->ufmt]) {
> 	 	if (!(bf = freopen(b->ufnm, f__w_mode[b->ufmt+2], bf)))
> 			goto bad1;
> 		fseek(bf, loc, SEEK_SET);
> 		}
> done1:
> 	fclose(tf);
> 	unlink(nm);
> done:
> 	f__cf = b->ufd = bf;
> #else
115a187
> 	fseek(b->ufd, loc, SEEK_SET);
117,124d188
< #ifdef MSDOS
< 	{
< 	extern char *f__r_mode[];
< 	b->uwrt = 0;
< 	if (!(b->ufd = fopen(b->ufnm, f__r_mode[b->ufmt])))
< 		rc = 1;
< 	}
< 	if (loc)
126d189
< 	fseek(b->ufd, loc, SEEK_SET);
