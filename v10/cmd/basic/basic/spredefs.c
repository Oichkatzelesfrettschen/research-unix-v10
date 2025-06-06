/*	"@(#) spredefs.c: V 1.11 8/19/83"	*/

/*
********* String Predefined Function Handlers ************
*/

#include	<fcntl.h>
#include	<stdio.h>
#include	<time.h>
#include	<bas.h>
#include	"tokens.h"

extern char	strstack[],
		*strtop;	/* next available space for strings
				   on the strstack		*/
extern STAKREC	*semtop;

#define STRCHEK(STRPTR)	if ((strtop + strlen(STRPTR)) > (strstack + STRMAX * 4))\
			{\
				error(inst.thing.linno,inst.thing.stmtno, 48);\
				return(-1);\
			}

#define ONENUMARG 	if (numargs != 1)\
			{\
				error(inst.thing.linno,inst.thing.stmtno, 52);\
				return(-1);\
			}\
			if (semtop->type == STRING)\
			{\
				error(inst.thing.linno,inst.thing.stmtno, 50);\
				return(-1);\
			}


bdate(numargs)
int	numargs;
{
	struct tm	*tmptr;
	struct tm	*localtime();
	long		time(),
			clock;

	if (numargs != 0)
	{
		error(inst.thing.linno,inst.thing.stmtno, 52);
		return(-1);
	}
	if (strtop + 8 > strstack + STRMAX * 4)
	{
		error(inst.thing.linno,inst.thing.stmtno, 48);
		return(-1);
	}
	(++semtop)->type = STRING;
	semtop->val.sval = strtop;
	clock = time((long *) 0);
	tmptr = localtime(&clock);
	sprintf(strtop, "%.2d-%.2d-%.4d", 
		tmptr->tm_mon + 1, tmptr->tm_mday, tmptr->tm_year + 1900);
	strtop += strlen(strtop) + 1;
	return(0);
}


btime(numargs)
int	numargs;
{
	struct tm	*tmptr;
	long		time(),
			clock;

	if (numargs != 0)
	{
		error(inst.thing.linno,inst.thing.stmtno, 52);
		return(-1);
	}
	if (strtop + 8 > strstack + STRMAX * 4)
	{
		error(inst.thing.linno,inst.thing.stmtno, 48);
		return(-1);
	}
	(++semtop)->type = STRING;
	semtop->val.sval = strtop;
	clock = time((long *) 0);
	tmptr = localtime(&clock);
	sprintf(strtop, "%.2d:%.2d:%.2d", 
		tmptr->tm_hour, tmptr->tm_min, tmptr->tm_sec);
	strtop += strlen(strtop) + 1;
	return(0);
}


chr(numargs)
int	numargs;
{
	int num;

	ONENUMARG
	switch (semtop->type)
	{
	case INTEGER:
		num = semtop->val.ival;
		break;
	case SINGLE:
		num = intify(semtop->val.fval);
		break;
	case DOUBLE:
		num = intify(semtop->val.dval);
		break;
	}
	if (num < 0 || num > 0377)
	{
		error(inst.thing.linno,inst.thing.stmtno, 55);/* bad argument */
		return(-1);
	}
	semtop->type = STRING;
	semtop->val.sval = strtop;
	if ((strtop + 1) > (strstack + STRMAX * 4))
		{
			error(inst.thing.linno,inst.thing.stmtno, 48);
			return(-1);
		}
	*strtop++ = num;
	*strtop++ = '\0';
	return(0);
}



hex(numargs)
int	numargs;
{
	int	number;
	char	string[STRMAX+1];

	ONENUMARG
	if (semtop->type == INTEGER)
		number = semtop->val.ival;
	else if (semtop->type == SINGLE)
		number = mkint(semtop->val.fval);
	else
		number = mkint(semtop->val.dval);
	sprintf(string, "%x", number);
	STRCHEK(string)
	semtop->type = STRING;
	semtop->val.sval = strtop;
	strtop += strlen(string) + 1;
	strcpy(semtop->val.sval, string);
	return(0);
}



left(numargs)
int	numargs;
{
	int 	num,
		slen;

	if (numargs != 2)
	{
		error(inst.thing.linno,inst.thing.stmtno, 52);
		return(-1);
	}
	switch (semtop->type)
	{
	case STRING:
		error(inst.thing.linno,inst.thing.stmtno, 50);
		return(-1);
	case INTEGER:
		num = semtop->val.ival;
		break;
	case SINGLE:
		num = intify(semtop->val.fval);
		break;
	case DOUBLE:
		num = intify(semtop->val.dval);
		break;
	}
	if (num < 0)
	{
		error(inst.thing.linno,inst.thing.stmtno, 55);
		return(-1);
	}
	semtop--;
	switch (semtop->type)
	{
	case STRING:
		slen = strlen(semtop->val.sval);
		if (num < slen)
		{
		*(semtop->val.sval + num) = '\0';
		strtop = semtop->val.sval + num + 1;
		}
		return(0);
	default:
		error(inst.thing.linno,inst.thing.stmtno, 50);
		return(-1);
	}
}



mid(numargs)
int	numargs;
{
	int 	num2,
		num1,
		slen;

	if (numargs == 2)
		num2 = STRMAX;
	else if (numargs == 3)
	{
		switch (semtop->type)
		{
		case STRING:
			error(inst.thing.linno,inst.thing.stmtno, 50);
			return(-1);
		case INTEGER:
			num2 = semtop->val.ival;
			break;
		case SINGLE:
			num2 = intify(semtop->val.fval);
			break;
		case DOUBLE:
			num2 = intify(semtop->val.dval);
			break;
		}
		if (num2 < 0)
		{
			error(inst.thing.linno,inst.thing.stmtno, 55);
			return(-1);
		}
		semtop--;
	}
	else
	{
		error(inst.thing.linno,inst.thing.stmtno, 52);
		return(-1);
	}
	switch (semtop->type)
	{
	case STRING:
		error(inst.thing.linno,inst.thing.stmtno, 50);
		return(-1);
	case INTEGER:
		num1 = semtop->val.ival;
		break;
	case SINGLE:
		num1 = intify(semtop->val.fval);
		break;
	case DOUBLE:
		num1 = intify(semtop->val.dval);
		break;
	}
	if (num1 <= 0)
	{
		error(inst.thing.linno,inst.thing.stmtno, 55);
		return(-1);
	}
	semtop--;
	switch (semtop->type)
	{
	case STRING:
		slen = strlen(semtop->val.sval);
		if (num1 > slen || num2 == 0)	/* return null string */
		{
			*(semtop->val.sval) = '\0';
			strtop = semtop->val.sval + 1;
			return(0);
		}
		if (num1 + num2 - 1 > slen)
			num2 = slen + 1 - num1;
		strncpy(semtop->val.sval, 
			  semtop->val.sval + num1 - 1, num2);
		*(semtop->val.sval + num2) = '\0';
		strtop = semtop->val.sval + num2 + 1;
		return(0);
	default:
		error(inst.thing.linno,inst.thing.stmtno, 50);
		return(-1);
	}
}



oct(numargs)
int	numargs;
{
	int	number;
	char	string[STRMAX+1];

	ONENUMARG
	if (semtop->type == INTEGER)
		number = semtop->val.ival;
	else if (semtop->type == SINGLE)
		number = mkint(semtop->val.fval);
	else
		number = mkint(semtop->val.dval);
	sprintf(string, "%o", number);
	STRCHEK(string)
	semtop->type = STRING;
	semtop->val.sval = strtop;
	strtop += strlen(string) + 1;
	strcpy(semtop->val.sval, string);
	return(0);
}



right(numargs)
int	numargs;
{
	int 	num,
		slen;

	if (numargs != 2)
	{
		error(inst.thing.linno,inst.thing.stmtno, 52);
		return(-1);
	}
	switch (semtop->type)
	{
	case STRING:
		error(inst.thing.linno,inst.thing.stmtno, 50);
		return(-1);
	case INTEGER:
		num = semtop->val.ival;
		break;
	case SINGLE:
		num = intify(semtop->val.fval);
		break;
	case DOUBLE:
		num = intify(semtop->val.dval);
		break;
	}
	if (num < 0)
	{
		error(inst.thing.linno,inst.thing.stmtno, 55);
		return(-1);
	}
	semtop--;
	switch (semtop->type)
	{
	case STRING:
		slen = strlen(semtop->val.sval);
		if (num < slen)
		{
		strncpy(semtop->val.sval, 
			  semtop->val.sval + slen - num, num);
		*(semtop->val.sval + num) = '\0';
		strtop = semtop->val.sval + num + 1;
		}
		return(0);
	default:
		error(inst.thing.linno,inst.thing.stmtno, 50);
		return(-1);
	}
}


space(numargs)
int	numargs;
{
	int	i,
		length;
	char	string[STRMAX+1];

	ONENUMARG
	if (semtop->type == INTEGER)
		length = semtop->val.ival;
	else if (semtop->type == SINGLE)
		length = intify(semtop->val.fval);
	else
		length = intify(semtop->val.dval);
	if (length > STRMAX)
	{
		error(inst.thing.linno,inst.thing.stmtno,87);
		return(-1);
	}
	i = 0;
	while (i < length)
		string[i++] = ' ';
	string[i] = '\0';
	STRCHEK(string)
	semtop->type = STRING;
	semtop->val.sval = strtop;
	strtop += length + 1;
	strcpy(semtop->val.sval, string);
	return(0);
}



str(numargs)
int	numargs;
{
	char	work[STRMAX+1];
	register char 	*tptr;

	ONENUMARG
	switch (semtop->type)
	{
	case INTEGER:
		if (semtop->val.ival < 0)
			sprintf(work, "%d", semtop->val.ival);
		else
			sprintf(work, " %d", semtop->val.ival);
		break;
	case SINGLE:
		if (semtop->val.fval < 0)
			sprintf(work, "%g", semtop->val.fval);
		else
			sprintf(work, " %g", semtop->val.fval);
		break;
	case DOUBLE:
		if (semtop->val.dval < 0)
			sprintf(work, "%g", semtop->val.dval);
		else
			sprintf(work, " %g", semtop->val.dval);
		break;
	}
	semtop->type = STRING;
	semtop->val.sval = strtop;
	tptr = work;
	STRCHEK(tptr);
	while (*strtop++ = *tptr++) ;
	return(0);
}



string(numargs)
int	numargs;
{
	int	i,
		character,
		length;
	char	string[STRMAX+1];

	if (numargs != 2)
	{
		error(inst.thing.linno,inst.thing.stmtno, 52);
		return(-1);
	}
	if (semtop->type == INTEGER)
		character = semtop->val.ival;
	else if (semtop->type == SINGLE)
		character = intify(semtop->val.fval);
	else if (semtop->type == DOUBLE)
		character = intify(semtop->val.dval);
	else
	{
		character = (int) *(semtop->val.sval);
		strtop = semtop->val.sval;
	}
	if (character < 0 || character > 255)
	{
		error(inst.thing.linno,inst.thing.stmtno, 55);
		return(-1);
	}
	semtop--;
	if (semtop->type == INTEGER)
		length = semtop->val.ival;
	else if (semtop->type == SINGLE)
		length = intify(semtop->val.fval);
	else if (semtop->type == DOUBLE)
		length = intify(semtop->val.dval);
	else
	{
		error(inst.thing.linno,inst.thing.stmtno, 50);
		return(-1);
	}
	if (length < 0 || length > 255)
	{
		error(inst.thing.linno,inst.thing.stmtno, 55);
		return(-1);
	}
	i = 0;
	while (i < length)
		string[i++] = (char) character;
	string[i] = '\0';
	STRCHEK(string)
	semtop->type = STRING;
	semtop->val.sval = strtop;
	strtop += length + 1;
	strcpy(semtop->val.sval, string);
	return(0);
}




inkey(numargs)
int	numargs;
{
	int	filedes,
		c = 0;

	if (numargs != 0)
	{
		error(inst.thing.linno,inst.thing.stmtno, 52);
		return(-1);
	}
	filedes = fileno(stdin);
	c = getc(stdin);
	++semtop;
	semtop->type = STRING;
	semtop->val.sval = strtop;
	if (c != EOF)
		*strtop++ = c;
	*strtop++ = NULL;
	return(0);
}




struct FILTBL 	{
		FILE		*fildes;
		char		mode;
		unsigned char	contin;
		short		currec;
		short		curchr;
		short		recsize;
		short		numrecs;
		char		*buffer;
		};

extern struct FILTBL	filtbl[];

rinput(numargs)
int	numargs;
{
	int	c,
		filedes,
		i,
		count;
	char	buf[BUFSIZ];
	FILE	*fd;

	if (numargs == 2)
	{
		switch (semtop->type)
		{
			case STRING:
				error(inst.thing.linno,inst.thing.stmtno, 50);
				return(-1);
			case SINGLE:
				semtop->val.ival = intify(semtop->val.fval);
			case DOUBLE:
				semtop->val.ival = intify(semtop->val.dval);
			case INTEGER:
				if (!legfildes(semtop->val.ival))
				{
					error(inst.thing.linno,inst.thing.stmtno, 47);
					return(-1);
				}
				filedes = semtop->val.ival;
				break;
		}
		--semtop;
		switch (semtop->type)
		{
			case STRING:
				error(inst.thing.linno,inst.thing.stmtno, 50);
				return(-1);
			case INTEGER:
				count = semtop->val.ival;
				break;
			case SINGLE:
				count = intify(semtop->val.fval);
				break;
			case DOUBLE:
				count = intify(semtop->val.dval);
				break;
		}
		if (count < 1 || count > 255)
		{
			error(inst.thing.linno,inst.thing.stmtno, 55);
			return(-1);
		}
		if (filtbl[filedes - 1].mode != 'r')
		{
			error(inst.thing.linno,inst.thing.stmtno, 37);
			return(-1);
		}
		fd = filtbl[filedes - 1].fildes;
		for (i = 0; i < count; ++i)
		{
			if ((c = getc(fd)) == EOF)
			{
				error(inst.thing.linno,inst.thing.stmtno, 7);
				return(-1);
			}
			buf[i] = c;
		}
		buf[i] = NULL;
		semtop->type = STRING;
		semtop->val.sval = strtop;
		strcpy(strtop, buf);
		strtop += strlen(strtop) + 1;
		return(0);
	}
	else if (numargs == 1)
	{
		switch (semtop->type)
		{
			case STRING:
				error(inst.thing.linno,inst.thing.stmtno, 50);
				return(-1);
			case INTEGER:
				count = semtop->val.ival;
				break;
			case SINGLE:
				count = intify(semtop->val.fval);
				break;
			case DOUBLE:
				count = intify(semtop->val.dval);
				break;
		}
		if (count < 1 || count > 255)
		{
			error(inst.thing.linno,inst.thing.stmtno, 55);
			return(-1);
		}
		filedes = fileno(stdin);
		for (i = 0; i < count; ++i)
			buf[i] = getc(stdin);
		buf[i] = NULL;
		semtop->type = STRING;
		semtop->val.sval = strtop;
		strcpy(strtop, buf);
		strtop += strlen(strtop) + 1;
		return(0);
	}
	else
	{
		error(inst.thing.linno,inst.thing.stmtno, 52);
		return(-1);
	}
}



/* table for encoding and dispatching predefined functions */
extern int	absolute(),
		asc(),
		atn(),
		cdbl(),
		cosine(),
		cint(),
		csng(),
		eof(),
		erlfunc(),
		errfunc(),
		_exp(),
		fix(),
		fre(),
		inkey(),
		instr(),
		_int(),
		len(),
		loc(),
		lof(),
		_log(),
		pos(),
		rinput(),
		rndgen(),
		sgn(),
		sh(),
		sine(),
		sqroot(),
		tangent(),
		usr0(),
		usr1(),
		usr2(),
		usr3(),
		usr4(),
		usr5(),
		usr6(),
		usr7(),
		usr8(),
		usr9(),
		val();

#define	FNCTABSIZE	51

struct FUNCTAB 	functab[FNCTABSIZE] = {
	{"abs",		absolute},
	{"asc",		asc},
	{"atn",		atn},
	{"cdbl",	cdbl},
	{"chr$",	chr},
	{"cint",	cint},
	{"cos",		cosine},
	{"csng",	csng},
	{"date$",	bdate},
	{"eof",		eof},
	{"erl",		erlfunc},
	{"err",		errfunc},
	{"exp",		_exp},
	{"fix",		fix},
	{"fre",		fre},
	{"hex$",	hex},
	{"inkey$",	inkey},
	{"input$",	rinput},
	{"instr",	instr},
	{"int",		_int},
	{"left$",	left},
	{"len",		len},
	{"loc",		loc},
	{"lof",		lof},
	{"log",		_log},
	{"mid$",	mid},
	{"oct$",	oct},
	{"pos",		pos},
	{"right$",	right},
	{"rnd",		rndgen},
	{"sgn",		sgn},
	{"sh",		sh},
	{"sin",		sine},
	{"space$",	space},
	{"sqr",		sqroot},
	{"str$",	str},
	{"string$",	string},
	{"tan",		tangent},
	{"time$",	btime},
	{"usr",		usr0},
	{"usr0",	usr0},
	{"usr1",	usr1},
	{"usr2",	usr2},
	{"usr3",	usr3},
	{"usr4",	usr4},
	{"usr5",	usr5},
	{"usr6",	usr6},
	{"usr7",	usr7},
	{"usr8",	usr8},
	{"usr9",	usr9},
	{"val",		val},
	};



funcsearch(key)
char	key[];
{
	register	m,
			l,
			u,
			n;

	l = 0;
	u = FNCTABSIZE - 1;
	while (l <= u)
	{
		m = (l + u) / 2;
		if ((n = strcmp(key, functab[m].name)) > 0)
			l = m + 1;
		else if (n == 0)
			return(m);
		else 
			u = m - 1;
	}
	return(-1);
}
