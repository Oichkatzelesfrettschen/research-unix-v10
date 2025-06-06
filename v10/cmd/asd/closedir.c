/* Copyright (c) 1982 Regents of the University of California */

#include "config.h"
#ifdef LOCALDIR
#include <sys/types.h>
#include "ndir.h"

static char sccsid[] = "@(#)closedir.c 4.2 3/10/82";

/*
 * close a directory.
 */
void
closedir(dirp)
	register DIR *dirp;
{
	close(dirp->dd_fd);
	dirp->dd_fd = -1;
	dirp->dd_loc = 0;
	free(dirp);
}
#endif
