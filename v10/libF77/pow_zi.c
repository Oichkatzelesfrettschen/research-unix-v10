/* Origin: /usr/src/libF77/pow_zi.c */
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

#ifdef KR_headers
VOID pow_zi(p, a, b) 	/* p = a**b  */
 doublecomplex *p, *a; integer *b;
#else
extern void z_div(doublecomplex*, doublecomplex*, doublecomplex*);
void pow_zi(doublecomplex *p, doublecomplex *a, integer *b) 	/* p = a**b  */
#endif
{
integer n;
double t;
doublecomplex x;
static doublecomplex one = {1.0, 0.0};

n = *b;
p->r = 1;
p->i = 0;

if(n == 0)
	return;
if(n < 0)
	{
	n = -n;
	z_div(&x, &one, a);
	}
else
	{
	x.r = a->r;
	x.i = a->i;
	}

for( ; ; )
	{
	if(n & 01)
		{
		t = p->r * x.r - p->i * x.i;
		p->i = p->r * x.i + p->i * x.r;
		p->r = t;
		}
	if(n >>= 1)
		{
		t = x.r * x.r - x.i * x.i;
		x.i = 2 * x.r * x.i;
		x.r = t;
		}
	else
		break;
	}
}
