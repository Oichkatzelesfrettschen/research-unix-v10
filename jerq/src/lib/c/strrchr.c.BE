                                                                          /*
 * Return the ptr in sp at which the character c last
 * appears; NULL if not found
*/

#define NULL 0

char *
strrchr(sp, c)
register char *sp, c;
{
	register char *r;

	r