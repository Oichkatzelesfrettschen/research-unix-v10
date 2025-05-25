/* Origin: /usr/src/libI77/Version.c */
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
< static char junk[] = "\n@(#) LIBI77 VERSION pjw,dmg-mods 1 Feb. 1993\n";
---
> static char junk[] = "\n@(#) LIBI77 VERSION pjw,dmg-mods 23 June 1993\n";
140a141,162
> /* 5 Feb. 1993:  tweaks to NAMELIST: rsne.c: ? prints the namelist being
> 		 sought; namelists of the wrong name are skipped (after
> 		 an error message; xwsne.c: namelist writes have a
> 		 newline before each new variable.
> 		 open.c: ACCESS='APPEND' positions sequential files
> 		 at EOF (nonstandard extension -- that doesn't require
> 		 changing data structures). */
> /* 9 Feb. 1993:  Change some #ifdef MSDOS lines to #ifdef NON_UNIZ_STDIO.
> 		 err.c: under NON_UNIX_STDIO, avoid close(creat(name,0666))
> 		 when the unit has another file descriptor for name. */
> /* 4 March 1993: err.c, open.c: take declaration of fdopen from rawio.h;
> 		 open.c: always give f__w_mode[] 4 elements for use
> 		 in t_runc (in endfile.c -- for change of 1 Feb. 1993). */
> /* 6 March 1993: uio.c: adjust off-end-of-record test for sequential
> 		 unformatted reads to respond to err= rather than end=. */
> /* 12 March 1993: various tweaks for C++ */
> /* 6 April 1993: adjust error returns for formatted inputs to flush
> 		 the current input line when err=label is specified.
> 		 To restore the old behavior (input left mid-line),
> 		 either adjust the #definition of errfl in fio.h or
> 		 omit the invocation of f__doend in err__fl (in err.c).	*/
> /* 23 June 1993: iio.c: fix bug in format reversions for internal writes */
