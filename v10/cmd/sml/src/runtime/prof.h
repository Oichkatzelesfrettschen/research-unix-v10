/* Origin: /usr/src/sml/runtime/prof.h */
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
/* modifications here must be duplicated in codegen/codegen.sml,
   vax/vaxprim.sml, and m68/m68prim.sml */
#define ARRAYS 		0
#define ARRAYSIZE 	1
#define STRINGS 		2
#define STRINGSIZE 	3
#define REFCELLS 	4
#define REFLISTS 	5
#define CLOSURES 	6
#define CLOSURESLOTS 	11
#define CLOSUREOVFL 	(CLOSURES + CLOSURESLOTS)
#define KCLOSURES 	18
#define KCLOSURESLOTS 	11
#define KCLOSUREOVFL 	(KCLOSURES + KCLOSURESLOTS)
#define CCLOSURES 	30
#define CCLOSURESLOTS 	11
#define CCLOSUREOVFL 	(CCLOSURES + CCLOSURESLOTS)
#define LINKS 		42
#define LINKSLOTS 	11
#define LINKOVFL 	(LINKS + LINKSLOTS)
#define SPLINKS 	54
#define SPLINKSLOTS 	11
#define SPLINKOVFL 	(SPLINKS + SPLINKSLOTS)
#define RECORDS 	66
#define RECORDSLOTS 	11
#define RECORDOVFL 	(RECORDS + RECORDSLOTS)
#define SPILLS 		78
#define SPILLSLOTS 	21
#define SPILLOVFL 	(SPILLS + SPILLSLOTS)
#define KNOWNCALLS 	(SPILLOVFL + 1)
#define STDKCALLS 	(KNOWNCALLS + 1)
#define STDCALLS 	(STDKCALLS + 1)
#define CNTCALLS 	(STDCALLS + 1)
#define ARITHOVH 	(CNTCALLS+1)
#define ARITHSLOTS 	5
#define PROFSIZE 	(ARITHOVH+ARITHSLOTS)
