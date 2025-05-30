/* makekey - make a key for the Atalla box.  Courtesy ftg. */


main(){
	int i, b;
	unsigned long key=0;

	srand((int)time((long *)0));

	printf("xxx:atalla:");

	for(i=0; i<8; i++) {
		printf("%.3o%s", b=nrand(256), i<7 ? " " : "");
		key = (key << 8) | b;
	}

	printf(":\n");

	/* printf("Check:  %u\n", key); */
}

#define	LENG	17
static
long	ary[LENG] =
{
	0x4B14EA50L,
	0x53C4A8E0L,
	0x67B1FA98L,
	0x9CFB3BB5L,
	0x18761AF1L,
	0x7970CD66L,
	0xDBAFE136L,
	0x3C31FC3EL,
	0x697B37DEL,
	0x07BC568BL,
	0xCAFD3967L,
	0xA8F48722L,
	0x4AB26824L,
	0xA479EE47L,
	0x5C7246E2L,
	0x954BF297L,
	0x20A713ADL,
};
static
int	i1 = 0;
static
int	i2 = 12;

srand(seed)
{
	register i, j;

	for(i = 0; i < LENG; i++) {
		ary[i] = 0x55555555L;
		if(seed & 1)
			ary[i] = 0xCCCCCCCCL;
		if(seed & 0x8000)
			ary[i] ^= 0xF0F0F0F0L;
		seed >>= 1;
	}
	i1 = 0;
	i2 = 12;
	for(i = 1; i < 32; i += i)
	do {
		j = rand();
		ary[i1] += ary[i1] >> i;
		ary[i2] += ary[i2] << i;
	} while (i1);
}

rand()
{

	if(++i1 >= LENG)
		i1 = 0;
	if(++i2 >= LENG)
		i2 = 0;
	ary[i1] += ary[i2];
	return((ary[i1] >> 15) & 0x7FFF);
}

long
lrand()
{

	if(++i1 >= LENG)
		i1 = 0;
	if(++i2 >= LENG)
		i2 = 0;
	ary[i1] += ary[i2];
	return(ary[i1] & 0x7FFFFFFFL);
}

double
frand()
{

	if(++i1 >= LENG)
		i1 = 0;
	if(++i2 >= LENG)
		i2 = 0;
	ary[i1] += ary[i2];
	return((ary[i1] & 0x7FFFFFFFL) / 2.147483648e9);
}

nrand(n)
{
	register long slop = 0x7FFFFFFFL % n, v;

	do{
		if(++i1 >= LENG)
			i1 = 0;
		if(++i2 >= LENG)
			i2 = 0;
		ary[i1] += ary[i2];
		v = ary[i1] & 0x7FFFFFFFL;
	}while(v <= slop);
	return(v % n);
}

Srand(c1, c2, carray, clen)
	int *c1, *c2, *carray, *clen;
{
	register i, j;

	i = *c1; *c1 = i1; i1 = i;
	i = *c2; *c2 = i2; i2 = i;
	*clen = LENG;
	for(i = 0; i < LENG; i++)
	{
		j = carray[i]; carray[i] = ary[i]; ary[i] = j;
	}
}
