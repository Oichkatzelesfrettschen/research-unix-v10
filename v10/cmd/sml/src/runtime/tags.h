/* Origin: /usr/src/sml/runtime/tags.h */
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
/* tags.h
 *
 * This file has a corresponding ML structure tags embedded in structure Boot
 * in the file boot/perv.sml.
 */

/* new tags */
#define width_tags 4
#define power_tags 16
#define tag_record	1     /* 0001 */
#define tag_array	9     /* 1001 */
#define tag_bytearray	11    /* 1011 */
#define tag_string	15    /* 1111 */
#define tag_embedded	7     /* 0111 */
#define tag_suspension	13    /* 1101 */
#define tag_backptr	5     /* 0101 */
#define tag_forwarded	3     /* 0011 */
#define contains_no_ptrs(x) ((x)&2)

/* If the tag is tag_suspension, then the high-order part is NOT a length.
   Instead, it is:   0 = unevaluated suspension
                     1 = evaluated suspension
                     2 = weak pointer
		     3 = nulled weak pointer
*/


/* independent.  uses * instead of << so it will work in as */
#define mak_desc(l,t) ((l)*power_tags+(t))

#define ML_INT(x) ((x)+(x)+1)
#define ML_UNIT  ML_INT(0)
#define ML_NIL   ML_INT(0)
#define ML_FALSE ML_INT(0)
#define ML_TRUE  ML_INT(1)

#define ml_true(x) ((x)==ML_TRUE)

#define CAUSE_GC	1
#define CAUSE_RET	2
#define CAUSE_EXN	3
#define CAUSE_EXPORT	4
#define CAUSE_BLAST	5
#define CAUSE_FAULT	6
#define CAUSE_STOR	7
#define CAUSE_SIGNAL	8
