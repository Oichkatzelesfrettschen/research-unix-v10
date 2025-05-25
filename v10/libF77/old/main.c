/* Origin: /usr/src/libF77/main.c */
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
/* STARTUP PROCEDURE FOR UNIX FORTRAN PROGRAMS */

#include <stdio.h>
#include <signal.h>

int xargc;
char **xargv;

main(argc, argv, arge)
int argc;
char **argv;
char **arge;
{
int sigfdie(), sigidie(), sigqdie(), sigindie(), sigtdie();

xargc = argc;
xargv = argv;
signal(SIGFPE, sigfdie);	/* ignore underflow, enable overflow */
signal(SIGIOT, sigidie);
if( (int)signal(SIGQUIT,sigqdie) & 01) signal(SIGQUIT, SIG_IGN);
if( (int)signal(SIGINT, sigindie) & 01) signal(SIGINT, SIG_IGN);
signal(SIGTERM,sigtdie);

#ifdef pdp11
	ldfps(01200); /* detect overflow as an exception */
#endif

f_init();
MAIN__();
f_exit();
}


static sigfdie()
{
sigdie("Floating Exception", 1);
}



static sigidie()
{
sigdie("IOT Trap", 1);
}


static sigqdie()
{
sigdie("Quit signal", 1);
}



static sigindie()
{
sigdie("Interrupt", 0);
}



static sigtdie()
{
sigdie("Killed", 0);
}



static sigdie(s, kill)
register char *s;
int kill;
{
/* print error message, then clear buffers */
fflush(stderr);
fprintf(stderr, "%s\n", s);
f_exit();
fflush(stderr);

if(kill)
	{
	/* now get a core */
	signal(SIGIOT, 0);
	abort();
	}
else
	exit(1);
}
