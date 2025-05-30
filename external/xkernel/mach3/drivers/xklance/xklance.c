/* 
 * Mach Operating System
 * Copyright (c) 1991,1990,1989 Carnegie Mellon University
 * All Rights Reserved.
 * 
 * Permission to use, copy, modify and distribute this software and its
 * documentation is hereby granted, provided that both the copyright
 * notice and this permission notice appear in all copies of the
 * software, derivative works or modified versions, and any portions
 * thereof, and that both notices appear in supporting documentation.
 * 
 * CARNEGIE MELLON ALLOWS FREE USE OF THIS SOFTWARE IN ITS "AS IS"
 * CONDITION.  CARNEGIE MELLON DISCLAIMS ANY LIABILITY OF ANY KIND FOR
 * ANY DAMAGES WHATSOEVER RESULTING FROM THE USE OF THIS SOFTWARE.
 * 
 * Carnegie Mellon requests users of this software to return to
 * 
 *  Software Distribution Coordinator  or  Software.Distribution@CS.CMU.EDU
 *  School of Computer Science
 *  Carnegie Mellon University
 *  Pittsburgh PA 15213-3890
 * 
 * any improvements or extensions that they make and grant Carnegie Mellon
 * the rights to redistribute these changes.
 */
/*
 * HISTORY
 * $Log: xklance.c,v $
 * Revision 1.20  1993/09/25  00:33:49  hkaram
 * Works with and w/o xkernel; installed changes due
 * to upgrade to MK82.
 *
 * Revision 1.18  1993/01/30  00:36:56  menze
 * Modified to use new message attribute interface
 *
 * Revision 1.17  1992/11/13  23:05:45  menze
 * Whether anyone other than the x-kernel receives incoming packets can
 * now be turned on and off at runtime with the xklanceAllUsers variable.
 *
 * Incoming messages are now truncated to the number of bytes read from
 * the device (note that this may not be equal to the number of bytes
 * sent for short packets.)
 *
 * Replaced calls to store routine with a single bcopy
 *
 * io_count in the iorequest for xkernel messages now includes the ETHhdr
 * length.
 *
 * Revision 1.16  1992/10/15  23:09:13  menze
 * Merged branch 1.14.1.2 into the trunk
 *
 *
 * Revision 1.15  1992/10/15  21:35:01  rcs
 * changed xklance_push to stuff eth packet header into a message attribute
 * istead of using 3 calls to msgPush.  Improved packet send time.
 *
 * Revision 1.14.1.2  1992/10/15  21:57:40  menze
 * Since we're not encapsulating outgoing unix-server requests, I removed
 * the 'where from' parameter to xknet_write and removed the kludgey
 * 'restore io_req->data pointer' code in xkCopyout
 *
 * Revision 1.14.1.1  1992/10/15  20:56:17  menze
 * outgoing unix-server messages are no longer encapsulated in xkernel messages
 *
 * Revision 1.14  1992/10/13  20:14:46  menze
 * merge 1.13.1.2 into the trunk
 *
 * Revision 1.13.1.2  1992/10/09  01:20:42  menze
 * Lance unit number is now stored in the 'state' field of the protocol
 * object
 *
 * Revision 1.13.1.1  1992/10/08  23:56:30  menze
 * Modifications to allow both the Unix server and the xkernel to send
 * and receive messages
 *
 * Revision 1.13  1992/10/05  19:29:08  rcs
 * fixes to improve multiple interface code; more to do
 *
 * Revision 1.12  1992/09/15  21:33:56  rcs
 * added code for GET_MY_HOST; fixed typos
 *
 * Revision 1.10  1992/09/01  21:35:30  menze
 * Fixed some typos
 *
 * Revision 1.9  1992/09/01  20:40:17  menze
 * Changed inclusion of "process_msg.h" to "kern_process_msg.h"
 *
 * Revision 1.8  1992/09/01  20:28:39  menze
 * Performance improvements by Rich.
 *
 * Changed se_read_xkernel to use the new thread scheme involving
 * separate thread and buffer queues.
 *
 * Revision 1.7  1992/06/19  19:48:56  ho
 * changed free() to xFree() in copy-to-lance
 *
 * Revision 1.6  1992/03/12  02:35:20  ho
 * Mapped interface stubs; make this Mach device xl, not ln.
 *
 * Revision 1.4  1992/03/02  18:53:30  ho
 * Uses thread_resume; does no mallocs on interrupt; see also process.c.
 *
 * Revision 1.3  1992/02/20  21:27:27  ho
 * Added memory throttle; don't accept packets if too much storage is in use.
 *
 * Revision 1.2  1992/02/03  21:47:35  ho
 * Fixed argument declaration in ethCtlXmit.
 *
 * Revision 1.1  1992/01/29  01:44:36  ho
 * Initial revision
 *
 *
 * Revision 1.3  Thu Jan 23 18:15:35 1992 hko
 *	Adapted to xkernel 3.2 baseline; calls CreateProcess;
 *      Added ifdef for xkernel mods
 *
 * Revision 1.2  1991/12/20  20:05:47  norm
 * Works with old xkernel 3.2
 *
 * Revision 1.1  1991/12/18  21:48:11  norm
 * Initial revision
 *
 * Revision 1.1  1991/12/18  21:46:28  norm
 * Initial revision
 *
 * Revision 2.18  91/09/04  11:41:18  jsb
 * 	Don't let ethernet interrupts blow us away.
 * 	[91/09/04  11:35:00  jsb]
 * 
 * Revision 2.17  91/08/24  11:52:03  af
 * 	Spls for 3min, which has yet another bogus DMA setup: now the
 * 	alignment for the rings can be different from the one for data.
 * 	What will be next ?
 * 	[91/08/02  02:24:15  af]
 * 
 * Revision 2.16  91/06/25  20:53:52  rpd
 * 	Tweaks to make gcc happy.
 * 	[91/06/25            rpd]
 * 
 * Revision 2.15  91/06/19  15:19:34  rvb
 * 	mips->DECSTATION; vax->VAXSTATION
 * 	[91/06/12  14:01:39  rvb]
 * 
 * 	File moved here from mips/PMAX since it tries to be generic;
 * 	it is used on the PMAX and the Vax3100.
 * 	[91/06/04            rvb]
 * 
 * Revision 2.14  91/05/14  17:21:57  mrt
 * 	Correcting copyright
 * 
 * Revision 2.13  91/03/16  14:53:46  rpd
 * 	Changed net_filter to net_packet.
 * 	[91/01/15            rpd]
 * 
 * Revision 2.12  91/02/14  14:34:05  mrt
 * 	In interrupt routine, drop priority as now required.
 * 	Added (optional) loopback of packets sent to ourselves,
 * 	this way can run multiple POEs and have them talk to each other.
 * 	Same flag lets you run with external hardware loopback terminator
 * 	ignoring no-carrier errors.
 * 	Fixed bug with multiple ether boards.
 * 	Fixed bug with loopback path shifting data incorrectly.
 * 	[91/02/12  12:53:29  af]
 * 
 * Revision 2.11  91/02/05  17:41:05  mrt
 * 	Added author notices
 * 	[91/02/04  11:13:39  mrt]
 * 
 * 	Changed to use new Mach copyright
 * 	[91/02/02  12:11:37  mrt]
 * 
 * Revision 2.10  91/01/08  15:47:51  rpd
 * 	Changed NET_KMSG_GET, NET_KMSG_FREE to net_kmsg_get, net_kmsg_put.
 * 	[91/01/05            rpd]
 * 
 * Revision 2.9  90/12/05  23:31:17  af
 * 	Cleanups.
 * 	Consistency renames, get defs for 3max from new pmad_aa.h file.
 * 	seinfo[] was improperly sized.
 * 	[90/12/03  23:18:52  af]
 * 
 * Revision 2.7  90/09/09  23:20:23  rpd
 * 	Ram size for lance depends on machine type: added to switch.
 * 	[90/09/09  18:58:52  af]
 * 
 * 	Co-existency hacks for the mapped interface.
 * 	[90/08/30  17:29:04  af]
 * 
 * Revision 2.6  90/08/27  22:05:36  dbg
 * 	Some revisions of the Lance chip might lose the CSR1 info,
 * 	made sure loading of the init block resets them.
 * 	Localized local localities :-)
 * 	[90/08/17  12:28:49  af]
 * 
 * Revision 2.5  90/08/07  22:24:40  rpd
 * 	Made silent by default.
 * 	[90/08/07  15:32:00  af]
 * 
 * Revision 2.3.4.2  90/07/27  11:27:43  af
 * 	3max support.
 * 
 * 
 * Revision 2.3.4.1  90/06/02  12:24:39  af
 * 	Works now.  The problem was an amusing one.  Turns out the chip
 * 	needs a little time to settle the csr1 and csr2 info, more than
 * 	the r3000 allowed for.  Since we allocate the init block
 * 	differently from the prom's way the chip was getting it from the wrong
 * 	place.
 * 	[90/06/01            af]
 * 
 * Revision 2.3.3.1  90/05/30  16:13:06  af
 * 	Support for 3max, new autocof.  What a nightmare, and still does
 * 	not work.
 * 
 * Revision 2.3.2.1  90/05/02  23:51:02  rpd
 * 	Converted to new IPC.
 * 	[90/03/26  22:45:00  rpd]
 *
 * Revision 2.3  89/12/08  19:46:33  rwd
 * 	Do not lose buffers in case of errors.
 * 	Make it silent by default.
 * 	[89/12/05  02:24:10  af]
 * 
 * Revision 2.2  89/11/29  14:10:33  af
 * 	Heavily modified for pure Mach kernel.
 * 	BTW, since the device is known to users as "se", sounded
 * 	like pure braindamage to use different names here.
 * 	[89/11/21            af]
 * 
 * Revision 2.4  89/09/25  22:20:33  mja
 * 	Support Ultrix SIOCRPHYSADDR call.
 * 	[89/09/22  18:02:05  mja]
 * 
 * Revision 2.3  89/08/08  21:47:40  jsb
 * 	Fixed the argument definition for lnint(), since it
 * 	is called directly from intr().
 * 	[89/07/31            af]
 * 
 * Revision 2.2  89/05/31  14:27:10  rvb
 * 	For now turn off ln_verbose.  I know I get misses.
 * 	[89/05/31            rvb]
 * 
 * Revision 2.1  89/05/30  12:49:45  rvb
 * Created.
 * 
 * 18-May-89  Robert Baron (rvb) at Carnegie-Mellon University
 *	Created.
 */
/*
 *	File:	lance.c
 *	Author: Robert V. Baron & Alessandro Forin
 *	Date:	5/90
 *
 *	Driver for the DEC LANCE Ethernet Controller.
 */

#ifdef IPC_FBUF
#define XK_NO_INCOMING_PACKETS
#endif

#ifdef XKNEWMACHKERNEL
#include <xl.h>
/* define the symbols for the mapped interface; we can't use it, though */
SE_open() { };
SE_close() { };
SE_mmap() { };
SE_portdeath() { };
SE_get_status() { };
SE_set_status() { };
SE_probe() { };
SE_attach() { };
SE_intr() { };
#define NLN   NXL
#else XKNEWMACHKERNEL
#include <ln.h>
#endif XKNEWMACHKERNEL
#if     NLN > 0 || NXL > 0
#include <platforms.h>

/*
 * AMD Am7990 LANCE (Ethernet Interface)
 */
#include <sys/ioctl.h>
#include <vm/vm_kern.h>

#include <machine/machspl.h>		/* spl definitions */
#include <kern/time_out.h>
#include <sys/syslog.h>
#include <ipc/ipc_port.h>
#include <ipc/ipc_kmsg.h>

#include <device/device_types.h>
#include <device/errno.h>
#include <device/io_req.h>
#include <device/if_hdr.h>
#include <device/if_ether.h>
#include <device/net_status.h>
#include <device/net_io.h>

#ifdef	FLAMINGO
#define se_reg_type unsigned int
#endif

#include <chips/lance.h>
#include <chips/busses.h>

#define private static
#define public

typedef struct se_softc *se_softc_t; /* move above prototypes */

void se_write_reg(); /* forwards */
void se_read();
void se_rint();
void se_tint();

private vm_offset_t se_Hmem_nogap(), se_Hmem_gap16();
private vm_offset_t se_malloc();

#ifdef	DECSTATION
#include <mips/mips_cpu.h>
#include <mips/PMAX/pmad_aa.h>

#ifdef XKMACHKERNEL
#include "xkernel.h"
#include "msg.h"
#include "msg_internal.h"
#include "eth_i.h"
#include "trace.h"
#include "list.h"
#include "kern_process_msg.h"
extern list_t ThreadQ;

#ifndef RICHDEBUG
int	tracexklancep = 0;
#else
int	tracexklancep = 100;
#endif

xmsg_handle_t xklance_push();
#endif XKMACHKERNEL

#define IO_IS_XK_MSG	(IO_SPARE_START)

#define	MAPPED 1


/*
 * The LANCE buffer memory as seen from the Pmax cpu is funny.
 * It is viewed as short words (16bits), spaced at word (32bits)
 * intervals.  The same applies to the registers.  From the LANCE
 * point of view memory is instead contiguous.
 * The ROM that contains the station address is in the space belonging
 * to the clock/battery backup memory.  This space is again 16 bits
 * in a 32bit envelope.  And the ether address is stored in the "high"
 * byte of 6 consecutive quantities.
 *
 * But Pmaxen and 3maxen (and..) map lance space differently.
 * This requires dynamic adaptation of the driver, which
 * is done via the following switches.
 * For convenience, the switch holds information about
 * the location of the lance control registers as well.
 * This could be either absolute (pmax) or relative to
 * some register base (3max, turbochannel)
 */
void copyin_gap16(), copyout_gap16(), bzero_gap16();
extern void bcopy(), bzero();
void copyin_gap32(), copyout_gap32();

static struct se_switch se_switch[] = {
/* pmax */
	{ 0x00000000, 0x01000000, 0x0, 0x05000000, 8, 16, 64*1024, 
	  copyin_gap16, copyout_gap16, copyin_gap16, copyout_gap16,
	  bzero_gap16, se_Hmem_gap16, se_Hmem_gap16},
/* 3max */
	{ PMAD_OFFSET_LANCE, PMAD_OFFSET_RAM, PMAD_OFFSET_RAM, PMAD_OFFSET_ROM,
	  16, 0, PMAD_RAM_SIZE,
	  bcopy, bcopy, bcopy, bcopy, bzero, se_Hmem_nogap, se_Hmem_nogap},
/* 3min */
/* XXX re-use other 64k */
	{ 0/*later*/, 0/*later*/, 0x0, 0/*later*/, 0, 128, 64*1024,
	  copyin_gap16, copyout_gap16, copyin_gap32, copyout_gap32,
	  bzero_gap16, se_Hmem_gap16, se_Hmem_nogap},
};

/*
 * "lna" is what se_malloc hands back.  They are offsets using
 * the sizing that the Lance would use. The Lance space is
 * mapped somewhere in the I/O space, as indicated by the softc.
 * Hence we have these two macros:
 */
/* H & L are not hi and lo but
   H = HOST  == addresses for host to reference board memory
   L = LOCAL == addresses on board
 */
#define Hmem(lna)	(vm_offset_t)((se_sw->mapaddr)(lna) + sc->lnbuf)
#define Lmem(lna)	(vm_offset_t)((unsigned)lna + sc->lnoffset)
#endif	/*DECSTATION*/

#ifdef	VAXSTATION
#include <vax/ka3100.h>

#define wbflush()

void xzero(x, l) vm_offset_t x; int l; { blkclr(x, l); }
void xcopy(f, t, l) vm_offset_t f, t; int l; { bcopy(f, t, l); }

private struct se_switch se_switch[] = {
	/* pvax sees contiguous bits in lower 16Meg of memory */
	{ 0, 0, 0, 0, 0, 0, 64*1024,
	  xcopy, xcopy, xcopy, xcopy, xzero, se_Hmem_nogap, se_Hmem_nogap},
};

/*
 * "lna" is what se_malloc hands back.  They are offsets using
 * the sizing that the Lance would use. The Lance space is
 * mapped somewhere in the I/O space, as indicated by the softc.
 * Hence we have these two macros:
 */
/* H & L are not hi and lo but
   H = HOST  == addresses for host to reference board memory
   L = LOCAL == addresses on board
 */
	/*
	 * This does not deal with > 16 Meg physical memory, where
	 * Hmem != Lmem
	 */
#define Hmem(lna)	(vm_offset_t)((lna) + sc->lnbuf)
#define Lmem(lna)	(vm_offset_t)((lna) + sc->lnoffset)

#endif	/*VAXSTATION*/



#ifdef	FLAMINGO
#include <alpha/alpha_cpu.h>

/* XXX might be wrong, mostly stolen from kmin */
extern void copyin_gap16(), copyout_gap16(), bzero_gap16();
extern void copyin_gap32(), copyout_gap32();
extern void bcopy(), bzero();

private struct se_switch se_switch[] = {
/* XXX re-use other 64k */
	{ 0/*later*/, 0/*later*/, 0x0, 0/*later*/, 0, 128, 64*1024,
	  copyin_gap16, copyout_gap16, copyin_gap32, copyout_gap32,
	  bzero_gap16, se_Hmem_gap16, se_Hmem_nogap},
};

/*
 * "lna" is what se_malloc hands back.  They are offsets using
 * the sizing that the Lance would use. The Lance space is
 * mapped somewhere in the I/O space, as indicated by the softc.
 * Hence we have these two macros:
 */
/* H & L are not hi and lo but
   H = HOST  == addresses for host to reference board memory
   L = LOCAL == addresses on board
 */
#define Hmem(lna)	(vm_offset_t)((se_sw->mapaddr)(lna) + sc->lnbuf)
#define Lmem(lna)	(vm_offset_t)((vm_offset_t)lna + sc->lnoffset)
#endif	/*FLAMINGO*/


/*
 * Map a lance-space offset into an host-space one
 */
private unsigned se_Hmem_nogap( vm_offset_t lna) { return lna;}
private unsigned se_Hmem_gap16( vm_offset_t lna) { return lna << 1;}

/*
 * Memory addresses for LANCE are 24 bits wide.
 */
#define Addr_lo(y)	((unsigned short)((vm_offset_t)(y) & 0xffff))
#define	Addr_hi(y)	((unsigned short)(((vm_offset_t)(y)>>16) & 0xff))

#define	LN_MEMORY_SIZE	(se_sw->ramsize)

/* XXX to accomodate heterogeneity this should be made per-drive */
/* XXX and then some more */

struct se_switch *se_sw = se_switch;

void set_se_switch(n)
{
	se_sw = &se_switch[n];
}

#ifndef LUNA88K
setse_switch(n, r, b, l, o)
	vm_offset_t	r, b, l, o;
	int		n;
{
	se_switch[n].regspace = r;
	se_switch[n].bufspace = b;
	se_switch[n].ln_bufspace = l;
	se_switch[n].romspace = o;

	/* make sure longword aligned */
	if (se_switch[n].bufspace & 0x7) {
		se_switch[n].bufspace = (se_switch[n].bufspace+0x7) & ~0x7;
	}

	set_se_switch(n);
}
#endif

/*
 * Autoconf info
 */


private vm_offset_t se_std[NLN] = { 0 };
private struct bus_device *se_info[NLN];
private int se_probe();
private void se_attach();

struct bus_driver se_driver =
       { se_probe, 0, se_attach, 0, se_std, "se", se_info, };

/*
 * Externally visible functions
 */
char	*se_unprobed_addr = 0;
void	se_intr();				/* kernel */

int	se_open(), se_output(), se_get_status(),	/* user */
	se_set_status(), se_setinput(), se_restart();

/*
 *
 * Internal functions & definitions
 *
 */


private	int se_probe();
private  void se_init();
private	void init_lance_space();
private  void se_desc_set_status();
private  volatile long *se_desc_alloc();	/* must be aligned! */
void	se_start();
private	void copy_from_lance();
private	int copy_to_lance();
#ifdef XKMACHKERNEL
static	int xkcopy_to_lance();
#endif XKMACHKERNEL

#ifndef RICHDEBUG
int se_verbose = 0;	/* debug flag */
#else
int se_verbose = 1;	/* debug flag */
#endif
int	xklanceAllUsers = 1;	/* allows non-xkernel users if true */


/* #define RLOG	4	*/	/* 2**4 = 16  receive descriptors */
/* It is better to RCV than to XMT. -- rcs */
#define RLOG	6		/* 2**6 = 64  receive descriptors */
#define TLOG	4		/* 2**4 = 16  transmit descriptors */
#define NRCV	(1<<RLOG) 	/* Receive descriptors */
#define NXMT	(1<<TLOG) 	/* Transmit descriptors	*/

/* #define	LN_BUFFER_SIZE	(0x800-0x80) */
#define	LN_BUFFER_SIZE	1550  /* lowered to permit 80 buffers -- rcs */

/*
 * Ethernet software status per interface.
 *
 * Each interface is referenced by a network interface structure,
 * is_if, which contains the output queue for the interface, its address, ...
 */
int se_loopback_hack = 1;  /* $$$$$ disables detection of transmitter errors! -rcs */

struct	se_softc {
	struct	ifnet	is_if;		/* generic interface header	*/
	unsigned char	is_addr[6];		/* ethernet hardware address	*/
	unsigned char	pad;
	se_reg_t		lnregs;		/* Lance registers	*/
	vm_offset_t		lnbuf;		/* Lance memory, Host offset */
	vm_offset_t		lnoffset;	/* Lance memory, Lance offset */
	vm_offset_t		lnrom;
	vm_offset_t		lnsbrk;		/* Lance memory allocator */
	vm_offset_t		lninit_block;	/* Init block address	*/
	se_desc_t		lnrring[NRCV];	/* Receive  ring desc. */
	volatile long 		*lnrbuf[NRCV];	/* Receive  buffers */
	se_desc_t		lntring[NXMT];	/* Transmit ring desc. */
	volatile long		*lntbuf[NXMT];	/* Transmit buffers */

	int	rcv_last;		/* Rcv buffer last read		*/

	io_req_t tpkt[NXMT+1];		/* Xmt pkt queue		*/
	int	xmt_count;		/* Xmt queue size		*/
	int	xmt_last;		/* Xmt queue head (insert)	*/
	int	xmt_complete;		/* Xmt queue tail (remove)	*/

	int	se_flags;		/* Flags for SIOCSIFFLAGS	*/
	int	counters[4];		/* error counters */
#define bablcnt  counters[0]
#define misscnt  counters[1]
#define merrcnt  counters[2]
#define rstrtcnt counters[3]
} se_softc_data[NLN];

se_softc_t	se_softc[NLN];		/* quick access */


#ifdef __STDC__

se_read_mach( se_softc_t, struct ether_header *, char *, int, u_short );

#endif

/*
 * Probe the Lance to see if it's there
 */
private int se_open_state = 0;

private se_probe(reg, ui)
	vm_offset_t reg;
	register struct bus_device *ui;
{
	register se_softc_t sc;
	se_reg_t        rdp, rap;
	int             unit = ui->unit;

	/*
	 * See if the interface is there by reading the lance CSR.  On pmaxen
	 * and 3maxen this is superfluous, but.. 
	 */
	rdp = (se_reg_t) (reg + se_sw->regspace);
#ifdef	DECSTATION
	if (check_memory(rdp, 0))
		return 0;
#endif	/*DECSTATION*/
#ifdef	MAPPED
	SE_probe(reg,ui);
#endif	/*MAPPED*/
	rap = rdp + 2;		/* XXX might not be true in the future XXX */
				/* rdp and rap are "shorts" on consecutive
				   "long" word boundaries */

	/*
	 * Bind this interface to the softc. 
	 */
	sc = &se_softc_data[unit];
	se_softc[unit] = sc;
	sc->lnregs	= (se_reg_t) (reg + se_sw->regspace);
	sc->lnbuf	= (vm_offset_t) (reg + se_sw->bufspace);
	sc->lnoffset	= (vm_offset_t) (se_sw->ln_bufspace);
	sc->lnrom	= (vm_offset_t) (reg + se_sw->romspace);

	/*
	 * Reset the interface, and make sure we really do it! (the 3max
	 * seems quite stubborn about these registers) 
	 */
	se_write_reg(rap, CSR0_SELECT, CSR0_SELECT, "RAP");
	se_write_reg(rdp, LN_CSR0_STOP, LN_CSR0_STOP, "csr0");

	/*
	 * Allocate lance RAM buffer memory 
	 */
	init_lance_space(sc);

	/*
	 * Initialize the chip
	 *
	 * NOTE: From now on we will only touch csr0
	 */
	if (se_ship_init_block(sc, unit))
		return 0;

	/*
	 * Tell the world we are alive and well 
	 */
	se_open_state++;
	return 1;
}

int se_ship_init_block(sc, unit)
	register se_softc_t sc;
	int		unit;
{
	se_reg_t	rdp = sc->lnregs;
	se_reg_t	rap;
	register int    i = 0;

	rap = rdp + 2;		/* XXX might not be true in the future XXX */

	/*
	 * Load LANCE control block. 
	 */
	se_write_reg(rap, CSR1_SELECT, CSR1_SELECT, "RAP");
	se_write_reg(rdp, Addr_lo(Lmem(sc->lninit_block)),
		     Addr_lo(Lmem(sc->lninit_block)), "csr1");

	se_write_reg(rap, CSR2_SELECT, CSR2_SELECT, "RAP");
	se_write_reg(rdp, Addr_hi(Lmem(sc->lninit_block)),
		     Addr_hi(Lmem(sc->lninit_block)), "csr2");

	/*
	 * Start the INIT sequence now
	 */
	se_write_reg(rap, CSR0_SELECT, CSR0_SELECT, "RAP");
	*rdp = (LN_CSR0_IDON | LN_CSR0_INIT);
	wbflush();

	/* give it plenty of time to settle */
	while (i++ < 10000) {
		delay(100);
		if ((*rdp & LN_CSR0_IDON) != 0)
			break;
	}
	/* make sure got out okay */
	if ((*rdp & LN_CSR0_IDON) == 0) {
		printf("se%d: cannot initialize\n", unit);
		if (*rdp & LN_CSR0_ERR)
			printf("se%d: initialization error, csr = %04x\n",
			       unit, (*rdp & 0xffff));
		return 1;
	}
	/*
	 * Do not enable interrupts just yet. 
	 */
/* this was commented out in MK74 version; reasonable to do it here too -rcs */
/*	se_write_reg(rdp, LN_CSR0_STOP, LN_CSR0_STOP, "csr0"); */

	return 0;
}
 
void se_write_reg(regptr, val, result, regname)
     register se_reg_t	regptr;
	register int	val;
	register int	result;
	char		*regname;
{
	register int    i = 0;

	while ((unsigned short)(*regptr) != (unsigned short)result) {
		*regptr = (se_reg_type)val;
		wbflush();
		if (++i > 10000) {
			printf("se: %s did not settle (to x%x): x%x\n",
			       regname, result, (unsigned short)(*regptr));
			return;
		}
		delay(100);
	}
}

private void
init_lance_space(sc)
	register se_softc_t sc;
{
	register int   	lptr;			/* Generic lance pointer */
	se_desc_t	ringaddr;
	long           *rom_eaddress = (long *) sc->lnrom;
	int             i;
	struct se_init_block	init_block;

	/*
	 * Allocate local RAM buffer memory for the init block,
	 * fill in our local copy then copyout.
	 */

	sc->lninit_block = se_malloc(sc, sizeof (struct se_init_block));

	/*
	 * Set values on stack, then copyout en-masse
	 */
	bzero(&init_block, sizeof(init_block));
	init_block.mode = 0;
	init_block.phys_addr_low = ((rom_eaddress[0]>>se_sw->romstride)&0xff) |
			      (((rom_eaddress[1]>>se_sw->romstride)&0xff) << 8);
	init_block.phys_addr_med = ((rom_eaddress[2]>>se_sw->romstride)&0xff) |
			      (((rom_eaddress[3]>>se_sw->romstride)&0xff) << 8);
	init_block.phys_addr_high = ((rom_eaddress[4]>>se_sw->romstride)&0xff) |
			      (((rom_eaddress[5]>>se_sw->romstride)&0xff) << 8);

	/*
	 * Allocate both descriptor rings at once.
	 * Note that the quadword alignment requirement is
	 * inherent in the way we perform allocation,
	 * but it does depend on the size of the init block.
	 */
	lptr = se_malloc(sc, sizeof (struct se_desc) * (NXMT + NRCV));

	/*
	 * Initialize the buffer descriptors
	 */
	init_block.recv_ring_pointer_lo = Addr_lo(Lmem(lptr));
	init_block.recv_ring_pointer_hi = Addr_hi(Lmem(lptr));
	init_block.recv_ring_len = RLOG;

	for ( i = 0; i < NRCV ; i++, lptr += sizeof(struct se_desc)) {
		ringaddr = (se_desc_t)Hmem(lptr);
		sc->lnrring[i] = ringaddr;
		sc->lnrbuf[i] = se_desc_alloc (sc, ringaddr);
	}

	init_block.xmit_ring_pointer_lo = Addr_lo(Lmem(lptr));
	init_block.xmit_ring_pointer_hi = Addr_hi(Lmem(lptr));
	init_block.xmit_ring_len = TLOG;

	for ( i = 0 ; i < NXMT ; i++, lptr += sizeof(struct se_desc)) {
		ringaddr = (se_desc_t)Hmem(lptr);
		sc->lntring[i] = ringaddr;
		sc->lntbuf[i] = se_desc_alloc (sc, ringaddr);
	}

	/*
	 * No logical address filtering
	 */
	init_block.logical_addr_filter0 = 0;
	init_block.logical_addr_filter1 = 0;
	init_block.logical_addr_filter2 = 0;
	init_block.logical_addr_filter3 = 0;

	/*
	 * Move init block into lance space
	 */
	(se_sw->desc_copyout)((vm_offset_t)&init_block, Hmem(sc->lninit_block), sizeof(init_block));
	wbflush();
}

/*
 * Interface exists: make available by filling in network interface
 * record.  System will initialize the interface when it is ready
 * to accept packets.
 */
private void
se_attach(ui)
	register struct bus_device *ui;
{
	unsigned char         *enaddr;
	struct ifnet   *ifp;
	long           *rom_eaddress;
	int             unit = ui->unit;
	se_softc_t	sc = se_softc[unit];

	rom_eaddress = (long *) sc->lnrom;

	/*
	 * Read the address from the prom and save it. 
	 */
	enaddr = sc->is_addr;
	enaddr[0] = (unsigned char) ((rom_eaddress[0] >> se_sw->romstride) & 0xff);
	enaddr[1] = (unsigned char) ((rom_eaddress[1] >> se_sw->romstride) & 0xff);
	enaddr[2] = (unsigned char) ((rom_eaddress[2] >> se_sw->romstride) & 0xff);
	enaddr[3] = (unsigned char) ((rom_eaddress[3] >> se_sw->romstride) & 0xff);
	enaddr[4] = (unsigned char) ((rom_eaddress[4] >> se_sw->romstride) & 0xff);
	enaddr[5] = (unsigned char) ((rom_eaddress[5] >> se_sw->romstride) & 0xff);

	printf(": %x-%x-%x-%x-%x-%x",
	       (rom_eaddress[0] >> se_sw->romstride) & 0xff,
	       (rom_eaddress[1] >> se_sw->romstride) & 0xff,
	       (rom_eaddress[2] >> se_sw->romstride) & 0xff,
	       (rom_eaddress[3] >> se_sw->romstride) & 0xff,
	       (rom_eaddress[4] >> se_sw->romstride) & 0xff,
	       (rom_eaddress[5] >> se_sw->romstride) & 0xff);

	/*
	 * Initialize the standard interface descriptor 
	 */
	ifp = &sc->is_if;
	ifp->if_unit = unit;
	ifp->if_header_size = sizeof(struct ether_header);
	ifp->if_header_format = HDR_ETHERNET;
	ifp->if_address_size = 6;
	ifp->if_mtu = ETHERMTU;
	ifp->if_flags |= IFF_BROADCAST;

	ifp->if_address = (char *) enaddr;

	if_init_queues(ifp);
#ifdef	MAPPED
	SE_attach(ui);
#endif	/*MAPPED*/

}

/*
 * Use a different hardware address for interface
 */
void
se_setaddr(eaddr, unit)
	unsigned char	eaddr[6];
{
	register se_softc_t sc = se_softc[unit];
	struct se_init_block	init_block;

	/*
	 * Modify initialization block accordingly
	 */
	(se_sw->desc_copyin) (Hmem(sc->lninit_block), (vm_offset_t)&init_block, sizeof(init_block));
	bcopy(eaddr, &init_block.phys_addr_low, sizeof(*eaddr));
	(se_sw->desc_copyout)((vm_offset_t)&init_block, Hmem(sc->lninit_block), sizeof(init_block));
	/*
	 * Make a note of it
	 */
	bcopy(eaddr, sc->is_addr, sizeof(*eaddr));

	/*
	 * Restart the interface
	 */
	se_restart(&sc->is_if);
	se_init(unit);
}

/*
 * Restart interface
 *
 * We use this internally on those errors that hang the chip,
 * not sure yet what use the MI code will make of it.
 *
 * After stopping the chip and effectively turning off the interface
 * we release all pending buffers and cause the chip to init
 * itself.  We do not enable interrupts here.
 */
int
se_restart( ifp )
	register struct ifnet *ifp;
{
	register se_softc_t sc = se_softc[ifp->if_unit];
	se_reg_t        rdp;
	register int    i;

	rdp = sc->lnregs;

	/*
	 * stop the chip 
	 */
	se_write_reg(rdp, LN_CSR0_STOP, LN_CSR0_STOP, "csr0");

	/*
	 * stop network activity 
	 */
	if (ifp->if_flags & IFF_RUNNING) {
		ifp->if_flags &= ~(IFF_UP | IFF_RUNNING);
		sc->se_flags &= ~(IFF_UP | IFF_RUNNING);
	}
	sc->rstrtcnt++;

	if (se_verbose)
		printf("se%d: %d restarts\n", ifp->if_unit, sc->rstrtcnt);

	/*
	 * free up any buffers currently in use 
	 */
	for (i = 0; i < NXMT; i++)
		if (sc->tpkt[i]) {
			iodone(sc->tpkt[i]);
			sc->tpkt[i] = (io_req_t) 0;
		}
	/*
	 * INIT the chip again, no need to reload init block address. 
	 */
	se_ship_init_block(sc, ifp->if_unit);

	return (0);
}

/*
 * Initialize the interface.
 */
private void
se_init(unit)
	int unit;
{
	register se_softc_t	 sc = se_softc[unit];
	register se_desc_t	*rp;
	register struct ifnet	*ifp = &sc->is_if;
	se_reg_t        rdp;
	short           mode;
	spl_t           s;
	int             i;

	if (ifp->if_flags & IFF_RUNNING)
		return;

	rdp = sc->lnregs;

	/*
	 * Init the buffer descriptors and indexes for each of the rings. 
	 */
	for (i = 0, rp = sc->lnrring; i < NRCV; i++, rp++)
		se_desc_set_status(*rp, LN_RSTATE_OWN);

	for (i = 0, rp = sc->lntring; i < NXMT; i++, rp++)
		se_desc_set_status(*rp, 0);

	sc->xmt_count = sc->xmt_complete = sc->xmt_last = sc->rcv_last = 0;

	/*
	 * Deal with loopback mode operation 
	 */
	s = splimp();

	(se_sw->desc_copyin) (Hmem(sc->lninit_block), (vm_offset_t)&mode, sizeof(mode));

	if (ifp->if_flags & IFF_LOOPBACK
	    && ((mode & LN_MODE_LOOP) == 0)) {
		/* if not already in loopback mode, do external loopback */
		mode &= ~LN_MODE_INTL;
		mode |= LN_MODE_LOOP;
		(se_sw->desc_copyout) ((vm_offset_t)&mode, Hmem(sc->lninit_block), sizeof(mode));
		se_restart(ifp);
		se_init(ifp->if_unit);
		splx(s);
		return;
	}

	ifp->if_flags |= (IFF_UP | IFF_RUNNING);
	sc->se_flags |= (IFF_UP | IFF_RUNNING);

	/*
	 * Start the Lance and enable interrupts 
	 */
	*rdp = (LN_CSR0_STRT | LN_CSR0_INEA);
	wbflush();

	/*
	 * See if anything is already queued 
	 */
	se_start(unit);
	splx(s);
}


/*
 * Shut off the lance
 */
void
se_stop(unit)
{
	se_reg_t        rdp = se_softc[unit]->lnregs;

	se_write_reg(rdp, LN_CSR0_STOP, LN_CSR0_STOP, "csr0");
}


/*
 * Open the device, declaring the interface up
 * and enabling lance interrupts.
 */
/* $$$$$ called twice in the XK Kernel version; appears harmless -- rcs */
/*ARGSUSED*/
int
se_open(unit, flag)
	int	unit;
	int	flag;
{
	register se_softc_t	sc = se_softc[unit];

#ifdef RICHDEBUG
/*$$$$ hack code */
/* turn it off for now -- rcs
printf("open lance unit%d NLN%d XKNEWMACHKERNEL%d XKMACHKERNEL%d MAPPED%d DECSTATION%d\n",
       unit, NLN,
#ifdef XKNEWMACHKERNEL
1
#else
0
#endif
,
#ifdef XKMACHKERNEL
1
#else
0
#endif
,
#ifdef MAPPED
1
#else
0
#endif
,
#ifdef DECSTATION
1
#else
0
#endif
);
printf("LN_CSR0_ERR %x  LN_CSR0_MISS %x  LN_RSTATE_OWN %x  LN_CSR0_STOP %x\n\
LN_CSR0_BABL %x  LN_CSR0_MERR %x  LN_CSR0_RXON %x  LN_CSR0_TXON %x\n\
LN_CSR0_INEA %x  LN_CSR0_WTC %x  LN_CSR0_RINT %x  LN_CSR0_TINT %x\n\
LN_TSTATE_OWN %x  LN_TSTATE_DEF %x  LN_TSTATE_ONE %x  LN_TSTATE_MORE %x\n\
LN_TSTATE_STP %x  LN_TSTATE_ENP %x\n\
LN_TSTATE_ERR %x  LN_TSTATE2_RTRY %x  LN_TSTATE2_LCOL %x  LN_TSTATE2_DISABLE %x\n\
LN_RSTATE_OWN %x  LN_RSTATE_STP %x  LN_RSTATE_ERR %x  LN_RSTATE_ENP %x\n\
LN_CSR0_TDMD %x  LN_CSR0_STRT %x  LN_MINBUF_NOCH %d  ETHERMTU %d  IF_CNTRS%d\n",
LN_CSR0_ERR ,  LN_CSR0_MISS ,  LN_RSTATE_OWN ,  LN_CSR0_STOP ,
LN_CSR0_BABL ,  LN_CSR0_MERR ,  LN_CSR0_RXON ,  LN_CSR0_TXON ,
LN_CSR0_INEA ,  LN_CSR0_WTC ,  LN_CSR0_RINT ,  LN_CSR0_TINT ,
LN_TSTATE_OWN ,  LN_TSTATE_DEF ,  LN_TSTATE_ONE ,  LN_TSTATE_MORE ,
LN_TSTATE_STP ,  LN_TSTATE_ENP ,
LN_TSTATE_ERR ,  LN_TSTATE2_RTRY ,  LN_TSTATE2_LCOL ,  LN_TSTATE2_DISABLE ,
LN_RSTATE_OWN ,  LN_RSTATE_STP ,  LN_RSTATE_ERR ,  LN_RSTATE_ENP ,
LN_CSR0_TDMD ,  LN_CSR0_STRT ,  LN_MINBUF_NOCH ,  ETHERMTU ,
#ifdef IF_CNTRS
1
#else
0
#endif
);
 printf("se_open: LN_BUFFER_SIZE %d  LN_MEMORY_SIZE %d  NRCV %d  NXMT %d\n",
 LN_BUFFER_SIZE,  LN_MEMORY_SIZE,  NRCV,  NXMT);
end of printfs */
#endif  /* RICHDEBUG */

	if (unit >= NLN)
		return EINVAL;
	if (!se_open_state)
		return ENXIO;

	sc->is_if.if_flags |= IFF_UP;
	se_open_state++;
	se_init(unit);
	return (0);
}

#ifdef	MAPPED
int se_use_mapped_interface[NLN];
#endif	/*MAPPED*/

void
se_normal(unit)
{
#ifdef RICHDEBUG
	printf("se_normal called: unit %d\n", unit);
#endif
#ifdef	MAPPED
	se_use_mapped_interface[unit] = 0;
#endif	/*MAPPED*/
	if (se_softc[unit]) {
		se_restart((struct ifnet *)se_softc[unit]);
		se_init(unit);
	}
}

/*
 * Ethernet interface interrupt routine
 */
void
se_intr(unit,spllevel)
	int	unit;
	spl_t	spllevel;
{
	register se_softc_t	 sc = se_softc[unit];
	se_reg_t 		 rdp;
	register struct ifnet	*ifp = &sc->is_if;
	register unsigned short	 csr;

#ifdef	MAPPED
	if (se_use_mapped_interface[unit])
	{
#ifdef RICHDEBUG
		printf("oops! using mapped interface!\n");
#endif  /* RICHDEBUG, within MAPPED */
		SE_intr(unit,spllevel);
		return;
	}
#endif	/*MAPPED*/

/* $$$$$ why is 2 the right value here? */
	if (se_open_state < 2) { /* Stray, or not open for business */
		rdp = (sc ? sc->lnregs : (se_reg_t)se_unprobed_addr);
		*rdp |= LN_CSR0_STOP;
		wbflush();
		return;
	}
	rdp = sc->lnregs;

	/*
	 * Read the CSR and process any error condition.
	 * Later on, restart the lance by writing back
	 * the CSR (for set-to-clear bits).
	 */
	csr = *rdp;		/* pick up the csr */
#ifdef RICHDEBUG
	printf("se_intr:  csr %x\n", csr);
#endif /* RICHDEBUG */

	/* drop spurious interrupts */
	if ((csr & LN_CSR0_INTR) == 0)
		return;
#ifdef	DECSTATION
	splx(spllevel);	/* drop priority now */
#endif	/*DECSTATION*/
again:
	/*
	 * Check for errors first
	 */
	if ( csr & LN_CSR0_ERR ) {
		if (csr & LN_CSR0_MISS) {
			/*
			 * Stop the chip to prevent a corrupt packet from
			 * being transmitted.  There is a known problem with
			 * missed packet errors causing corrupted data to
			 * be transmitted to the same host as was just
			 * transmitted, with a valid crc appended to the
			 * packet.  The only solution is to stop the chip,
			 * which will clear the Lance silo, thus preventing
			 * the corrupt data from being sent.
			 */
			se_write_reg(rdp, LN_CSR0_STOP, LN_CSR0_STOP, "csr0");

			sc->misscnt++;
			if (se_verbose) {
				int me = 0, lance = 0, index;
				struct se_desc r;
				for (index = 0; index < NRCV; index++) {
					(se_sw->desc_copyin)(
					    (vm_offset_t)sc->lnrring[index],
					    (vm_offset_t)&r,
					    sizeof(r));
					if (r.status & LN_RSTATE_OWN)
						lance++;
					else
						me++;
				}
				printf("se%d: missed packet (%d) csr = %x, Lance %x, me %x\n",
					unit, sc->misscnt, csr, lance, me);
			}
			se_restart(ifp);
			se_init(unit);
			return;
		}
		if (csr & LN_CSR0_BABL) {
			sc->bablcnt++;
			if (se_verbose)
			    printf("se%d: xmt timeout (%d)\n",
			    	   unit, sc->bablcnt);
		}
		if (csr & LN_CSR0_MERR) {
			sc->merrcnt++;
			printf("se%d: memory error (%d)\n",
				   unit, sc->merrcnt);

			if (((csr & LN_CSR0_RXON) == 0)
			    || ((csr & LN_CSR0_TXON) == 0)) {
				se_restart(ifp);
				se_init(unit);
				return;
			}
		}
	}

	*rdp = LN_CSR0_INEA | (csr & LN_CSR0_WTC);
	wbflush();

	if ( csr & LN_CSR0_RINT )
		se_rint( unit );

	if ( csr & LN_CSR0_TINT )
		se_tint( unit );

	if ((csr = *rdp) & (LN_CSR0_RINT | LN_CSR0_TINT)) {
#ifdef RICHDEBUG
		printf("se_intr: going again; csr %x\n", csr);
#endif /* RICHDEBUG */
		goto again; };
}
 
/*
 * Handle a transmitter complete interrupt.
 */
void
se_tint(unit)
	int unit;
{
	register se_softc_t sc = se_softc[unit];
	register        index;
	register        status;
	io_req_t        request;
	struct se_desc  r;

#ifdef RICHDEBUG
	printf("se_tint unit %d\n", unit);
#endif /* RICHDEBUG */

	/*
	 * Free up descriptors for all packets in queue for which
	 * transmission is complete.  Start from queue tail, stop at first
	 * descriptor we do not OWN, or which is in an inconsistent state
	 * (lance still working). 
	 */

	while ((sc->xmt_complete != sc->xmt_last) && (sc->xmt_count > 0)) {

		index = sc->xmt_complete;
		(se_sw->desc_copyin) ((vm_offset_t)sc->lntring[index],
				      (vm_offset_t)&r, sizeof(r));
		status = r.status;

		/*
		 * Does lance still own it ? 
		 */
		if (status & LN_TSTATE_OWN)
			break;

		/*
		 * Packet sent allright, release queue slot.
		 */
		request = sc->tpkt[index];
		sc->tpkt[index] = (io_req_t) 0;
		sc->xmt_complete = ++index & (NXMT - 1);
		--sc->xmt_count;

		sc->is_if.if_opackets++;
		if (status & (LN_TSTATE_DEF|LN_TSTATE_ONE|LN_TSTATE_MORE))
			sc->is_if.if_collisions++;

		/*
		 * Check for transmission errors. 
		 */
		if (!se_loopback_hack && status & LN_TSTATE_ERR) {
			sc->is_if.if_oerrors++;
			if (se_verbose)
				printf("se%d: xmt error (x%x)\n", unit, r.status2);

			if (r.status2 & (LN_TSTATE2_RTRY|LN_TSTATE2_LCOL))
				sc->is_if.if_collisions++;

			/*
			 * Restart chip on errors that disable the
			 * transmitter. 
			 */
			iodone(request);
			if (r.status2 & LN_TSTATE2_DISABLE) {
				register struct ifnet *ifp = &sc->is_if;
				se_restart(ifp);
				se_init(ifp->if_unit);
				return;
			}
		} else if (request) {
			/*
			 * If this was a broadcast packet loop it back.
			 * Signal successful transmission of the packet. 
			 */
			register struct ether_header *eh;
			register int    i;

			eh = (struct ether_header *) request->io_data;
			/* ether broadcast address is in the spec */
			for (i = 0; (i < 6) && (eh->ether_dhost[i] == 0xff); i++)
				; /* nop */
			/* sending to ourselves makes sense sometimes */
			if (i != 6 && se_loopback_hack)
				for (i = 0;
				     (i < 6) && (eh->ether_dhost[i] == sc->is_addr[i]);
				     i++)
				; /* nop */
			if (i == 6)
				se_read(sc, 0, request->io_count, request);
			iodone(request);
		}
	}
	/*
	 * Dequeue next transmit request, if any. 
	 */
	/* If lance is working on last packet, give it more to chew on. */
	/* xmt_count is the number of outstanding packets in lance xmt ring. */
	if (sc->xmt_count <= 1)   /* Was 0! -- rcs */
		se_start(unit);
}

/* $$$$$ Possible good hack:  Use lance buffers that are half or less of the max
packet size, maybe 775.  This would let the lance absorb more small packets,
which are a good bit of the traffic.  The cost is wasted descriptor space
(not aproblem) + a bit of software complexity + perhaps, multiple interrupts?
Same idea might apply to transmissions.  Maybe the "right" thing is to
subdivide buffer space as finely as possible, up to 256 or whatever the ring
size is.  In principle, I could even rewire the ring & buffer allocations
on the fly, using only the required buffer space.  The benefit of all this
hacking would be tolerance to longer bursts of small packets, with not
much penalty for the big guys.  */
 
/*
 * Handle a receiver complete interrupt.
 */
void
se_rint(unit)
	int unit;
{
	register se_softc_t	sc = se_softc[unit];
	register        index, first, len;
	unsigned char          status, status1;
	int             ring_cnt;
	struct se_desc  r;

#ifdef XKLANCE_NORECEIVE
	return;
#endif

#ifdef RICHDEBUG
	printf("se_rint unit %d\n", unit);
#endif /* RICHDEBUG */

	/*
	 * Starting from where we left off, look around the receive ring and
	 * pass on all complete packets. 
	 */

	for (;; sc->rcv_last = ++index & (NRCV - 1)) {

		/*
		 * Read in current descriptor 
		 */
read_descriptor:
		(se_sw->desc_copyin) ((vm_offset_t)sc->lnrring[sc->rcv_last],
				      (vm_offset_t)&r, sizeof(r));
		status = r.status;
		if (status & LN_RSTATE_OWN)
			break;
		first = index = sc->rcv_last;

		/*
		 * If not the start of a packet, error 
		 */
		if (!(status & LN_RSTATE_STP)) {
			if (se_verbose)
				printf("se%d: Rring #%d, status=%x !STP\n",
				       unit, index, status);
			break;
		}
		/*
		 * See if packet is chained (should not) by looking at
		 * the last descriptor (OWN clear and ENP set).
		 * Remember the status info in this last descriptor. 
		 */
		ring_cnt = 1, status1 = status;
		while (((status1 & (LN_RSTATE_ERR | LN_RSTATE_OWN | LN_RSTATE_ENP)) == 0) &&
		       (ring_cnt++ <= NRCV)) {
			struct se_desc  r1;
			index = (index + 1) & (NRCV - 1);
			(se_sw->desc_copyin) ((vm_offset_t)sc->lnrring[index],
					      (vm_offset_t)&r1, sizeof(r1));
			status1 = r1.status;
		}

		/*
		 * Chained packet (--> illegally sized!); re-init the
		 * descriptors involved and ignore this bogus packet.  I
		 * donno how, but it really happens that we get these
		 * monsters. 
		 */
		if (ring_cnt > 1) {
			/*
			 * Return all descriptors to lance 
			 */
			se_desc_set_status(sc->lnrring[first], LN_RSTATE_OWN);
			while (first != index) {
				first = (first + 1) & (NRCV - 1);
				se_desc_set_status(sc->lnrring[first], LN_RSTATE_OWN);
			}
			if ((status1 & LN_RSTATE_ERR) && se_verbose)
				printf("se%d: rcv error %x (chained)\n", unit, status1);
			continue;
		}

		/*
		 * Good packets must be owned by us and have the end of
		 * packet flag.  And nothing else. 
		 */
		if ((status & ~LN_RSTATE_STP) == LN_RSTATE_ENP) {
			sc->is_if.if_ipackets++;

			if ((len = r.message_size) == 0)
				/* race seen on pmaxen: the lance
				 * has not updated the size yet ??
				 */
/* $$$$$ this is bogus: the driver makes no effort to set the size to 0, and
   there's no reason for the lance to initialize it to 0 when starting to
   read the packet.  Maybe add code to zero the packet length? -- RS July92
   Things are more complicated: desc4.bits is 0d by desc_set_status.  Need
   to investigate further. */
				goto read_descriptor;
/*
#ifdef	IF_CNTRS
/* $$$$$ code to increment these for outgoing packets is missing -- RS
   as is code to print out most of the trouble information
   I found some increment code. 
			se_ein[log_2(len)]++;
			if (len < 128)
				se_lin[len >> 3]++;
#endif	IF_CNTRS
*/
			/*
			 * Drop trailing CRC bytes from len and ship packet
			 * up, minus the checksum.
			 */
			se_read(sc, (volatile char*)sc->lnrbuf[first], len-4,0);

			/*
			 * Return descriptor to lance, and move on to next
			 * packet 
			 */
			r.status = LN_RSTATE_OWN;
			(se_sw->desc_copyout) ((vm_offset_t)&r,
					      (vm_offset_t)sc->lnrring[first],
					      sizeof(r));
			continue;
		}
		/*
		 * Not a good packet, see what is wrong 
		 */
		if (status & LN_RSTATE_ERR) {
			sc->is_if.if_ierrors++;

			if (se_verbose)
				printf("se%d: rcv error (x%x)\n", unit, status);

			/*
			 * Return descriptor to lance 
			 */
			se_desc_set_status(sc->lnrring[first], LN_RSTATE_OWN);
		} else {
			/*
			 * Race condition viz lance, Wait for the next
			 * interrupt. 
			 */
			return;
		}
	}
}

/*
 * Output routine.
 * Call common function for wiring memory,
 * come back later (to se_start) to get
 * things going.
 */
io_return_t
se_output(dev, ior)
	int		dev;
	io_req_t	ior;
{
#ifdef XK_DEBUG
	static int	outCount = 0;

	outCount++;
	xTrace1(xklancep, TR_EVENTS, "se_output (%d)", outCount);
#endif
#if defined ALLOW_NON_XK_USERS || ! defined XKMACHKERNEL
#ifdef XKMACHKERNEL
	xTrace1(xklancep, TR_MORE_EVENTS, "se_output: ior data pointer is %x", ior->io_data);
#endif
	return (net_write(&se_softc[dev]->is_if, (int(*)())se_start, ior));
#else
	xTrace0(xklancep, TR_SOFT_ERRORS, "se_output (disabled) called");
	return D_DEVICE_DOWN;
#endif ALLOW_NON_XK_USERS
}

/* #define XKOUTTIMER */
#ifdef XKOUTTIMER
long xkouttime_start, xkouttime_count, xkouttime_i, xkouttimes[],
	    loops_per_wait_avg;
XTime *xkouttime_end, *xkouttime_begin, *xkouttime_deltat;
void subtime();
#endif /* XKOUTTIMER */

/*
 * Start output on interface.
 *
 */
void
se_start(unit)
	int	unit;
{
	register se_softc_t sc = se_softc[unit];
	io_req_t        request;
	struct se_desc  r;
	int             tlen;
	spl_t		s;
	register int    index;
	int qed;

	s = splimp();

#ifdef RICHDEBUG
	printf("se_start unit %d  xmt_count %d\n", unit, sc->xmt_count);
#endif /* RICHDEBUG */

	for (index = sc->xmt_last;
	     sc->xmt_count < (NXMT - 1);
	     sc->xmt_last = index = (index + 1) & (NXMT - 1)) {
		/*
		 * Dequeue the next transmit request, if any. 
		 */
		IF_DEQUEUE(&sc->is_if.if_snd, request);
		if (request == 0) {
/* HASNAIN: ADDED */
			/*
			 * Tell the lance to send the packet now
			 * instead of waiting until the next 1.6 ms
			 * poll interval expires.
			 */
			*sc->lnregs = LN_CSR0_TDMD | LN_CSR0_INEA;
/* ***** */

			/* splx(s); */
			/* return; */	/* Nothing on the queue	 */
		  break;  /* fix lazy transmit strategy; make it eager -- rcs */
		}

		/*
		 * Keep request around until transmission complete
		 */
		sc->tpkt[index] = request;
		/*
		 * Pass the message to the correct routine
		 */
#ifdef ALLOW_NON_XK_USERS
		if ( request->io_op & IO_IS_XK_MSG ) {
		    tlen =  xkcopy_to_lance(request, sc->lntbuf[index]);
		} else {
		    tlen =  copy_to_lance(request, sc->lntbuf[index]);
		}
#else ALLOW_NON_XK_USERS
#ifdef XKMACHKERNEL
		tlen =  xkcopy_to_lance(request, sc->lntbuf[index]);
#else
		tlen =  copy_to_lance(request, sc->lntbuf[index]);
#endif XKMACHKERNEL
#endif ALLOW_NON_XK_USERS

#ifdef XKOUTTIMER
		if (xkouttime_start)
		{ xkouttime_count = wait_for_tick();
		  xGetTime(xkouttime_end);
		  subtime(xkouttime_begin,xkouttime_end,xkouttime_deltat);
		  xkouttimes[xkouttime_i] = 1000000 * xkouttime_deltat->sec + xkouttime_deltat->usec
		    - (xkouttime_count * 15625) / loops_per_wait_avg;
		  xkouttime_start = 0; };
#endif XKOUTTIMER

		/*
		 * Give away buffer.  Must copyin/out, set len,
		 * and set the OWN flag.  We do not do chaining.
		 */
		(se_sw->desc_copyin)(sc->lntring[index], &r, sizeof(r));
		r.buffer_size = -(tlen) | 0xf000;
		r.status = (LN_TSTATE_OWN | LN_TSTATE_STP | LN_TSTATE_ENP);
		(se_sw->desc_copyout)((vm_offset_t)&r,
				      (vm_offset_t)sc->lntring[index],
				      sizeof(r));
		wbflush();

		sc->xmt_count++;
/* HASNAIN: DELETED
                qed++;
/* ****** */
	}
	/*
	 * Since we actually have queued new packets, tell
	 * the chip to rescan the descriptors _now_.
	 * It is quite unlikely that the ring be filled,
	 * but if it is .. the more reason to do it!
	 */
	/* make that "If we have queued any new packets ..." -- rcs */
	if (qed) *sc->lnregs = LN_CSR0_TDMD | LN_CSR0_INEA;

#ifdef RICHDEBUG
	printf("exiting se_start unit %d  xmt_count %d\n", unit, sc->xmt_count);
#endif /* RICHDEBUG */

	splx(s);
}


/*
 * Pull a packet off the interface and
 * hand it up to the higher levels.
 *
 * Simulate broadcast packets in software.
 */
 /* $$$$$ keeping loopback code here, since we'll have to make it work someday -- rcs */
se_read_mach( sc, inHdr, inData, len, ethType )  /* ,loop_back */
    	register se_softc_t	 sc;
    	struct ether_header	*inHdr;
    	char			*inData;
    	int			len;
    	u_short			ethType;
/*	io_req_t		 loop_back; */
{
	register struct ifnet *ifp = &sc->is_if;
	register ipc_kmsg_t	new_kmsg;
	char			*addr, *hdr, *pkt;

#ifdef XKMACHKERNEL
	xTrace0(xklancep, TR_MORE_EVENTS, "se_read_mach called");
#endif

	if (len <= sizeof(struct ether_header))
/* $$$$$ technically, a bug.  ether_header can have padding, depending on the compiler;
   the test should be <=14 or some ethernet defined constant -- rcs */
		return;	/* sanity */

	/*
	 * Get a new kmsg to put data into.
	 */
	new_kmsg = net_kmsg_get();
	if (new_kmsg == IKM_NULL) {
	    /*
	     * No room, drop the packet
	     */
	    ifp->if_rcvdrops++;
	    return;
	}

	hdr = net_kmsg(new_kmsg)->header;
	pkt = net_kmsg(new_kmsg)->packet;

#define OFF0 (sizeof(struct ether_header) - sizeof(struct packet_header))
	/* 
	 * len is the size of the ethernet packet (with header)
	 */
/* #define OFF1 (OFF0 & ~3)
	if (loop_back) {
		bcopy(loop_back->io_data, hdr, sizeof(struct ether_header));
		bcopy(loop_back->io_data + OFF0,
			pkt, len - OFF0);
	} else
		copy_from_lance(lnrbuf, len, hdr, pkt, FALSE);
*/
	bcopy(inHdr, hdr, sizeof(struct ether_header));
	/* 
	 * Copy in real data after the 'packet header' (note, this is
	 * not an ether header) 
	 */
	bcopy(inData, pkt + sizeof(struct packet_header), len - sizeof(struct ether_header));

	/*
	 * Set up the 'fake' header.  Length in the packet_header
	 * field includes the packet_header itself.
	 */
	len -= OFF0;
	((struct packet_header *)pkt)->type = ethType;
	((struct packet_header *)pkt)->length = len;

	/*
	 * Hand the packet to the network module.
	 */
#ifdef XKMACHKERNEL
	xTrace0(xklancep, TR_MORE_EVENTS, "se_read up");
#endif
	net_packet(ifp, new_kmsg, len, ethernet_priority(new_kmsg));
}


#ifdef XKMACHKERNEL

/*
 *    Support for generic xkernel operations
 *     The openenable interface allows the driver 
 *     get the address of the higher level protocol to which it interfaces
 */

XObj self_protocol[NLN];

xkern_return_t
xklance_openenable(self, hlp, hlptype, part)
     XObj self, hlp, hlptype;
     Part part;
{ int index;
  index = self->instName[strlen(self->instName)-1]-'0';
  if (index <0 || index > NLN-1 ) {
    xTrace0(xklancep, TR_ERRORS, "Interface name cannot be translated to interface index");
    return XK_FAILURE;
  }
  self_protocol[index] = self;
  xSetUp(self, hlp);
  return XK_SUCCESS;
}

/*
 * Just use network byte order...let the protocol writers
 * worry about it.....
 * This is used in msgPush calls
 */
void
xkStore( hdr, des, len, arg )
char *hdr, *des, *arg;
long len;
{
	bcopy( hdr, des, len );
}

#endif

/*
 * reserve a pointer into the message structure
 */
static char *upMsg_data;

#if defined XK_NO_INCOMING_PACKETS || ! defined XKMACHKERNEL

/* 
 * Kludge to block incoming packets to the xkernel.
 */

void se_read(sc, lnrbuf, len, loop_back)
    register se_softc_t	sc;
    volatile char	*lnrbuf;
    int			len;
    io_req_t		loop_back;
{
	struct {
		struct ether_header	hdr;
		char			data[1500];
	} buf;
	
#ifdef XK_DEBUG
	static int	inCount = 0;
	
	inCount++;
	xTrace1(xklancep, TR_EVENTS, "se_read (%d)", inCount);
#endif
	if ( loop_back ) {
#ifdef XKMACHKERNEL
		xTrace0(xklancep, TR_EVENTS, "se_read -- loopback");
#endif
		bcopy(loop_back->io_data, &buf.hdr, sizeof(struct ether_header));
		bcopy(loop_back->io_data + sizeof(struct ether_header),
		      buf.data, len - sizeof(struct ether_header));
	} else {
		copy_from_lance(lnrbuf, len, (struct ether_header*)&buf.hdr, (struct packet_header*)buf.data, TRUE );
	}
	se_read_mach(sc, &buf.hdr, buf.data, len, buf.hdr.ether_type);
}

#else XK_NO_INCOMING_PACKETS 

#ifdef XKMACHKERNEL

/*
 * se_read_xkernel  $$$$$ renamed? --rcs
 *
 * Pull a packet off the interface and
 * hand it up to the higher levels.
 *
 * This is the interface between the interrupt handler and the xkernel.
 * Be extremely careful not to invoke xkernel functions that have
 * any chance of blocking (e.g., any form of malloc).
 *
 */
void se_read(sc, lnrbuf, len, loop_back)
register se_softc_t	 sc;
volatile char		*lnrbuf;
int			 len;
io_req_t		 loop_back;
{
	struct threadIBlock	*ti;
	struct input_buffer	*buf;
	int			device_index = sc - se_softc[0];  /* $$$$ why does this work? --rcs */
	XObj			self = self_protocol[device_index];

	if (len <= sizeof(struct ether_header))  /* $$$$ should actually compare to a named constant -- rcs */
		return;	/* sanity */

	if( loop_back ) {
		xTrace0(xklancep, TR_SOFT_ERRORS, "loopback disabled");
		return;
	}
	if ( ! self->up ) {
		xTrace0(xklancep, TR_SOFT_ERRORS, "xklance -- no eth protl registered");
		return;
	}
	/* 
	 * Try to find a free shepherd thread.
	 */
	ti = delist( &xkThreadQ );
#ifdef RICHDEBUG
printf("se_read_xkernel taking thread %x\n", ti);
#endif
	if ( ti ) {
		xTrace2(xklancep, TR_DETAILED, "using thread ID %d (%x)",
			ti->xkThreadId, ti);
		ti->buf = buf = delist( &xkBufferPool );
	    	if ( buf ) {
			buf->driverProtl = self;
			copy_from_lance(lnrbuf, len, &buf->hdr, buf->data,
					TRUE );
			msgSetAttr(&buf->upmsg, 0, &buf->hdr, sizeof(ETHhdr));
			msgTruncate(&buf->upmsg, len - sizeof(struct ether_header));
#ifdef ALLOW_NON_XK_USERS
			if ( xklanceAllUsers ) {
			    se_read_mach(sc, &buf->hdr, buf->data, len,
					 ((ETHhdr *)buf->hdr)->type);
			}
#endif
	    	} else {
			xTrace0(xklancep, TR_SOFT_ERROR,
		    "lance: Dropped incoming msg (got thread but no buffer)");
			/* 
			 * We'll restart the thread anyway.  It will find no
			 * buffer attached to its structure and put itself back
			 * on the queue. 
			 */
		};
		xAssert(ti->thread);
		clear_wait(ti->thread,THREAD_AWAKENED,FALSE);
	} else {
	    	/* 
	     	 * No thread available.  Try to put the message on the
	     	 * incomingData queue.
	     	 */
		xTrace0(xklancep, TR_SOFT_ERRORS, "xklance is QUEUING!!!");
	    	if ( xkIncomingData_lock == 0 ) {
		    	if ( (buf = delist( &xkBufferPool )) != 0 ) {
				buf->driverProtl = self;
		    		copy_from_lance(lnrbuf, len, &buf->hdr,
						buf->data, TRUE );
		    		msgSetAttr(&buf->upmsg, 0, &buf->hdr, sizeof(ETHhdr));
				msgTruncate(&buf->upmsg, len - sizeof(struct ether_header));
				enlist(&xkIncomingData, buf);
#ifdef ALLOW_NON_XK_USERS
				if ( xklanceAllUsers ) {
				    se_read_mach(sc, &buf->hdr, buf->data, len,
						 ((ETHhdr *)buf->hdr)->type);
				}
#endif
			} else {
		    		xTrace0(xklancep, TR_SOFT_ERROR,
			    "lance: Dropped incoming msg (no thread or buffer)");
			}
		} else {
			xTrace0(xklancep, TR_SOFT_ERROR,
		       "lance: Dropped incoming msg (incomingData queue locked)");
		}
	}
}

#endif XKMACHKERNEL

#endif XK_NO_INCOMING_PACKETS



/*
 * Get a packet out of Lance memory and into main memory.
 */
private void
copy_from_lance(rbuf, nbytes, hdr, pkt, isX)
	register volatile unsigned char *rbuf;
	register unsigned int	  nbytes;
	struct ether_header	 *hdr;
	struct packet_header 	 *pkt;
        int			  isX;
{
	/*
	 * Read in ethernet header 
	 */
#ifdef XKMACHKERNEL
	xAssert(rbuf);
#endif XKMACHKERNEL

	(se_sw->data_copyin) ((vm_offset_t)rbuf, (vm_offset_t)hdr, sizeof(struct ether_header));
#ifdef RICHDEBUG
	printf("copy_from_lance: packet length = %d ", nbytes);
	{int i; for (i=0;i<sizeof(struct ether_header);i++)
	            printf(" %02x", (char) *( (char *)hdr + i) &0xff);}
	printf("\nrbuf %x  hdr %x  pkt %x  isX %x\n", rbuf, hdr, pkt, isX);
#endif

	nbytes -= sizeof(struct ether_header);
	rbuf += (se_sw->mapoffs) (sizeof(struct ether_header));

	if( isX )
	  /* blows up when fbuf are used */
		(se_sw->data_copyin) (rbuf, pkt, nbytes);
	else {

		pkt->type = (unsigned short) hdr->ether_type;
		(se_sw->data_copyin) ((vm_offset_t)rbuf, (vm_offset_t)(pkt + 1), nbytes);
	}
}

#ifdef XKMACHKERNEL
static char	*xkOutP;		/* xkCopyout pointer */
  
static int
   xkCopyout( srcPtr, len, arg )
char 	*srcPtr, *arg;
long	len;
{
	xIfTrace(xklancep, TR_DETAILED ) {
		printf( "lance: copy %ld bytes to lance %02x %02x %02x %02x %02x %02x\n"
		       , len, srcPtr[0],srcPtr[1],srcPtr[2],srcPtr[3],srcPtr[4],srcPtr[5] );
	};

	/* 
	 * xkOutP has been initialized to point at the lance buffer
	 */

	(se_sw->data_copyout)( srcPtr, xkOutP, len );

	/*
	 * Advance xkOutP so that the call on the next msg contig
	 * has advanced in the lance buffer
	 */

	xkOutP += len;

	return( TRUE );
}


/*
 * Move a x-kernel message into Lance space
 */
static
	xkcopy_to_lance(request, sbuf)
register io_req_t request;
volatile long	 *sbuf;
{
	register u_char *cp;
	register int    len;
	ETHhdr *hdr;
	
	len = request->io_count;
	
#ifdef	IF_CNTRS
	se_eout[log_2(len)]++;
	if (len < 128)
		se_lout[len >> 3]++;
#endif	IF_CNTRS
	
	if (len > ETHERMTU + sizeof(struct ether_header)) {
		printf("se: truncating HUGE packet\n");
		len = ETHERMTU + sizeof(struct ether_header);
	}
	
	xIfTrace(xklancep, TR_EVENTS ) {
		printf( "lance: Outgoing message: " );
		msgShow( (Msg *)request->io_data );
	}

	xkOutP = (char *)sbuf;
	hdr = msgGetAttr(request->io_data, 0);
	xkCopyout(hdr, sizeof(ETHhdr), 0);
	msgForEach(  (Msg *)request->io_data
				  , (XCharFun)xkCopyout
				  , (char *) 0 );
	
	xFree(hdr);
	msgDestroy((Msg *)request->io_data);
	xFree(request->io_data);

	/***** Trace stuff *******/
	xIfTrace(xklancep, TR_DETAILED ) {
		cp = (u_char *) sbuf;
		printf("[xk2Lan destination is :%02x:%02x:%02x:%02x:%02x:%02x \n, \
source is %02x:%02x:%02x:%02x:%02x:%02x , type is %02x:%02x  \
data: %02x:%02x:%02x:%02x:%02x:%02x..]\n",
				 cp[0], cp[1], cp[2], cp[3], cp[4], cp[5], cp[6],
				 cp[7], cp[8], cp[9], cp[10],cp[11], cp[12], cp[13],
				 cp[14], cp[15], cp[16], cp[17],cp[18], cp[19]);
	}
	/*************************/

	if (len < LN_MINBUF_NOCH)
		/*
		 * The lance needs at least this much data in a packet. Who
		 * cares if I send some garbage that was left in the lance
		 * buffer ?  If one can spoof packets then one can spoof
		 * packets!
		 */
		len = LN_MINBUF_NOCH;

	return len;
}
#endif XKMACHKERNEL


/*
 * Move a packet into Lance space
 */
private int
copy_to_lance(request, sbuf)
	register io_req_t request;
	volatile char	 *sbuf;
{
	register unsigned short *dp;
	register int    len;

	dp = (unsigned short *) request->io_data;
	len = request->io_count;

	if (len > (int)(ETHERMTU + sizeof(struct ether_header))) {
		printf("se: truncating HUGE packet\n");
		len = ETHERMTU + sizeof(struct ether_header);
	}

	(se_sw->data_copyout) ((vm_offset_t)dp, (vm_offset_t)sbuf, len);

	if (len < LN_MINBUF_NOCH)
		/*
		 * The lance needs at least this much data in a packet. Who
		 * cares if I send some garbage that was left in the lance
		 * buffer ?  If one can spoof packets then one can spoof
		 * packets!
		 */
		len = LN_MINBUF_NOCH;
	return len;
}

/*
 * Reset a descriptor's flags.
 * Optionally give the descriptor to the lance
 */
private void
se_desc_set_status (lndesc, val)
	register se_desc_t	lndesc;
	int		 	val;
{
	struct se_desc		desc;

	(se_sw->desc_copyin) ((vm_offset_t)lndesc, (vm_offset_t)&desc, sizeof(desc));
	desc.desc4.bits = 0;
	desc.status     = val;
	(se_sw->desc_copyout) ((vm_offset_t)&desc, (vm_offset_t)lndesc, sizeof(desc));
	wbflush();
}

/*
 * Set/Get status functions
 */
se_get_status(dev, flavor, status, status_count)
	int		 dev;
	dev_flavor_t	 flavor;
	dev_status_t	 status;	/* pointer to OUT array */
	natural_t	*status_count;	/* out */
{
	return (net_getstat(&se_softc[dev]->is_if,
			    flavor, status, status_count));
}

se_set_status(unit, flavor, status, status_count)
	int		unit;
	dev_flavor_t	flavor;
	dev_status_t	status;
	natural_t	status_count;
{
	register se_softc_t	sc;

	sc = se_softc[unit];

	switch (flavor) {
	case NET_STATUS:
	      break;

	case NET_ADDRESS: {

			register union ether_cvt {
				unsigned char addr[6];
				int           lwd[2];
			} *ec = (union ether_cvt *) status;

			if (status_count < sizeof(*ec) / sizeof(int))
				return (D_INVALID_SIZE);

			ec->lwd[0] = ntohl(ec->lwd[0]);
			ec->lwd[1] = ntohl(ec->lwd[1]);

			se_setaddr(ec->addr, unit);

			break;
		}
	default:
		return (D_INVALID_OPERATION);
	}
	return (D_SUCCESS);
}


/*
 * Install new filter.
 * Nothing special needs to be done here.
 */
io_return_t
se_setinput(dev, receive_port, priority, filter, filter_count)
	int		dev;
	ipc_port_t	receive_port;
	int		priority;
	filter_t	*filter;
	unsigned int	filter_count;
{
	return (net_set_filter(&se_softc[dev]->is_if,
			       receive_port, priority,
			       filter, filter_count));
}

/*
 * Allocate and initialize a ring descriptor.
 * Allocates a buffer from the lance memory and writes a descriptor
 * for that buffer to the host virtual address LNDESC.
 */
private volatile long
*se_desc_alloc (sc, lndesc)
	register se_softc_t	sc;
	register se_desc_t	lndesc;
{
	register vm_offset_t	dp;	/* data pointer */
	struct se_desc		desc;

#ifdef RICHDEBUG
	printf("se_desc_alloc: LN_BUFFER_SIZE %d  LN_MEMORY_SIZE %d  NRCV %d  NXMT %d\n",
	 LN_BUFFER_SIZE,  LN_MEMORY_SIZE,  NRCV,  NXMT);
#endif /* RICHDEBUG */

	/*
	 * Allocate buffer in lance space 
	 */
	dp = se_malloc(sc, LN_BUFFER_SIZE);

	/*
	 * Build a descriptor pointing to it 
	 */
	desc.addr_low = Addr_lo(Lmem(dp));
	desc.addr_hi  = Addr_hi(Lmem(dp));
	desc.status   = 0;
	desc.buffer_size = -LN_BUFFER_SIZE;
	desc.desc4.bits  = 0;

	/*
	 * Copy the descriptor to lance space 
	 */
	(se_sw->desc_copyout) ((vm_offset_t)&desc, (vm_offset_t)lndesc, sizeof(desc));
	wbflush();

	return (volatile long *) Hmem(dp);
}

/*
 * Allocate a chunk of lance RAM buffer. Since we never
 * give lance RAM buffer memory back, we'll just step up the
 * byte-count on a per-unit basis.
 *
 * The return value is an index into the lance memory, which can be
 * passed with Hmem() and Lmem() to get the host and chip virtual addresses.
 */
private vm_offset_t
se_malloc(sc, size)
	se_softc_t	sc;
	int		size;
{
	register vm_offset_t    ret;

	/*
	 * On first call, zero lance memory 
	 */
	if (sc->lnsbrk == 0)
		(se_sw->bzero) (Hmem(0), LN_MEMORY_SIZE);

	/*
	 * Start out on the first double longword boundary
	 * (this accomodates some machines, with minimal loss)
	 */
	if (sc->lnsbrk & 0xf)
		sc->lnsbrk = (sc->lnsbrk + 0x10) & ~0xf;

	ret = sc->lnsbrk;
	sc->lnsbrk += size;

#ifdef RICHDEBUG
	printf("se_malloc: at %d  want %d  end+1 %d\n", ret, size, sc->lnsbrk);
#endif /* RICHDEBUG */

	if (sc->lnsbrk > LN_MEMORY_SIZE)
		panic("se_malloc");

	return ret;
}

#ifdef XKMACHKERNEL
static void
mygetLocalEthHost(host, unit)  /* unused with new interface ?? */
    ETHhost *host;
    int unit;
{
/*	se_open((dev_t)0, 0); Turn this off for now --rcs $$$$$ */
	bcopy ( se_softc[unit]->is_addr, (char *)host, sizeof( ETHhost ) );
	xTrace3(xklancep, TR_EVENTS, "lance: host addr %x.%x.%x",
		host->high, host->mid, host->low);
}

/*
 *  xklance_control
 *
 *   Control operations
 *
 */
int
xklance_control(self, op, buf, len)
     XObj  self;
     int   op;
     char *buf;
     int   len;
{  int unit;

    xTrace1(xklancep, TR_FULL_TRACE, "xklance_control: operation %x", op);
    if (op == GETMYHOST) {
        if (len >= sizeof(ETHhost)) {
	  unit = self->instName[strlen(self->instName)-1] - '0';
	  if (unit>=0 && unit < NLN) {
	    mygetLocalEthHost(buf, unit);
	    return sizeof(ETHhost);
	  }
	}
    }
    return -1;
}

xkern_return_t
xklance_init(self)
     XObj self;
{
	extern			kalloc_max;
	int		        unit;
	dev_t			device;

	xTrace0(xklancep, TR_GROSS_EVENTS, "xklance_init");
	/* don't want to try to get pages beyond what kalloc can
	   conveniently work with; larger pages get wired down memory
	   */
	if (PageSize > kalloc_max) panic("lance: xkernel msg pages too big");
	if (PageSize < MAX_ETH_DATA_SZ) panic("lance: xkernel msg pages too small for network MTU");
	unit = self->instName[strlen(self->instName)-1] - '0';
	if (unit<0 || unit >= NLN) {
	  unit = 0;
	  xTrace1(xklancep, TR_ERRORS, "lance: assuming unit 0 for %s",
		  self->instName);
	}
	/* 
	 * We kludge the unit number in the 'state' pointer field of the XObj.
	 */
	self->state = unit;
	self_protocol[unit] = self;
	se_open((dev_t)unit, 0);
	self->openenable = xklance_openenable;
	self->push = xklance_push;
	self->control = xklance_control;
	xTrace0(xklancep, TR_GROSS_EVENTS, "xklance_init returns");
	return XK_SUCCESS;
}


io_return_t
xknet_write(ifp, start, ior)
	register struct ifnet *ifp;
	int		(*start)();
	io_req_t	ior;
{
	int	s;
	kern_return_t	rc;

	/*
	 * Reject the write if the interface is down.
	 */
	if ((ifp->if_flags & (IFF_UP|IFF_RUNNING)) != (IFF_UP|IFF_RUNNING))
	    return (D_DEVICE_DOWN);

	/*
	 * Reject the write if the packet is too large or too small.
	 */
	if (ior->io_count < ifp->if_header_size ||
	    ior->io_count > ifp->if_header_size + ifp->if_mtu)
	    return (D_INVALID_SIZE);

	/*
	 * Queue the packet on the output queue, and
	 * start the device.
	 *
	 */
	xTrace0(xklancep, TR_DETAILED, "lance: write packet");
	s = splimp();
	IF_ENQUEUE(&ifp->if_snd, ior);
	(*start)(ifp->if_unit);
	splx(s);

	return (D_IO_QUEUED);
}


free_ior(ior)
io_req_t ior;
{
	return TRUE;
}

/*
 * xklance_push
 *
 * the interface from the xkernel for outgoing packets
 *
 */
xmsg_handle_t
xklance_push(s, downMsg)
     XObj s;
     Msg *downMsg;
/* ethCtlrXmit(downMsg, dest, type)
Msg *downMsg;
ETHhost *dest;
short type;
*/
{
    ETHhdr  *hdr = (ETHhdr *)msgGetAttr(downMsg, 0);
    ETHtype type;
    ETHhost *dest;
    io_req_t ior;
    io_return_t net_write_prime();
    char *msgattr;

#ifdef XKLANCE_NOSEND
    return;
#endif

        type = hdr->type;
        dest = &hdr->dst;

	io_req_alloc(ior, 0);
	bzero(ior, sizeof(struct io_req));

	ior->io_data = (char *)xMalloc( sizeof( Msg ) );
	msgConstructCopy((Msg *)ior->io_data, downMsg);

/* $$$$ another way, saves time - rcs */
        msgattr = xMalloc(sizeof(ETHhdr));
	bcopy((char *)hdr, msgattr, sizeof(ETHhdr));
        msgSetAttr(ior->io_data, 0, msgattr, sizeof(ETHhdr));

	xTrace3(xklancep, TR_EVENTS, "lance: send to %x.%x.%x", dest->high, dest->mid, dest->low);

	ior->io_count = msgLen((Msg *)ior->io_data) + sizeof(ETHhdr);

	/* operation is write and call io_done_thread when done */
	ior->io_op = IO_WRITE | IO_CALL;
#ifdef ALLOW_NON_XK_USERS
	ior->io_op |= IO_IS_XK_MSG;
#endif
	ior->io_done = free_ior;
	ior->io_unit = s->state;
	 
	/*	simulate an inband se_output(ior->io_unit, ior); */
	if( xknet_write(&se_softc[ior->io_unit]->is_if, se_start, ior)
	   						!= D_IO_QUEUED )
		panic( "xknet_write: bad return value" );
	
}
#endif XKMACHKERNEL

#endif   /* NLN > 0 || NXL > 0 */
