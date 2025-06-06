# define STRCONST 257
# define FIXCONST 258
# define SNGCONST 259
# define DBLCONST 260
# define INTCONST 261
# define OCTCONST 262
# define DECCONST 263
# define HEXCONST 264
# define STRID 265
# define INTID 266
# define SNGID 267
# define DBLID 268
# define STRAID 269
# define INTAID 270
# define SNGAID 271
# define DBLAID 272
# define STRUID 273
# define INTUID 274
# define SNGUID 275
# define DBLUID 276
# define FUNCID 277
# define LPAR 278
# define RPAR 279
# define COMMA 280
# define LPOUND 281
# define LDOT 282
# define LSEMI 283
# define LBANG 284
# define LEXP 285
# define LMINUS 286
# define LPLUS 287
# define LMULT 288
# define LDIV 289
# define LIDIV 290
# define LMOD 291
# define LEQ 292
# define LNE 293
# define LLE 294
# define LLT 295
# define LGE 296
# define LGT 297
# define LNOT 298
# define LAND 299
# define LOR 300
# define LXOR 301
# define LIMP 302
# define LEQV 303
# define GLITCH 304
# define TOKERR 305

# line 59 "eval.y"
#include	<errno.h>
#include	<math.h>
#include	<setjmp.h>
#include	<stdio.h>
#include	<values.h>
#include	<bas.h>
#include	<ctype.h>

char	tokstr[LINMAX+1]; 		/* from lexical analyzer - yylex() */

/***** GLOBALS SET BY EVAL **************/

char		*eoexpr;  /* points to end of expression - set by yylex() */
short		exprtype; /* type of return value */
struct value	exprval;  /* return value */

/************* EXTERNALS *****************/

jmp_buf	overenv;	  		/* for overflow trapping */
extern	int		errno;
extern	char		*strget();
extern struct sym	*stinsert(),
			*stsrch(),
			*paramptr;
extern struct FUNCTAB	functab[];
extern double 		atof1(),
			pow();

/*********** SEMANTIC STACK **************/

#define		STAKMAX		20

STAKREC semstack[STAKMAX],
	*semtop = semstack - 1;

char	strstack[STRMAX*4],	/* string stack */
	*strtop  = strstack;

/*******MACROS FOR ERROR CHECKING*******/

#define	NUMCHEK if ((semtop-1)->type == STRING || semtop->type == STRING)\
		{\
			error(inst.thing.linno,inst.thing.stmtno, 49);\
			return(-1);\
		}

#define MIXCHEK if (((semtop-1)->type == STRING && semtop->type != STRING)\
	  	     || ((semtop-1)->type != STRING && semtop->type == STRING))\
		{\
			error(inst.thing.linno,inst.thing.stmtno, 80);\
			return(-1);\
		}

#define STAKCHEK if (semtop >= (semstack + STAKMAX - 1))\
		 {\
			error(inst.thing.linno,inst.thing.stmtno, 48);\
			return(-1);\
		 }

#define STRCHEK(STRPTR)	if ((strtop + strlen(STRPTR)) > (strstack + STRMAX * 4))\
			{\
				error(inst.thing.linno,inst.thing.stmtno, 48);\
				return(-1);\
			}
# define UMINUS 306
#define yyclearin yychar = -1
#define yyerrok yyerrflag = 0
extern int yychar;
extern short yyerrflag;
#ifndef YYMAXDEPTH
#define YYMAXDEPTH 150
#endif
YYSTYPE yylval; YYSTYPE yyval;
# define YYERRCODE 256

# line 806 "eval.y"

eval(evstring)
char	*evstring;
{
	STAKREC	*oldsem;
	char	*oldstr;

	eoexpr = evstring;
	oldsem = semtop;
	oldstr = strtop;
	if (yyparse())
	{
		semtop = oldsem;
		strtop = oldstr;
		return(-1);
	}
	else
	{
		semtop = oldsem;
		strtop = oldstr;
		return(0);
	}
}


yyerror(errstring)
char	*errstring;
{
	error(inst.thing.linno,inst.thing.stmtno, 8);
}



yylex()
{
	extern	int	rinput();
	int		retval;
	register char	*tptr;
	register	trailing;

	switch (retval = lex(&eoexpr, tokstr))
	{
	case FUNCID:
		yylval.ival = tokstr[1] & 0377;
		if (functab[yylval.ival-1].handler == rinput)
			return(GLITCH);
		else
			return(FUNCID);
	case INTCONST:
			yylval.ival = trailing = 0;
			tptr = tokstr;
			while (*tptr == '0') 
				tptr++;
			while (1)
				switch (*tptr++)
				{
				case '\0' :
					yylval.ival -= trailing;
					return(INTCONST);
				case '0'  :
					yylval.ival++;
					trailing++;
					break;
				default   :
					yylval.ival++;
					trailing = 0;
					break;
				}
	case FIXCONST:
			yylval.ival = trailing = 0;
			tptr = tokstr;
			while (*tptr == '0' || *tptr == '.') 
				tptr++;
			while (1)
				switch (*tptr++)
				{
				case '\0':
					yylval.ival -= trailing;
					return(FIXCONST);
				case '0' :
					yylval.ival++;
					trailing++;
					break;
				case '.' :
					break;
				default  :
					yylval.ival++;
					trailing = 0;
					break;
				}
	default:
			break;
	}
	if (retval > TOKERR)	/* keyword encountered, back up and stop */
	{
		eoexpr--;
		return(0);
	}
	return(retval);
}


dmpstak(msg)
{
	STAKREC	*currec;

	printf("Semantic Stack Dump %s\n", msg);
	currec = semtop;
	while (currec >= semstack)
		switch(currec->type)
		{
		case DOUBLE :   printf("DOUBLE: %.40g\n", (currec--)->val.dval);
				break;
		case SINGLE :   printf("SINGLE: %.40g\n", (currec--)->val.fval);
				break;
		case INTEGER :  printf("INTEGER: %d\n", (currec--)->val.ival);
				break;
		case STRING :   printf("STRING: %s\n", (currec--)->val.sval);
				break;
		}
}


/*	evaluates calls to user-defined functions	*/
ufunceval(stptr, numargs)
struct sym	*stptr;
int		numargs;
{
	struct sym	*oldparam,
			*curarg;
	char		savetok[LINMAX+1],
			*oldlexptr,
			*tptr;
	int		actargs,
			oldyylval;

	if (stptr->scratch)
	{	/* recursive call */
		stptr->scratch = 0;
		error(inst.thing.linno,inst.thing.stmtno, 65);
		return(-1);
	}
	/* save active parameter and globals */
	oldparam = paramptr;
	strcpy(savetok, tokstr);
	oldyylval = yylval.ival;
	oldlexptr = eoexpr;
	if (stptr->data.udef.arg == NULL)
	{
		if (numargs != 0)
		{
			error(inst.thing.linno,inst.thing.stmtno, 52);
			return(-1);
		} else
			paramptr = NULL;
	}
	else
	{
		curarg = paramptr = stptr->data.udef.arg;
		actargs = 1;
		while (actargs <= numargs)
		{
			if (curarg == NULL)
			{
				error(inst.thing.linno,inst.thing.stmtno, 52);
				return(-1);
			}
			switch (curarg->symtype)
			{
			case DBLID:
				switch (semtop->type)
				{
				case DOUBLE:
					curarg->data.dval = semtop->val.dval;
					break;
				case SINGLE:
					curarg->data.dval = semtop->val.fval;
					break;
				case INTEGER:
					curarg->data.dval = semtop->val.ival;
					break;
				case STRING:
					error(inst.thing.linno,inst.thing.stmtno, 50);
					return(-1);
				}
				break;
			case SNGID:
				switch (semtop->type)
				{
				case DOUBLE:
					curarg->data.fval 
						= mkfloat(semtop->val.dval);
					break;
				case SINGLE:
					curarg->data.fval = semtop->val.fval;
					break;
				case INTEGER:
					curarg->data.fval = semtop->val.ival;
					break;
				case STRING:
					error(inst.thing.linno,inst.thing.stmtno, 50);
					return(-1);
				}
				break;
			case INTID:
				switch (semtop->type)
				{
				case DOUBLE:
					curarg->data.ival 
					     = mkint(semtop->val.dval);
					break;
				case SINGLE:
					curarg->data.ival 
						= mkint(semtop->val.fval);
					break;
				case INTEGER:
					curarg->data.ival = semtop->val.ival;
					break;
				case STRING:
					error(inst.thing.linno,inst.thing.stmtno, 50);
					return(-1);
				}
				break;
			case STRID:
				switch (semtop->type)
				{
				case DOUBLE:
				case SINGLE:
				case INTEGER:
					error(inst.thing.linno,inst.thing.stmtno, 50);
					return(-1);
				case STRING:
					if((curarg->data.string = 
					    strget(semtop->val.sval)) == NULL)
						return(-1);
					strtop = semtop->val.sval;
					break;
				}
				break;
			}
			semtop--;
			actargs++;
			curarg = curarg->next;
		}
		if (curarg != NULL)
		{
			error(inst.thing.linno,inst.thing.stmtno, 52);
			return(-1);
		}
	}

	stptr->scratch = 1;
	if (eval(stptr->data.udef.funcexp) < 0)
	{
		paramptr = oldparam;
		strcpy(tokstr, savetok);
		eoexpr = oldlexptr;
		stptr->scratch = 0;
		return(-1);
	}

	/* restore old parameter and globals */
	curarg = paramptr;
	for (actargs = 1; actargs <= numargs; actargs++)
	{
		if (curarg->symtype == STRID)
			strfree(curarg->data.string);
		curarg = curarg->next;
	}
	paramptr = oldparam;
	strcpy(tokstr, savetok);
	yylval.ival = oldyylval;
	eoexpr = oldlexptr;
	stptr->scratch = 0;

	/* stack result */
	STAKCHEK
	if (stptr->symtype == DBLUID)
	{
		if (exprtype == STRING)
		{
			error(inst.thing.linno,inst.thing.stmtno, 49);
			return(-1);
		}
		else if (exprtype == INTEGER)
			(++semtop)->val.dval = exprval.ival;
		else if (exprtype == SINGLE)
			(++semtop)->val.dval = exprval.fval;
		else 
			(++semtop)->val.dval = exprval.dval;
		semtop->type = DOUBLE;
	}
	if (stptr->symtype == SNGUID)
	{
		if (exprtype == STRING)
		{
			error(inst.thing.linno,inst.thing.stmtno, 49);
			return(-1);
		}
		else if (exprtype == INTEGER)
			(++semtop)->val.fval = exprval.ival;
		else if (exprtype == SINGLE)
			(++semtop)->val.fval = exprval.fval;
		else 
			(++semtop)->val.fval = mkfloat(exprval.dval);
		semtop->type = SINGLE;
	}
	else if (stptr->symtype == INTUID)
	{
		if (exprtype == STRING)
		{
			error(inst.thing.linno,inst.thing.stmtno, 49);
			return(-1);
		}
		else if (exprtype == INTEGER)
			(++semtop)->val.ival = exprval.ival;
		else if (exprtype == SINGLE)
			(++semtop)->val.ival = mkint(exprval.fval);
		else 
			(++semtop)->val.ival = mkint(exprval.dval);
		semtop->type = INTEGER;
	}
	else	/* STRUID */
	{
		if (exprtype != STRING)
		{
			error(inst.thing.linno,inst.thing.stmtno, 51);
			return(-1);
		}
		(++semtop)->val.sval = strtop;
		semtop->type = STRING;
		tptr = exprval.sval;
		STRCHEK(tptr);
		while (*strtop++ = *tptr++) ;
	}
	return(0);
}



/*	makes list of dimensions from values on semantic stack	*/
mkdimlist(numdims, dimlist)
int	numdims;
short	dimlist[];
{
	register	i;

	for (i=0; i < numdims; i++)
		switch ((semtop - numdims + i + 1)->type)
		{
		case STRING:
			error(inst.thing.linno,inst.thing.stmtno, 49);
			return(-1);
		case DOUBLE:
			if ((semtop - numdims + i + 1)->val.dval < -.5)
			{
				error(inst.thing.linno,inst.thing.stmtno, 28);
				return(-1);
			}
			if ((semtop - numdims + i + 1)->val.dval >= MAXSHORT)
			{
				error(inst.thing.linno,inst.thing.stmtno, 86);
				return(-1);
			}
			dimlist[i] = (semtop - numdims + i + 1)->val.dval + .5;
			break;
		case SINGLE:
			if ((semtop - numdims + i + 1)->val.fval < -.5)
			{
				error(inst.thing.linno,inst.thing.stmtno, 28);
				return(-1);
			}
			if ((semtop - numdims + i + 1)->val.fval >= MAXSHORT)
			{
				error(inst.thing.linno,inst.thing.stmtno, 86);
				return(-1);
			}
			dimlist[i] = (semtop - numdims + i + 1)->val.fval + .5;
			break;
		case INTEGER:
			if ((semtop - numdims + i + 1)->val.ival < 0)
			{
				error(inst.thing.linno,inst.thing.stmtno, 28);
				return(-1);
			}
			if ((semtop - numdims + i + 1)->val.ival >= MAXSHORT)
			{
				error(inst.thing.linno,inst.thing.stmtno, 28);
				return(-1);
			}
			dimlist[i] = (semtop - numdims + i + 1)->val.ival;
			break;
		}
	return(0);
}



intify(value)
double	value;
{
	if (value > MAXINT)
		value = MAXINT;
	if (value < -MAXINT)
		value = -MAXINT;
	return((value > 0) ? (int) (value + .5) : (int) (value - .5));
}



mkint(value)
double	value;
{
	if (value > MAXINT)
	{
		error(inst.thing.linno,inst.thing.stmtno, 94);
		value = MAXINT;
	}
	if (value < -MAXINT)
	{
		error(inst.thing.linno,inst.thing.stmtno, 94);
		value = -MAXINT;
	}
	return((value > 0) ? (int) (value + .5) : (int) (value - .5));
}



float
mkfloat(value)
double	value;
{
	if (value > maxfloat)
	{
		error(inst.thing.linno,inst.thing.stmtno, 95);
		value = maxfloat;
	}
	if (value < -maxfloat)
	{
		error(inst.thing.linno,inst.thing.stmtno, 95);
		value = -maxfloat;
	}
	return(value);
}
short yyexca[] ={
-1, 1,
	0, -1,
	-2, 0,
	};
# define YYNPROD 55
# define YYLAST 409
short yyact[]={

   8,  10,  12,  11,   9,  13,  14,  15,  20,  23,
  26,  29,  21,  24,  27,  30,  22,  25,  28,  31,
  16,  19,  49,  49,  87,  47,  48,  46,  45,   5,
   6,  49,  44,  43,  47,  48,  46,  45,  55,  49,
  54,   4,  47,  48,  46,  84,  81,  17,   3,   8,
  10,  12,  11,   9,  13,  14,  15,  20,  23,  26,
  29,  21,  24,  27,  30,  22,  25,  28,  31,  16,
  19,  49,  80,  81,  47,  48,  53,  75,   5,   6,
   7,   1,  18,   0,   0,   0,   0,   0,   0,   0,
   4,   0,   0,   0,   0,   0,  17,   8,  10,  12,
  11,   9,  13,  14,  15,  20,  23,  26,  29,  21,
  24,  27,  30,  22,  25,  28,  31,  16,  19,   0,
   0,   0,   0,   0,   0,   0,   5,   6,   0,   0,
   0,   0,   0,  78,   0,   0,   0,   0,   4,  82,
  83,   0,   0,   0,  17,  49,  44,  43,  47,  48,
  46,  45,  37,  38,  39,  40,  41,  42,  90,  36,
  34,  35,  33,  32,  49,  44,  43,  47,  48,  46,
  45,  37,  38,  39,  40,  41,  42,  88,  36,  34,
  35,  33,  32,  49,  44,  43,  47,  48,  46,  45,
  37,  38,  39,  40,  41,  42,  79,  36,  34,  35,
  33,  32,  49,  44,  43,  47,  48,  46,  45,  37,
  38,  39,  40,  41,  42,   0,  36,  34,  35,  33,
  32,  49,  44,  43,  47,  48,  46,  45,  37,  38,
  39,  40,  41,  42,   0,  36,  34,  35,  33,  32,
  49,  44,  43,  47,  48,  46,  45,  37,  38,  39,
  40,  41,  42,   0,  36,  34,  35,   0,  32,  49,
  44,  43,  47,  48,  46,  45,  37,  38,  39,  40,
  41,  42,   0,  36,  34,  35,  49,  44,  43,  47,
  48,  46,  45,  37,  38,  39,  40,  41,  42,   0,
  36,  34,  49,  44,  43,  47,  48,  46,  45,  37,
  38,  39,  40,  41,  42,   0,  36,  49,  44,  43,
  47,  48,  46,  45,  37,  38,  39,  40,  41,  42,
  76,   2,   0,   0,   0,  50,  51,  52,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
  56,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,  57,  58,  59,  60,  61,  62,  63,
  64,  65,  66,  67,  68,  69,  70,  71,  72,  73,
  74,   0,   0,   0,   0,  77,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,  85,   0,  86,   0,   0,   0,  89 };
short yypact[]={

-208,-1000, -64,-1000,-160,-160,-160,-1000,-1000,-1000,
-1000,-1000,-1000,-1000,-1000,-1000,-202,-238,-240,-160,
-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000,
-1000,-1000,-160,-160,-160,-160,-160,-160,-160,-160,
-160,-160,-160,-160,-160,-160,-160,-160,-160,-160,
  22,-262,-262,-160,-160,-160, -83, -26, -45,   7,
  -9,  22,-254,-254,-254,-254,-254,-254,-263,-263,
-246,-214,-262,-262,-1000,-207, -64,-140,-234,-1000,
-1000,-160,-1000,-257,-1000, -64,-102,-160,-1000,-121,
-1000 };
short yypgo[]={

   0,  77,  82,  81, 320,  80 };
short yyr1[]={

   0,   3,   3,   4,   4,   4,   4,   4,   4,   4,
   4,   4,   4,   4,   4,   4,   4,   4,   4,   4,
   4,   4,   4,   4,   4,   5,   5,   5,   5,   5,
   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,
   5,   2,   2,   2,   2,   2,   2,   2,   2,   2,
   2,   2,   2,   1,   1 };
short yyr2[]={

   0,   1,   1,   3,   3,   3,   3,   3,   2,   3,
   3,   3,   3,   3,   3,   3,   3,   3,   3,   3,
   3,   2,   2,   3,   1,   1,   1,   1,   1,   1,
   1,   1,   1,   1,   4,   4,   6,   7,   1,   4,
   3,   1,   1,   1,   1,   1,   1,   1,   1,   1,
   1,   1,   1,   3,   1 };
short yychk[]={

-1000,  -3,  -4, 256, 298, 286, 287,  -5, 257, 261,
 258, 260, 259, 262, 263, 264, 277, 304,  -2, 278,
 265, 269, 273, 266, 270, 274, 267, 271, 275, 268,
 272, 276, 303, 302, 300, 301, 299, 292, 293, 294,
 295, 296, 297, 287, 286, 291, 290, 288, 289, 285,
  -4,  -4,  -4, 278, 278, 278,  -4,  -4,  -4,  -4,
  -4,  -4,  -4,  -4,  -4,  -4,  -4,  -4,  -4,  -4,
  -4,  -4,  -4,  -4,  -4,  -1,  -4,  -4,  -1, 279,
 279, 280, 279, 280, 279,  -4,  -4, 281, 279,  -4,
 279 };
short yydef[]={

   0,  -2,   1,   2,   0,   0,   0,  24,  25,  26,
  27,  28,  29,  30,  31,  32,  33,   0,  38,   0,
  41,  42,  43,  44,  45,  46,  47,  48,  49,  50,
  51,  52,   0,   0,   0,   0,   0,   0,   0,   0,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   8,  21,  22,   0,   0,   0,   0,   3,   4,   5,
   6,   7,   9,  10,  11,  12,  13,  14,  15,  16,
  17,  18,  19,  20,  23,   0,  54,   0,   0,  40,
  34,   0,  35,   0,  39,  53,   0,   0,  36,   0,
  37 };
#
# define YYFLAG -1000
# define YYERROR goto yyerrlab
# define YYACCEPT return(0)
# define YYABORT return(1)

/*	parser for yacc output	*/

#ifdef YYDEBUG
int yydebug = 0; /* 1 for debugging */
#endif
YYSTYPE yyv[YYMAXDEPTH]; /* where the values are stored */
int yychar = -1; /* current input token number */
int yynerrs = 0;  /* number of errors */
short yyerrflag = 0;  /* error recovery flag */

yyparse() {

	short yys[YYMAXDEPTH];
	short yyj, yym;
	register YYSTYPE *yypvt;
	register short yystate, *yyps, yyn;
	register YYSTYPE *yypv;
	register short *yyxi;

	yystate = 0;
	yychar = -1;
	yynerrs = 0;
	yyerrflag = 0;
	yyps= &yys[-1];
	yypv= &yyv[-1];

 yystack:    /* put a state and value onto the stack */

#ifdef YYDEBUG
	if( yydebug  ) printf( "state %d, char 0%o\n", yystate, yychar );
#endif
		if( ++yyps> &yys[YYMAXDEPTH] ) { yyerror( "yacc stack overflow" ); return(1); }
		*yyps = yystate;
		++yypv;
		*yypv = yyval;

 yynewstate:

	yyn = yypact[yystate];

	if( yyn<= YYFLAG ) goto yydefault; /* simple state */

	if( yychar<0 ) if( (yychar=yylex())<0 ) yychar=0;
	if( (yyn += yychar)<0 || yyn >= YYLAST ) goto yydefault;

	if( yychk[ yyn=yyact[ yyn ] ] == yychar ){ /* valid shift */
		yychar = -1;
		yyval = yylval;
		yystate = yyn;
		if( yyerrflag > 0 ) --yyerrflag;
		goto yystack;
		}

 yydefault:
	/* default state action */

	if( (yyn=yydef[yystate]) == -2 ) {
		if( yychar<0 ) if( (yychar=yylex())<0 ) yychar = 0;
		/* look through exception table */

		for( yyxi=yyexca; (*yyxi!= (-1)) || (yyxi[1]!=yystate) ; yyxi += 2 ) ; /* VOID */

		while( *(yyxi+=2) >= 0 ){
			if( *yyxi == yychar ) break;
			}
		if( (yyn = yyxi[1]) < 0 ) return(0);   /* accept */
		}

	if( yyn == 0 ){ /* error */
		/* error ... attempt to resume parsing */

		switch( yyerrflag ){

		case 0:   /* brand new error */

			yyerror( "syntax error" );
		yyerrlab:
			++yynerrs;

		case 1:
		case 2: /* incompletely recovered error ... try again */

			yyerrflag = 3;

			/* find a state where "error" is a legal shift action */

			while ( yyps >= yys ) {
			   yyn = yypact[*yyps] + YYERRCODE;
			   if( yyn>= 0 && yyn < YYLAST && yychk[yyact[yyn]] == YYERRCODE ){
			      yystate = yyact[yyn];  /* simulate a shift of "error" */
			      goto yystack;
			      }
			   yyn = yypact[*yyps];

			   /* the current yyps has no shift onn "error", pop stack */

#ifdef YYDEBUG
			   if( yydebug ) printf( "error recovery pops state %d, uncovers %d\n", *yyps, yyps[-1] );
#endif
			   --yyps;
			   --yypv;
			   }

			/* there is no state on the stack with an error shift ... abort */

	yyabort:
			return(1);


		case 3:  /* no shift yet; clobber input char */

#ifdef YYDEBUG
			if( yydebug ) printf( "error recovery discards char %d\n", yychar );
#endif

			if( yychar == 0 ) goto yyabort; /* don't discard EOF, quit */
			yychar = -1;
			goto yynewstate;   /* try again in the same state */

			}

		}

	/* reduction by production yyn */

#ifdef YYDEBUG
		if( yydebug ) printf("reduce %d\n",yyn);
#endif
		yyps -= yyr2[yyn];
		yypvt = yypv;
		yypv -= yyr2[yyn];
		yyval = yypv[1];
		yym=yyn;
			/* consult goto table to find next state */
		yyn = yyr1[yyn];
		yyj = yypgo[yyn] + *yyps + 1;
		if( yyj>=YYLAST || yychk[ yystate = yyact[yyj] ] != -yyn ) yystate = yyact[yypgo[yyn]];
		switch(yym){
			
case 1:
# line 147 "eval.y"
{
			exprtype = semtop->type;

			switch (semtop->type)
			{
			case STRING  : strcpy(exprval.sval, semtop->val.sval);
				       break;
			case INTEGER : exprval.ival = semtop->val.ival;
				       break;
			case SINGLE  : exprval.fval = semtop->val.fval;
				       break;
			case DOUBLE  : exprval.dval = semtop->val.dval;
				       break;
			}
			} break;
case 2:
# line 164 "eval.y"
{
			return(-1);
			} break;
case 3:
# line 170 "eval.y"
{
			if (eqv() < 0)
				return(-1);
			} break;
case 4:
# line 176 "eval.y"
{
			if (imp() < 0)
				return(-1);
			} break;
case 5:
# line 182 "eval.y"
{
			if (or() < 0)
				return(-1);
			} break;
case 6:
# line 188 "eval.y"
{
			if (xor() < 0)
				return(-1);
			} break;
case 7:
# line 194 "eval.y"
{
			if (and() < 0)
				return(-1);
			} break;
case 8:
# line 200 "eval.y"
{
			if (semtop->type == STRING)
			{
				error(inst.thing.linno,inst.thing.stmtno, 49);
				return(-1);
			}
			switch (semtop->type)
			{
			case DOUBLE:
				semtop->val.ival = ~mkint(semtop->val.dval);
				break;
			case SINGLE:
				semtop->val.ival = 
					       ~mkint((double)semtop->val.fval);
				break;
			case INTEGER:
				semtop->val.ival = ~ semtop->val.ival;
				break;
			}
			semtop->type = INTEGER;
			} break;
case 9:
# line 223 "eval.y"
{
			if (eq() < 0)
				return(-1);
			} break;
case 10:
# line 229 "eval.y"
{
			if (ne() < 0)
				return(-1);
			} break;
case 11:
# line 235 "eval.y"
{
			if (le() < 0)
				return(-1);
			} break;
case 12:
# line 241 "eval.y"
{
			if (lt() < 0)
				return(-1);
			} break;
case 13:
# line 247 "eval.y"
{
			if (ge() < 0)
				return(-1);
			} break;
case 14:
# line 253 "eval.y"
{
			if (gt() < 0)
				return(-1);
			} break;
case 15:
# line 259 "eval.y"
{
			if (plus() < 0)
				return(-1);
			} break;
case 16:
# line 265 "eval.y"
{
			if (minus() < 0)
				return(-1);
			} break;
case 17:
# line 271 "eval.y"
{
			if (mod() < 0)
				return(-1);
			} break;
case 18:
# line 277 "eval.y"
{
			if (idiv() < 0)
				return(-1);
			} break;
case 19:
# line 283 "eval.y"
{
			if (mult() < 0)
				return(-1);
			} break;
case 20:
# line 289 "eval.y"
{
			if (div() < 0)
				return(-1);
			} break;
case 21:
# line 295 "eval.y"
{
			switch (semtop->type)
			{
			case DOUBLE:
				semtop->val.dval = -semtop->val.dval;
				break;
			case SINGLE:
				semtop->val.fval = -semtop->val.fval;
				break;
			case INTEGER:
				semtop->val.ival = -semtop->val.ival;
				break;
			default:
				error(inst.thing.linno,inst.thing.stmtno, 49);
				return(-1);
			}
			} break;
case 23:
# line 316 "eval.y"
{
			if (raise() < 0)
				return(-1);
			} break;
case 25:
# line 325 "eval.y"
{
			register char	*tptr;

			STAKCHEK
			(++semtop)->val.sval = strtop;
			semtop->type = STRING;
			tptr = tokstr;
			STRCHEK(tptr);
			while (*strtop++ = *tptr++) ;
			if ((strtop - semtop->val.sval) > STRMAX)
			{
				error(inst.thing.linno,inst.thing.stmtno, 87);
				return(-1);
			}
			} break;
case 26:
# line 342 "eval.y"
{
			STAKCHEK
			++semtop;
			if (setjmp(overenv) != 0)
				semtop->val.dval = MAXDOUBLE;
			else if (( semtop->val.dval = atof1(tokstr))
							== MAXDOUBLE)
				error(inst.thing.linno,inst.thing.stmtno, 60);
			if (semtop->val.dval >= -MAXINT 
				&& semtop->val.dval <= MAXINT)
			{
				semtop->val.ival = semtop->val.dval;
				semtop->type = INTEGER;
			} 
			else if ((semtop->val.dval >= -maxfloat 
				&& semtop->val.dval <= maxfloat)
				&& yypvt[-0].ival <= 7)
			{
				semtop->val.fval = semtop->val.dval;
				semtop->type = SINGLE;
			} 
			else
				semtop->type = DOUBLE;
			} break;
case 27:
# line 368 "eval.y"
{
			STAKCHEK
			++semtop;
			if (setjmp(overenv) != 0)
				semtop->val.dval = MAXDOUBLE;
			else if (( semtop->val.dval = atof1(tokstr))
							== MAXDOUBLE)
				error(inst.thing.linno,inst.thing.stmtno, 60);
			if (yypvt[-0].ival > 7 || semtop->val.dval < -maxfloat 
					       || semtop->val.dval > maxfloat)
				semtop->type = DOUBLE;
			else
			{
				semtop->val.fval = semtop->val.dval;
				semtop->type = SINGLE;
			} 
			} break;
case 28:
# line 387 "eval.y"
{
			STAKCHEK
			++semtop;
			if (setjmp(overenv) != 0)
				semtop->val.dval = MAXDOUBLE;
			else if ((semtop->val.dval = atof1(tokstr))
							== MAXDOUBLE)
				error(inst.thing.linno,inst.thing.stmtno, 60);
			semtop->type = DOUBLE;
			} break;
case 29:
# line 399 "eval.y"
{
			STAKCHEK
			++semtop;
			if (setjmp(overenv) != 0)
				semtop->val.fval = maxfloat;
			else 
				semtop->val.fval = mkfloat(atof1(tokstr));
			semtop->type = SINGLE;
			} break;
case 30:
# line 410 "eval.y"
{
			STAKCHEK
			(++semtop)->type = INTEGER;
			if (octtoi(tokstr, &(semtop->val.ival)) < 0)
			{
				error(inst.thing.linno,inst.thing.stmtno, 8);
				return(-1);
			}
			} break;
case 31:
# line 421 "eval.y"
{
			STAKCHEK
			(++semtop)->type = INTEGER;
			if (dectoi(tokstr, &(semtop->val.ival)) < 0)
			{
				error(inst.thing.linno,inst.thing.stmtno, 8);
				return(-1);
			}
			} break;
case 32:
# line 432 "eval.y"
{
			STAKCHEK
			(++semtop)->type = INTEGER;
			if (hextoi(tokstr, &(semtop->val.ival)) < 0)
			{
				error(inst.thing.linno,inst.thing.stmtno, 8);
				return(-1);
			}
			} break;
case 33:
# line 443 "eval.y"
{
			errno = 0;
			if (((*(functab[yypvt[-0].ival - 1].handler))(0)) < 0)
				return(-1);
			} break;
case 34:
# line 450 "eval.y"
{
			errno = 0;
			if (((*(functab[yypvt[-3].ival - 1].handler))(yypvt[-1].ival)) < 0)
				return(-1);
			} break;
case 35:
# line 457 "eval.y"
{
			errno = 0;
			if (((*(functab[yypvt[-3].ival - 1].handler))(1)) < 0)
				return(-1);
			} break;
case 36:
# line 464 "eval.y"
{
			errno = 0;
			if (((*(functab[yypvt[-5].ival - 1].handler))(2)) < 0)
				return(-1);
			} break;
case 37:
# line 471 "eval.y"
{
			errno = 0;
			if (((*(functab[yypvt[-6].ival - 1].handler))(2)) < 0)
				return(-1);
			} break;
case 38:
# line 478 "eval.y"
{
			register char	*tptr;

			STAKCHEK
			switch (yypvt[-0].symptr->symtype)
			{
			case DBLID:
				if (yypvt[-0].symptr->isbufvar)
				{
					if (getdouble(yypvt[-0].symptr->data.bufvar.start,
						&((++semtop)->val.dval)) < 0)
						return(-1);
				} else
					(++semtop)->val.dval = yypvt[-0].symptr->data.dval;
				semtop->type = DOUBLE;
				break;
			case SNGID:
				if (yypvt[-0].symptr->isbufvar)
				{
					float	tmp;

					if (getfloat(yypvt[-0].symptr->data.bufvar.start,
						& tmp) < 0)
						return(-1);
					(++semtop)->val.fval = tmp;
				} else
					(++semtop)->val.fval = yypvt[-0].symptr->data.fval;
				semtop->type = SINGLE;
				break;
			case INTID:
				if (yypvt[-0].symptr->isbufvar)
				{
					int	i;
					char	*to,
						*from;

					to = (char *) & (++semtop)->val.ival;
					from = yypvt[-0].symptr->data.bufvar.start;
					for (i=0; i<yypvt[-0].symptr->data.bufvar.length; i++)
						*to++ = *from++;
				} else
					(++semtop)->val.ival = yypvt[-0].symptr->data.ival;
				semtop->type = INTEGER;
				break;
			case STRID:
				(++semtop)->val.sval = strtop;
				semtop->type = STRING;
				if (yypvt[-0].symptr->isbufvar)
				{
					int	i;
					char	*from;

					if ((strtop + yypvt[-0].symptr->data.bufvar.length+1) 
						> (strstack+STRMAX*4))
					{
						error(inst.thing.linno,inst.thing.stmtno, 48);
						return(-1);
					}
					from = yypvt[-0].symptr->data.bufvar.start;
					for (i=0; i<yypvt[-0].symptr->data.bufvar.length; i++)
						*strtop++ = *from++;
					*strtop++ = '\0';
				} else {
					tptr = yypvt[-0].symptr->data.string;
					STRCHEK(tptr);
					while (*strtop++ = *tptr++) ;
				}
				break;
			case DBLUID:
			case SNGUID:
			case INTUID:
			case STRUID:
				if (ufunceval(yypvt[-0].symptr, 0) < 0)
					return(-1);
			}
			} break;
case 39:
# line 556 "eval.y"
{
			short		dimlist[MAXDIM],
					offset,
					*makeheader();
			register 	i;
			long		size;
			register char	*tptr;

			switch (yypvt[-3].symptr->symtype)
			{
			case DBLAID:
				if (yypvt[-3].symptr->data.darr.header == NULL) 
				/* auto dimension */
				{
					for (i=0; i < yypvt[-1].ival; i++)
						dimlist[i] = DEFDIM;
					if ((yypvt[-3].symptr->data.darr.header = makeheader(yypvt[-1].ival, dimlist, &size)) == NULL)
					{
						stremove(yypvt[-3].symptr->name, yypvt[-3].symptr->symtype);
						return(-1);
					}
					if ((yypvt[-3].symptr->data.darr.arblok = (double *) calloc((unsigned) size, (unsigned) sizeof(double))) == NULL)
					{
						stremove(yypvt[-3].symptr->name, yypvt[-3].symptr->symtype);
						error(inst.thing.linno,inst.thing.stmtno, 84);
						return(-1);
					}
					for (i=0; i < size; i++)
						*(yypvt[-3].symptr->data.darr.arblok + i) = 0.0;
				}
				if (mkdimlist(yypvt[-1].ival, dimlist) < 0)
					return(-1);
				if ((offset = getoffset(yypvt[-3].symptr->data.darr.header, yypvt[-1].ival, dimlist)) < 0)
					return(-1);
				semtop -= yypvt[-1].ival - 1;
				semtop->type = DOUBLE;
				semtop->val.dval = *((yypvt[-3].symptr->data.darr.arblok) + offset);
				break;

			case SNGAID:
				if (yypvt[-3].symptr->data.farr.header == NULL) 
				/* auto dimension */
				{
					for (i=0; i < yypvt[-1].ival; i++)
						dimlist[i] = DEFDIM;
					if ((yypvt[-3].symptr->data.farr.header = makeheader(yypvt[-1].ival, dimlist, &size)) == NULL)
					{
						stremove(yypvt[-3].symptr->name, yypvt[-3].symptr->symtype);
						return(-1);
					}
					if ((yypvt[-3].symptr->data.farr.arblok = (float *) calloc((unsigned) size, (unsigned) sizeof(float))) == NULL)
					{
						stremove(yypvt[-3].symptr->name, yypvt[-3].symptr->symtype);
						error(inst.thing.linno,inst.thing.stmtno, 84);
						return(-1);
					}
					for (i=0; i < size; i++)
						*(yypvt[-3].symptr->data.farr.arblok + i) = 0.0;
				}
				if (mkdimlist(yypvt[-1].ival, dimlist) < 0)
					return(-1);
				if ((offset = getoffset(yypvt[-3].symptr->data.farr.header, yypvt[-1].ival, dimlist)) < 0)
					return(-1);
				semtop -= yypvt[-1].ival - 1;
				semtop->type = SINGLE;
				semtop->val.fval = *((yypvt[-3].symptr->data.farr.arblok) + offset);
				break;

			case INTAID:
				if (yypvt[-3].symptr->data.iarr.header == NULL) 	
				/* auto dimension */
				{
					for (i=0; i < yypvt[-1].ival; i++)
						dimlist[i] = DEFDIM;
					if ((yypvt[-3].symptr->data.iarr.header = makeheader(yypvt[-1].ival, dimlist, &size)) == NULL)
					{
						stremove(yypvt[-3].symptr->name, yypvt[-3].symptr->symtype);
						return(-1);
					}
					if ((yypvt[-3].symptr->data.iarr.arblok = (int *) calloc((unsigned) size, (unsigned) sizeof(int))) == NULL)
					{
						stremove(yypvt[-3].symptr->name, yypvt[-3].symptr->symtype);
						error(inst.thing.linno,inst.thing.stmtno, 84);
						return(-1);
					}
					for (i=0; i < size; i++)
						*(yypvt[-3].symptr->data.iarr.arblok + i) = 0;
				}
				if (mkdimlist(yypvt[-1].ival, dimlist) < 0)
					return(-1);
				if ((offset = getoffset(yypvt[-3].symptr->data.iarr.header, yypvt[-1].ival, dimlist)) < 0)
					return(-1);
				semtop -= yypvt[-1].ival - 1;
				semtop->type = INTEGER;
				semtop->val.ival = *((yypvt[-3].symptr->data.iarr.arblok) + offset);
				break;
			case STRAID:
				if (yypvt[-3].symptr->data.sarr.header == NULL)
				/* auto dimension */
				{
					for (i=0; i < yypvt[-1].ival; i++)
						dimlist[i] = DEFDIM;
					if ((yypvt[-3].symptr->data.sarr.header = makeheader(yypvt[-1].ival, dimlist, &size)) == NULL)
					{
						stremove(yypvt[-3].symptr->name, yypvt[-3].symptr->symtype);
						return(-1);
					}
					if ((yypvt[-3].symptr->data.sarr.arblok = (char **) calloc((unsigned) size, (unsigned) sizeof(char *))) == NULL)
					{
						stremove(yypvt[-3].symptr->name, yypvt[-3].symptr->symtype);
						error(inst.thing.linno,inst.thing.stmtno, 84);
						return(-1);
					}
					for (i=0; i < size; i++)
						*(yypvt[-3].symptr->data.sarr.arblok + i) = strget("");
				}
				if (mkdimlist(yypvt[-1].ival, dimlist) < 0)
					return(-1);
				if ((offset = getoffset(yypvt[-3].symptr->data.sarr.header, yypvt[-1].ival, dimlist)) < 0)
					return(-1);
				semtop -= yypvt[-1].ival - 1;
				semtop->type = STRING;
				tptr = *((yypvt[-3].symptr->data.sarr.arblok) + offset);
				STRCHEK(tptr);
				semtop->val.sval = strtop;
				while (*strtop++ = *tptr++) ;
				break;
			case DBLUID:
			case SNGUID:
			case INTUID:
			case STRUID:
				if (ufunceval(yypvt[-3].symptr, yypvt[-1].ival) < 0)
					return(-1);
			}
			} break;
case 41:
# line 696 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, STRID)) == NULL)
				if ((yyval.symptr = stinsert(tokstr, STRID)) == NULL)
					return(-1);
				else
					yyval.symptr->data.string = strget("");
			} break;
case 42:
# line 705 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, STRAID)) == NULL)
				if ((yyval.symptr = stinsert(tokstr, STRAID)) == NULL)
					return(-1);
			} break;
case 43:
# line 712 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, STRUID)) == NULL)
			{
				error(inst.thing.linno,inst.thing.stmtno, 10);
				return(-1);
			}
			} break;
case 44:
# line 721 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, INTID)) == NULL)
				if ((yyval.symptr = stinsert(tokstr, INTID)) == NULL)
					return(-1);
				else
					yyval.symptr->data.ival = 0;
			} break;
case 45:
# line 730 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, INTAID)) == NULL)
				if ((yyval.symptr = stinsert(tokstr, INTAID)) == NULL)
					return(-1);
			} break;
case 46:
# line 737 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, INTUID)) == NULL)
			{
				error(inst.thing.linno,inst.thing.stmtno, 10);
				return(-1);
			}
			} break;
case 47:
# line 746 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, SNGID)) == NULL)
				if ((yyval.symptr = stinsert(tokstr, SNGID)) == NULL)
					return(-1);
				else
					yyval.symptr->data.fval = 0.0;
			} break;
case 48:
# line 755 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, SNGAID)) == NULL)
				if ((yyval.symptr = stinsert(tokstr, SNGAID)) == NULL)
					return(-1);
			} break;
case 49:
# line 762 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, SNGUID)) == NULL)
			{
				error(inst.thing.linno,inst.thing.stmtno, 10);
				return(-1);
			}
			} break;
case 50:
# line 771 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, DBLID)) == NULL)
				if ((yyval.symptr = stinsert(tokstr, DBLID)) == NULL)
					return(-1);
				else
					yyval.symptr->data.dval = 0.0;
			} break;
case 51:
# line 780 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, DBLAID)) == NULL)
				if ((yyval.symptr = stinsert(tokstr, DBLAID)) == NULL)
					return(-1);
			} break;
case 52:
# line 787 "eval.y"
{
			if ((yyval.symptr = stsrch(tokstr, DBLUID)) == NULL)
			{
				error(inst.thing.linno,inst.thing.stmtno, 10);
				return(-1);
			}
			} break;
case 53:
# line 797 "eval.y"
{
			yyval.ival = yypvt[-2].ival + 1;
			} break;
case 54:
# line 802 "eval.y"
{
			yyval.ival = 1;
			} break;
		}
		goto yystack;  /* stack new state and value */

	}
