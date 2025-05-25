/* Origin: /usr/src/libI77/lread.c */
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
67c67
< 		l_eof = f__curunit->uend = 1;
---
> 		f__curunit->uend = l_eof = 1;
127c127
< 			err(f__elist->cierr,112,"bad repetition count")
---
> 			errfl(f__elist->cierr,112,"bad repetition count");
160c160
< 			err(f__elist->cierr,112,"exponent field")
---
> 			errfl(f__elist->cierr,112,"exponent field");
203c203
< 				err(f__elist->cierr,112,"invalid number")
---
> 				errfl(f__elist->cierr,112,"invalid number");
239c239
< 				err(f__elist->cierr,112,"complex format")
---
> 				errfl(f__elist->cierr,112,"complex format");
245c245
< 				err(f__elist->cierr,112,"no star")
---
> 				errfl(f__elist->cierr,112,"no star");
263c263
< 		err(f__elist->cierr,112,"no real part");
---
> 		errfl(f__elist->cierr,112,"no real part");
268c268
< 		err(f__elist->cierr,112,"no comma");
---
> 		errfl(f__elist->cierr,112,"no comma");
275c275
< 		err(f__elist->cierr,112,"no imaginary part");
---
> 		errfl(f__elist->cierr,112,"no imaginary part");
277c277
< 	if(ch!=')') err(f__elist->cierr,112,"no )");
---
> 	if(ch!=')') errfl(f__elist->cierr,112,"no )");
294c294
< 				err(f__elist->cierr,112,"no star")
---
> 				errfl(f__elist->cierr,112,"no star");
315c315
< 		else	err(f__elist->cierr,112,"logical");
---
> 		else	errfl(f__elist->cierr,112,"logical");
331,332c331,333
< 	p=f__lchar=malloc((unsigned int)size);
< 	if(f__lchar==NULL) err(f__elist->cierr,113,"no space");
---
> 	p=f__lchar = (char *)malloc((unsigned int)size);
> 	if(f__lchar == NULL)
> 		errfl(f__elist->cierr,113,"no space");
368c369
< 				f__lchar = realloc(f__lchar,
---
> 				f__lchar = (char *)realloc(f__lchar,
400c401
< 				f__lchar = realloc(f__lchar,
---
> 				f__lchar = (char *)realloc(f__lchar,
413c414,415
< 			f__lchar= realloc(f__lchar, (unsigned int)(size += BUFSIZE));
---
> 			f__lchar= (char *)realloc(f__lchar,
> 					(unsigned int)(size += BUFSIZE));
528c530
< 				err(f__elist->cierr,errno,"list in")
---
> 				errfl(f__elist->cierr,errno,"list in");
536c538
< 			Ptr->flchar = f__lx;
---
> 			Ptr->flchar = (char)f__lx;
540c542
< 			Ptr->flshort=f__lx;
---
> 			Ptr->flshort = (short)f__lx;
600a603
> 	f__doend = xrd_SL;
