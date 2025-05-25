/* Origin: /usr/src/libI77/wref0.c */
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
#include "fio.h"
#include "fmt.h"

wrt_E(p,w,d,e,len) ufloat *p; ftnlen len;
{	char *s;
	int dp,sign,i, delta;
	char *ecvt();
	double dd;
	if(e == 0)
		e = 2;
	if(scale) {
		if(scale >= d + 2 || scale <= -d)
			goto nogood;
		if(scale > 0)
			d++;
	}
	if (len == sizeof(float))
		dd = p->pf;
	else
		dd = p->pd;
	s=ecvt( dd ,d,&dp,&sign);
	delta = 1 /* for the . */ + 2 /* for the E+ */ + (sign || cplus);
	if(w < d + e + delta) {
nogood:
		for(i=0;i<w;i++) (*putn)('*');
		return(0);
	}
	if(p->pf != 0) dp -= scale;
	else	dp = 0;
	switch(e) {	/* grumph */
	case 1:
		if(dp <= -10 || dp >= 10)
			goto nogood;
		break;
	case 2:
		if(dp <= -100 || dp >= 100)
			goto nogood;
		break;
	case 3:
		if(dp <= -1000 || dp >= 1000)
			goto nogood;
		break;
	default:
		/* probably ok */
		break;
	}
	for(i=0;i<w-(delta+d+e);i++) (*putn)(' ');
	if(sign) (*putn)('-');
	else if(cplus) (*putn)('+');
	if(scale<0)
	{
		(*putn)('.');
		for(i=0;i<-scale;i++)
			(*putn)('0');
		for(i=0;i<d+scale;i++)
			(*putn)(*s++);
	}
	else if(scale>0 && scale<d+2)
	{	for(i=0;i<scale;i++)
			(*putn)(*s++);
		(*putn)('.');
		for(i=0;i<d-scale;i++)
			(*putn)(*s++);
	}
	else
	{	(*putn)('.');
		for(i=0;i<d;i++) (*putn)(*s++);
	}
	if(dp < 100 && dp > -100) (*putn)('e');
	if(dp<0)
	{	(*putn)('-');
		dp = -dp;
	}
	else	(*putn)('+');
	for(; e >= 4; e--)
		(*putn)('0');
	if(e>=3 || dp >= 100)
	{	(*putn)(dp/100 + '0');
		dp = dp % 100;
	}
	if(e!=1) (*putn)(dp/10+'0');
	(*putn)(dp%10+'0');
	return(0);
}

wrt_F(p,w,d,len) ufloat *p; ftnlen len;
{	int i,delta,dp,sign,n;
	double x;
	char *s,*fcvt();
	x= (len==sizeof(float)?p->pf:p->pd);
	if(scale)
	{	if(scale>0)
			for(i=0;i<scale;i++) x*=10;
		else	for(i=0;i<-scale;i++) x/=10;
	}
	s=fcvt(x,d,&dp,&sign);
	if(-dp>=d) sign=0;
	if(sign || cplus) delta=2;
	else delta=1;
	n= w - (d+delta+(dp>0?dp:0));
	if(n<0)
	{
		for(i=0;i<w;i++) PUT('*');
		return(0);
	}
	for(i=0;i<n;i++) PUT(' ');
	if(sign) PUT('-');
	else if(cplus) PUT('+');
	for(i=0;i<dp;i++) PUT(*s++);
	PUT('.');
	for(i=0;i< -dp && i<d;i++) PUT('0');
	for(;i<d;i++)
	{	if(*s) PUT(*s++);
		else PUT('0');
	}
	return(0);
}
