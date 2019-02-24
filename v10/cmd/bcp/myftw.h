/* Copyright (c) 1989, 1990 AT&T --- All Rights Reserved.              */
/* THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T.                */
/* The copyright notice does not imply actual or intended publication. */
/* AUTHORS:                                            */
/*     H. S. Baird - ATT-BL MH - first versions        */
/*
 *	Codes for the third argument to the user-supplied function
 *	which is passed as the second argument to ftw...
 */

#define	FTW_F	0	/* file */
#define	FTW_D	1	/* directory */
#define	FTW_DNR	2	/* directory without read permission */
#define	FTW_NS	3	/* unknown type, stat failed */
#define FTW_DP	4	/* directory, postorder visit */
#define FTW_SL	5	/* symbolic link */
#define FTW_NSL 6	/* stat failed (errno = ENOENT) on symbolic link */

/*	Values the user-supplied function may wish to assign to
	component quit of struct FTW...
 */

#define FTW_SKD 1	/* skip this directory (2nd par = FTW_D) */
#define FTW_SKR 2	/* skip rest of current directory */
#define FTW_FOLLOW 3	/* follow symbolic link */

struct FTW { int quit, base, level;
#ifndef FTW_more_to_come
	};
#endif
