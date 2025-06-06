/* 
 * vdrop.c
 *
 * x-kernel v3.2
 *
 * Copyright (c) 1993,1991,1990  Arizona Board of Regents
 *
 *
 * $Revision: 1.9 $
 * $Date: 1993/07/29 17:14:23 $
 */


#include "xkernel.h"
#include "vdrop.h"
#include "vdrop_i.h"

#ifdef __STDC__

static void		protlFuncInit( XObj );
static void		sessnInit( XObj );
static XObj		vdropCreateSessn( XObj, XObj, XObj, XObj );
static XObj		vdropOpen( XObj, XObj, XObj, Part * );
static xkern_return_t	vdropOpenDisable( XObj, XObj, XObj, Part * );
static xkern_return_t	vdropOpenDone( XObj, XObj, XObj, XObj );
static xkern_return_t	vdropOpenEnable( XObj, XObj, XObj, Part * );

#else

static void		protlFuncInit();
static void		sessnInit();
static XObj		vdropCreateSessn();
static XObj		vdropOpen();
static xkern_return_t	vdropOpenDisable();
static xkern_return_t	vdropOpenDone();
static xkern_return_t	vdropOpenEnable();

#endif __STDC__


int tracevdropp;


void
vdrop_init( self )
    XObj 	self;
{
    PState	*ps;
    
    xTraceP0(self, TR_GROSS_EVENTS, "init");
    xAssert(xIsProtocol(self));
    if ( ! xIsProtocol(xGetDown(self, 0)) ) {
	xError("VDROP down vector is misconfigured");
	return;
    }
    ps = X_NEW(PState);
    self->state = (VOID *)ps;
    protlFuncInit(self);
    ps->activeMap = mapCreate(VDROP_ACT_MAP_SZ, sizeof(XObj));
    ps->passiveMap = mapCreate(VDROP_PAS_MAP_SZ, sizeof(XObj));
}


static XObj
vdropOpen( self, hlpRcv, hlpType, p )
    XObj	self, hlpRcv, hlpType;
    Part 	*p;
{
    XObj	s, lls;
    PState	*ps = (PState *)self->state;
    
    xTraceP0(self, TR_MAJOR_EVENTS, "open");
    if ( (lls = xOpen(self, hlpType, xGetDown(self, 0), p)) == ERR_XOBJ ) {
	xTraceP0(self, TR_ERRORS, "open: could not open lower session");
	return ERR_XOBJ;
    }
    if ( mapResolve(ps->activeMap, &lls, &s) == XK_SUCCESS ) {
	xTraceP0(self, TR_MORE_EVENTS, "open -- found an existing one");
    } else {
	xTraceP0(self, TR_MAJOR_EVENTS, "open -- creating a new one");
	if ( (s = vdropCreateSessn(self, hlpRcv, hlpType, lls)) == ERR_XOBJ ) {
	    xClose(lls);
	}
    }
    return s;
}


static XObj
vdropCreateSessn( self, hlpRcv, hlpType, lls )
    XObj 	self, hlpRcv, hlpType, lls;
{
    XObj	s;
    PState	*ps = (PState *)self->state;
    SState	*ss;
    XTime	t;
    
    if ( (s = xCreateSessn(sessnInit, hlpRcv, hlpType, self, 1, &lls))
			== ERR_XOBJ ) {
	xTraceP0(self, TR_ERRORS, "xCreateSessn fails");
	return ERR_XOBJ;
    }
    s->binding = mapBind(ps->activeMap, (char *)&lls, (int)s);
    if ( s->binding == ERR_BIND ) {
	xTraceP0(self, TR_ERRORS, "mapBind fails in createSessn");
	return ERR_XOBJ;
    }
    /*
     * The lower sessions' up field is made to point to this
     * vdrop session (not the protocol)
     */
    xSetUp(lls, s);
    ss = X_NEW(SState);
    s->state = (VOID *)ss;
    xGetTime(&t);
    ss->interval = ((t.usec/100) % (VDROP_MAX_INTERVAL - 1) + 2);
    xTraceP1(self, TR_MAJOR_EVENTS, "dropping once every %d pckts",
	    ss->interval);
    ss->count = 0;
    xTraceP1(self, TR_MAJOR_EVENTS, "open returns %x", s);
    return s;
}


static int
vdropControlSessn( s, opcode, buf, len )
    XObj 	s;
    int 	opcode, len;
    char 	*buf;
{
    SState	*ss = (SState *)s->state;

    xTraceP0(s, TR_EVENTS, "controlsessn");
    switch ( opcode ) {

      case VDROP_SETINTERVAL:
	ss->interval = *(int *)buf;
	xTraceP1(s, TR_EVENTS,
		"controlsessn resets drop interval to %d",
		ss->interval);
	return 0;

      case VDROP_GETINTERVAL:
	*(int *)buf = ss->interval;
	return sizeof(int);

      default:
	/*
	 * All other opcodes are forwarded to the lower session.  
	 */
	return xControl(xGetDown(s, 0), opcode, buf, len);
    }
}


static int
vdropControlProtl( self, opcode, buf, len )
    XObj 	self;
    int 	opcode, len;
    char 	*buf;
{
    /*
     * All opcodes are forwarded to the lower protocol
     */
    return xControl(xGetDown(self, 0), opcode, buf, len);
}


static xkern_return_t
vdropOpenEnable( self, hlpRcv, hlpType, p )
    XObj 	self, hlpRcv, hlpType;
    Part 	*p;
{
    PState	*ps = (PState *)self->state;
    
    xTraceP0(self, TR_MAJOR_EVENTS, "open enable");
    return defaultVirtualOpenEnable(self, ps->passiveMap, hlpRcv, hlpType,
				    self->down, p);
}


static xkern_return_t
vdropOpenDisable( self, hlpRcv, hlpType, p )
    XObj 	self, hlpRcv, hlpType;
    Part 	*p;
{
    PState	*ps = (PState *)self->state;

    return defaultVirtualOpenDisable(self, ps->passiveMap, hlpRcv, hlpType,
				     self->down, p);
}


static xkern_return_t
vdropClose( s )
    XObj 	s;
{
    PState		*ps;
    xkern_return_t	res;
    XObj		lls;
    
    xTraceP1(s, TR_MAJOR_EVENTS, "close of session %x", (int)s);
    xAssert(s->rcnt == 0);
    ps = (PState *)xMyProtl(s)->state;
    res = mapRemoveBinding(ps->activeMap, s->binding);
    xAssert( res != XK_FAILURE );
    lls = xGetDown(s, 0);
    xAssert(xIsSession(lls));
    xSetUp(lls, xMyProtl(s));
    xClose(lls);
    xDestroy(s);
    return XK_SUCCESS;
}


static xmsg_handle_t
vdropPush( s, msg )
    XObj	s;
    Msg 	*msg;
{
    xTraceP0(s, TR_EVENTS, "push");
    return xPush(xGetDown(s, 0), msg);
}


static xkern_return_t
vdropOpenDone( self, lls, llp, hlpType )
    XObj	self, lls, llp, hlpType;
{
    XObj	s;
    PState	*ps = (PState *)self->state;
    Enable	*e;
    
    xTraceP0(self, TR_MAJOR_EVENTS, "In openDone");
    if ( self == hlpType ) {
	xTraceP0(self, TR_ERRORS, "self == hlpType in openDone");
	return XK_FAILURE;
    }
    /*
     * check for openEnable
     */
    
    if ( mapResolve(ps->passiveMap, &hlpType, &e) == XK_FAILURE ) {
	/* 
	 * This shouldn't happen
	 */
	xTraceP0(self, TR_ERRORS,
		"openDone: Couldn't find hlp for incoming session");
	return XK_FAILURE;
    }
    if ( (s = vdropCreateSessn(self, e->hlpRcv, e->hlpType, lls))
							== ERR_XOBJ ) {
	return XK_FAILURE;
    }
    xDuplicate(lls);
    xTraceP0(self, TR_EVENTS,
	    "passively opened session successfully created");
    return xOpenDone(e->hlpRcv, s, self);
}


static xkern_return_t
vdropProtlDemux( self, lls, m )
    XObj	self, lls;
    Msg		*m;
{
    xTraceP0(self, TR_ERRORS, "protlDemux called!!");
    return XK_SUCCESS;
}


/* 
 * vdropPop and vdropSessnDemux must be used (i.e., they can't be
 * bypassed) for the UPI reference count mechanism to work properly. 
 */
static xkern_return_t
vdropPop( s, lls, msg, h )
    XObj 	s, lls;
    Msg 	*msg;
    VOID	*h;
{
    SState	*ss = (SState *)s->state;

    xTraceP0(s, TR_EVENTS, "pop");
    if ((ss->interval) && ( ++ss->count >= ss->interval )) {
	xTraceP0(s, TR_MAJOR_EVENTS, "pop is dropping msg");
	ss->count = 0;
	return XK_SUCCESS;
    } else {
	return xDemux(s, msg);
    }
}


static xkern_return_t
vdropSessnDemux( self, lls, msg )
    XObj 	self, lls;
    Msg 	*msg;
{
    xTraceP0(self, TR_EVENTS, "session demux");
    return xPop(self, lls, msg, 0);
}


static void
sessnInit( s )
    XObj 	s;
{
    xAssert(xIsSession(s));
    
    s->push = vdropPush;
    s->pop = vdropPop;
    s->close = vdropClose;
    s->control = vdropControlSessn;
    /* 
     * VDROP sessions will look like a protocol to lower sessions, so we
     * need a demux function
     */
    s->demux = vdropSessnDemux;
}


static void
protlFuncInit(p)
    XObj p;
{
    xAssert(xIsProtocol(p));

    p->control = vdropControlProtl;
    p->open = vdropOpen;
    p->openenable = vdropOpenEnable;
    p->opendisable = vdropOpenDisable;
    p->demux = vdropProtlDemux;
    p->opendone = vdropOpenDone;
}
