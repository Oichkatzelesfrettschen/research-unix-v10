/* Origin: /usr/src/libI77/wref.c */
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
#include "fmt.h"
#include "fp.h"
#ifndef VAX
#include "ctype.h"
#endif

#ifndef KR_headers
#undef abs
#undef min
#undef max
#include "stdlib.h"
#include "string.h"
#endif

#ifdef KR_headers
wrt_E(p,w,d,e,len) ufloat *p; ftnlen len;
#else
wrt_E(ufloat *p, int w, int d, int e, ftnlen len)
#endif
{
	char buf[FMAX+EXPMAXDIGS+4], *s, *se;
	int d1, delta, e1, i, sign, signspace;
	double dd;
#ifndef VAX
	int e0 = e;
#endif

	if(e <= 0)
		e = 2;
	if(f__scale) {
		if(f__scale >= d + 2 || f__scale <= -d)
			goto nogood;
		}
	if(f__scale <= 0)
		--d;
	if (len == sizeof(real))
		dd = p->pf;
	else
		dd = p->pd;
	if (dd < 0.) {
		signspace = sign = 1;
		dd = -dd;
		}
	else {
		sign = 0;
		signspace = f__cplus;
#ifndef VAX
		if (!dd)
			dd = 0.;	/* avoid -0 */
#endif
		}
	delta = w - (2 /* for the . and the d adjustment above */
			+ 2 /* for the E+ */ + signspace + d + e);
	if (delta < 0) {
nogood:
		while(--w >= 0)
			PUT('*');
		return(0);
		}
	if (f__scale < 0)
		d += f__scale;
	if (d > FMAX) {
		d1 = d - FMAX;
		d = FMAX;
		}
	else
		d1 = 0;
	sprintf(buf,"%#.*E", d, dd);
#ifndef VAX
	/* check for NaN, Infinity */
	if (!isdigit(buf[0])) {
		switch(buf[0]) {
			case 'n':
			case 'N':
				signspace = 0;	/* no sign for NaNs */
			}
		delta = w - strlen(buf) - signspace;
		if (delta < 0)
			goto nogood;
		while(--delta >= 0)
			PUT(' ');
		if (signspace)
			PUT(sign ? '-' : '+');
		for(s = buf; *s; s++)
			PUT(*s);
		return 0;
		}
#endif
	se = buf + d + 3;
	if (f__scale != 1 && dd)
		sprintf(se, "%+.2d", atoi(se) + 1 - f__scale);
	s = ++se;
	if (e < 2) {
		if (*s != '0')
			goto nogood;
		}
#ifndef VAX
	/* accommodate 3 significant digits in exponent */
	if (s[2]) {
#ifdef Pedantic
		if (!e0 && !s[3])
			for(s -= 2, e1 = 2; s[0] = s[1]; s++);

	/* Pedantic gives the behavior that Fortran 77 specifies,	*/
	/* i.e., requires that E be specified for exponent fields	*/
	/* of more than 3 digits.  With Pedantic undefined, we get	*/
	/* the behavior that Cray displays -- you get a bigger		*/
	/* exponent field if it fits.	*/
#else
		if (!e0) {
			for(s -= 2, e1 = 2; s[0] = s[1]; s++)
#ifdef CRAY
				delta--;
			if ((delta += 4) < 0)
				goto nogood
#endif
				;
			}
#endif
		else if (e0 >= 0)
			goto shift;
		else
			e1 = e;
		}
	else
 shift:
#endif
		for(s += 2, e1 = 2; *s; ++e1, ++s)
			if (e1 >= e)
				goto nogood;
	while(--delta >= 0)
		PUT(' ');
	if (signspace)
		PUT(sign ? '-' : '+');
	s = buf;
	i = f__scale;
	if (f__scale <= 0) {
		PUT('.');
		for(; i < 0; ++i)
			PUT('0');
		PUT(*s);
		s += 2;
		}
	else if (f__scale > 1) {
		PUT(*s);
		s += 2;
		while(--i > 0)
			PUT(*s++);
		PUT('.');
		}
	if (d1) {
		se -= 2;
		while(s < se) PUT(*s++);
		se += 2;
		do PUT('0'); while(--d1 > 0);
		}
	while(s < se)
		PUT(*s++);
	if (e < 2)
		PUT(s[1]);
	else {
		while(++e1 <= e)
			PUT('0');
		while(*s)
			PUT(*s++);
		}
	return 0;
	}

#ifdef KR_headers
wrt_F(p,w,d,len) ufloat *p; ftnlen len;
#else
wrt_F(ufloat *p, int w, int d, ftnlen len)
#endif
{
	int d1, sign, n;
	double x;
	char *b, buf[MAXINTDIGS+MAXFRACDIGS+4], *s;

	x= (len==sizeof(real)?p->pf:p->pd);
	if (d < MAXFRACDIGS)
		d1 = 0;
	else {
		d1 = d - MAXFRACDIGS;
		d = MAXFRACDIGS;
		}
	if (x < 0.)
		{ x = -x; sign = 1; }
	else {
		sign = 0;
#ifndef VAX
		if (!x)
			x = 0.;
#endif
		}

	if (n = f__scale)
		if (n > 0)
			do x *= 10.; while(--n > 0);
		else
			do x *= 0.1; while(++n < 0);

#ifdef USE_STRLEN
	sprintf(b = buf, "%#.*f", d, x);
	n = strlen(b) + d1;
#else
	n = sprintf(b = buf, "%#.*f", d, x) + d1;
#endif

	if (buf[0] == '0' && d)
		{ ++b; --n; }
	if (sign) {
		/* check for all zeros */
		for(s = b;;) {
			while(*s == '0') s++;
			switch(*s) {
				case '.':
					s++; continue;
				case 0:
					sign = 0;
				}
			break;
			}
		}
	if (sign || f__cplus)
		++n;
	if (n > w) {
		while(--w >= 0)
			PUT('*');
		return 0;
		}
	for(w -= n; --w >= 0; )
		PUT(' ');
	if (sign)
		PUT('-');
	else if (f__cplus)
		PUT('+');
	while(n = *b++)
		PUT(n);
	while(--d1 >= 0)
		PUT('0');
	return 0;
	}
