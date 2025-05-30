static
short costab[91]={
	10000,	9998,	9993,	9986,	9975,
	9961,	9945,	9925,	9902,	9876,
	9848,	9816,	9781,	9743,	9702,
	9659,	9612,	9563,	9510,	9455,
	9396,	9335,	9271,	9205,	9135,
	9063,	8987,	8910,	8829,	8746,
	8660,	8571,	8480,	8386,	8290,
	8191,	8090,	7986,	7880,	7771,
	7660,	7547,	7431,	7313,	7193,
	7071,	6946,	6819,	6691,	6560,
	6427,	6293,	6156,	6018,	5877,
	5735,	5591,	5446,	5299,	5150,
	5000,	4848,	4694,	4539,	4383,
	4226,	4067,	3907,	3746,	3583,
	3420,	3255,	3090,	2923,	2756,
	2588,	2419,	2249,	2079,	1908,
	1736,	1564,	1391,	1218,	1045,
	871,	697,	523,	348,	174,
	0,
};

pcos(x)
	register x;
{
	x %= 360;
	while(x<0)
		x+=360;
	if(x<=180)
		return(x<90? costab[x] : -costab[180-x]);
	return(x<180+90? -costab[x-180] : costab[360-x]);
}

psin(x)
	register x;
{
	return(pcos(x-90));
}

Psin(x)
	register x;
{
	return(Pcos(x-9000));
}

Pcos(x)
	register x;
{
	register int a = x/100;
	register int b = x%100;
	register int c = pcos(a);
	register int d = pcos(a+1);

	a = c + (b*(d-c))/100;
	return a;
}
