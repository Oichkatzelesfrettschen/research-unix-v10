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
#ifndef MSDOS
#include "sys/types.h"
#include "sys/stat.h"
#endif
#include "f2c.h"
#include "fio.h"
#include "fcntl.h"
#include "rawio.h"
#include "fmt.h"	/* for struct syl */
#ifdef NON_UNIX_STDIO
#ifdef KR_headers
extern char *malloc();
#else
#undef abs
#undef min
#undef max
#include "stdlib.h"
#endif
#endif
#ifndef O_WRONLY
#define O_WRONLY 1
#endif

/*global definitions*/
unit f__units[MXUNIT];	/*unit table*/
flag f__init;	/*0 on entry, 1 after initializations*/
cilist *f__elist;	/*active external io list*/
flag f__reading;	/*1 if reading, 0 if writing*/
flag f__cplus,f__cblank;
char *f__fmtbuf;
flag f__external;	/*1 if external io, 0 if internal */
#ifdef KR_headers
int (*f__doed)(),(*f__doned)();
int (*f__doend)(),(*f__donewrec)(),(*f__dorevert)();
int (*f__getn)(),(*f__putn)();	/*for formatted io*/
#else
int (*f__getn)(void),(*f__putn)(int);	/*for formatted io*/
int (*f__doed)(struct f__syl*, char*, ftnlen),(*f__doned)(struct f__syl*);
int (*f__dorevert)(void),(*f__donewrec)(void),(*f__doend)(void);
#endif
flag f__sequential;	/*1 if sequential io, 0 if direct*/
flag f__formatted;	/*1 if formatted io, 0 if unformatted*/
FILE *f__cf;	/*current file*/
unit *f__curunit;	/*current unit*/
int f__recpos;	/*place in current record*/
int f__cursor,f__scale;

/*error messages*/
char *F_err[] =
{
	"error in format",				/* 100 */
	"illegal unit number",				/* 101 */
	"formatted io not allowed",			/* 102 */
	"unformatted io not allowed",			/* 103 */
	"direct io not allowed",			/* 104 */
	"sequential io not allowed",			/* 105 */
	"can't backspace file",				/* 106 */
	"null file name",				/* 107 */
	"can't stat file",				/* 108 */
	"unit not connected",				/* 109 */
	"off end of record",				/* 110 */
	"truncation failed in endfile",			/* 111 */
	"incomprehensible list input",			/* 112 */
	"out of free space",				/* 113 */
	"unit not connected",				/* 114 */
	"read unexpected character",			/* 115 */
	"bad logical input field",			/* 116 */
	"bad variable type",				/* 117 */
	"bad namelist name",				/* 118 */
	"variable not in namelist",			/* 119 */
	"no end record",				/* 120 */
	"variable count incorrect",			/* 121 */
	"subscript for scalar variable",		/* 122 */
	"invalid array section",			/* 123 */
	"substring out of bounds",			/* 124 */
	"subscript out of bounds",			/* 125 */
	"can't read file",				/* 126 */
	"can't write file",				/* 127 */
	"'new' file exists"				/* 128 */
};
#define MAXERR (sizeof(F_err)/sizeof(char *)+100)

#ifdef KR_headers
f__canseek(f) FILE *f; /*SYSDEP*/
#else
f__canseek(FILE *f) /*SYSDEP*/
#endif
{
#ifdef MSDOS
	return !isatty(fileno(f));
#else
	struct stat x;

	if (fstat(fileno(f),&x) < 0)
		return(0);
#ifdef S_IFMT
	switch(x.st_mode & S_IFMT) {
	case S_IFDIR:
	case S_IFREG:
		if(x.st_nlink > 0)	/* !pipe */
			return(1);
		else
			return(0);
	case S_IFCHR:
		if(isatty(fileno(f)))
			return(0);
		return(1);
#ifdef S_IFBLK
	case S_IFBLK:
		return(1);
#endif
	}
#else
#ifdef S_ISDIR
	/* POSIX version */
	if (S_ISREG(x.st_mode) || S_ISDIR(x.st_mode)) {
		if(x.st_nlink > 0)	/* !pipe */
			return(1);
		else
			return(0);
		}
	if (S_ISCHR(x.st_mode)) {
		if(isatty(fileno(f)))
			return(0);
		return(1);
		}
	if (S_ISBLK(x.st_mode))
		return(1);
#else
	Help! How does fstat work on this system?
#endif
#endif
	return(0);	/* who knows what it is? */
#endif
}

 void
#ifdef KR_headers
f__fatal(n,s) char *s;
#else
f__fatal(int n, char *s)
#endif
{
	if(n<100 && n>=0) perror(s); /*SYSDEP*/
	else if(n >= (int)MAXERR || n < -1)
	{	fprintf(stderr,"%s: illegal error number %d\n",s,n);
	}
	else if(n == -1) fprintf(stderr,"%s: end of file\n",s);
	else
		fprintf(stderr,"%s: %s\n",s,F_err[n-100]);
	if (f__curunit) {
		fprintf(stderr,"apparent state: unit %d ",f__curunit-f__units);
		fprintf(stderr, f__curunit->ufnm ? "named %s\n" : "(unnamed)\n",
			f__curunit->ufnm);
		}
	else
		fprintf(stderr,"apparent state: internal I/O\n");
	if (f__fmtbuf)
		fprintf(stderr,"last format: %s\n",f__fmtbuf);
	fprintf(stderr,"lately %s %s %s %s",f__reading?"reading":"writing",
		f__sequential?"sequential":"direct",f__formatted?"formatted":"unformatted",
		f__external?"external":"internal");
	sig_die(" IO", 1);
}
/*initialization routine*/
 VOID
f_init(Void)
{	unit *p;

	f__init=1;
	p= &f__units[0];
	p->ufd=stderr;
	p->useek=f__canseek(stderr);
#ifdef COMMENTED_OUT
	if(isatty(fileno(stderr))) {
		extern char *malloc();
		setbuf(stderr, malloc(BUFSIZ));
		/* setvbuf(stderr, _IOLBF, 0, 0); */
	}	/* wastes space, but win for debugging in windows */
#endif
#ifdef NON_UNIX_STDIO
	setbuf(stderr, malloc(BUFSIZ));
#else
	stderr->_flag &= ~_IONBF;
#endif
	p->ufmt=1;
	p->uwrt=1;
	p = &f__units[5];
	p->ufd=stdin;
	p->useek=f__canseek(stdin);
	p->ufmt=1;
	p->uwrt=0;
	p= &f__units[6];
	p->ufd=stdout;
	p->useek=f__canseek(stdout);
	/* IOLBUF and setvbuf only in system 5+ */
#ifdef COMMENTED_OUT
	if(isatty(fileno(stdout))) {
		extern char _sobuf[];
		setbuf(stdout, _sobuf);
		/* setvbuf(stdout, _IOLBF, 0, 0);	/* the buf arg in setvbuf? */
		p->useek = 1;	/* only within a record no bigger than BUFSIZ */
	}
#endif
	p->ufmt=1;
	p->uwrt=1;
}
#ifdef KR_headers
f__nowreading(x) unit *x;
#else
f__nowreading(unit *x)
#endif
{
	long loc;
	extern char *f__r_mode[];
	if (!x->ufnm)
		goto cantread;
	loc=ftell(x->ufd);
	if(freopen(x->ufnm,f__r_mode[x->ufmt],x->ufd) == NULL) {
 cantread:
		errno = 126;
		return(1);
		}
	x->uwrt=0;
	(void) fseek(x->ufd,loc,SEEK_SET);
	return(0);
}
#ifdef KR_headers
f__nowwriting(x) unit *x;
#else
f__nowwriting(unit *x)
#endif
{
	long loc;
	int k;
	extern char *f__w_mode[];

	if (!x->ufnm)
		goto cantwrite;
	if (x->uwrt == 3) { /* just did write, rewind */
		if (close(creat(x->ufnm,0666)))
			goto cantwrite;
		}
	else {
		loc=ftell(x->ufd);
		if (fclose(x->ufd) < 0
		|| (k = x->uwrt == 2 ? creat(x->ufnm,0666)
				     : open(x->ufnm,O_WRONLY)) < 0
		|| (f__cf = x->ufd = fdopen(k,f__w_mode[x->ufmt])) == NULL) {
			x->ufd = NULL;
 cantwrite:
			errno = 127;
			return(1);
			}
		(void) fseek(x->ufd,loc,SEEK_SET);
		}
	x->uwrt = 1;
	return(0);
}
