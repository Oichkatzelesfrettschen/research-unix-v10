/*
 * iptest.c
 *
 * x-kernel v3.2
 *
 * Copyright (c) 1993,1991,1990  Arizona Board of Regents
 *
 *
 * $Revision: 1.16 $
 * $Date: 1993/05/10 23:01:04 $
 */

/*
 * Ping-pong test of IP
 */

#include "ip.h"

/*
 * These definitions describe the lower protocol
 */
#define HOST_TYPE IPhost
#define INIT_FUNC iptest_init
#define TRACE_VAR traceiptestp
#define PROT_STRING "ip"

static HOST_TYPE ServerAddr;
static HOST_TYPE ClientAddr;

#define TRIPS 100
#define TIMES 1
#define DELAY 3
/*
 * Define to do timing calculations
 */
#define TIME

#define INF_LOOP

static int lens[] = { 
  1, 1000, 2000, 4000, 8000, 16000
};


#define SAVE_SERVER_SESSN

#include "common_test.c"

static void
testInit()
{
}
