/* The Plum Hall Validation Suite for C
 * Unpublished copyright (c) 1986-1991, Chiron Systems Inc and Plum Hall Inc.
 * VERSION: 4
 * DATE: 1993-01-01
 * The "ANSI" mode of this suite corresponds to official ANSI C, X3.159-1989.
 * As per your license agreement, your distribution is not to be moved or copied outside the Designated Site
 * without specific permission from Plum Hall Inc.
 */

/* 3.8	Syn	SYNTAX-MANDATORY */
/* 	#if has only one constant-expr */
int main() {
	#if  1  2
	int i;
	#endif
	return 0; }
