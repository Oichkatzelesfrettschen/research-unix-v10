#include "tdef.h"
#include "ext.h"
#include "fns.h"
#include <ctype.h>

/*
 * n6.c -- width functions, sizes and fonts
*/

n_width(Tchar j)
{
	int i, k;

	if (iszbit(j))
		return 0;
	if (ismot(j)) {
		if (isvmot(j))
			return(0);
		k = absmot(j);
		if (isnmot(j))
			k = -k;
		return(k);
	}
	i = cbits(j);
	if (i < ' ') {
		if (i == '\b')
			return(-widthp);
		if (i == PRESC)
			i = eschar;
		else if (i == HX)
			return(0);
	}
	if (i == ohc)
		return(0);
	i = trtab[i];
	if (i < ' ')
		return(0);
	k = t.width[i] * t.Char;
	widthp = k;
	return(k);
}


Tchar n_setch(int c)
{
	int j;
	char temp[50];
	char *s;

	s = temp;
	if (c == '(') {	/* \(xx */
		if ((*s++ = getach()) == 0 || (*s++ = getach()) == 0)
			return(0);
	} else {	/* \C'...' */
		c = getach();
		while ((*s = getach()) != c && *s != 0 && s < temp + sizeof(temp) - 1)
			s++;
	}
	*s = '\0';
	if ((j = findch(temp)) > 0)
		return j | chbits;
	else
		return 0;
}

Tchar n_setabs(void)	/* set absolute char from \C'...' */
{			/* for now, a no-op */
	int n;

	getch();
	n = 0;
	n = inumb(&n);
	getch();
	if (nonumb)
		return 0;
	if (n >= nchtab + ALPHABET) {
		ERROR "\\N'%d' toooo large", n WARN;
		return 0;
	}
	return n + nchtab + ALPHABET;
}

int n_findft(int i)
{
	int k;

	if ((k = i - '0') >= 0 && k <= nfonts && k < smnt)
		return(k);
	for (k = 0; fontlab[k] != i; k++)
		if (k > nfonts)
			return(-1);
	return(k);
}



void n_mchbits(void)
{
	chbits = 0;
	setfbits(chbits, font);
	sps = width(' ' | chbits);
}


void n_setps(void )
{
	int i, j;

	i = cbits(getch());
	if (isdigit(i)) {		/* \sd or \sdd */
		i -= '0';
		if (i == 0)		/* \s0 */
			;
		else if (i <= 3 && (ch=getch()) && isdigit(cbits(ch))) {	/* \sdd */
			ch = 0;
		}
	} else if (i == '(') {		/* \s(dd */
		getch();
		getch();
	} else if (i == '+' || i == '-') {	/* \s+, \s- */
		j = cbits(getch());
		if (isdigit(j)) {		/* \s+d, \s-d */
			;
		} else if (j == '(') {		/* \s+(dd, \s-(dd */
			getch();
			getch();
		}
	}
}


Tchar n_setht(void)		/* set character height from \H'...' */
{

	getch();
	inumb(&apts);
	getch();
	return(0);
}


Tchar n_setslant(void)		/* set slant from \S'...' */
{
	int n;

	getch();
	n = 0;
	n = inumb(&n);
	getch();
	return(0);
}


void n_caseft(void)
{
	skip();
	setfont(1);
}


void n_setfont(int a)
{
	int i, j;

	if (a)
		i = getrq();
	else 
		i = getsn();
	if (!i || i == 'P') {
		j = font1;
		goto s0;
	}
	if (i == 'S' || i == '0')
		return;
	if ((j = findft(i)) == -1)
		return;
s0:
	font1 = font;
	font = j;
	mchbits();
}


void n_setwd(void)
{
	int base, wid;
	Tchar i;
	int	delim, emsz, k;
	int	savhp, savapts, savapts1, savfont, savfont1, savpts, savpts1;

	base = numtab[ST].val = numtab[ST].val = wid = numtab[CT].val = 0;
	if (ismot(i = getch()))
		return;
	delim = cbits(i);
	savhp = numtab[HP].val;
	numtab[HP].val = 0;
	savapts = apts;
	savapts1 = apts1;
	savfont = font;
	savfont1 = font1;
	savpts = pts;
	savpts1 = pts1;
	setwdf++;
	while (cbits(i = getch()) != delim && !nlflg) {
		k = width(i);
		wid += k;
		numtab[HP].val += k;
		if (!ismot(i)) {
			emsz = (INCH * pts + 36) / 72;
		} else if (isvmot(i)) {
			k = absmot(i);
			if (isnmot(i))
				k = -k;
			base -= k;
			emsz = 0;
		} else 
			continue;
		if (base < numtab[SB].val)
			numtab[SB].val = base;
		if ((k = base + emsz) > numtab[ST].val)
			numtab[ST].val = k;
	}
	setn1(wid, 0, (Tchar) 0);
	numtab[HP].val = savhp;
	apts = savapts;
	apts1 = savapts1;
	font = savfont;
	font1 = savfont1;
	pts = savpts;
	pts1 = savpts1;
	mchbits();
	setwdf = 0;
}


Tchar n_vmot(void)
{
	dfact = lss;
	vflag++;
	return n_mot();
}


Tchar n_hmot(void)
{
	dfact = EM;
	return n_mot();
}


Tchar n_mot(void)
{
	int j, n;
	Tchar i;

	j = HOR;
	getch(); /*eat delim*/
	if (n = atoi0()) {
		if (vflag)
			j = VERT;
		i = makem(quant(n, j));
	} else
		i = 0;
	getch();
	vflag = 0;
	dfact = 1;
	return(i);
}


Tchar n_sethl(int k)
{
	int j;
	Tchar i;

	j = t.Halfline;
	if (k == 'u')
		j = -j;
	else if (k == 'r')
		j = -2 * j;
	vflag++;
	i = makem(j);
	vflag = 0;
	return(i);
}


Tchar n_makem(int i)
{
	Tchar j;

	if (i >= 0)
		j = i;
	else
		j = -i;
	j |= MOT;
	if (i < 0)
		j |= NMOT;
	if (vflag)
		j |= VMOT;
	return(j);
}


void n_casefp(void)
{
	int i, j;

	skip();
	if ((i = cbits(getch()) - '0') < 0 || i > nfonts)
		return;
	if (skip() || !(j = getrq()))
		return;
	fontlab[i] = j;
}



void n_casebd(void)
{
	int i, j, k;

	k = 0;
bd0:
	if (skip() || !(i = getrq()) || (j = findft(i)) == -1) {
		if (k)
			goto bd1;
		else 
			return;
	}
	if (j == smnt) {
		k = smnt;
		goto bd0;
	}
	if (k) {
		sbold = j;
		j = k;
	}
bd1:
	skip();
	noscale++;
	bdtab[j] = atoi0();
	noscale = 0;
}


void n_casevs(void)
{
	int i;

	skip();
	vflag++;
	dfact = INCH; /*default scaling is points!*/
	dfactd = 72;
	res = VERT;
	i = inumb(&lss);
	if (nonumb)
		i = lss1;
	if (i < VERT)
		i = VERT;	/* was VERT */
	lss1 = lss;
	lss = i;
}




Tchar n_xlss(void)
{
	/* stores \x'...' into
	/* two successive Tchars.
	/* the first contains HX, the second the value,
	/* encoded as a vertical motion.
	/* decoding is done in n2.c by pchar().
	*/
	int	i;

	getch();
	dfact = lss;
	i = quant(atoi0(), VERT);
	dfact = 1;
	getch();
	if (i >= 0)
		*pbp++ = MOT | VMOT | i;
	else
		*pbp++ = MOT | VMOT | NMOT | -i;
	return(HX);
}
