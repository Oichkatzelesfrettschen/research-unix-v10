#include "xk_uproxy.h"
#define EXPORT_BOOLEAN
#include <mach/boolean.h>
#include <mach/kern_return.h>
#include <mach/message.h>
#include <mach/notify.h>
#include <mach/mach_types.h>
#include <mach/mig_errors.h>
#include <mach/mig_support.h>
#include <mach/msg_type.h>
/* LINTLIBRARY */

#ifndef	mig_internal
#define	mig_internal	static
#endif

#ifndef	mig_external
#define mig_external
#endif

#ifndef	TypeCheck
#define	TypeCheck 1
#endif

#ifndef	UseExternRCSId
#define	UseExternRCSId		1
#endif

#ifndef	lint
#if	UseExternRCSId
char xk_uproxy_user_rcsid[] = "$Header: /usr/var/tmp/x32/tmpdist/mach3/api/proxy/RCS/xk_uproxy.defs,v 1.10 1993/09/16 22:04:16 menze Exp $";
#else	/* UseExternRCSId */
static char rcsid[] = "$Header: /usr/var/tmp/x32/tmpdist/mach3/api/proxy/RCS/xk_uproxy.defs,v 1.10 1993/09/16 22:04:16 menze Exp $";
#endif	/* UseExternRCSId */
#endif	/* lint */

#define msgh_request_port	msgh_remote_port
#define msgh_reply_port		msgh_local_port

#include <mach/std_types.h>
#include "xk_mig_sizes.h"
#include "xk_mig_t.h"
#include "assert.h"
#include "proxy_offset.h"

/* Routine abort */
mig_external kern_return_t call_uproxy_abort
(
	mach_port_t reqPort,
	mach_port_t lproxyPort
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t lproxyPortType;
		mach_port_t lproxyPort;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;

	static const mach_msg_type_t lproxyPortType = {
		/* msgt_name = */		20,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->lproxyPortType = lproxyPortType;

	InP->lproxyPort = lproxyPort;

	InP->Head.msgh_bits = MACH_MSGH_BITS_COMPLEX|
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844415;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 32, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844515) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (OutP->Head.msgh_size != 32))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	return OutP->RetCode;
}

/* Routine xGetProtlByName */
mig_external kern_return_t call_uproxy_xGetProtlByName
(
	mach_port_t reqPort,
	xk_string_80_t name,
	xobj_ext_id_t *protl
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_long_t nameType;
		xk_string_80_t name;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
		mach_msg_type_t protlType;
		xobj_ext_id_t protl;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;
#if	TypeCheck
	unsigned int msgh_size;
#endif	/* TypeCheck */

	static const mach_msg_type_long_t nameType = {
	{
		/* msgt_name = */		0,
		/* msgt_size = */		0,
		/* msgt_number = */		0,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		TRUE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	},
		/* msgtl_name = */	12,
		/* msgtl_size = */	640,
		/* msgtl_number = */	1,
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t protlCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->nameType = nameType;

	(void) mig_strncpy(InP->name, name, 80);

	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844416;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 116, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844516) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	msgh_size = OutP->Head.msgh_size;

	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    ((msgh_size != 40) &&
	     ((msgh_size != sizeof(mig_reply_header_t)) ||
	      (OutP->RetCode == KERN_SUCCESS))))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (OutP->RetCode != KERN_SUCCESS)
		return OutP->RetCode;

#if	TypeCheck
	if (* (int *) &OutP->protlType != * (int *) &protlCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*protl = OutP->protl;

	return KERN_SUCCESS;
}

/* Routine xControl */
mig_external kern_return_t call_uproxy_xControl
(
	mach_port_t reqPort,
	xobj_ext_id_t obj,
	int opcode,
	xk_ctl_buf_t buf,
	int *bufLen
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t objType;
		xobj_ext_id_t obj;
		mach_msg_type_t opcodeType;
		int opcode;
		mach_msg_type_t bufType;
		xk_ctl_buf_t buf;
		mach_msg_type_t bufLenType;
		int bufLen;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
		mach_msg_type_t bufType;
		xk_ctl_buf_t buf;
		mach_msg_type_t bufLenType;
		int bufLen;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;
#if	TypeCheck
	unsigned int msgh_size;
#endif	/* TypeCheck */

	static const mach_msg_type_t objType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t opcodeType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t bufType = {
		/* msgt_name = */		8,
		/* msgt_size = */		8,
		/* msgt_number = */		200,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t bufLenType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t bufCheck = {
		/* msgt_name = */		8,
		/* msgt_size = */		8,
		/* msgt_number = */		200,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t bufLenCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->objType = objType;

	InP->obj = obj;

	InP->opcodeType = opcodeType;

	InP->opcode = opcode;

	InP->bufType = bufType;

	{ typedef struct { char data[200]; } *sp; * (sp) InP->buf = * (sp) buf; }

	InP->bufLenType = bufLenType;

	InP->bufLen = *bufLen;

	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844417;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 252, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844517) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	msgh_size = OutP->Head.msgh_size;

	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    ((msgh_size != 244) &&
	     ((msgh_size != sizeof(mig_reply_header_t)) ||
	      (OutP->RetCode == KERN_SUCCESS))))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (OutP->RetCode != KERN_SUCCESS)
		return OutP->RetCode;

#if	TypeCheck
	if (* (int *) &OutP->bufType != * (int *) &bufCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	{ typedef struct { char data[200]; } *sp; * (sp) buf = * (sp) OutP->buf; }

#if	TypeCheck
	if (* (int *) &OutP->bufLenType != * (int *) &bufLenCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*bufLen = OutP->bufLen;

	return KERN_SUCCESS;
}

/* Routine xOpenEnable */
mig_external kern_return_t call_uproxy_xOpenEnable
(
	mach_port_t reqPort,
	mach_port_t lproxyPort,
	xkern_return_t *retVal,
	xobj_ext_id_t hlpRcv,
	xobj_ext_id_t hlpType,
	xobj_ext_id_t llp,
	xk_part_t part
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t lproxyPortType;
		mach_port_t lproxyPort;
		mach_msg_type_t hlpRcvType;
		xobj_ext_id_t hlpRcv;
		mach_msg_type_t hlpTypeType;
		xobj_ext_id_t hlpType;
		mach_msg_type_t llpType;
		xobj_ext_id_t llp;
		mach_msg_type_t partType;
		xk_part_t part;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
		mach_msg_type_t retValType;
		xkern_return_t retVal;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;
#if	TypeCheck
	unsigned int msgh_size;
#endif	/* TypeCheck */

	static const mach_msg_type_t lproxyPortType = {
		/* msgt_name = */		20,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t hlpRcvType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t hlpTypeType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t llpType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t partType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1224,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t retValCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->lproxyPortType = lproxyPortType;

	InP->lproxyPort = lproxyPort;

	InP->hlpRcvType = hlpRcvType;

	InP->hlpRcv = hlpRcv;

	InP->hlpTypeType = hlpTypeType;

	InP->hlpType = hlpType;

	InP->llpType = llpType;

	InP->llp = llp;

	InP->partType = partType;

	{ typedef struct { char data[4896]; } *sp; * (sp) InP->part = * (sp) part; }

	InP->Head.msgh_bits = MACH_MSGH_BITS_COMPLEX|
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844418;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 4956, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844518) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	msgh_size = OutP->Head.msgh_size;

	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    ((msgh_size != 40) &&
	     ((msgh_size != sizeof(mig_reply_header_t)) ||
	      (OutP->RetCode == KERN_SUCCESS))))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (OutP->RetCode != KERN_SUCCESS)
		return OutP->RetCode;

#if	TypeCheck
	if (* (int *) &OutP->retValType != * (int *) &retValCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*retVal = OutP->retVal;

	return KERN_SUCCESS;
}

/* Routine xOpenDisable */
mig_external kern_return_t call_uproxy_xOpenDisable
(
	mach_port_t reqPort,
	mach_port_t lproxyPort,
	xkern_return_t *retVal,
	xobj_ext_id_t hlpRcv,
	xobj_ext_id_t hlpType,
	xobj_ext_id_t llp,
	xk_part_t part
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t lproxyPortType;
		mach_port_t lproxyPort;
		mach_msg_type_t hlpRcvType;
		xobj_ext_id_t hlpRcv;
		mach_msg_type_t hlpTypeType;
		xobj_ext_id_t hlpType;
		mach_msg_type_t llpType;
		xobj_ext_id_t llp;
		mach_msg_type_t partType;
		xk_part_t part;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
		mach_msg_type_t retValType;
		xkern_return_t retVal;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;
#if	TypeCheck
	unsigned int msgh_size;
#endif	/* TypeCheck */

	static const mach_msg_type_t lproxyPortType = {
		/* msgt_name = */		20,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t hlpRcvType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t hlpTypeType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t llpType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t partType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1224,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t retValCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->lproxyPortType = lproxyPortType;

	InP->lproxyPort = lproxyPort;

	InP->hlpRcvType = hlpRcvType;

	InP->hlpRcv = hlpRcv;

	InP->hlpTypeType = hlpTypeType;

	InP->hlpType = hlpType;

	InP->llpType = llpType;

	InP->llp = llp;

	InP->partType = partType;

	{ typedef struct { char data[4896]; } *sp; * (sp) InP->part = * (sp) part; }

	InP->Head.msgh_bits = MACH_MSGH_BITS_COMPLEX|
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844419;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 4956, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844519) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	msgh_size = OutP->Head.msgh_size;

	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    ((msgh_size != 40) &&
	     ((msgh_size != sizeof(mig_reply_header_t)) ||
	      (OutP->RetCode == KERN_SUCCESS))))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (OutP->RetCode != KERN_SUCCESS)
		return OutP->RetCode;

#if	TypeCheck
	if (* (int *) &OutP->retValType != * (int *) &retValCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*retVal = OutP->retVal;

	return KERN_SUCCESS;
}

/* Routine xOpen */
mig_external kern_return_t call_uproxy_xOpen
(
	mach_port_t reqPort,
	mach_port_t lproxyPort,
	xobj_ext_id_t *retObj,
	xobj_ext_id_t hlpRcv,
	xobj_ext_id_t hlpType,
	xobj_ext_id_t llp,
	xk_part_t part
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t lproxyPortType;
		mach_port_t lproxyPort;
		mach_msg_type_t hlpRcvType;
		xobj_ext_id_t hlpRcv;
		mach_msg_type_t hlpTypeType;
		xobj_ext_id_t hlpType;
		mach_msg_type_t llpType;
		xobj_ext_id_t llp;
		mach_msg_type_t partType;
		xk_part_t part;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
		mach_msg_type_t retObjType;
		xobj_ext_id_t retObj;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;
#if	TypeCheck
	unsigned int msgh_size;
#endif	/* TypeCheck */

	static const mach_msg_type_t lproxyPortType = {
		/* msgt_name = */		20,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t hlpRcvType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t hlpTypeType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t llpType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t partType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1224,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t retObjCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->lproxyPortType = lproxyPortType;

	InP->lproxyPort = lproxyPort;

	InP->hlpRcvType = hlpRcvType;

	InP->hlpRcv = hlpRcv;

	InP->hlpTypeType = hlpTypeType;

	InP->hlpType = hlpType;

	InP->llpType = llpType;

	InP->llp = llp;

	InP->partType = partType;

	{ typedef struct { char data[4896]; } *sp; * (sp) InP->part = * (sp) part; }

	InP->Head.msgh_bits = MACH_MSGH_BITS_COMPLEX|
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844420;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 4956, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844520) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	msgh_size = OutP->Head.msgh_size;

	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    ((msgh_size != 40) &&
	     ((msgh_size != sizeof(mig_reply_header_t)) ||
	      (OutP->RetCode == KERN_SUCCESS))))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (OutP->RetCode != KERN_SUCCESS)
		return OutP->RetCode;

#if	TypeCheck
	if (* (int *) &OutP->retObjType != * (int *) &retObjCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*retObj = OutP->retObj;

	return KERN_SUCCESS;
}

/* Routine dumpXObj */
mig_external kern_return_t call_uproxy_dumpXObj
(
	mach_port_t reqPort,
	xkern_return_t *retVal,
	xobj_ext_id_t obj,
	xk_xobj_dump_t *dump
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t objType;
		xobj_ext_id_t obj;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
		mach_msg_type_t retValType;
		xkern_return_t retVal;
		mach_msg_type_t dumpType;
		xk_xobj_dump_t dump;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;
#if	TypeCheck
	unsigned int msgh_size;
#endif	/* TypeCheck */

	static const mach_msg_type_t objType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t retValCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t dumpCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		44,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->objType = objType;

	InP->obj = obj;

	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844421;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 32, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844521) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	msgh_size = OutP->Head.msgh_size;

	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    ((msgh_size != 220) &&
	     ((msgh_size != sizeof(mig_reply_header_t)) ||
	      (OutP->RetCode == KERN_SUCCESS))))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (OutP->RetCode != KERN_SUCCESS)
		return OutP->RetCode;

#if	TypeCheck
	if (* (int *) &OutP->retValType != * (int *) &retValCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*retVal = OutP->retVal;

#if	TypeCheck
	if (* (int *) &OutP->dumpType != * (int *) &dumpCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*dump = OutP->dump;

	return KERN_SUCCESS;
}

/* Routine xDuplicate */
mig_external kern_return_t call_uproxy_xDuplicate
(
	mach_port_t reqPort,
	mach_port_t lproxyPort,
	xkern_return_t *retVal,
	xobj_ext_id_t hlp,
	xobj_ext_id_t obj
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t lproxyPortType;
		mach_port_t lproxyPort;
		mach_msg_type_t hlpType;
		xobj_ext_id_t hlp;
		mach_msg_type_t objType;
		xobj_ext_id_t obj;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
		mach_msg_type_t retValType;
		xkern_return_t retVal;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;
#if	TypeCheck
	unsigned int msgh_size;
#endif	/* TypeCheck */

	static const mach_msg_type_t lproxyPortType = {
		/* msgt_name = */		20,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t hlpType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t objType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t retValCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->lproxyPortType = lproxyPortType;

	InP->lproxyPort = lproxyPort;

	InP->hlpType = hlpType;

	InP->hlp = hlp;

	InP->objType = objType;

	InP->obj = obj;

	InP->Head.msgh_bits = MACH_MSGH_BITS_COMPLEX|
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844422;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 48, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844522) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	msgh_size = OutP->Head.msgh_size;

	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    ((msgh_size != 40) &&
	     ((msgh_size != sizeof(mig_reply_header_t)) ||
	      (OutP->RetCode == KERN_SUCCESS))))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (OutP->RetCode != KERN_SUCCESS)
		return OutP->RetCode;

#if	TypeCheck
	if (* (int *) &OutP->retValType != * (int *) &retValCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*retVal = OutP->retVal;

	return KERN_SUCCESS;
}

/* Routine xClose */
mig_external kern_return_t call_uproxy_xClose
(
	mach_port_t reqPort,
	xkern_return_t *retVal,
	xobj_ext_id_t lls
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t llsType;
		xobj_ext_id_t lls;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
		mach_msg_type_t retValType;
		xkern_return_t retVal;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;
#if	TypeCheck
	unsigned int msgh_size;
#endif	/* TypeCheck */

	static const mach_msg_type_t llsType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t retValCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->llsType = llsType;

	InP->lls = lls;

	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844425;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 32, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844525) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	msgh_size = OutP->Head.msgh_size;

	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    ((msgh_size != 40) &&
	     ((msgh_size != sizeof(mig_reply_header_t)) ||
	      (OutP->RetCode == KERN_SUCCESS))))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (OutP->RetCode != KERN_SUCCESS)
		return OutP->RetCode;

#if	TypeCheck
	if (* (int *) &OutP->retValType != * (int *) &retValCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*retVal = OutP->retVal;

	return KERN_SUCCESS;
}

/* Routine ping */
mig_external kern_return_t call_uproxy_ping
(
	mach_port_t reqPort
)
{
	typedef struct {
		mach_msg_header_t Head;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->Head.msgh_bits =
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844426;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 24, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844526) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (OutP->Head.msgh_size != 32))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	return OutP->RetCode;
}

/* Routine pingtest */
mig_external kern_return_t call_uproxy_pingtest
(
	mach_port_t reqPort,
	mach_port_t repPort,
	int number
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t repPortType;
		mach_port_t repPort;
		mach_msg_type_t numberType;
		int number;
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;

	static const mach_msg_type_t repPortType = {
		/* msgt_name = */		20,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t numberType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->repPortType = repPortType;

	InP->repPort = repPort;

	InP->numberType = numberType;

	InP->number = number;

	InP->Head.msgh_bits = MACH_MSGH_BITS_COMPLEX|
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE);
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844427;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, 40, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844527) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    (OutP->Head.msgh_size != 32))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	return OutP->RetCode;
}
/* Routine xCall */
mig_external kern_return_t call_uproxy_xCall
(
	mach_port_t reqPort,
	xkern_return_t *retVal,
	xobj_ext_id_t lls,
	xk_msg_data_t reqmsg,
	mach_msg_type_number_t reqmsgCnt,
	xk_large_msg_data_t reqool,
	mach_msg_type_number_t reqoolCnt,
	xk_msg_data_t repmsg,
	mach_msg_type_number_t *repmsgCnt,
	xk_large_msg_data_t *repool,
	mach_msg_type_number_t *repoolCnt,
	xk_msg_attr_t reqAttr,
	mach_msg_type_number_t reqAttrCnt
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t llsType;
		xobj_ext_id_t lls;
		mach_msg_type_t reqmsgType;
		char reqmsg[4000];
		mach_msg_type_long_t reqoolType;
		char reqool[2048];
		mach_msg_type_t reqAttrType;
		char reqAttr[200];
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
		mach_msg_type_t retValType;
		xkern_return_t retVal;
		mach_msg_type_t repmsgType;
		char repmsg[4000];
		mach_msg_type_long_t repoolType;
		char repool[2048];
	} Reply;

/* 
 * Begin x-kernel Sed hack
 */
	typedef union {
		Request In;
		Reply Out;
	} union_mess;

	union_mess	*Mess = (union_mess *)repmsg;
	Msg		*xReqMsg = (Msg *)reqmsg;
	register Request *InP = &Mess->In;
	register Reply 	*OutP = &Mess->Out;

/* 
 * End x-kernel Sed hack
 */

	mach_msg_return_t msg_result;
	boolean_t msgh_simple = TRUE;
	unsigned int msgh_size;
	unsigned int msgh_size_delta;

	static const mach_msg_type_t llsType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t reqmsgType = {
		/* msgt_name = */		8,
		/* msgt_size = */		8,
		/* msgt_number = */		4000,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_long_t reqoolType = {
	{
		/* msgt_name = */		0,
		/* msgt_size = */		0,
		/* msgt_number = */		0,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		TRUE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	},
		/* msgtl_name = */	8,
		/* msgtl_size = */	8,
		/* msgtl_number = */	2048,
	};

	static const mach_msg_type_t reqAttrType = {
		/* msgt_name = */		8,
		/* msgt_size = */		8,
		/* msgt_number = */		200,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t retValCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	InP->llsType = llsType;

	InP->lls = lls;

	InP->reqmsgType = reqmsgType;

	if (reqmsgCnt > 4000) {
		return MIG_ARRAY_TOO_LARGE;
	}
	else {
/* 
 * Begin x-kernel Sed hack
 */
		if ( xReqMsg ) {
	    		msg2buf(xReqMsg, (char *)InP->reqmsg);
		}
/* 
 * End x-kernel Sed hack
 */
	}

	InP->reqmsgType.msgt_number = reqmsgCnt;

	msgh_size_delta = (reqmsgCnt + 3) & ~3;
	msgh_size = 52 + msgh_size_delta;
	InP = (Request *) ((char *) InP + msgh_size_delta - 4000);
	InP->reqoolType = reqoolType;

	if (reqoolCnt > 2048) {
		InP->reqoolType.msgtl_header.msgt_inline = FALSE;
		*((char **)InP->reqool) = reqool;
		msgh_simple = FALSE;
	}
	else {
		memcpy(InP->reqool, reqool, reqoolCnt);
	}

	InP->reqoolType.msgtl_number = reqoolCnt;

	msgh_size_delta = (InP->reqoolType.msgtl_header.msgt_inline) ? (reqoolCnt + 3) & ~3 : sizeof(char *);
	msgh_size += msgh_size_delta;
	InP = (Request *) ((char *) InP + msgh_size_delta - 2048);
	InP->reqAttrType = reqAttrType;

	if (reqAttrCnt > 200) {
		return MIG_ARRAY_TOO_LARGE;
	}
	else {
		memcpy(InP->reqAttr, reqAttr, reqAttrCnt);
	}

	InP->reqAttrType.msgt_number = reqAttrCnt;

	msgh_size += (reqAttrCnt + 3) & ~3;
/* 
 * Begin x-kernel Sed hack
 */
	InP = &Mess->In;
/* 
 * End x-kernel Sed hack
 */
	InP->Head.msgh_bits = msgh_simple ?
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE) :
		(MACH_MSGH_BITS_COMPLEX|
		 MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE));
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844424;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, msgh_size, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844524) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	msgh_size = OutP->Head.msgh_size;
	msgh_simple = !(OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX);

	if (((msgh_size < 56)) &&
	    ((msgh_size != sizeof(mig_reply_header_t)) ||
	     !msgh_simple ||
	     (OutP->RetCode == KERN_SUCCESS)))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (OutP->RetCode != KERN_SUCCESS)
		return OutP->RetCode;

#if	TypeCheck
	if (* (int *) &OutP->retValType != * (int *) &retValCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*retVal = OutP->retVal;

#if	TypeCheck
	if ((OutP->repmsgType.msgt_inline != TRUE) ||
	    (OutP->repmsgType.msgt_longform != FALSE) ||
	    (OutP->repmsgType.msgt_name != 8) ||
	    (OutP->repmsgType.msgt_size != 8))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	msgh_size_delta = (OutP->repmsgType.msgt_number + 3) & ~3;
#if	TypeCheck
	if (msgh_size < 56 + msgh_size_delta)
		return MIG_TYPE_ERROR;
	msgh_size -= msgh_size_delta;
#endif	/* TypeCheck */

	if (OutP->repmsgType.msgt_number > *repmsgCnt) {
/* 
 * Begin x-kernel Sed hack
 */
		return MIG_ARRAY_TOO_LARGE;
/* 
 * End x-kernel Sed hack
 */
		*repmsgCnt = OutP->repmsgType.msgt_number;
		return MIG_ARRAY_TOO_LARGE;
	}
	else {
/* 
 * Begin x-kernel Sed hack
 */
/*		memcpy(repmsg, OutP->repmsg, OutP->repmsgType.msgt_number);*/
/* 
 * End x-kernel Sed hack
 */
	}

	*repmsgCnt = OutP->repmsgType.msgt_number;

	OutP = (Reply *) ((char *) OutP + msgh_size_delta - 4000);

#if	TypeCheck
	if ((OutP->repoolType.msgtl_header.msgt_longform != TRUE) ||
	    (OutP->repoolType.msgtl_name != 8) ||
	    (OutP->repoolType.msgtl_size != 8))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (msgh_size != 56 + ((OutP->repoolType.msgtl_header.msgt_inline) ? (OutP->repoolType.msgtl_number + 3) & ~3 : sizeof(char *)))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (!OutP->repoolType.msgtl_header.msgt_inline)
	    *repool = *((char **)OutP->repool);
	else if (OutP->repoolType.msgtl_number > *repoolCnt) {
	    mig_allocate((vm_offset_t *)repool,
		OutP->repoolType.msgtl_number);
	    memcpy(*repool, OutP->repool, OutP->repoolType.msgtl_number);
	}
	else {
	    memcpy(*repool, OutP->repool, OutP->repoolType.msgtl_number);
	}

	*repoolCnt = OutP->repoolType.msgtl_number;

/* 
 * Begin x-kernel Sed hack
 */
	xAssert( offsetof(Reply,repmsg) == XK_CALL_REP_OFFSET );
/* 
 * End x-kernel Sed hack
 */
	return KERN_SUCCESS;
}

/* Routine xPush */
mig_external kern_return_t call_uproxy_xPush
(
	mach_port_t reqPort,
	xmsg_handle_t *handle,
	xobj_ext_id_t lls,
	xk_msg_data_t xmsg,
	mach_msg_type_number_t xmsgCnt,
	xk_large_msg_data_t xmsgool,
	mach_msg_type_number_t xmsgoolCnt,
	xk_msg_attr_t attr,
	mach_msg_type_number_t attrCnt
)
{
	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t llsType;
		xobj_ext_id_t lls;
		mach_msg_type_t xmsgType;
		char xmsg[4000];
		mach_msg_type_long_t xmsgoolType;
		char xmsgool[2048];
		mach_msg_type_t attrType;
		char attr[200];
	} Request;

	typedef struct {
		mach_msg_header_t Head;
		mach_msg_type_t RetCodeType;
		kern_return_t RetCode;
		mach_msg_type_t handleType;
		xmsg_handle_t handle;
	} Reply;

	union {
		Request In;
		Reply Out;
	} Mess;

	register Request *InP = &Mess.In;
	register Reply *OutP = &Mess.Out;

	mach_msg_return_t msg_result;
	boolean_t msgh_simple = TRUE;
	unsigned int msgh_size;
	unsigned int msgh_size_delta;
/* 
 * Begin x-kernel Sed hack
 */
	char	*machMsgStart; 
/* 
 * End x-kernel Sed hack
 */

	static const mach_msg_type_t llsType = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t xmsgType = {
		/* msgt_name = */		8,
		/* msgt_size = */		8,
		/* msgt_number = */		4000,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_long_t xmsgoolType = {
	{
		/* msgt_name = */		0,
		/* msgt_size = */		0,
		/* msgt_number = */		0,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		TRUE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	},
		/* msgtl_name = */	8,
		/* msgtl_size = */	8,
		/* msgtl_number = */	2048,
	};

	static const mach_msg_type_t attrType = {
		/* msgt_name = */		8,
		/* msgt_size = */		8,
		/* msgt_number = */		200,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t RetCodeCheck = {
		/* msgt_name = */		MACH_MSG_TYPE_INTEGER_32,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

	static const mach_msg_type_t handleCheck = {
		/* msgt_name = */		2,
		/* msgt_size = */		32,
		/* msgt_number = */		1,
		/* msgt_inline = */		TRUE,
		/* msgt_longform = */		FALSE,
		/* msgt_deallocate = */		FALSE,
		/* msgt_unused = */		0
	};

/* 
 * Begin x-kernel Sed hack
 */
	if ( ((xk_and_mach_msg_t *)xmsg)->machMsg ) {	
		xAssert( offsetof(Request,xmsg) == XK_PUSH_REQ_OFFSET );  
		InP = (Request *)((xk_and_mach_msg_t *)xmsg)->machMsg;	
		OutP = (Reply *)((xk_and_mach_msg_t *)xmsg)->machMsg;	
		xAssert( ! ((xk_and_mach_msg_t *)xmsg)->xkMsg );	
	} 
	machMsgStart = (char *)InP; 
/* 
 * End x-kernel Sed hack
 */
	InP->llsType = llsType;

	InP->lls = lls;

	InP->xmsgType = xmsgType;

	if (xmsgCnt > 4000) {
		return MIG_ARRAY_TOO_LARGE;
	}
	else {
/* 
 * Begin x-kernel Sed hack
 */
		if ( ((xk_and_mach_msg_t *)xmsg)->xkMsg ) {
			msg2buf( ((xk_and_mach_msg_t *)xmsg)->xkMsg, (char *)InP->xmsg);
		}
/* 
 * End x-kernel Sed hack
 */
	}

	InP->xmsgType.msgt_number = xmsgCnt;

	msgh_size_delta = (xmsgCnt + 3) & ~3;
	msgh_size = 52 + msgh_size_delta;
	InP = (Request *) ((char *) InP + msgh_size_delta - 4000);
	InP->xmsgoolType = xmsgoolType;

	if (xmsgoolCnt > 2048) {
		InP->xmsgoolType.msgtl_header.msgt_inline = FALSE;
		*((char **)InP->xmsgool) = xmsgool;
		msgh_simple = FALSE;
	}
	else {
		memcpy(InP->xmsgool, xmsgool, xmsgoolCnt);
	}

	InP->xmsgoolType.msgtl_number = xmsgoolCnt;

	msgh_size_delta = (InP->xmsgoolType.msgtl_header.msgt_inline) ? (xmsgoolCnt + 3) & ~3 : sizeof(char *);
	msgh_size += msgh_size_delta;
	InP = (Request *) ((char *) InP + msgh_size_delta - 2048);
	InP->attrType = attrType;

	if (attrCnt > 200) {
		return MIG_ARRAY_TOO_LARGE;
	}
	else {
		memcpy(InP->attr, attr, attrCnt);
	}

	InP->attrType.msgt_number = attrCnt;

	msgh_size += (attrCnt + 3) & ~3;
/* 
 * Begin x-kernel Sed hack
 */
	InP = (Request *)machMsgStart;
/* 
 * End x-kernel Sed hack
 */
	InP->Head.msgh_bits = msgh_simple ?
		MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE) :
		(MACH_MSGH_BITS_COMPLEX|
		 MACH_MSGH_BITS(19, MACH_MSG_TYPE_MAKE_SEND_ONCE));
	/* msgh_size passed as argument */
	InP->Head.msgh_request_port = reqPort;
	InP->Head.msgh_reply_port = mig_get_reply_port();
	InP->Head.msgh_seqno = 0;
	InP->Head.msgh_id = 844423;

	msg_result = mach_msg(&InP->Head, MACH_SEND_MSG|MACH_RCV_MSG|MACH_MSG_OPTION_NONE, msgh_size, sizeof(Reply), InP->Head.msgh_reply_port, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
	if (msg_result != MACH_MSG_SUCCESS) {
		if ((msg_result == MACH_SEND_INVALID_REPLY) ||
		    (msg_result == MACH_SEND_INVALID_MEMORY) ||
		    (msg_result == MACH_SEND_INVALID_RIGHT) ||
		    (msg_result == MACH_SEND_INVALID_TYPE) ||
		    (msg_result == MACH_SEND_MSG_TOO_SMALL) ||
		    (msg_result == MACH_RCV_INVALID_NAME))
			mig_dealloc_reply_port(InP->Head.msgh_reply_port);
		else
			mig_put_reply_port(InP->Head.msgh_reply_port);
		return msg_result;
	}
	mig_put_reply_port(InP->Head.msgh_reply_port);

	if (OutP->Head.msgh_id != 844523) {
		if (OutP->Head.msgh_id == MACH_NOTIFY_SEND_ONCE)
		return MIG_SERVER_DIED;
		else
		return MIG_REPLY_MISMATCH;
	}

#if	TypeCheck
	msgh_size = OutP->Head.msgh_size;

	if ((OutP->Head.msgh_bits & MACH_MSGH_BITS_COMPLEX) ||
	    ((msgh_size != 40) &&
	     ((msgh_size != sizeof(mig_reply_header_t)) ||
	      (OutP->RetCode == KERN_SUCCESS))))
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

#if	TypeCheck
	if (* (int *) &OutP->RetCodeType != * (int *) &RetCodeCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	if (OutP->RetCode != KERN_SUCCESS)
		return OutP->RetCode;

#if	TypeCheck
	if (* (int *) &OutP->handleType != * (int *) &handleCheck)
		return MIG_TYPE_ERROR;
#endif	/* TypeCheck */

	*handle = OutP->handle;

	return KERN_SUCCESS;
}

