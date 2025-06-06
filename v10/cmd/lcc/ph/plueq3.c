/* The Plum Hall Validation Suite for C
 * Unpublished copyright (c) 1986-1991, Chiron Systems Inc and Plum Hall Inc.
 * VERSION: 4
 * DATE: 1993-01-01
 * The "ANSI" mode of the Suite corresponds to the official ANSI C, X3.159-1989.
 * As per your license agreement, your distribution is not to be moved or copied outside the Designated Site
 * without specific permission from Plum Hall Inc.
 */

#define ANSI 1  /* This file follows ANSI arithmetic rules, which may not work in non-ANSI modes */
#include "types.h"
#include "n.h"
int main()
	{
	extern char *Filename;
	auto CHAR Cc = 7;
	auto CHAR *pCc = &Cc;
	auto CHAR **ppCc = &pCc;
#if ANSI
	auto SCHAR Csc = 8;
	auto SCHAR *pCsc = &Csc;
	auto SCHAR **ppCsc = &pCsc;
#endif
	auto SHORT Cs = 9;
	auto SHORT *pCs = &Cs;
	auto SHORT **ppCs = &pCs;
	auto INT Ci = 10;
	auto INT *pCi = &Ci;
	auto INT **ppCi = &pCi;
	auto UCHAR Cuc = 11;
	auto UCHAR *pCuc = &Cuc;
	auto UCHAR **ppCuc = &pCuc;
	auto USHORT Cus = 12;
	auto USHORT *pCus = &Cus;
	auto USHORT **ppCus = &pCus;
	auto UINT Cui = 13;
	auto UINT *pCui = &Cui;
	auto UINT **ppCui = &pCui;
	auto LONG Cl = 14;
	auto LONG *pCl = &Cl;
	auto LONG **ppCl = &pCl;
	auto ULONG Cul = 15;
	auto ULONG *pCul = &Cul;
	auto ULONG **ppCul = &pCul;
	auto FLOAT Cf = 16;
	auto FLOAT *pCf = &Cf;
	auto FLOAT **ppCf = &pCf;
	auto DOUBLE Cd = 17;
	auto DOUBLE *pCd = &Cd;
	auto DOUBLE **ppCd = &pCd;
#if ANSI
	auto LDOUBLE Cld = 18;
	auto LDOUBLE *pCld = &Cld;
	auto LDOUBLE **ppCld = &pCld;
#endif
	{
	CHAR *Nc();
#if ANSI
	SCHAR *Nsc();
#endif
	SHORT *Ns();
	INT *Ni();
	UCHAR *Nuc();
	USHORT *Nus();
	UINT *Nui();
	LONG *Nl();
	ULONG *Nul();
	FLOAT *Nf();
	DOUBLE *Nd();
#if ANSI
	LDOUBLE *Nld();
#endif
	{
	int true = 1, false = 0;
	Filename =  " auto pscalar2 auto funcrp plueq3 ";
	*Nf() = 16; **ppCus = 12;
	*Nf() += **ppCus;
	dequals(__LINE__, *Nf(), (FLOAT)28.);
	*Nf() = 16;
	dequals(__LINE__, *Nf() += **ppCus, (FLOAT)28.);
	**ppCus = 12; *Nd() = 17;
	**ppCus += *Nd();
	iequals(__LINE__, **ppCus, (USHORT)29);
	**ppCus = 12;
	iequals(__LINE__, **ppCus += *Nd(), (USHORT)29);
	*Nd() = 17; **ppCus = 12;
	*Nd() += **ppCus;
	dequals(__LINE__, *Nd(), (DOUBLE)29.);
	*Nd() = 17;
	dequals(__LINE__, *Nd() += **ppCus, (DOUBLE)29.);
#if ANSI
	**ppCus = 12; *Nld() = 18;
	**ppCus += *Nld();
	iequals(__LINE__, **ppCus, (USHORT)30);
	**ppCus = 12;
	iequals(__LINE__, **ppCus += *Nld(), (USHORT)30);
	*Nld() = 18; **ppCus = 12;
	*Nld() += **ppCus;
	ldequals(__LINE__, *Nld(), (LDOUBLE)30.L);
	*Nld() = 18;
	ldequals(__LINE__, *Nld() += **ppCus, (LDOUBLE)30.L);
#endif
	**ppCui = 13; *Nc() = 7;
	**ppCui += *Nc();
	iequals(__LINE__, **ppCui, (UINT)20);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Nc(), (UINT)20);
	*Nc() = 7; **ppCui = 13;
	*Nc() += **ppCui;
	iequals(__LINE__, *Nc(), (CHAR)20);
	*Nc() = 7;
	iequals(__LINE__, *Nc() += **ppCui, (CHAR)20);
#if ANSI
	**ppCui = 13; *Nsc() = 8;
	**ppCui += *Nsc();
	iequals(__LINE__, **ppCui, (UINT)21);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Nsc(), (UINT)21);
	*Nsc() = 8; **ppCui = 13;
	*Nsc() += **ppCui;
	iequals(__LINE__, *Nsc(), (SCHAR)21);
	*Nsc() = 8;
	iequals(__LINE__, *Nsc() += **ppCui, (SCHAR)21);
#endif
	**ppCui = 13; *Ns() = 9;
	**ppCui += *Ns();
	iequals(__LINE__, **ppCui, (UINT)22);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Ns(), (UINT)22);
	*Ns() = 9; **ppCui = 13;
	*Ns() += **ppCui;
	iequals(__LINE__, *Ns(), (SHORT)22);
	*Ns() = 9;
	iequals(__LINE__, *Ns() += **ppCui, (SHORT)22);
	**ppCui = 13; *Ni() = 10;
	**ppCui += *Ni();
	iequals(__LINE__, **ppCui, (UINT)23);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Ni(), (UINT)23);
	*Ni() = 10; **ppCui = 13;
	*Ni() += **ppCui;
	iequals(__LINE__, *Ni(), (INT)23);
	*Ni() = 10;
	iequals(__LINE__, *Ni() += **ppCui, (INT)23);
	**ppCui = 13; *Nuc() = 11;
	**ppCui += *Nuc();
	iequals(__LINE__, **ppCui, (UINT)24);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Nuc(), (UINT)24);
	*Nuc() = 11; **ppCui = 13;
	*Nuc() += **ppCui;
	iequals(__LINE__, *Nuc(), (UCHAR)24);
	*Nuc() = 11;
	iequals(__LINE__, *Nuc() += **ppCui, (UCHAR)24);
	**ppCui = 13; *Nus() = 12;
	**ppCui += *Nus();
	iequals(__LINE__, **ppCui, (UINT)25);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Nus(), (UINT)25);
	*Nus() = 12; **ppCui = 13;
	*Nus() += **ppCui;
	iequals(__LINE__, *Nus(), (USHORT)25);
	*Nus() = 12;
	iequals(__LINE__, *Nus() += **ppCui, (USHORT)25);
	**ppCui = 13; *Nui() = 13;
	**ppCui += *Nui();
	iequals(__LINE__, **ppCui, (UINT)26);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Nui(), (UINT)26);
	*Nui() = 13; **ppCui = 13;
	*Nui() += **ppCui;
	iequals(__LINE__, *Nui(), (UINT)26);
	*Nui() = 13;
	iequals(__LINE__, *Nui() += **ppCui, (UINT)26);
	**ppCui = 13; *Nl() = 14;
	**ppCui += *Nl();
	iequals(__LINE__, **ppCui, (UINT)27);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Nl(), (UINT)27);
	*Nl() = 14; **ppCui = 13;
	*Nl() += **ppCui;
	lequals(__LINE__, *Nl(), (LONG)27L);
	*Nl() = 14;
	lequals(__LINE__, *Nl() += **ppCui, (LONG)27L);
	**ppCui = 13; *Nul() = 15;
	**ppCui += *Nul();
	iequals(__LINE__, **ppCui, (UINT)28);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Nul(), (UINT)28);
	*Nul() = 15; **ppCui = 13;
	*Nul() += **ppCui;
	lequals(__LINE__, *Nul(), (ULONG)28L);
	*Nul() = 15;
	lequals(__LINE__, *Nul() += **ppCui, (ULONG)28L);
	**ppCui = 13; *Nf() = 16;
	**ppCui += *Nf();
	iequals(__LINE__, **ppCui, (UINT)29);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Nf(), (UINT)29);
	*Nf() = 16; **ppCui = 13;
	*Nf() += **ppCui;
	dequals(__LINE__, *Nf(), (FLOAT)29.);
	*Nf() = 16;
	dequals(__LINE__, *Nf() += **ppCui, (FLOAT)29.);
	**ppCui = 13; *Nd() = 17;
	**ppCui += *Nd();
	iequals(__LINE__, **ppCui, (UINT)30);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Nd(), (UINT)30);
	*Nd() = 17; **ppCui = 13;
	*Nd() += **ppCui;
	dequals(__LINE__, *Nd(), (DOUBLE)30.);
	*Nd() = 17;
	dequals(__LINE__, *Nd() += **ppCui, (DOUBLE)30.);
#if ANSI
	**ppCui = 13; *Nld() = 18;
	**ppCui += *Nld();
	iequals(__LINE__, **ppCui, (UINT)31);
	**ppCui = 13;
	iequals(__LINE__, **ppCui += *Nld(), (UINT)31);
	*Nld() = 18; **ppCui = 13;
	*Nld() += **ppCui;
	ldequals(__LINE__, *Nld(), (LDOUBLE)31.L);
	*Nld() = 18;
	ldequals(__LINE__, *Nld() += **ppCui, (LDOUBLE)31.L);
#endif
	**ppCl = 14; *Nc() = 7;
	**ppCl += *Nc();
	lequals(__LINE__, **ppCl, (LONG)21L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Nc(), (LONG)21L);
	*Nc() = 7; **ppCl = 14;
	*Nc() += **ppCl;
	iequals(__LINE__, *Nc(), (CHAR)21);
	*Nc() = 7;
	iequals(__LINE__, *Nc() += **ppCl, (CHAR)21);
#if ANSI
	**ppCl = 14; *Nsc() = 8;
	**ppCl += *Nsc();
	lequals(__LINE__, **ppCl, (LONG)22L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Nsc(), (LONG)22L);
	*Nsc() = 8; **ppCl = 14;
	*Nsc() += **ppCl;
	iequals(__LINE__, *Nsc(), (SCHAR)22);
	*Nsc() = 8;
	iequals(__LINE__, *Nsc() += **ppCl, (SCHAR)22);
#endif
	**ppCl = 14; *Ns() = 9;
	**ppCl += *Ns();
	lequals(__LINE__, **ppCl, (LONG)23L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Ns(), (LONG)23L);
	*Ns() = 9; **ppCl = 14;
	*Ns() += **ppCl;
	iequals(__LINE__, *Ns(), (SHORT)23);
	*Ns() = 9;
	iequals(__LINE__, *Ns() += **ppCl, (SHORT)23);
	**ppCl = 14; *Ni() = 10;
	**ppCl += *Ni();
	lequals(__LINE__, **ppCl, (LONG)24L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Ni(), (LONG)24L);
	*Ni() = 10; **ppCl = 14;
	*Ni() += **ppCl;
	iequals(__LINE__, *Ni(), (INT)24);
	*Ni() = 10;
	iequals(__LINE__, *Ni() += **ppCl, (INT)24);
	**ppCl = 14; *Nuc() = 11;
	**ppCl += *Nuc();
	lequals(__LINE__, **ppCl, (LONG)25L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Nuc(), (LONG)25L);
	*Nuc() = 11; **ppCl = 14;
	*Nuc() += **ppCl;
	iequals(__LINE__, *Nuc(), (UCHAR)25);
	*Nuc() = 11;
	iequals(__LINE__, *Nuc() += **ppCl, (UCHAR)25);
	**ppCl = 14; *Nus() = 12;
	**ppCl += *Nus();
	lequals(__LINE__, **ppCl, (LONG)26L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Nus(), (LONG)26L);
	*Nus() = 12; **ppCl = 14;
	*Nus() += **ppCl;
	iequals(__LINE__, *Nus(), (USHORT)26);
	*Nus() = 12;
	iequals(__LINE__, *Nus() += **ppCl, (USHORT)26);
	**ppCl = 14; *Nui() = 13;
	**ppCl += *Nui();
	lequals(__LINE__, **ppCl, (LONG)27L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Nui(), (LONG)27L);
	*Nui() = 13; **ppCl = 14;
	*Nui() += **ppCl;
	iequals(__LINE__, *Nui(), (UINT)27);
	*Nui() = 13;
	iequals(__LINE__, *Nui() += **ppCl, (UINT)27);
	**ppCl = 14; *Nl() = 14;
	**ppCl += *Nl();
	lequals(__LINE__, **ppCl, (LONG)28L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Nl(), (LONG)28L);
	*Nl() = 14; **ppCl = 14;
	*Nl() += **ppCl;
	lequals(__LINE__, *Nl(), (LONG)28L);
	*Nl() = 14;
	lequals(__LINE__, *Nl() += **ppCl, (LONG)28L);
	**ppCl = 14; *Nul() = 15;
	**ppCl += *Nul();
	lequals(__LINE__, **ppCl, (LONG)29L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Nul(), (LONG)29L);
	*Nul() = 15; **ppCl = 14;
	*Nul() += **ppCl;
	lequals(__LINE__, *Nul(), (ULONG)29L);
	*Nul() = 15;
	lequals(__LINE__, *Nul() += **ppCl, (ULONG)29L);
	**ppCl = 14; *Nf() = 16;
	**ppCl += *Nf();
	lequals(__LINE__, **ppCl, (LONG)30L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Nf(), (LONG)30L);
	*Nf() = 16; **ppCl = 14;
	*Nf() += **ppCl;
	dequals(__LINE__, *Nf(), (FLOAT)30.);
	*Nf() = 16;
	dequals(__LINE__, *Nf() += **ppCl, (FLOAT)30.);
	**ppCl = 14; *Nd() = 17;
	**ppCl += *Nd();
	lequals(__LINE__, **ppCl, (LONG)31L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Nd(), (LONG)31L);
	*Nd() = 17; **ppCl = 14;
	*Nd() += **ppCl;
	dequals(__LINE__, *Nd(), (DOUBLE)31.);
	*Nd() = 17;
	dequals(__LINE__, *Nd() += **ppCl, (DOUBLE)31.);
#if ANSI
	**ppCl = 14; *Nld() = 18;
	**ppCl += *Nld();
	lequals(__LINE__, **ppCl, (LONG)32L);
	**ppCl = 14;
	lequals(__LINE__, **ppCl += *Nld(), (LONG)32L);
	*Nld() = 18; **ppCl = 14;
	*Nld() += **ppCl;
	ldequals(__LINE__, *Nld(), (LDOUBLE)32.L);
	*Nld() = 18;
	ldequals(__LINE__, *Nld() += **ppCl, (LDOUBLE)32.L);
#endif
	**ppCul = 15; *Nc() = 7;
	**ppCul += *Nc();
	lequals(__LINE__, **ppCul, (ULONG)22L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Nc(), (ULONG)22L);
	*Nc() = 7; **ppCul = 15;
	*Nc() += **ppCul;
	iequals(__LINE__, *Nc(), (CHAR)22);
	*Nc() = 7;
	iequals(__LINE__, *Nc() += **ppCul, (CHAR)22);
#if ANSI
	**ppCul = 15; *Nsc() = 8;
	**ppCul += *Nsc();
	lequals(__LINE__, **ppCul, (ULONG)23L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Nsc(), (ULONG)23L);
	*Nsc() = 8; **ppCul = 15;
	*Nsc() += **ppCul;
	iequals(__LINE__, *Nsc(), (SCHAR)23);
	*Nsc() = 8;
	iequals(__LINE__, *Nsc() += **ppCul, (SCHAR)23);
#endif
	**ppCul = 15; *Ns() = 9;
	**ppCul += *Ns();
	lequals(__LINE__, **ppCul, (ULONG)24L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Ns(), (ULONG)24L);
	*Ns() = 9; **ppCul = 15;
	*Ns() += **ppCul;
	iequals(__LINE__, *Ns(), (SHORT)24);
	*Ns() = 9;
	iequals(__LINE__, *Ns() += **ppCul, (SHORT)24);
	**ppCul = 15; *Ni() = 10;
	**ppCul += *Ni();
	lequals(__LINE__, **ppCul, (ULONG)25L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Ni(), (ULONG)25L);
	*Ni() = 10; **ppCul = 15;
	*Ni() += **ppCul;
	iequals(__LINE__, *Ni(), (INT)25);
	*Ni() = 10;
	iequals(__LINE__, *Ni() += **ppCul, (INT)25);
	**ppCul = 15; *Nuc() = 11;
	**ppCul += *Nuc();
	lequals(__LINE__, **ppCul, (ULONG)26L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Nuc(), (ULONG)26L);
	*Nuc() = 11; **ppCul = 15;
	*Nuc() += **ppCul;
	iequals(__LINE__, *Nuc(), (UCHAR)26);
	*Nuc() = 11;
	iequals(__LINE__, *Nuc() += **ppCul, (UCHAR)26);
	**ppCul = 15; *Nus() = 12;
	**ppCul += *Nus();
	lequals(__LINE__, **ppCul, (ULONG)27L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Nus(), (ULONG)27L);
	*Nus() = 12; **ppCul = 15;
	*Nus() += **ppCul;
	iequals(__LINE__, *Nus(), (USHORT)27);
	*Nus() = 12;
	iequals(__LINE__, *Nus() += **ppCul, (USHORT)27);
	**ppCul = 15; *Nui() = 13;
	**ppCul += *Nui();
	lequals(__LINE__, **ppCul, (ULONG)28L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Nui(), (ULONG)28L);
	*Nui() = 13; **ppCul = 15;
	*Nui() += **ppCul;
	iequals(__LINE__, *Nui(), (UINT)28);
	*Nui() = 13;
	iequals(__LINE__, *Nui() += **ppCul, (UINT)28);
	**ppCul = 15; *Nl() = 14;
	**ppCul += *Nl();
	lequals(__LINE__, **ppCul, (ULONG)29L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Nl(), (ULONG)29L);
	*Nl() = 14; **ppCul = 15;
	*Nl() += **ppCul;
	lequals(__LINE__, *Nl(), (LONG)29L);
	*Nl() = 14;
	lequals(__LINE__, *Nl() += **ppCul, (LONG)29L);
	**ppCul = 15; *Nul() = 15;
	**ppCul += *Nul();
	lequals(__LINE__, **ppCul, (ULONG)30L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Nul(), (ULONG)30L);
	*Nul() = 15; **ppCul = 15;
	*Nul() += **ppCul;
	lequals(__LINE__, *Nul(), (ULONG)30L);
	*Nul() = 15;
	lequals(__LINE__, *Nul() += **ppCul, (ULONG)30L);
	**ppCul = 15; *Nf() = 16;
	**ppCul += *Nf();
	lequals(__LINE__, **ppCul, (ULONG)31L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Nf(), (ULONG)31L);
	*Nf() = 16; **ppCul = 15;
	*Nf() += **ppCul;
	dequals(__LINE__, *Nf(), (FLOAT)31.);
	*Nf() = 16;
	dequals(__LINE__, *Nf() += **ppCul, (FLOAT)31.);
	**ppCul = 15; *Nd() = 17;
	**ppCul += *Nd();
	lequals(__LINE__, **ppCul, (ULONG)32L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Nd(), (ULONG)32L);
	*Nd() = 17; **ppCul = 15;
	*Nd() += **ppCul;
	dequals(__LINE__, *Nd(), (DOUBLE)32.);
	*Nd() = 17;
	dequals(__LINE__, *Nd() += **ppCul, (DOUBLE)32.);
#if ANSI
	**ppCul = 15; *Nld() = 18;
	**ppCul += *Nld();
	lequals(__LINE__, **ppCul, (ULONG)33L);
	**ppCul = 15;
	lequals(__LINE__, **ppCul += *Nld(), (ULONG)33L);
	*Nld() = 18; **ppCul = 15;
	*Nld() += **ppCul;
	ldequals(__LINE__, *Nld(), (LDOUBLE)33.L);
	*Nld() = 18;
	ldequals(__LINE__, *Nld() += **ppCul, (LDOUBLE)33.L);
#endif
	}}
	return 	report(Filename);
	}
