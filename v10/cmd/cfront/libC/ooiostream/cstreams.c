/*ident	"@(#)ctrans:lib/stream/cstreams.c	1.1.4.1" */
/**************************************************************************
                        Copyright (c) 1984 AT&T
                          All Rights Reserved   

        THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T
        
        The copyright notice above does not evidence any        
        actual or intended publication of such source code.

cstreams.c:

*****************************************************************************/

#include <iostream.h>
#include <fstream.h>
#include <new.h>
#include "streamdefs.h"

int Iostream_init::stdstatus = 0 ;
int Iostream_init::initcount = 0 ;

static char cinbuf[STREAMBUFSIZE];
static char coutbuf[STREAMBUFSIZE];

istream_withassign cin ;
ostream_withassign cout ;
ostream_withassign cerr ;
ostream_withassign clog ;

	// The value of Iostream_init::stdstatus describes the
	// The std stream variables

	// 0 means istream::stdin, ostream::stdout, ostream::stderr, and
	//	ostream::stdlog are unitialized
	// 1 means they are initialized to filebufs
	// 2 means they are initialized to stdiobufs

Iostream_init::Iostream_init() 
{
	++initcount ;
	if ( initcount > 1 ) return ;

	// Be careful.  Initialization occurs before constructors
	// of the standard streams are called.
	new (&cin) istream_withassign ;
	new (&cout) ostream_withassign ;
	new (&cerr) ostream_withassign ;
	new (&clog) ostream_withassign ;
	cin = new filebuf(0,cinbuf,sizeof(cinbuf)) ;
	cout = new filebuf(1,coutbuf,sizeof(coutbuf)) ;
	cerr = new filebuf(2,0,0) ;
	clog = new filebuf(2) ;

	cin.skip(1) ;
	cin.tie(&cout) ;
	cerr.tie(&cout) ;
	clog.tie(&cout) ;
	stdstatus = 1 ;
	}

Iostream_init::~Iostream_init()
{
	--initcount ;
	if ( initcount > 0 ) return ;
	cout.flush() ;
	cerr.flush() ;
	clog.flush() ;
	}
