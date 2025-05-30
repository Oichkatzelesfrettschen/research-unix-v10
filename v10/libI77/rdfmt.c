/* Origin: /usr/src/libI77/rdfmt.c */
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

extern int f__cursor;
#ifdef KR_headers
extern double atof();
#else
#undef abs
#undef min
#undef max
#include "stdlib.h"
#endif

 static int
#ifdef KR_headers
rd_Z(n,w,len) Uint *n; ftnlen len;
#else
rd_Z(Uint *n, int w, ftnlen len)
#endif
{
	long x[9];
	char *s, *s0, *s1, *se, *t;
	int ch, i, w1, w2;
	static char hex[256];
	static int one = 1;
	int bad = 0;

	if (!hex['0']) {
		s = "0123456789";
		while(ch = *s++)
			hex[ch] = ch - '0' + 1;
		s = "ABCDEF";
		while(ch = *s++)
			hex[ch] = hex[ch + 'a' - 'A'] = ch - 'A' + 11;
		}
	s = s0 = (char *)x;
	s1 = (char *)&x[4];
	se = (char *)&x[8];
	if (len > 4*sizeof(long))
		return errno = 117;
	while (w) {
		GET(ch);
		if (ch==',' || ch=='\n')
			break;
		w--;
		if (ch > ' ') {
			if (!hex[ch & 0xff])
				bad++;
			*s++ = ch;
			if (s == se) {
				/* discard excess characters */
				for(t = s0, s = s1; t < s1;)
					*t++ = *s++;
				s = s1;
				}
			}
		}
	if (bad)
		return errno = 115;
	w = (int)len;
	w1 = s - s0;
	w2 = w1+1 >> 1;
	t = (char *)n;
	if (*(char *)&one) {
		/* little endian */
		t += w - 1;
		i = -1;
		}
	else
		i = 1;
	for(; w > w2; t += i, --w)
		*t = 0;
	if (!w)
		return 0;
	if (w < w2)
		s0 = s - (w << 1);
	else if (w1 & 1) {
		*t = hex[*s0++ & 0xff] - 1;
		if (!--w)
			return 0;
		t += i;
		}
	do {
		*t = hex[*s0 & 0xff]-1 << 4 | hex[s0[1] & 0xff]-1;
		t += i;
		s0 += 2;
		}
		while(--w);
	return 0;
	}

 static int
#ifdef KR_headers
rd_I(n,w,len, base) Uint *n; int w; ftnlen len; register int base;
#else
rd_I(Uint *n, int w, ftnlen len, register int base)
#endif
{	long x;
	int sign,ch;
	char s[84], *ps;
	ps=s; x=0;
	while (w)
	{
		GET(ch);
		if (ch==',' || ch=='\n') break;
		*ps=ch; ps++; w--;
	}
	*ps='\0';
	ps=s;
	while (*ps==' ') ps++;
	if (*ps=='-') { sign=1; ps++; }
	else { sign=0; if (*ps=='+') ps++; }
loop:	while (*ps>='0' && *ps<='9') { x=x*base+(*ps-'0'); ps++; }
	if (*ps==' ') {if (f__cblank) x *= base; ps++; goto loop;}
	if(sign) x = -x;
	if(len==sizeof(integer)) n->il=x;
	else if(len == sizeof(char)) n->ic = (char)x;
#ifdef Allow_TYQUAD
	else if (len == sizeof(longint)) n->ili = x;
#endif
	else n->is = (short)x;
	if (*ps) return(errno=115); else return(0);
}
 static int
#ifdef KR_headers
rd_L(n,w,len) ftnint *n; ftnlen len;
#else
rd_L(ftnint *n, int w, ftnlen len)
#endif
{	int ch, lv;
	char s[84], *ps;
	ps=s;
	while (w) {
		GET(ch);
		if (ch==','||ch=='\n') break;
		*ps=ch;
		ps++; w--;
		}
	*ps='\0';
	ps=s; while (*ps==' ') ps++;
	if (*ps=='.') ps++;
	if (*ps=='t' || *ps == 'T')
		lv = 1;
	else if (*ps == 'f' || *ps == 'F')
		lv = 0;
	else return(errno=116);
	switch(len) {
		case sizeof(char):	*(char *)n = (char)lv;	 break;
		case sizeof(short):	*(short *)n = (short)lv; break;
		default:		*n = lv;
		}
	return 0;
}

#include "ctype.h"

 static int
#ifdef KR_headers
rd_F(p, w, d, len) ufloat *p; ftnlen len;
#else
rd_F(ufloat *p, int w, int d, ftnlen len)
#endif
{
	char s[FMAX+EXPMAXDIGS+4];
	register int ch;
	register char *sp, *spe, *sp1;
	double x;
	int scale1, se;
	long e, exp;

	sp1 = sp = s;
	spe = sp + FMAX;
	exp = -d;
	x = 0.;

	do {
		GET(ch);
		w--;
		} while (ch == ' ' && w);
	switch(ch) {
		case '-': *sp++ = ch; sp1++; spe++;
		case '+':
			if (!w) goto zero;
			--w;
			GET(ch);
		}
	while(ch == ' ') {
blankdrop:
		if (!w--) goto zero; GET(ch); }
	while(ch == '0')
		{ if (!w--) goto zero; GET(ch); }
	if (ch == ' ' && f__cblank)
		goto blankdrop;
	scale1 = f__scale;
	while(isdigit(ch)) {
digloop1:
		if (sp < spe) *sp++ = ch;
		else ++exp;
digloop1e:
		if (!w--) goto done;
		GET(ch);
		}
	if (ch == ' ') {
		if (f__cblank)
			{ ch = '0'; goto digloop1; }
		goto digloop1e;
		}
	if (ch == '.') {
		exp += d;
		if (!w--) goto done;
		GET(ch);
		if (sp == sp1) { /* no digits yet */
			while(ch == '0') {
skip01:
				--exp;
skip0:
				if (!w--) goto done;
				GET(ch);
				}
			if (ch == ' ') {
				if (f__cblank) goto skip01;
				goto skip0;
				}
			}
		while(isdigit(ch)) {
digloop2:
			if (sp < spe)
				{ *sp++ = ch; --exp; }
digloop2e:
			if (!w--) goto done;
			GET(ch);
			}
		if (ch == ' ') {
			if (f__cblank)
				{ ch = '0'; goto digloop2; }
			goto digloop2e;
			}
		}
	switch(ch) {
	  default:
		break;
	  case '-': se = 1; goto signonly;
	  case '+': se = 0; goto signonly;
	  case 'e':
	  case 'E':
	  case 'd':
	  case 'D':
		if (!w--)
			goto bad;
		GET(ch);
		while(ch == ' ') {
			if (!w--)
				goto bad;
			GET(ch);
			}
		se = 0;
	  	switch(ch) {
		  case '-': se = 1;
		  case '+':
signonly:
			if (!w--)
				goto bad;
			GET(ch);
			}
		while(ch == ' ') {
			if (!w--)
				goto bad;
			GET(ch);
			}
		if (!isdigit(ch))
			goto bad;

		e = ch - '0';
		for(;;) {
			if (!w--)
				{ ch = '\n'; break; }
			GET(ch);
			if (!isdigit(ch)) {
				if (ch == ' ') {
					if (f__cblank)
						ch = '0';
					else continue;
					}
				else
					break;
				}
			e = 10*e + ch - '0';
			if (e > EXPMAX && sp > sp1)
				goto bad;
			}
		if (se)
			exp -= e;
		else
			exp += e;
		scale1 = 0;
		}
	switch(ch) {
	  case '\n':
	  case ',':
		break;
	  default:
bad:
		return (errno = 115);
		}
done:
	if (sp > sp1) {
		while(*--sp == '0')
			++exp;
		if (exp -= scale1)
			sprintf(sp+1, "e%ld", exp);
		else
			sp[1] = 0;
		x = atof(s);
		}
zero:
	if (len == sizeof(real))
		p->pf = x;
	else
		p->pd = x;
	return(0);
	}


 static int
#ifdef KR_headers
rd_A(p,len) char *p; ftnlen len;
#else
rd_A(char *p, ftnlen len)
#endif
{	int i,ch;
	for(i=0;i<len;i++)
	{	GET(ch);
		*p++=VAL(ch);
	}
	return(0);
}
 static int
#ifdef KR_headers
rd_AW(p,w,len) char *p; ftnlen len;
#else
rd_AW(char *p, int w, ftnlen len)
#endif
{	int i,ch;
	if(w>=len)
	{	for(i=0;i<w-len;i++)
			GET(ch);
		for(i=0;i<len;i++)
		{	GET(ch);
			*p++=VAL(ch);
		}
		return(0);
	}
	for(i=0;i<w;i++)
	{	GET(ch);
		*p++=VAL(ch);
	}
	for(i=0;i<len-w;i++) *p++=' ';
	return(0);
}
 static int
#ifdef KR_headers
rd_H(n,s) char *s;
#else
rd_H(int n, char *s)
#endif
{	int i,ch;
	for(i=0;i<n;i++)
		if((ch=(*f__getn)())<0) return(ch);
		else *s++ = ch=='\n'?' ':ch;
	return(1);
}
 static int
#ifdef KR_headers
rd_POS(s) char *s;
#else
rd_POS(char *s)
#endif
{	char quote;
	int ch;
	quote= *s++;
	for(;*s;s++)
		if(*s==quote && *(s+1)!=quote) break;
		else if((ch=(*f__getn)())<0) return(ch);
		else *s = ch=='\n'?' ':ch;
	return(1);
}
#ifdef KR_headers
rd_ed(p,ptr,len) struct f__syl *p; char *ptr; ftnlen len;
#else
rd_ed(struct f__syl *p, char *ptr, ftnlen len)
#endif
{	int ch;
	for(;f__cursor>0;f__cursor--) if((ch=(*f__getn)())<0) return(ch);
	if(f__cursor<0)
	{	if(f__recpos+f__cursor < 0) /*err(elist->cierr,110,"fmt")*/
			f__cursor = -f__recpos;	/* is this in the standard? */
		if(f__external == 0) {
			extern char *f__icptr;
			f__icptr += f__cursor;
		}
		else if(f__curunit && f__curunit->useek)
			(void) fseek(f__cf,(long) f__cursor,SEEK_CUR);
		else
			err(f__elist->cierr,106,"fmt");
		f__recpos += f__cursor;
		f__cursor=0;
	}
	switch(p->op)
	{
	default: fprintf(stderr,"rd_ed, unexpected code: %d\n", p->op);
		sig_die(f__fmtbuf, 1);
	case IM:
	case I: ch = rd_I((Uint *)ptr,p->p1,len, 10);
		break;

		/* O and OM don't work right for character, double, complex, */
		/* or doublecomplex, and they differ from Fortran 90 in */
		/* showing a minus sign for negative values. */

	case OM:
	case O: ch = rd_I((Uint *)ptr, p->p1, len, 8);
		break;
	case L: ch = rd_L((ftnint *)ptr,p->p1,len);
		break;
	case A:	ch = rd_A(ptr,len);
		break;
	case AW:
		ch = rd_AW(ptr,p->p1,len);
		break;
	case E: case EE:
	case D:
	case G:
	case GE:
	case F:	ch = rd_F((ufloat *)ptr,p->p1,p->p2,len);
		break;

		/* Z and ZM assume 8-bit bytes. */

	case ZM:
	case Z:
		ch = rd_Z((Uint *)ptr, p->p1, len);
		break;
	}
	if(ch == 0) return(ch);
	else if(ch == EOF) return(EOF);
	if (f__cf)
		clearerr(f__cf);
	return(errno);
}
#ifdef KR_headers
rd_ned(p) struct f__syl *p;
#else
rd_ned(struct f__syl *p)
#endif
{
	switch(p->op)
	{
	default: fprintf(stderr,"rd_ned, unexpected code: %d\n", p->op);
		sig_die(f__fmtbuf, 1);
	case APOS:
		return(rd_POS(*(char **)&p->p2));
	case H:	return(rd_H(p->p1,*(char **)&p->p2));
	case SLASH: return((*f__donewrec)());
	case TR:
	case X:	f__cursor += p->p1;
		return(1);
	case T: f__cursor=p->p1-f__recpos - 1;
		return(1);
	case TL: f__cursor -= p->p1;
		if(f__cursor < -f__recpos)	/* TL1000, 1X */
			f__cursor = -f__recpos;
		return(1);
	}
}
