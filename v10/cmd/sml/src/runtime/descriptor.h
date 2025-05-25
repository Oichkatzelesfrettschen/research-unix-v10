/* Origin: /usr/src/sml/runtime/descriptor.h */
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
/* needs tags.h */

#define is_ptr(x) (!((int)(x)&1))
#define mak_int(x) ((int)(x)*2+1)
#define mask_tags (power_tags-1)
#define get_len(x) (*(int *)(x)>>width_tags)
#define get_lenz(x) ((((*(int*)(x))&(power_tags-1))==tag_suspension)?1:get_len(x))
#define get_strlen(x) (((*(int *)(x)>>width_tags)+3)/4)
#define get_tag(x) (*(int *)(x)&mask_tags)

typedef char * mlstring;

extern char *get_str();
