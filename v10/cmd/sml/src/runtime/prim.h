/* Origin: /usr/src/sml/runtime/prim.h */
/*
 * STANDARD ML OF NEW JERSEY COPYRIGHT NOTICE, LICENSE AND DISCLAIMER.
 *
 * Copyright 1989 by AT&T Bell Laboratories
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted,
 * provided that the above copyright notice appear in all copies and that
 * both the copyright notice and this permission notice and warranty
 * disclaimer appear in supporting documentation, and that the name of
 * AT&T Bell Laboratories or any AT&T entity not be used in advertising
 * or publicity pertaining to distribution of the software without
 * specific, written prior permission.
 *
 * AT&T disclaims all warranties with regard to this software, including
 * all implied warranties of merchantability and fitness.  In no event
 * shall AT&T be liable for any special, indirect or consequential
 * damages or any damages whatsoever resulting from loss of use, data or
 * profits, whether in an action of contract, negligence or other
 * tortious action, arising out of or in connection with the use or
 * performance of this software.
 */
#ifndef MIPS
#define _div_e (_div_e0+4)
#define _real_e (_real_e0+4)
#define _interrupt_e (_interrupt_e0+4)
#define _overflow_e (_overflow_e0+4)
#define _systemcall_e (_systemcall_e0+4)
#else
#define div_e div_e0+4
#define real_e real_e0+4
#define interrupt_e interrupt_e0+4
#define overflow_e overflow_e0+4
#define systemcall_e systemcall_e0+4
#endif

#ifdef BSD
#define FIONREAD 0x4004667f
#define TIOCGETP 0x40067408
#endif
#ifdef V9
#define FIONREAD 0x667f
#define TIOCGETP 0x7408
#endif
