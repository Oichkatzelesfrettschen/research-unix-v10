/* The Plum Hall Validation Suite for C
 * Unpublished copyright (c) 1986-1991, Chiron Systems Inc and Plum Hall Inc.
 * VERSION: 4
 * DATE: 1993-01-01
 * The "ANSI" mode of this suite corresponds to official ANSI C, X3.159-1989.
 * As per your license agreement, your distribution is not to be moved or copied outside the Designated Site
 * without specific permission from Plum Hall Inc.
 */

/* 3.3.2.4	SemP1S4 (and 3.3.6 ConP2)	CONSTRAINT-MANDATORY */
/* 	constraints of arith ops and asst ops apply to post ++ */
int main() {
	int (*pf)();
	pf++;
	return 0; }
