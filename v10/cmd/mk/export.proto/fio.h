#define	FIOBSIZE	4096

typedef struct Fbuffer
{
	unsigned char *next;		/* next char to be used */
	unsigned char *end;		/* first invalid char */
	unsigned char *lnext;		/* previous value of next */
	unsigned short flags;		/* see FIO_.* below */
	short oflush;			/* if >= 0 fd to flush on read */
	long offset;			/* seek of end */
	unsigned char buf[FIOBSIZE];
} Fbuffer;
extern Fbuffer *Ffb[];

#define	FIORESET(f)	((f)->next=(f)->lnext=(f)->end=(f)->buf, (f)->flags&= ~FIO_MALLOCED, (f)->oflush= -1)
#define	FIOSET(f, fd)	if((f=Ffb[fd&=0x7f]) == 0){Finit(fd,(char *)0);f=Ffb[fd];}
/* FIOLINELEN is length of last input */
#define	FIOLINELEN(fd)	(((int)(Ffb[fd]->next - Ffb[fd]->lnext))-1)
/* FIOSEEK is lseek of next char to be processed */
#define	FIOSEEK(fd)	(Ffb[fd]->offset - (Ffb[fd]->end - Ffb[fd]->next))
#define	FIOFLUSH(fd)	if((fd >= 0) && Ffb[fd]) Fflush(fd)

#define	FIO_RDLAST	0x0001		/* true if last input was rdline */
#define	FIO_WRITING	0x0002		/* true if last action was write */
#define	FIO_MALLOCED	0x0004		/* set if Finit did the malloc */

extern void Finit();
extern char *Frdline();
extern void Fundo();
extern int Fgetc();
extern long Fread();
extern long Fwrite();
extern long Fseek();
extern int Fflush();

#ifdef	FIO_IMP
/* COUNT is the type of counts to things like read, write, memcpy etc */
#ifdef	GNOT
#define	COUNT	long
#define	FIOMALLOC(n)	malloc(n)
#define	SEEK(a,b,c)	seek(a,b,c)
#else
#define	COUNT	int
#define	FIOMALLOC(n)	malloc(n)
#define	SEEK(a,b,c)	lseek(a,b,c)
#endif
extern COUNT read(), write();
#endif
