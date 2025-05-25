/* Origin: /usr/src/libF77/ef1asc_.c */
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
/* EFL support routine to copy string b to string a */

#include "f2c.h"


#define M	( (long) (sizeof(long) - 1) )
#define EVEN(x)	( ( (x)+ M) & (~M) )

#ifdef KR_headers
extern VOID s_copy();
ef1asc_(a, la, b, lb) ftnint *a, *b; ftnlen *la, *lb;
#else
extern void s_copy(char*,char*,ftnlen,ftnlen);
int ef1asc_(ftnint *a, ftnlen *la, ftnint *b, ftnlen *lb)
#endif
{
s_copy( (char *)a, (char *)b, EVEN(*la), *lb );
#ifdef __cplusplus
return 0;
#endif
}
