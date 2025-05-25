/* Origin: /usr/src/libI77/xwsne.c */
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
#include "f2c.h"
#include "fio.h"
#include "lio.h"
#include "fmt.h"

 static VOID
nl_donewrec(Void)
{
	(*f__donewrec)();
	PUT(' ');
	}

#ifdef KR_headers
x_wsne(a) cilist *a;
#else
#include "string.h"

 VOID
x_wsne(cilist *a)
#endif
{
	Namelist *nl;
	char *s;
	Vardesc *v, **vd, **vde;
	ftnint *number, type;
	ftnlen *dims;
	ftnlen size;
	static ftnint one = 1;
	extern ftnlen f__typesize[];

	nl = (Namelist *)a->cifmt;
	PUT('&');
	for(s = nl->name; *s; s++)
		PUT(*s);
	PUT(' ');
	vd = nl->vars;
	vde = vd + nl->nvars;
	while(vd < vde) {
		v = *vd++;
		s = v->name;
#ifdef No_Extra_Namelist_Newlines
		if (f__recpos+strlen(s)+2 >= L_len)
#endif
			nl_donewrec();
		while(*s)
			PUT(*s++);
		PUT(' ');
		PUT('=');
		number = (dims = v->dims) ? dims + 1 : &one;
		type = v->type;
		if (type < 0) {
			size = -type;
			type = TYCHAR;
			}
		else
			size = f__typesize[type];
		l_write(number, v->addr, size, type);
		if (vd < vde) {
			if (f__recpos+2 >= L_len)
				nl_donewrec();
			PUT(',');
			PUT(' ');
			}
		else if (f__recpos+1 >= L_len)
			nl_donewrec();
		}
	PUT('/');
	}
