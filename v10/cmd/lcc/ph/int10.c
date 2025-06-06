/* The Plum Hall Validation Suite for C
 * Unpublished copyright (c) 1986-1991, Chiron Systems Inc and Plum Hall Inc.
 * VERSION: 4
 * DATE: 1993-01-01
 * The "ANSI" mode of the Suite corresponds to the official ANSI C, X3.159-1989.
 * As per your license agreement, your distribution is not to be moved or copied outside the Designated Site
 * without specific permission from Plum Hall Inc.
 */

/****************************************************************************
 ** Self-checking C source code generated by EGEN component of             **
 **    The Plum Hall Validation Suite for C.                               **
 **    (C) 1986-1988 Chiron Systems Inc and Plum Hall Inc                  **
 **    EGEN Version 1.09.000  88/08/21                                     **
 **                                                                        **
 **    EGEN -P -R10 -V -A -N5 -Dinteger.gen ( @ @ ) @ ( @ @ )              **
 ****************************************************************************/
#include "defs.h"


int main()
	{
	extern char *Filename;
	auto unsigned int ui;
	static unsigned int * pui;
	auto unsigned int ** ppui;
	auto int i;
	static int * pi;
	auto int ** ppi;
	auto unsigned short us;
	static unsigned short * pus;
	auto unsigned short ** ppus;
	auto short s;
	static short * ps;
	auto short ** pps;
	auto unsigned char uc;
	static unsigned char * puc;
	auto unsigned char ** ppuc;
	auto char c;
	static char * pc;
	auto char ** ppc;
	auto unsigned long ul;
	static unsigned long * pul;
	auto unsigned long ** ppul;
	auto long l;
	static long * pl;
	auto long ** ppl;
	register int rint1;
	register int rint2;
	register int rint3;
	register int rint4;
	register int rint5;

	ui = ivalue(100);
	pui = &ui;
	ppui = &pui;
	i = ivalue(10);
	pi = &i;
	ppi = &pi;
	us = lvalue(33000);
	pus = &us;
	ppus = &pus;
	s = ivalue(13);
	ps = &s;
	pps = &ps;
	uc = ivalue(128);
	puc = &uc;
	ppuc = &puc;
	c = ivalue(20);
	pc = &c;
	ppc = &pc;
	ul = lvalue(65000L);
	pul = &ul;
	ppul = &pul;
	l = lvalue(97L);
	pl = &l;
	ppl = &pl;
	rint1 = ivalue(1);
	rint2 = ivalue(2);
	rint3 = ivalue(3);
	rint4 = ivalue(4);
	rint5 = ivalue(5);
	Filename = "int10.c";

	/* 13 & 13 => 13 */
	/* 0x80e8 &= 13 => 0x8 */
	/* 5 ^ 20 => 17 */
	/* 17 ^ 20 => 5 */
	/* 0x8 > 5 => 1 */
	iequals(__LINE__, ((**ppus &= (s & s)) > ((rint5 ^ *pc) ^ **ppc)), 1);
	iequals(__LINE__, us, (unsigned)8);

	/* post++ 14 => 13 */
	/* 13 + 0x80 => 141 */
	/* 128 != 128 => 0 */
	/* 20 += 0 => 20 */
	/* 141 + 20 => 161 */
	iequals(__LINE__, ((((**pps)++ ) + *puc) + (**ppc += (**ppuc != **ppuc))), 161);
	iequals(__LINE__, c, 20);
	iequals(__LINE__, s, 14);

	/* ! 0xfde8L => 0 */
	/* 0 != 0xfde8L => 1 */
	/* 0x64 - 5 => 0x5f */
	/* 0x80 &= 0x5f => 0x0 */
	/* 1 >= 0 => 1 */
	iequals(__LINE__, ((( ! **ppul) != ul) >= (*puc &= (**ppui - rint5))), 1);
	iequals(__LINE__, uc, (unsigned)0);

	/* 0x8 + 97L => 105L */
	/* 105L != 20 => 1 */
	/* 1 & 1 => 1 */
	iequals(__LINE__, (((us + *pl) != *pc) & ((rint5 || *pui) || ui)), 1);

	/* 10 / 4 => 2 */
	/* 97L += 2 => 99L */
	/* 0 > 0 => 0 */
	/* 1 ^ 0 => 1 */
	/* 99L * 1 => 99L */
	lequals(__LINE__, ((l += (i / rint4)) * (rint1 ^ (uc > **ppuc))), 99L);
	lequals(__LINE__, l, 99L);

	return 	report(Filename);
	}
