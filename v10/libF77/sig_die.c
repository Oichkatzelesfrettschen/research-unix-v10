/* Origin: /usr/src/libF77/sig_die.c */
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
#include "stdio.h"
#include "signal.h"

#ifndef SIGIOT
#define SIGIOT SIGABRT
#endif

#ifdef KR_headers
void sig_die(s, kill) register char *s; int kill;
#else
#include "stdlib.h"
#ifdef __cplusplus
extern "C" {
#endif
 extern void f_exit(void);

void sig_die(register char *s, int kill)
#endif
{
	/* print error message, then clear buffers */
	fprintf(stderr, "%s\n", s);
	fflush(stderr);
	f_exit();
	fflush(stderr);

	if(kill)
		{
		/* now get a core */
		signal(SIGIOT, SIG_DFL);
		abort();
		}
	else
		exit(1);
	}
#ifdef __cplusplus
}
#endif
