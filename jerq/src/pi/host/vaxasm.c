#include "asm.pri"
#include "vaxasm.h"
#include "core.pub"
#include "format.pub"
SRCFILE("vaxasm.c")

VaxInstr.VaxInstr(Asm*a,long l):(a,l)	{ tab = 0; display(); }
char *VaxAsm.literaldelimiter()		{ return "$"; }
Instr *VaxAsm.newInstr(long a)		{ return (Instr*) new VaxInstr(this,a); }
VaxAsm.VaxAsm(Core *c):(c)		{ }

char *VaxInstr.arg(int i)
{
	long modereg, mode, type, casex;

	trace( "%d.Arg(0x%X)", this, argtype ); OK("Instr.arg");
	casex = argtype(i)&CASEX;
	type = argtype(i)&7;
	if( argtype(i)&ACCB )
		modereg = 0xAF + (type<<5);			/* branch disp */
	else
		modereg = (unsigned char) _asm->core->peekcode(next++)->chr;
	mode = modereg>>4;
	reg = modereg&0xF;
	m = *_asm->core->peekcode(next);
	switch( modereg ){
	case 0x8F:						// immed
	    	switch(type){
		case TYPB: next += 1; if( casex ) next += 2*(m.chr+1);
			   return literal( F_MASKEXT8|fmt );
        	case TYPW: next += 2; if( casex ) next += 2*(m.sht+1);
			   return literal( F_MASKEXT16|fmt );
    		case TYPL: next += 4; if( casex ) next += 2*(m.lng+1);
			   return literal( fmt );
 		case TYPQ: next += 8; return literal( F_DBLHEX );
 		case TYPF: next += 4; return literal( F_FLOAT );
 		case TYPD: next += 8; return literal( F_DOUBLE );
		default:	      return sf( "<0x8F:0x%X>", type );
		}
	case 0x9F: next+=4;		return symbolic("*");
	case 0xAF: m = m.chr+(next+=1); return symbolic("" );
	case 0xBF: m = m.chr+(next+=1); return symbolic("*");
	case 0xCF: m = m.sht+(next+=2); return symbolic("" );
	case 0xDF: m = m.sht+(next+=2); return symbolic("*");
	case 0xEF: m = m.lng+(next+=4); return symbolic("" );
	case 0xFF: m = m.lng+(next+=4); return symbolic("*");
	}
	switch( mode ){
	case 0:
	case 1:
	case 2:
	case 3:
		if( type==TYPF || type==TYPD ) {
			m = (modereg<<4)|0x4000; return literal( F_FLOAT );
		} else {
			m = modereg;
			if( casex ) next += 2*(m.chr+1);
			return literal(fmt);
		}
	case 4:	char *ix = sf(
			regarg( "%s[%s]",	fmt&F_SYMBOLIC|F_NONE ) );
		return sf( "%s%s", arg(i), ix );
	case 5:   return regarg( "%s%s",	fmt&F_SYMBOLIC|F_NONE );
	case 6:   return regarg( "%s(%s)",	fmt&F_SYMBOLIC|F_NONE );
	case 7:   return regarg( "%s-(%s)",	fmt&F_SYMBOLIC|F_NONE );
	case 8:   return regarg( "%s(%s)+",	fmt&F_SYMBOLIC|F_NONE );
	case 9:   return regarg( "%s*(%s)+",	fmt&F_SYMBOLIC|F_NONE );
	case 0xA: next+=1; m = m.chr; return regarg( "%s(%s)",	fmt|F_MASKEXT8	);
	case 0xB: next+=1; m = m.chr; return regarg( "*%s(%s)",	fmt|F_MASKEXT8	);
	case 0xC: next+=2; m = m.sht; return regarg( "%s(%s)",	fmt|F_MASKEXT16	);
	case 0xD: next+=2; m = m.sht; return regarg( "*%s(%s)",	fmt|F_MASKEXT16	);
	case 0xE: next+=4;	      return regarg( "%s(%s)",	fmt		);
	case 0xF: next+=4;	      return regarg( "*%s(%s)",	fmt		);
	}
	return sf( "modereg=0x%X", modereg );
} 

int VaxInstr.argtype(int i)
{
	return tab->argtype[i];
}

char *VaxInstr.mnemonic()
{
	for( tab = VaxOpTab; tab->opname; ++tab )
		if( tab->opcode == opcode ) return tab->opname;
	return Instr::mnemonic();
}

int VaxInstr.nargs()
{
	return tab->nargs;
}

#define OP(a,b,c,d,e,f,g,h,i) {a,b,c,d,e,f,g,h,i}

struct vaxoptab VaxOpTab[] = {
OP("xorw3",0xad,3,ACCR+TYPW,ACCR+TYPW,ACCW+TYPW,0,0,0),
OP("xorw2",0xac,2,ACCR+TYPW,ACCM+TYPW,0,0,0,0),
OP("xorl3",0xcd,3,ACCR+TYPL,ACCR+TYPL,ACCW+TYPL,0,0,0),
OP("xorl2",0xcc,2,ACCR+TYPL,ACCM+TYPL,0,0,0,0),
OP("xorb3",0x8d,3,ACCR+TYPB,ACCR+TYPB,ACCW+TYPB,0,0,0),
OP("xorb2",0x8c,2,ACCR+TYPB,ACCM+TYPB,0,0,0,0),
OP("xfc",0xfc,1,ACCI+TYPB,0,0,0,0,0),
OP("tstw",0xb5,1,ACCR+TYPW,0,0,0,0,0),
OP("tstl",0xd5,1,ACCR+TYPL,0,0,0,0,0),
OP("tstf",0x53,1,ACCR+TYPF,0,0,0,0,0),
OP("tstd",0x73,1,ACCR+TYPD,0,0,0,0,0),
OP("tstb",0x95,1,ACCR+TYPB,0,0,0,0,0),
OP("svpctx",0x07,0,0,0,0,0,0,0),
OP("subw3",0xa3,3,ACCR+TYPW,ACCR+TYPW,ACCW+TYPW,0,0,0),
OP("subw2",0xa2,2,ACCR+TYPW,ACCM+TYPW,0,0,0,0),
OP("subp6",0x23,6,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB),
OP("subp4",0x22,4,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,0,0),
OP("subl3",0xc3,3,ACCR+TYPL,ACCR+TYPL,ACCW+TYPL,0,0,0),
OP("subl2",0xc2,2,ACCR+TYPL,ACCM+TYPL,0,0,0,0),
OP("subf3",0x43,3,ACCR+TYPF,ACCR+TYPF,ACCW+TYPF,0,0,0),
OP("subf2",0x42,2,ACCR+TYPF,ACCM+TYPF,0,0,0,0),
OP("subd3",0x63,3,ACCR+TYPD,ACCR+TYPD,ACCW+TYPD,0,0,0),
OP("subd2",0x62,2,ACCR+TYPD,ACCM+TYPD,0,0,0,0),
OP("subb3",0x83,3,ACCR+TYPB,ACCR+TYPB,ACCW+TYPB,0,0,0),
OP("subb2",0x82,2,ACCR+TYPB,ACCM+TYPB,0,0,0,0),
OP("spanc",0x2b,4,ACCR+TYPW,ACCA+TYPB,ACCA+TYPB,ACCR+TYPB,0,0),
OP("sobgtr",0xf5,2,ACCM+TYPL,ACCB+TYPB,0,0,0,0),
OP("sobgeq",0xf4,2,ACCM+TYPL,ACCB+TYPB,0,0,0,0),
OP("skpc",0x3b,3,ACCR+TYPB,ACCR+TYPW,ACCA+TYPB,0,0,0),
OP("scanc",0x2a,4,ACCR+TYPW,ACCA+TYPB,ACCA+TYPB,ACCR+TYPB,0,0),
OP("sbwc",0xd9,2,ACCR+TYPL,ACCM+TYPL,0,0,0,0),
OP("rsb",0x05,0,0,0,0,0,0,0),
OP("rotl",0x9c,3,ACCR+TYPB,ACCR+TYPL,ACCW+TYPL,0,0,0),
OP("ret",0x04,0,0,0,0,0,0,0),
OP("remque",0x0f,2,ACCA+TYPB,ACCW+TYPL,0,0,0,0),
OP("rei",0x02,0,0,0,0,0,0,0),
OP("pushr",0xbb,1,ACCR+TYPW,0,0,0,0,0),
OP("pushl",0xdd,1,ACCR+TYPL,0,0,0,0,0),
OP("pushaw",0x3f,1,ACCA+TYPW,0,0,0,0,0),
OP("pushaq",0x7f,1,ACCA+TYPQ,0,0,0,0,0),
OP("pushal",0xdf,1,ACCA+TYPL,0,0,0,0,0),
OP("pushaf",0xdf,1,ACCA+TYPF,0,0,0,0,0),
OP("pushad",0x7f,1,ACCA+TYPD,0,0,0,0,0),
OP("pushab",0x9f,1,ACCA+TYPB,0,0,0,0,0),
OP("probew",0x0d,3,ACCR+TYPB,ACCR+TYPW,ACCA+TYPB,0,0,0),
OP("prober",0x0c,3,ACCR+TYPB,ACCR+TYPW,ACCA+TYPB,0,0,0),
OP("popr",0xba,1,ACCR+TYPW,0,0,0,0,0),
OP("polyf",0x55,3,ACCR+TYPF,ACCR+TYPW,ACCA+TYPB,0,0,0),
OP("polyd",0x75,3,ACCR+TYPD,ACCR+TYPW,ACCA+TYPB,0,0,0),
OP("nop",0x01,0,0,0,0,0,0,0),
OP("mulw3",0xa5,3,ACCR+TYPW,ACCR+TYPW,ACCW+TYPW,0,0,0),
OP("mulw2",0xa4,2,ACCR+TYPW,ACCM+TYPW,0,0,0,0),
OP("mulp",0x25,6,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB),
OP("mull3",0xc5,3,ACCR+TYPL,ACCR+TYPL,ACCW+TYPL,0,0,0),
OP("mull2",0xc4,2,ACCR+TYPL,ACCM+TYPL,0,0,0,0),
OP("mulf3",0x45,3,ACCR+TYPF,ACCR+TYPF,ACCW+TYPF,0,0,0),
OP("mulf2",0x44,2,ACCR+TYPF,ACCM+TYPF,0,0,0,0),
OP("muld3",0x65,3,ACCR+TYPD,ACCR+TYPD,ACCW+TYPD,0,0,0),
OP("muld2",0x64,2,ACCR+TYPD,ACCM+TYPD,0,0,0,0),
OP("mulb3",0x85,3,ACCR+TYPB,ACCR+TYPB,ACCW+TYPB,0,0,0),
OP("mulb2",0x84,2,ACCR+TYPB,ACCM+TYPB,0,0,0,0),
OP("mtpr",0xda,2,ACCR+TYPL,ACCR+TYPL,0,0,0,0),
OP("movzwl",0x3c,2,ACCR+TYPW,ACCW+TYPL,0,0,0,0),
OP("movzbw",0x9b,2,ACCR+TYPB,ACCW+TYPW,0,0,0,0),
OP("movzbl",0x9a,2,ACCR+TYPB,ACCW+TYPL,0,0,0,0),
OP("movw",0xb0,2,ACCR+TYPW,ACCW+TYPW,0,0,0,0),
OP("movtuc",0x2f,6,ACCR+TYPW,ACCA+TYPB,ACCR+TYPB,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB),
OP("movtc",0x2e,6,ACCR+TYPW,ACCA+TYPB,ACCR+TYPB,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB),
OP("movq",0x7d,2,ACCR+TYPQ,ACCW+TYPQ,0,0,0,0),
OP("movpsl",0xdc,1,ACCW+TYPL,0,0,0,0,0),
OP("movp",0x34,3,ACCR+TYPW,ACCA+TYPB,ACCA+TYPB,0,0,0),
OP("movl",0xd0,2,ACCR+TYPL,ACCW+TYPL,0,0,0,0),
OP("movf",0x50,2,ACCR+TYPF,ACCW+TYPF,0,0,0,0),
OP("movd",0x70,2,ACCR+TYPD,ACCW+TYPD,0,0,0,0),
OP("movc5",0x2c,5,ACCR+TYPW,ACCA+TYPB,ACCR+TYPB,ACCR+TYPW,ACCA+TYPB,0),
OP("movc3",0x28,3,ACCR+TYPW,ACCA+TYPB,ACCA+TYPB,0,0,0),
OP("movb",0x90,2,ACCR+TYPB,ACCW+TYPB,0,0,0,0),
OP("movaw",0x3e,2,ACCA+TYPW,ACCW+TYPL,0,0,0,0),
OP("movaq",0x7e,2,ACCA+TYPQ,ACCW+TYPL,0,0,0,0),
OP("moval",0xde,2,ACCA+TYPL,ACCW+TYPL,0,0,0,0),
OP("movaf",0xde,2,ACCA+TYPF,ACCW+TYPL,0,0,0,0),
OP("movad",0x7e,2,ACCA+TYPD,ACCW+TYPL,0,0,0,0),
OP("movab",0x9e,2,ACCA+TYPB,ACCW+TYPL,0,0,0,0),
OP("mnegw",0xae,2,ACCR+TYPW,ACCW+TYPL,0,0,0,0),
OP("mnegl",0xce,2,ACCR+TYPL,ACCW+TYPL,0,0,0,0),
OP("mnegf",0x52,2,ACCR+TYPF,ACCW+TYPF,0,0,0,0),
OP("mnegd",0x72,2,ACCR+TYPD,ACCW+TYPD,0,0,0,0),
OP("mnegb",0x8e,2,ACCR+TYPB,ACCW+TYPB,0,0,0,0),
OP("mfpr",0xdb,2,ACCR+TYPL,ACCW+TYPL,0,0,0,0),
OP("mcomw",0xb2,2,ACCR+TYPW,ACCW+TYPW,0,0,0,0),
OP("mcoml",0xd2,2,ACCR+TYPL,ACCW+TYPL,0,0,0,0),
OP("mcomb",0x92,2,ACCR+TYPB,ACCW+TYPB,0,0,0,0),
OP("matchc",0x39,4,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,0,0),
OP("locc",0x3a,3,ACCR+TYPB,ACCR+TYPW,ACCA+TYPB,0,0,0),
OP("ldpctx",0x06,0,0,0,0,0,0,0),
OP("jsb",0x16,1,ACCA+TYPB,0,0,0,0,0),
OP("jmp",0x17,1,ACCA+TYPB,0,0,0,0,0),
OP("insv",0xf0,4,ACCR+TYPL,ACCR+TYPL,ACCR+TYPB,ACCW+TYPB,0,0),
OP("insque",0x0e,2,ACCA+TYPB,ACCA+TYPB,0,0,0,0),
OP("index",0x0a,6,ACCR+TYPL,ACCR+TYPL,ACCR+TYPL,ACCR+TYPL,ACCR+TYPL,ACCW+TYPL),
OP("incw",0xb6,1,ACCM+TYPW,0,0,0,0,0),
OP("incl",0xd6,1,ACCM+TYPL,0,0,0,0,0),
OP("incb",0x96,1,ACCM+TYPB,0,0,0,0,0),
OP("halt",0x00,0,0,0,0,0,0,0),
OP("ffs",0xea,4,ACCR+TYPL,ACCR+TYPB,ACCR+TYPB,ACCW+TYPL,0,0),
OP("ffc",0xeb,4,ACCR+TYPL,ACCR+TYPB,ACCR+TYPB,ACCW+TYPL,0,0),
OP("extzv",0xef,4,ACCR+TYPL,ACCR+TYPB,ACCR+TYPB,ACCW+TYPL,0,0),
OP("extv",0xee,4,ACCR+TYPL,ACCR+TYPB,ACCR+TYPB,ACCW+TYPL,0,0),
OP("escf",0xff,0,0,0,0,0,0,0),
OP("esce",0xfe,0,0,0,0,0,0,0),
OP("escd",0xfd,0,0,0,0,0,0,0),
OP("emul",0x7a,4,ACCR+TYPL,ACCR+TYPL,ACCR+TYPL,ACCW+TYPQ,0,0),
OP("emodf",0x54,5,ACCR+TYPF,ACCR+TYPB,ACCR+TYPF,ACCW+TYPL,ACCW+TYPF,0),
OP("emodd",0x74,5,ACCR+TYPD,ACCR+TYPB,ACCR+TYPD,ACCW+TYPL,ACCW+TYPD,0),
OP("ediv",0x7b,4,ACCR+TYPL,ACCR+TYPQ,ACCW+TYPL,ACCW+TYPL,0,0),
OP("editpc",0x38,4,ACCR+TYPW,ACCA+TYPB,ACCA+TYPB,ACCA+TYPB,0,0),
OP("divw3",0xa7,3,ACCR+TYPW,ACCR+TYPW,ACCW+TYPW,0,0,0),
OP("divw2",0xa6,2,ACCR+TYPW,ACCM+TYPW,0,0,0,0),
OP("divp",0x27,6,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB),
OP("divl3",0xc7,3,ACCR+TYPL,ACCR+TYPL,ACCW+TYPL,0,0,0),
OP("divl2",0xc6,2,ACCR+TYPL,ACCM+TYPL,0,0,0,0),
OP("divf3",0x47,3,ACCR+TYPF,ACCR+TYPF,ACCW+TYPF,0,0,0),
OP("divf2",0x46,2,ACCR+TYPF,ACCM+TYPF,0,0,0,0),
OP("divd3",0x67,3,ACCR+TYPD,ACCR+TYPD,ACCR+TYPD,0,0,0),
OP("divd2",0x66,2,ACCR+TYPD,ACCM+TYPD,0,0,0,0),
OP("divb3",0x87,3,ACCR+TYPB,ACCR+TYPB,ACCW+TYPB,0,0,0),
OP("divb2",0x86,2,ACCR+TYPB,ACCM+TYPB,0,0,0,0),
OP("decw",0xb7,1,ACCM+TYPW,0,0,0,0,0),
OP("decl",0xd7,1,ACCM+TYPL,0,0,0,0,0),
OP("decb",0x97,1,ACCM+TYPB,0,0,0,0,0),
OP("cvtwl",0x32,2,ACCR+TYPW,ACCW+TYPL,0,0,0,0),
OP("cvtwf",0x4d,2,ACCR+TYPW,ACCW+TYPF,0,0,0,0),
OP("cvtwd",0x6d,2,ACCR+TYPW,ACCW+TYPD,0,0,0,0),
OP("cvtwb",0x33,2,ACCR+TYPW,ACCW+TYPB,0,0,0,0),
OP("cvttp",0x26,5,ACCR+TYPW,ACCA+TYPB,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,0),
OP("cvtsp",0x09,4,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,0,0),
OP("cvtrfl",0x4b,2,ACCR+TYPF,ACCW+TYPL,0,0,0,0),
OP("cvtrdl",0x6b,2,ACCR+TYPD,ACCW+TYPL,0,0,0,0),
OP("cvtpt",0x24,5,ACCR+TYPW,ACCA+TYPB,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,0),
OP("cvtps",0x08,4,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,0,0),
OP("cvtpl",0x36,3,ACCR+TYPW,ACCA+TYPB,ACCW+TYPL,0,0,0),
OP("cvtlw",0xf7,2,ACCR+TYPL,ACCW+TYPW,0,0,0,0),
OP("cvtlp",0xf9,3,ACCR+TYPL,ACCR+TYPW,ACCA+TYPB,0,0,0),
OP("cvtlf",0x4e,2,ACCR+TYPL,ACCW+TYPF,0,0,0,0),
OP("cvtld",0x6e,2,ACCR+TYPL,ACCW+TYPD,0,0,0,0),
OP("cvtlb",0xf6,2,ACCR+TYPL,ACCW+TYPB,0,0,0,0),
OP("cvtfw",0x49,2,ACCR+TYPF,ACCW+TYPW,0,0,0,0),
OP("cvtfl",0x4a,2,ACCR+TYPF,ACCW+TYPL,0,0,0,0),
OP("cvtfd",0x56,2,ACCR+TYPF,ACCW+TYPD,0,0,0,0),
OP("cvtfb",0x48,2,ACCR+TYPF,ACCW+TYPB,0,0,0,0),
OP("cvtdw",0x69,2,ACCR+TYPD,ACCW+TYPW,0,0,0,0),
OP("cvtdl",0x6a,2,ACCR+TYPD,ACCW+TYPL,0,0,0,0),
OP("cvtdf",0x76,2,ACCR+TYPD,ACCW+TYPF,0,0,0,0),
OP("cvtdb",0x68,2,ACCR+TYPD,ACCW+TYPB,0,0,0,0),
OP("cvtbw",0x99,2,ACCR+TYPB,ACCW+TYPW,0,0,0,0),
OP("cvtbl",0x98,2,ACCR+TYPB,ACCW+TYPL,0,0,0,0),
OP("cvtbf",0x4c,2,ACCR+TYPB,ACCW+TYPB,0,0,0,0),
OP("cvtbd",0x6c,2,ACCR+TYPB,ACCW+TYPD,0,0,0,0),
OP("crc",0x0b,4,ACCA+TYPB,ACCR+TYPL,ACCR+TYPW,ACCA+TYPB,0,0),
OP("cmpzv",0xed,4,ACCR+TYPL,ACCR+TYPB,ACCR+TYPB,ACCR+TYPL,0,0),
OP("cmpw",0xb1,2,ACCR+TYPW,ACCR+TYPW,0,0,0,0),
OP("cmpv",0xec,4,ACCR+TYPL,ACCR+TYPB,ACCR+TYPB,ACCR+TYPL,0,0),
OP("cmpp4",0x37,4,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,0,0),
OP("cmpp3",0x35,3,ACCR+TYPW,ACCA+TYPB,ACCA+TYPB,0,0,0),
OP("cmpl",0xd1,2,ACCR+TYPL,ACCR+TYPL,0,0,0,0),
OP("cmpf",0x51,2,ACCR+TYPF,ACCR+TYPF,0,0,0,0),
OP("cmpd",0x71,2,ACCR+TYPD,ACCR+TYPD,0,0,0,0),
OP("cmpc5",0x2d,5,ACCR+TYPW,ACCA+TYPB,ACCR+TYPB,ACCR+TYPW,ACCA+TYPB,0),
OP("cmpc3",0x29,3,ACCR+TYPW,ACCA+TYPB,ACCA+TYPB,0,0,0),
OP("cmpb",0x91,2,ACCR+TYPB,ACCR+TYPB,0,0,0,0),
OP("clrw",0xb4,1,ACCW+TYPW,0,0,0,0,0),
OP("clrq",0x7c,1,ACCW+TYPQ,0,0,0,0,0),
OP("clrl",0xd4,1,ACCW+TYPL,0,0,0,0,0),
OP("clrf",0xd4,1,ACCW+TYPF,0,0,0,0,0),
OP("clrd",0x7c,1,ACCW+TYPD,0,0,0,0,0),
OP("clrb",0x94,1,ACCW+TYPB,0,0,0,0,0),
OP("chmu",0xbf,1,ACCR+TYPW,0,0,0,0,0),
OP("chms",0xbe,1,ACCR+TYPW,0,0,0,0,0),
OP("chmk",0xbc,1,ACCR+TYPW,0,0,0,0,0),
OP("chme",0xbd,1,ACCR+TYPW,0,0,0,0,0),
OP("casew",0xaf,3,ACCR+TYPW,ACCR+TYPW,CASEX|ACCR+TYPW,0,0,0),
OP("casel",0xcf,3,ACCR+TYPL,ACCR+TYPL,CASEX|ACCR+TYPL,0,0,0),
OP("caseb",0x8f,3,ACCR+TYPB,ACCR+TYPB,CASEX|ACCR+TYPB,0,0,0),
OP("calls",0xfb,2,ACCR+TYPL,ACCA+TYPB,0,0,0,0),
OP("callg",0xfa,2,ACCA+TYPB,ACCA+TYPB,0,0,0,0),
OP("bvs",0x1d,1,ACCB+TYPB,0,0,0,0,0),
OP("bvc",0x1c,1,ACCB+TYPB,0,0,0,0,0),
OP("bsbw",0x30,1,ACCB+TYPW,0,0,0,0,0),
OP("bsbb",0x10,1,ACCB+TYPB,0,0,0,0,0),
OP("brw",0x31,1,ACCB+TYPW,0,0,0,0,0),
OP("brb",0x11,1,ACCB+TYPB,0,0,0,0,0),
OP("bpt",0x03,0,0,0,0,0,0,0),
OP("bnequ",0x12,1,ACCB+TYPB,0,0,0,0,0),
OP("bneq",0x12,1,ACCB+TYPB,0,0,0,0,0),
OP("blssu",0x1f,1,ACCB+TYPB,0,0,0,0,0),
OP("blss",0x19,1,ACCB+TYPB,0,0,0,0,0),
OP("blequ",0x1b,1,ACCB+TYPB,0,0,0,0,0),
OP("bleq",0x15,1,ACCB+TYPB,0,0,0,0,0),
OP("blbs",0xe8,2,ACCR+TYPL,ACCB+TYPB,0,0,0,0),
OP("blbc",0xe9,2,ACCR+TYPL,ACCB+TYPB,0,0,0,0),
OP("bitw",0xb3,2,ACCR+TYPW,ACCR+TYPW,0,0,0,0),
OP("bitl",0xd3,2,ACCR+TYPL,ACCR+TYPL,0,0,0,0),
OP("bitb",0x93,2,ACCR+TYPB,ACCR+TYPB,0,0,0,0),
OP("bisw3",0xa9,3,ACCR+TYPW,ACCR+TYPW,ACCW+TYPW,0,0,0),
OP("bisw2",0xa8,2,ACCR+TYPW,ACCM+TYPW,0,0,0,0),
OP("bispsw",0xb8,1,ACCR+TYPW,0,0,0,0,0),
OP("bisl3",0xc9,3,ACCR+TYPL,ACCR+TYPL,ACCW+TYPL,0,0,0),
OP("bisl2",0xc8,2,ACCR+TYPL,ACCM+TYPL,0,0,0,0),
OP("bisb3",0x89,3,ACCR+TYPB,ACCR+TYPB,ACCW+TYPB,0,0,0),
OP("bisb2",0x88,2,ACCR+TYPB,ACCM+TYPB,0,0,0,0),
OP("bicw3",0xab,3,ACCR+TYPW,ACCR+TYPW,ACCW+TYPW,0,0,0),
OP("bicw2",0xaa,2,ACCR+TYPW,ACCM+TYPW,0,0,0,0),
OP("bicpsw",0xb9,1,ACCR+TYPW,0,0,0,0,0),
OP("bicl3",0xcb,3,ACCR+TYPL,ACCR+TYPL,ACCW+TYPL,0,0,0),
OP("bicl2",0xca,2,ACCR+TYPL,ACCM+TYPL,0,0,0,0),
OP("bicb3",0x8b,3,ACCR+TYPB,ACCR+TYPB,ACCW+TYPB,0,0,0),
OP("bicb2",0x8a,2,ACCR+TYPB,ACCM+TYPB,0,0,0,0),
OP("bgtru",0x1a,1,ACCB+TYPB,0,0,0,0,0),
OP("bgtr",0x14,1,ACCB+TYPB,0,0,0,0,0),
OP("bgequ",0x1e,1,ACCB+TYPB,0,0,0,0,0),
OP("bgeq",0x18,1,ACCB+TYPB,0,0,0,0,0),
OP("beqlu",0x13,1,ACCB+TYPB,0,0,0,0,0),
OP("beql",0x13,1,ACCB+TYPB,0,0,0,0,0),
OP("bcs",0x1f,1,ACCB+TYPB,0,0,0,0,0),
OP("bcc",0x1e,1,ACCB+TYPB,0,0,0,0,0),
OP("bbssi",0xe6,3,ACCR+TYPL,ACCR+TYPB,ACCB+TYPB,0,0,0),
OP("bbss",0xe2,3,ACCR+TYPL,ACCR+TYPB,ACCB+TYPB,0,0,0),
OP("bbsc",0xe4,3,ACCR+TYPL,ACCR+TYPB,ACCB+TYPB,0,0,0),
OP("bbs",0xe0,3,ACCR+TYPL,ACCR+TYPB,ACCB+TYPB,0,0,0),
OP("bbcs",0xe3,3,ACCR+TYPL,ACCR+TYPB,ACCB+TYPB,0,0,0),
OP("bbcci",0xe7,3,ACCR+TYPL,ACCR+TYPB,ACCB+TYPB,0,0,0),
OP("bbcc",0xe5,3,ACCR+TYPL,ACCR+TYPB,ACCB+TYPB,0,0,0),
OP("bbc",0xe1,3,ACCR+TYPL,ACCR+TYPB,ACCB+TYPB,0,0,0),
OP("ashq",0x79,3,ACCR+TYPB,ACCR+TYPQ,ACCW+TYPQ,0,0,0),
OP("ashp",0xf8,6,ACCR+TYPB,ACCR+TYPW,ACCA+TYPB,ACCR+TYPB,ACCR+TYPW,ACCA+TYPB),
OP("ashl",0x78,3,ACCR+TYPB,ACCR+TYPL,ACCW+TYPL,0,0,0),
OP("aoblss",0xf2,3,ACCR+TYPL,ACCM+TYPL,ACCB+TYPB,0,0,0),
OP("aobleq",0xf3,3,ACCR+TYPL,ACCM+TYPL,ACCB+TYPB,0,0,0),
OP("adwc",0xd8,2,ACCR+TYPL,ACCM+TYPL,0,0,0,0),
OP("addw3",0xa1,3,ACCR+TYPW,ACCR+TYPW,ACCW+TYPW,0,0,0),
OP("addw2",0xa0,2,ACCR+TYPW,ACCM+TYPW,0,0,0,0),
OP("addp6",0x21,6,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB),
OP("addp4",0x20,4,ACCR+TYPW,ACCA+TYPB,ACCR+TYPW,ACCA+TYPB,0,0),
OP("addl3",0xc1,3,ACCR+TYPL,ACCR+TYPL,ACCW+TYPL,0,0,0),
OP("addl2",0xc0,2,ACCR+TYPL,ACCM+TYPL,0,0,0,0),
OP("addf3",0x41,3,ACCR+TYPF,ACCR+TYPF,ACCW+TYPF,0,0,0),
OP("addf2",0x40,2,ACCR+TYPF,ACCM+TYPF,0,0,0,0),
OP("addd3",0x61,3,ACCR+TYPD,ACCR+TYPD,ACCW+TYPD,0,0,0),
OP("addd2",0x60,2,ACCR+TYPD,ACCM+TYPD,0,0,0,0),
OP("addb3",0x81,3,ACCR+TYPB,ACCR+TYPB,ACCW+TYPB,0,0,0),
OP("addb2",0x80,2,ACCR+TYPB,ACCM+TYPB,0,0,0,0),
OP("adawi",0x58,2,ACCR+TYPW,ACCM+TYPW,0,0,0,0),
OP("acbw",0x3d,4,ACCR+TYPW,ACCR+TYPW,ACCM+TYPW,ACCB+TYPW,0,0),
OP("acbl",0xf1,4,ACCR+TYPL,ACCR+TYPL,ACCM+TYPL,ACCB+TYPW,0,0),
OP("acbf",0x4f,4,ACCR+TYPF,ACCR+TYPF,ACCM+TYPF,ACCB+TYPW,0,0),
OP("acbd",0x6f,4,ACCR+TYPD,ACCR+TYPD,ACCM+TYPD,ACCB+TYPW,0,0),
OP("acbb",0x9d,4,ACCR+TYPB,ACCR+TYPB,ACCM+TYPB,ACCB+TYPW,0,0),
OP(0,0,0,0,0,0,0,0,0)
} ;
