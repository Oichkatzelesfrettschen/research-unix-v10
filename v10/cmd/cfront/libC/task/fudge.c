/*ident	"%W%" */
/**************************************************************************
			Copyright (c) 1984 AT&T
	  		  All Rights Reserved  	

	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T
	
	The copyright notice above does not evidence any   	
	actual or intended publication of such source code.

*****************************************************************************/
#include <task.h>
#include "hw_stack.h"

// VAX frame fudger

// STACK GROWS DOWN

/*
 * Fudge frame of function-defined-by-f_fp (called "f" below)
 * so that that function returns to its grandparent,
 * in particular, so a parent task returns to the function that
 * called the derived constructor (de_ctor), skipping de_ctor;
 * the child will return to the derived constructor, which is its "main."
 * To do this we will overwrite the old fp, ap, and pc (those saved by
 * f) with the old-old ones (those saved by f's caller),
 * and we will overwrite the register save area with registers saved by 
 * f's caller (referred to as "skip" below).
 *
 * There are 2 register-save cases to deal with:
 *     1. skip_n_saved <= f_n_saved
 *     3. skip_n_saved >  f_n_saved
 *
 * These are handled as follows:
 *     1. copy the saved skip_regs over the corresponding f_regs,
 *        leaving any additional saved f_regs intact.
 *        f's restore instruction will be correct.
 *     2. f's restore instruction will restore too few regs, must take special
 *	  care to see that the extras are restored properly.
 *	  -Copy saved skip_regs over any corresponding f_regs,
 *	  -If fudge_return saved more regs than f did, then
 *	   copy saved extra saved skip_regs over any corresponding fudge_regs,
 *	  -If more extra skip_regs (not saved by either f or fudge_return,
 *	   and therefore not used by either) remain, restore them explicitly.
 *	   They will not be disturbed by the return from fudge_return or f,
 */
void
task::fudge_return(int* f_fp)
{
	register int*	fp = f_fp;		   // fp of frame-to-be-fudged
	register int*	skip_fp = (int*)OLD_FP(fp); // fp for f's caller (skip)
	unsigned short	mask = ENTRY_MASK(fp);
	unsigned	spa = mask >> 14;  // stack pointer alignment
	mask &= 0xfff;  // mask of saved registers in the frame
	unsigned short	skip_mask = ENTRY_MASK(skip_fp);
	unsigned	skip_spa = skip_mask >> 14;
	skip_mask &= 0xfff;

	OLD_AP(fp) = OLD_AP(skip_fp);
	OLD_FP(fp) = OLD_FP(skip_fp);
	OLD_PC(fp) = OLD_PC(skip_fp);

	// finally copy saved regs
	// copy any saved skip regs over corresponding f regs; if there isn't
	// a corresponding f reg, copy over corresponding fudge_return reg;
	// if there isn't a corresponding fr_reg, restore it explicitly.
	register int*	to = FIRST_SAVED_REG_P(fp,0);
	register int*	from = FIRST_SAVED_REG_P(skip_fp,0);
	register int*	fr_fp = FP();
	register int*	fr_to = FIRST_SAVED_REG_P(fr_fp,0);
	unsigned short	fr_mask = ENTRY_MASK(fr_fp);
	fr_mask &= 0xfff;
	for (int m = 1; m != 0x1000; m <<= 1) {
		if (m & mask) {
			if (m & skip_mask) {
				*to++ = *from++;
				if (m & fr_mask) fr_to++;
			} else {  // nothing to copy
				to++;
				if (m & fr_mask) fr_to++;
			}
		} else if (m & skip_mask)  {
			// No slot for *from in f's frame
			if (m & fr_mask) {  // copy to fudge_return's frame
				*fr_to++ = *from++;
			} else {
				// Not used in f or fudge_return;
				// restore explicitly
				switch(m)	{
				case 0x0020:
					set_r6(from++);
					break;
				case 0x0040:
					set_r7(from++);
					break;
				case 0x0080:
					set_r8(from++);
					break;
				case 0x0100:
					set_r9(from++);
					break;
				case 0x0200:
					set_r10(from++);
					break;
				case 0x0400:
					set_r11(from++);
					break;
				default:
					// Oops--don't expect other regs
					// to be saved
					from++;
					task_error(E_REGMASK, this);
					break;
				}
			}
		} else if (m & fr_mask)	fr_to++;
	}

	// to and from now point at argument descriptor (if spa == 0);
	// add number of words in skip's frame to arg descriptor, so sp
	// will be set properly when f returns (no need for fudge_sp here).
	// WARNING:  spa != 0 untested.
	to -= spa;
	from -= skip_spa;
	unsigned big_arg_list = *(unsigned char*)from + (from - to);
	if (big_arg_list > 0xff)
		task_error(E_FUDGE_SIZE, this);
	*(unsigned char*)to = big_arg_list;
}

