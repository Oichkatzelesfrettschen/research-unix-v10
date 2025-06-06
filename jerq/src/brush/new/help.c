/*
 *
 *	handle Helps for Brush  --  brush/help.c
 *
 *	note: a Help is a set of 3 Texture16's used in help area
 *
 *	Brush 
 *	Garry Hodgson	1985
 *
 *	Copyright 1985 AT&T Bell Laboratories
 *	All Rights Reserved
 */

#include "brush.h"

Texture16 skull     = { 0x0000, 0x0000, 0x0000, 0xC003,
	 		0xE7E7, 0x3FFC, 0x0FF0, 0x0DB0,
	 		0x07E0, 0x0660, 0x37EC, 0xE427,
	 		0xC3C3, 0x0000, 0x0000, 0x0000, };

/*
Texture16 hourglass=  { 0x1FF0, 0x1FF0, 0x0820, 0x0820,
			0x0820, 0x0C60, 0x06C0, 0x0100,
			0x0100, 0x06C0, 0x0C60, 0x0820,
			0x0820, 0x0820, 0x1FF0, 0x1FF0 };
*/


Texture16 hourglass = {				/* really infinity */
	 0x0000, 0x0000, 0x0000, 0x0000,
	 0x3C1C, 0x4E2E, 0x8747, 0x8383,
	 0xC1C1, 0xE2E1, 0x7472, 0x383C,
	 0x0000, 0x0000, 0x0000, 0x0000,
};

Texture16 menucursor= { 0xFFC0, 0x8040, 0x8040, 0x8040,
			0xFFC0, 0xFFC0, 0xFE00, 0xFEF0,
			0x80E0, 0x80F0, 0x80B8, 0xFE1C,
			0x800E, 0x8047, 0x8042, 0xFFC0, };

Texture16 hand      = { 0x0000, 0x0000, 0x0000, 0x3f00,
			0x40ff, 0x8c81, 0x0afe, 0x0a90,
			0x12e0, 0x0320, 0x87c0, 0x4440,
			0x3f80, 0x0000, 0x0000, 0x0000 };

Texture16 drawcursor ={ 0x0001, 0x0003, 0x0007, 0x000F,
			0x001E, 0x003C, 0x0078, 0x00F0,
			0x01E0, 0x03C0, 0x0780, 0x0900,
			0x1100, 0x1200, 0x3C00, 0xF000, };

Texture16 erasecursor={ 0x0410, 0x0550, 0x0550, 0x0550,
			0x0550, 0x0550, 0x0550, 0x0410,
			0x0410, 0x07F0, 0x0410, 0x0410,
			0x0410, 0x07F0, 0x000E, 0x000E, };

Texture16 sweepcursor={ 0x43FF,0xE001,0x7001,0x3801,
			0x1D01,0x0F01,0x8701,0x8F01,
			0x8001,0x8001,0x8001,0x8001,
			0x8001,0x8001,0x8001,0xFFFF };

Texture16 sweepcircle={ 0x43F0, 0xE008, 0x7004, 0x3802,
			0x1D01, 0x0F01, 0x8701, 0x8F01,
			0x8001, 0x8001, 0x8001, 0x8001,
			0x4002, 0x2004, 0x1008, 0x0FF0, };

Texture16 thumbsup  = { 0x00C0, 0x0120, 0x0120, 0x0120,
			0x0320, 0x3E20, 0x4030, 0x401E,
			0x7812, 0x4012, 0x4012, 0x7812,
			0x401E, 0x4030, 0x3FE0, 0x0000, };

Texture16 thumbsdown= { 0x0000, 0x3FE0, 0x4030, 0x401E,
			0x7812, 0x4012, 0x4012, 0x7812,
			0x401E, 0x4030, 0x3E20, 0x0320,
			0x0120, 0x0120, 0x0120, 0x00C0, };

Help default_set = { &drawcursor,&erasecursor,&menucursor };
Help sweep_set   = { &thumbsdown,&thumbsdown,&sweepcursor };
Help point_set   = { &hand,null(Texture16),&thumbsdown };
Help pos_set     = { &drawcursor,&erasecursor,&thumbsdown };
Help exit_set    = { &thumbsdown,&thumbsdown,&skull };
Help kill_set    = { &thumbsdown,&thumbsdown,&thumbsdown };
Help menu_set    = { &thumbsdown,&thumbsdown,&menucursor };
Help fade_set    = { null(Texture16),&erasecursor,&thumbsdown };
Help circ_set    = { &thumbsdown,&thumbsdown,&sweepcircle };
Help snarf_set   = { &thumbsdown,&thumbsdown,&thumbsup };
Help curr_set;

Help
helpswitch( new_set )
	Help new_set;
{
	Help last_set;

	last_set = curr_set;
	draw_help( curr_set = new_set );
	return last_set;
}

draw_help( b )
	Help b;
{
	Word i;

	for ( i=0; i<3; i++ )
		showbutton( i+1,b.text[i] );
}

showbutton( b,tp )
	Word b;		/* button number */
	Texture16 *tp;
{
	Point p;
	Rectangle r;

	r = raddp( Rect( 0,0,24,24 ),add( Pt(2,2),mul( Pt(26,0),b-1 )));
	r = raddp( r,Helper.r.origin );
	rectf( &display,r,F_CLR );

	if ( tp )
		tx16blt( tp,Rect(0,0,16,16),
			 &display,add( r.origin,Pt(4,4)),F_STORE );
}

