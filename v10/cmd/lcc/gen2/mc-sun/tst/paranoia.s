.data
.globl _Zero
.align 2; _Zero:.long 0x0,0x0
.globl _Half
.align 2; _Half:.long 0x3fe00000,0x0
.globl _One
.align 2; _One:.long 0x3ff00000,0x0
.globl _Two
.align 2; _Two:.long 0x40000000,0x0
.globl _Three
.align 2; _Three:.long 0x40080000,0x0
.globl _Four
.align 2; _Four:.long 0x40100000,0x0
.globl _Five
.align 2; _Five:.long 0x40140000,0x0
.globl _Eight
.align 2; _Eight:.long 0x40200000,0x0
.globl _Nine
.align 2; _Nine:.long 0x40220000,0x0
.globl _TwentySeven
.align 2; _TwentySeven:.long 0x403b0000,0x0
.globl _ThirtyTwo
.align 2; _ThirtyTwo:.long 0x40400000,0x0
.globl _TwoForty
.align 2; _TwoForty:.long 0x406e0000,0x0
.globl _MinusOne
.align 2; _MinusOne:.long 0xbff00000,0x0
.globl _OneAndHalf
.align 2; _OneAndHalf:.long 0x3ff80000,0x0
.globl _NoTrials
.align 2; _NoTrials:.long 20
.text
.globl _sigfpe
.align 2
_sigfpe:link a6,#-8
addql #1,_fpecount:l
movl #L2,sp@
jbsr _printf:l
movl #__iob+20,sp@
jbsr _fflush:l
tstl _sigsave:l; jeq L4
movl #8,sp@
movl _sigsave:l,sp@(4)
jbsr _signal:l
clrl _sigsave:l
movl #_ovfl_buf,sp@
movl #1,sp@(4)
jbsr _longjmp:l
L4:
jbsr _abort:l
L1:
unlk a6
rts
.data
.align 2; L762:.long L763
.long L764
.long L765
.long L766
.text
.globl _main
.align 2
_main:link a6,#-144
fmovemx #0xff,a6@(-100)
moveml #0x498,a6@(-116)
movl #L7,sp@
movl #L8,sp@(4)
movl #L9,sp@(8)
lea a6@(-4),a2
movl a2,sp@(12)
jbsr _ieee_flags:l
fmoved L10:l,fp3
fmoved fp3,_Zero:l
fmoved L11:l,fp3
fmoved fp3,_One:l
fmoved _One:l,fp3
fmovex fp3,fp2; faddx fp3,fp2
fmoved fp2,_Two:l
fmoved _Two:l,fp2
fmovex fp2,fp7
fmovex fp2,fp1; faddx fp3,fp1
fmoved fp1,_Three:l
fmoved _Three:l,fp1
fmovex fp1,fp0; faddx fp3,fp0
fmoved fp0,_Four:l
fmoved _Four:l,fp0
fmovex fp0,fp2; faddx fp3,fp2
fmoved fp2,_Five:l
fmovex fp0,fp2; faddx fp0,fp2
fmoved fp2,_Eight:l
fmovex fp1,fp2; fmulx fp1,fp2
fmoved fp2,_Nine:l
fmoved _Nine:l,fp2
fmulx fp1,fp2
fmoved fp2,_TwentySeven:l
fmovex fp0,fp2; fmuld _Eight:l,fp2
fmoved fp2,_ThirtyTwo:l
fmovex fp0,fp2; fmuld _Five:l,fp2
fmulx fp1,fp2
fmulx fp0,fp2
fmoved fp2,_TwoForty:l
fnegx fp3,fp2
fmoved fp2,_MinusOne:l
fmovex fp3,fp2; fdivx fp7,fp2
fmoved fp2,_Half:l
faddd _Half:l,fp3
fmoved fp3,_OneAndHalf:l
clrl _ErrCnt:l
clrl _ErrCnt+4:l
clrl _ErrCnt+8:l
clrl _ErrCnt+12:l
movl #1,_PageNo:l
clrl _Milestone:l
movl #8,sp@
movl #_sigfpe,sp@(4)
jbsr _signal:l
jbsr _Instructions:l
jbsr _Pause:l
jbsr _Heading:l
jbsr _Pause:l
jbsr _Characteristics:l
jbsr _Pause:l
jbsr _History:l
jbsr _Pause:l
movl #7,_Milestone:l
movl #L15,sp@
jbsr _printf:l
movl #0,sp@
fmoved _Zero:l,fp3
fmovex fp3,fp2; faddx fp3,fp2
fcmpx fp3,fp2; fjne L18
fmoved _One:l,fp2
fmovex fp2,fp1; fsubx fp2,fp1
fcmpx fp3,fp1; fjne L18
fcmpx fp3,fp2; fjle L18
fmovex fp2,fp3; faddx fp2,fp3
fcmpd _Two:l,fp3; fjne L18
movl #1,d7
jra L19
L18:
clrl d7
L19:
movl d7,sp@(4)
movl #L17,sp@(8)
jbsr _TstCond:l
fnegd _Zero:l,fp3
fmoved fp3,_Z:l
fmoved _Z:l,fp3
fcmpd L10:l,fp3; fjeq L20
addql #1,_ErrCnt:l
movl #L22,sp@
jbsr _printf:l
fmoved L23:l,fp3
fmoved fp3,_U1:l
fmoved L11:l,fp3
fmoved fp3,_Radix:l
jbsr _TstPtUf:l
L20:
movl #0,sp@
fmoved _Three:l,fp3
fmoved _Two:l,fp2
fmovex fp2,fp7
fmoved _One:l,fp1
fmovex fp1,fp6
fmovex fp2,fp0; faddx fp1,fp0
fcmpx fp0,fp3; fjne L26
fmoved _Four:l,fp0
fmovex fp3,fp2; faddx fp1,fp2
fcmpx fp2,fp0; fjne L26
fnegx fp7,fp2
fmovex fp7,fp1; fmulx fp2,fp1
fmovex fp0,fp2; faddx fp1,fp2
fmoved _Zero:l,fp1
fcmpx fp1,fp2; fjne L26
fmovex fp0,fp2; fsubx fp3,fp2
fmovex fp2,fp3; fsubx fp6,fp3
fcmpx fp1,fp3; fjne L26
movl #1,d7
jra L27
L26:
clrl d7
L27:
movl d7,sp@(4)
movl #L25,sp@(8)
jbsr _TstCond:l
fmoved _MinusOne:l,fp3
fmoved L10:l,fp2
fmoved _One:l,fp1
fsubx fp1,fp2
fcmpx fp2,fp3; fjne L30
fmovex fp3,fp2; faddx fp1,fp2
fmoved _Zero:l,fp0
fcmpx fp0,fp2; fjne L30
fmovex fp1,fp2; faddx fp3,fp2
fcmpx fp0,fp2; fjne L30
fmoved fp1,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
faddx fp0,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjne L30
fmoved _MinusOne:l,fp3
fmovex fp3,fp1; fmulx fp3,fp1
faddx fp1,fp3
fcmpx fp2,fp3; fjne L30
movl #1,d7
jra L31
L30:
clrl d7
L31:
movl #0,sp@
movl d7,sp@(4)
movl #L29,sp@(8)
jbsr _TstCond:l
movl #0,sp@
fmoved _Half:l,fp3
fmovex fp3,fp2; faddd _MinusOne:l,fp2
faddx fp3,fp2
fcmpd _Zero:l,fp2; fjne L34
movl #1,d7
jra L35
L34:
clrl d7
L35:
movl d7,sp@(4)
movl #L33,sp@(8)
jbsr _TstCond:l
movl #10,_Milestone:l
movl #0,sp@
fmoved _Nine:l,fp3
fmoved _Three:l,fp2
fmovex fp2,fp1; fmulx fp2,fp1
fcmpx fp1,fp3; fjne L38
fmoved _TwentySeven:l,fp1
fmulx fp2,fp3
fcmpx fp3,fp1; fjne L38
fmoved _Eight:l,fp3
fmoved _Four:l,fp2
fmovex fp2,fp0; faddx fp2,fp0
fcmpx fp0,fp3; fjne L38
fmoved _ThirtyTwo:l,fp0
fmulx fp2,fp3
fcmpx fp3,fp0; fjne L38
fmovex fp0,fp3; fsubx fp1,fp3
fsubx fp2,fp3
fsubd _One:l,fp3
fcmpd _Zero:l,fp3; fjne L38
movl #1,d7
jra L39
L38:
clrl d7
L39:
movl d7,sp@(4)
movl #L37,sp@(8)
jbsr _TstCond:l
movl #0,sp@
fmoved _Five:l,fp3
fmovex fp3,fp7
fmoved _Four:l,fp2
fmovex fp2,fp1; faddd _One:l,fp1
fcmpx fp1,fp3; fjne L42
fmoved _TwoForty:l,fp1
fmovex fp1,fp5
fmovex fp2,fp0; fmulx fp3,fp0
fmoved _Three:l,fp3
fmovex fp3,fp6
fmulx fp3,fp0
fmulx fp2,fp0
fcmpx fp0,fp1; fjne L42
fmovex fp1,fp0; fdivx fp3,fp0
fmovex fp2,fp3; fmulx fp2,fp3
fmulx fp7,fp3
fsubx fp3,fp0
fmoved _Zero:l,fp3
fcmpx fp3,fp0; fjne L42
fmovex fp1,fp0; fdivx fp2,fp0
fmovex fp7,fp1; fmulx fp6,fp1
fmulx fp2,fp1
fsubx fp1,fp0
fcmpx fp3,fp0; fjne L42
fmovex fp5,fp1; fdivx fp7,fp1
fmovex fp2,fp0; fmulx fp6,fp0
fmulx fp2,fp0
fmovex fp1,fp2; fsubx fp0,fp2
fcmpx fp3,fp2; fjne L42
movl #1,d7
jra L43
L42:
clrl d7
L43:
movl d7,sp@(4)
movl #L41,sp@(8)
jbsr _TstCond:l
tstl _ErrCnt:l; jne L44
movl #L46,sp@
jbsr _printf:l
movl #L47,sp@
jbsr _printf:l
L44:
movl #L48,sp@
jbsr _printf:l
fmoved _One:l,fp3
fmoved fp3,_W:l
L49:
fmoved _W:l,fp3
fmovex fp3,fp2; faddx fp3,fp2
fmoved fp2,_W:l
fmoved _W:l,fp3
fmoved _One:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmoved fp1,_Y:l
fmoved _Y:l,fp1
fsubx fp3,fp1
fmoved fp1,_Z:l
fmoved _Z:l,fp3
fsubx fp2,fp3
fmoved fp3,_Y:l
L50:
fmoved _Y:l,fp3
fmoved fp3,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _MinusOne:l,fp3
faddx fp0,fp3
fcmpd _Zero:l,fp3; fjlt L49
fmoved _Zero:l,fp3
fmoved fp3,_Precision:l
fmoved _One:l,fp3
fmoved fp3,_Y:l
L52:
fmoved _W:l,fp3
fmoved _Y:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmoved fp1,_Radix:l
fmovex fp2,fp1; faddx fp2,fp1
fmoved fp1,_Y:l
fmoved _Radix:l,fp2
fsubx fp3,fp2
fmoved fp2,_Radix:l
L53:
fmoved _Radix:l,fp3
fcmpd _Zero:l,fp3; fjeq L52
fmoved _Radix:l,fp3
fcmpd _Two:l,fp3; fjge L55
fmoved _One:l,fp3
fmoved fp3,_Radix:l
L55:
movl #L57,sp@
fmoved _Radix:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
fmoved _Radix:l,fp3
fcmpd L11:l,fp3; fjeq L58
fmoved _One:l,fp3
fmoved fp3,_W:l
L60:
fmoved _Precision:l,fp3
fmoved _One:l,fp2
faddx fp2,fp3
fmoved fp3,_Precision:l
fmoved _W:l,fp3
fmuld _Radix:l,fp3
fmoved fp3,_W:l
fmoved _W:l,fp3
faddx fp2,fp3
fmoved fp3,_Y:l
L61:
fmoved _Y:l,fp3
fsubd _W:l,fp3
fcmpd _One:l,fp3; fjeq L60
L58:
fmoved _One:l,fp3
fdivd _W:l,fp3
fmoved fp3,_U1:l
fmoved _Radix:l,fp3
fmoved _U1:l,fp2
fmulx fp2,fp3
fmoved fp3,_U2:l
movl #L63,sp@
fmoved fp2,sp@(4)
jbsr _printf:l
movl #L64,sp@
jbsr _printf:l
fmoved _Radix:l,fp3
fmoved fp3,_E0:l
fmoved _U1:l,fp3
fmoved fp3,_E1:l
fmoved _U2:l,fp3
fmoved fp3,_E9:l
fmoved _Precision:l,fp3
fmoved fp3,_E3:l
fmoved _Four:l,fp3
fdivd _Three:l,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fsubd _One:l,fp3
fmoved fp3,_Third:l
fmoved _Half:l,fp3
fmoved _Third:l,fp2
fsubx fp2,fp3
fmoved fp3,_F6:l
fmoved _F6:l,fp3
fmovex fp3,fp1; faddx fp3,fp1
fmoved fp1,_X:l
fmoved _X:l,fp3
fsubx fp2,fp3
fmoved fp3,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_X:l
fmoved _X:l,fp3
fcmpd _U2:l,fp3; fjge L65
fmoved _U2:l,fp3
fmoved fp3,_X:l
L65:
L67:
fmoved _X:l,fp3
fmoved fp3,_U2:l
fmoved _Half:l,fp3
fmoved _U2:l,fp2
fmulx fp2,fp3
fmoved _ThirtyTwo:l,fp1
fmulx fp2,fp1
fmulx fp2,fp1
faddx fp1,fp3
fmoved fp3,_Y:l
fmoved _One:l,fp3
fmovex fp3,fp2; faddd _Y:l,fp2
fmoved fp2,_Y:l
fmoved _Y:l,fp2
fsubx fp3,fp2
fmoved fp2,_X:l
L68:
fmoved _U2:l,fp3
fmoved _X:l,fp2
fcmpx fp2,fp3; fjle L70
fcmpd _Zero:l,fp2; fjgt L67
L70:
fmoved _Two:l,fp3
fdivd _Three:l,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp3
fmoved fp3,_F6:l
fmoved _F6:l,fp3
fmovex fp3,fp1; faddx fp3,fp1
fmoved fp1,_Third:l
fmoved _Third:l,fp1
fsubx fp2,fp1
fmoved fp1,_X:l
fmoved _X:l,fp2
faddx fp3,fp2
fmoved fp2,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_X:l
fmoved _X:l,fp3
fcmpd _U1:l,fp3; fjge L71
fmoved _U1:l,fp3
fmoved fp3,_X:l
L71:
L73:
fmoved _X:l,fp3
fmoved fp3,_U1:l
fmoved _Half:l,fp3
fmoved _U1:l,fp2
fmovex fp3,fp1; fmulx fp2,fp1
fmoved _ThirtyTwo:l,fp0
fmulx fp2,fp0
fmulx fp2,fp0
fmovex fp1,fp2; faddx fp0,fp2
fmoved fp2,_Y:l
fmovex fp3,fp2; fsubd _Y:l,fp2
fmoved fp2,_Y:l
fmovex fp3,fp2; faddd _Y:l,fp2
fmoved fp2,_X:l
fmovex fp3,fp2; fsubd _X:l,fp2
fmoved fp2,_Y:l
faddd _Y:l,fp3
fmoved fp3,_X:l
L74:
fmoved _U1:l,fp3
fmoved _X:l,fp2
fcmpx fp2,fp3; fjle L76
fcmpd _Zero:l,fp2; fjgt L73
L76:
fmoved _U1:l,fp3
fcmpd _E1:l,fp3; fjne L77
movl #L79,sp@
jbsr _printf:l
jra L78
L77:
movl #L80,sp@
fmoved _U1:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L78:
fmoved _One:l,fp3
fmoved _U1:l,fp2
fdivx fp2,fp3
fmoved fp3,_W:l
fmoved _Half:l,fp3
fmovex fp3,fp1; fsubx fp2,fp1
faddx fp3,fp1
fmoved fp1,_F9:l
fmoved _U2:l,fp3
fdivx fp2,fp3
faddd L81:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Radix:l
fmoved _Radix:l,fp3
fcmpd _E0:l,fp3; fjne L82
movl #L84,sp@
jbsr _printf:l
jra L83
L82:
movl #L85,sp@
fmoved _Radix:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L83:
movl #2,sp@
fmoved _Radix:l,fp3
fmoved _Eight:l,fp2
fmovex fp2,fp1; faddx fp2,fp1
fcmpx fp1,fp3; fjgt L88
movl #1,d7
jra L89
L88:
clrl d7
L89:
movl d7,sp@(4)
movl #L87,sp@(8)
jbsr _TstCond:l
movl #3,sp@
fmoved _Radix:l,fp3
fcmpd _Two:l,fp3; fjeq L95
fcmpd L96:l,fp3; fjeq L95
fcmpd _One:l,fp3; fjne L92
L95:
movl #1,d7
jra L93
L92:
clrl d7
L93:
movl d7,sp@(4)
movl #L91,sp@(8)
jbsr _TstCond:l
movl #20,_Milestone:l
movl #0,sp@
fmoved _F9:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp3
fcmpx fp2,fp3; fjge L99
movl #1,d7
jra L100
L99:
clrl d7
L100:
movl d7,sp@(4)
movl #L98,sp@(8)
jbsr _TstCond:l
fmoved _F9:l,fp3
fmoved fp3,_X:l
movl #1,_I:l
fmoved _X:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fsubx fp2,fp3
fmoved fp3,_Z:l
movl #0,sp@
fmoved _X:l,fp3
fcmpd _One:l,fp3; fjne L105
fmoved _Z:l,fp3
fcmpd _Zero:l,fp3; fjne L103
L105:
movl #1,d7
jra L104
L103:
clrl d7
L104:
movl d7,sp@(4)
movl #L102,sp@(8)
jbsr _TstCond:l
fmoved _One:l,fp3
fmoved _U2:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmoved fp1,_X:l
clrl _I:l
movl #25,_Milestone:l
fmoved _Radix:l,fp1
fmovex fp1,fp0; fsubx fp3,fp0
fmoved fp0,_BMinusU2:l
fmoved _BMinusU2:l,fp0
fsubx fp2,fp0
fmovex fp0,fp2; faddx fp3,fp2
fmoved fp2,_BMinusU2:l
fcmpx fp3,fp1; fjeq L106
fmoved _U1:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp7
fmoved _Radix:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fnegd _TwoForty:l,fp3
fmulx fp7,fp3
fdivx fp0,fp3
fmoved fp3,_X:l
fmoved _Half:l,fp3
faddd _X:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Y:l
fmoved _X:l,fp3
fsubd _Y:l,fp3
fmoved fp3,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp3; fmuld _Four:l,fp3
fcmpd _One:l,fp3; fjge L108
fmoved _Y:l,fp3
fmoved fp3,_X:l
L108:
fmoved _X:l,fp3
fdivd _TwoForty:l,fp3
fmoved fp3,_Precision:l
fmoved _Half:l,fp3
faddd _Precision:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Y:l
fmoved _Precision:l,fp3
fsubd _Y:l,fp3
fmoved fp3,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp3; fmuld _TwoForty:l,fp3
fcmpd _Half:l,fp3; fjge L110
fmoved _Y:l,fp3
fmoved fp3,_Precision:l
L110:
L106:
fmoved _Precision:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpx fp0,fp3; fjne L114
fmoved _Radix:l,fp3
fcmpd _One:l,fp3; fjne L112
L114:
movl #L115,sp@
jbsr _printf:l
movl #L116,sp@
jbsr _printf:l
L112:
fmoved _Radix:l,fp3
fcmpd _One:l,fp3; fjne L117
movl #L119,sp@
jbsr _printf:l
jra L118
L117:
movl #L120,sp@
fmoved _Precision:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L118:
movl #1,sp@
fmoved _U2:l,fp3
fmoved _Nine:l,fp2
fmulx fp2,fp3
fmulx fp2,fp3
fmuld _TwoForty:l,fp3
fcmpd _One:l,fp3; fjge L123
movl #1,d7
jra L124
L123:
clrl d7
L124:
movl d7,sp@(4)
movl #L122,sp@(8)
jbsr _TstCond:l
movl #30,_Milestone:l
fmoved _Four:l,fp3
fmoved _Three:l,fp2
fmovex fp3,fp1; fdivx fp2,fp1
fmoved _One:l,fp0
fsubx fp0,fp1
fdivx fp3,fp0
fmovex fp1,fp3; fsubx fp0,fp3
fmulx fp2,fp3
fsubx fp0,fp3
fmoved fp3,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_X:l
L125:
fmoved _X:l,fp3
fmoved fp3,_Z2:l
fmoved _One:l,fp3
fmoved _Half:l,fp2
fmoved _Z2:l,fp1
fmulx fp1,fp2
fmoved _ThirtyTwo:l,fp0
fmulx fp1,fp0
fmulx fp1,fp0
faddx fp0,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmovex fp1,fp2; fsubx fp3,fp2
fmoved fp2,_X:l
L126:
fmoved _Z2:l,fp3
fmoved _X:l,fp2
fcmpx fp2,fp3; fjle L128
fcmpd _Zero:l,fp2; fjgt L125
L128:
fmoved _Three:l,fp3
fmoved _Four:l,fp2
fmovex fp3,fp1; fdivx fp2,fp1
fmoved _Two:l,fp0
fdivx fp3,fp0
fsubx fp0,fp1
fmulx fp3,fp1
fmoved _One:l,fp3
fdivx fp2,fp3
fmovex fp1,fp2; fsubx fp3,fp2
fmoved fp2,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Z:l
fmoved fp0,_Y:l
fmoved fp0,_X:l
L129:
fmoved _Z:l,fp3
fmoved fp3,_Z1:l
fmoved _One:l,fp3
fdivd _Two:l,fp3
fmoved _Half:l,fp2
fmoved _Z1:l,fp1
fmulx fp1,fp2
fmoved _ThirtyTwo:l,fp0
fmulx fp1,fp0
fmulx fp1,fp0
faddx fp0,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmovex fp1,fp2; faddx fp3,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmovex fp1,fp2; faddx fp3,fp2
fmoved fp2,_Z:l
L130:
fmoved _Z1:l,fp3
fmoved _Z:l,fp2
fcmpx fp2,fp3; fjle L132
fcmpd _Zero:l,fp2; fjgt L129
L132:
L133:
L136:
fmoved _Y:l,fp3
fmoved fp3,_Y1:l
fmoved _Half:l,fp3
fmoved _Y1:l,fp2
fmovex fp3,fp1; fmulx fp2,fp1
fmoved _ThirtyTwo:l,fp0
fmulx fp2,fp0
fmulx fp2,fp0
fmovex fp1,fp2; faddx fp0,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmovex fp1,fp2; faddx fp3,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmovex fp1,fp2; faddx fp3,fp2
fmoved fp2,_Y:l
L137:
fmoved _Y1:l,fp3
fmoved _Y:l,fp2
fcmpx fp2,fp3; fjle L139
fcmpd _Zero:l,fp2; fjgt L136
L139:
fmoved _X:l,fp3
fmoved fp3,_X1:l
fmoved _Half:l,fp3
fmoved _X1:l,fp2
fmulx fp2,fp3
fmoved _ThirtyTwo:l,fp1
fmulx fp2,fp1
fmulx fp2,fp1
faddx fp1,fp3
fmoved _F9:l,fp2
fsubx fp2,fp3
faddx fp2,fp3
fmoved fp3,_X:l
L134:
fmoved _X1:l,fp3
fmoved _X:l,fp2
fcmpx fp2,fp3; fjle L140
fcmpd _Zero:l,fp2; fjgt L133
L140:
fmoved _X1:l,fp3
fcmpd _Y1:l,fp3; fjne L143
fcmpd _Z1:l,fp3; fjeq L141
L143:
movl #1,sp@
movl #L144,sp@(4)
jbsr _BadCond:l
movl #L145,sp@
fmoved _X1:l,fp3
fmoved fp3,sp@(4)
fmoved _Y1:l,fp3
fmoved fp3,sp@(12)
fmoved _Z1:l,fp3
fmoved fp3,sp@(20)
jbsr _printf:l
movl #L146,sp@
jbsr _printf:l
movl #L147,sp@
jbsr _printf:l
movl #L148,sp@
jbsr _notify:l
fmoved _X1:l,fp3
fmoved _U1:l,fp2
fcmpx fp2,fp3; fjeq L152
fmoved _Y1:l,fp3
fcmpx fp2,fp3; fjeq L152
fmoved _Z1:l,fp3
fcmpx fp2,fp3; fjne L142
L152:
movl #L153,sp@
jbsr _printf:l
jra L142
L141:
fmoved _Z1:l,fp3
fcmpd _U1:l,fp3; fjne L156
fmoved _Z2:l,fp3
fcmpd _U2:l,fp3; fjeq L154
L156:
fmoved _Z1:l,fp3
fcmpd _U1:l,fp3; fjge L159
fmoved _Z2:l,fp3
fcmpd _U2:l,fp3; fjlt L157
L159:
movl #0,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
movl #L161,sp@
jbsr _notify:l
movl #L162,sp@
fmoved _U1:l,fp3
fmoved fp3,sp@(4)
fmoved _Z1:l,fp2
fsubx fp3,fp2
fmoved fp2,sp@(12)
jbsr _printf:l
movl #L163,sp@
fmoved _U2:l,fp3
fmoved fp3,sp@(4)
fmoved _Z2:l,fp2
fsubx fp3,fp2
fmoved fp2,sp@(12)
jbsr _printf:l
jra L158
L157:
fmoved _Z1:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjle L166
fmoved _Z2:l,fp3
fcmpx fp2,fp3; fjgt L164
L166:
movl #L167,sp@
fmoved _Radix:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L168,sp@
jbsr _printf:l
movl #L169,sp@
fmoved _Z1:l,fp3
fmoved fp3,sp@(4)
fmoved _Z2:l,fp3
fmoved fp3,sp@(12)
jbsr _printf:l
movl #L170,sp@
jbsr _notify:l
L164:
fmoved _Z1:l,fp3
fcmpd _Z2:l,fp3; fjne L173
fcmpd _Zero:l,fp3; fjle L171
L173:
fmoved _Z1:l,fp3
fdivd _U1:l,fp3
fmoved fp3,_X:l
fmoved _Z2:l,fp3
fdivd _U2:l,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fcmpd _X:l,fp3; fjle L174
fmoved _Y:l,fp3
fmoved fp3,_X:l
L174:
fmoved _X:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fnegx fp0,fp3
fmoved fp3,_Q:l
movl #L176,sp@
jbsr _printf:l
fmoved _Radix:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
movl #L177,sp@
fmoved _Q:l,fp3
fdivx fp0,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
fmoved L96:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
movl #L178,sp@
fmoved _Q:l,fp3
fdivx fp0,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L171:
movl #L153,sp@
jbsr _printf:l
L158:
L154:
L142:
jbsr _Pause:l
movl #35,_Milestone:l
fmoved _Radix:l,fp3
fcmpd _Two:l,fp3; fjlt L179
fmoved _W:l,fp3
fmoved _Radix:l,fp2
fmovex fp2,fp1; fmulx fp2,fp1
fdivx fp1,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fmovex fp3,fp2; faddd _One:l,fp2
fmoved fp2,_Y:l
fmoved _Y:l,fp2
fsubx fp3,fp2
fmoved fp2,_Z:l
fmoved _Z:l,fp3
fmovex fp3,fp2; faddd _U2:l,fp2
fmoved fp2,_T:l
fmoved _T:l,fp2
fsubx fp3,fp2
fmoved fp2,_X:l
movl #0,sp@
fmoved _X:l,fp3
fcmpd _U2:l,fp3; fjne L183
movl #1,d7
jra L184
L183:
clrl d7
L184:
movl d7,sp@(4)
movl #L182,sp@(8)
jbsr _TstCond:l
fmoved _X:l,fp3
fcmpd _U2:l,fp3; fjne L185
movl #L187,sp@
jbsr _printf:l
L185:
L179:
movl #L188,sp@
jbsr _printf:l
fmoved _F9:l,fp3
fmoved _One:l,fp2
fmovex fp2,fp7
fmovex fp3,fp1; fmulx fp2,fp1
fmoved fp1,_Y:l
fmovex fp2,fp1; fmulx fp3,fp1
fmoved fp1,_Z:l
fmoved _Half:l,fp1
fsubx fp1,fp3
fmoved fp3,_X:l
fmoved _Y:l,fp3
fsubx fp1,fp3
fmoved _X:l,fp0
fsubx fp0,fp3
fmoved fp3,_Y:l
fmoved _Z:l,fp3
fsubx fp1,fp3
fsubx fp0,fp3
fmoved fp3,_Z:l
fmoved _U2:l,fp3
fmovex fp2,fp1; faddx fp3,fp1
fmoved fp1,_X:l
fmoved _X:l,fp1
fmoved _Radix:l,fp0
fmovex fp1,fp2; fmulx fp0,fp2
fmoved fp2,_T:l
fmovex fp0,fp2; fmulx fp1,fp2
fmoved fp2,_R:l
fmoved _T:l,fp2
fsubx fp0,fp2
fmoved fp2,_X:l
fmoved _X:l,fp2
fmovex fp0,fp1; fmulx fp3,fp1
fmovex fp2,fp3; fsubx fp1,fp3
fmoved fp3,_X:l
fmoved _R:l,fp3
fsubx fp0,fp3
fmoved fp3,_T:l
fmoved _T:l,fp3
fsubx fp1,fp3
fmoved fp3,_T:l
fmoved _X:l,fp3
fmovex fp0,fp2; fsubx fp7,fp2
fmulx fp2,fp3
fmoved fp3,_X:l
fmoved _T:l,fp3
fmulx fp2,fp3
fmoved fp3,_T:l
fmoved _X:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjne L189
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjne L189
fmoved _Z:l,fp3
fcmpx fp2,fp3; fjne L189
fmoved _T:l,fp3
fcmpx fp2,fp3; fjne L189
movl #1,_GMult:l
jra L190
L189:
clrl _GMult:l
movl #1,sp@
clrl sp@(4)
movl #L191,sp@(8)
jbsr _TstCond:l
L190:
fmoved _Radix:l,fp3
fmuld _U2:l,fp3
fmoved fp3,_Z:l
fmoved _One:l,fp3
fmoved _Z:l,fp2
faddx fp2,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fmovex fp3,fp1; faddx fp2,fp1
fmovex fp3,fp2; fmulx fp3,fp2
fmovex fp1,fp3; fsubx fp2,fp3
fmoved fp3,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _U2:l,fp3
fmovex fp0,fp2; fsubx fp3,fp2
fmoved fp2,_Y:l
fmoved _One:l,fp2
fsubx fp3,fp2
fmoved fp2,_X:l
fmoved _X:l,fp2
fmovex fp2,fp1; fsubx fp3,fp1
fmovex fp2,fp3; fmulx fp2,fp3
fmovex fp1,fp2; fsubx fp3,fp2
fmoved fp2,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp3; fsubd _U1:l,fp3
fmoved fp3,_Z:l
movl #0,sp@
fmoved _Y:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjgt L194
fmoved _Z:l,fp3
fcmpx fp2,fp3; fjgt L194
movl #1,d7
jra L195
L194:
clrl d7
L195:
movl d7,sp@(4)
movl #L193,sp@(8)
jbsr _TstCond:l
fmoved _One:l,fp3
fmoved _U2:l,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmoved fp1,_Y:l
fmovex fp3,fp1; faddx fp2,fp1
fmoved fp1,_X:l
fmovex fp3,fp2; fdivd _Y:l,fp2
fmoved fp2,_Z:l
fmoved _Z:l,fp2
fsubd _X:l,fp2
fmoved fp2,_Y:l
fmoved _Three:l,fp2
fdivx fp2,fp3
fmoved fp3,_X:l
fmoved _Nine:l,fp3
fdivx fp3,fp2
fmoved fp2,_Z:l
fmoved _X:l,fp2
fmoved _Z:l,fp1
fsubx fp1,fp2
fmoved fp2,_X:l
fdivd _TwentySeven:l,fp3
fmoved fp3,_T:l
fmovex fp1,fp3; fsubd _T:l,fp3
fmoved fp3,_Z:l
movl #2,sp@
fmoved _X:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjne L198
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjne L198
fmoved _Z:l,fp3
fcmpx fp2,fp3; fjne L198
movl #1,d7
jra L199
L198:
clrl d7
L199:
movl d7,sp@(4)
movl #L197,sp@(8)
jbsr _TstCond:l
fmoved _F9:l,fp3
fmoved _One:l,fp2
fmovex fp3,fp1; fdivx fp2,fp1
fmoved fp1,_Y:l
fmoved _Half:l,fp1
fsubx fp1,fp3
fmoved fp3,_X:l
fmoved _Y:l,fp3
fsubx fp1,fp3
fsubd _X:l,fp3
fmoved fp3,_Y:l
fmovex fp2,fp3; faddd _U2:l,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fmovex fp3,fp1; fdivx fp2,fp1
fmoved fp1,_T:l
fmoved _T:l,fp2
fsubx fp3,fp2
fmoved fp2,_X:l
fmoved _X:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjne L200
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjne L200
fmoved _Z:l,fp3
fcmpx fp2,fp3; fjne L200
movl #1,_GDiv:l
jra L201
L200:
clrl _GDiv:l
movl #1,sp@
clrl sp@(4)
movl #L202,sp@(8)
jbsr _TstCond:l
L201:
fmoved _One:l,fp3
fmovex fp3,fp2; faddd _U2:l,fp2
fdivx fp2,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp3
fsubx fp2,fp3
fmoved fp3,_Y:l
movl #1,sp@
fmoved _Y:l,fp3
fcmpd _Zero:l,fp3; fjge L205
movl #1,d7
jra L206
L205:
clrl d7
L206:
movl d7,sp@(4)
movl #L204,sp@(8)
jbsr _TstCond:l
fmoved _One:l,fp3
fmoved _U2:l,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmoved fp1,_X:l
fmoved _Radix:l,fp1
fmovex fp1,fp0; fmulx fp2,fp0
faddx fp0,fp3
fmoved fp3,_Y:l
fmoved _X:l,fp3
fmovex fp3,fp2; fmulx fp1,fp2
fmoved fp2,_Z:l
fmoved _Y:l,fp2
fmovex fp2,fp0; fmulx fp1,fp0
fmoved fp0,_T:l
fmoved _Z:l,fp0
fdivx fp1,fp0
fmoved fp0,_R:l
fmoved _T:l,fp0
fdivx fp1,fp0
fmoved fp0,_StickyBit:l
fmoved _R:l,fp1
fsubx fp3,fp1
fmoved fp1,_X:l
fmoved _StickyBit:l,fp3
fsubx fp2,fp3
fmoved fp3,_Y:l
movl #0,sp@
fmoved _X:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjne L209
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjne L209
movl #1,d7
jra L210
L209:
clrl d7
L210:
movl d7,sp@(4)
movl #L208,sp@(8)
jbsr _TstCond:l
fmoved _One:l,fp3
fmoved _U1:l,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmoved fp1,_Y:l
fmovex fp3,fp1; fsubd _F9:l,fp1
fmoved fp1,_X:l
fsubd _Y:l,fp3
fmoved fp3,_Y:l
fmoved _Radix:l,fp3
fmoved _U2:l,fp1
fmovex fp3,fp0; fsubx fp1,fp0
fmoved fp0,_T:l
fmovex fp3,fp0; fsubd _BMinusU2:l,fp0
fmoved fp0,_Z:l
fsubd _T:l,fp3
fmoved fp3,_T:l
fmoved _X:l,fp3
fcmpx fp2,fp3; fjne L211
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjne L211
fmoved _Z:l,fp3
fcmpx fp1,fp3; fjne L211
fmoved _T:l,fp3
fcmpx fp1,fp3; fjne L211
movl #1,_GAddSub:l
jra L212
L211:
clrl _GAddSub:l
movl #1,sp@
clrl sp@(4)
movl #L213,sp@(8)
jbsr _TstCond:l
L212:
fmoved _F9:l,fp3
fmoved _One:l,fp2
fcmpx fp2,fp3; fjeq L214
fsubx fp2,fp3
fcmpd _Zero:l,fp3; fjlt L214
movl #1,sp@
movl #L216,sp@(4)
jbsr _BadCond:l
movl #L217,sp@
jbsr _printf:l
movl #L218,sp@
jbsr _printf:l
movl #L219,sp@
jbsr _printf:l
L214:
cmpl #1,_GMult:l; jne L220
cmpl #1,_GDiv:l; jne L220
cmpl #1,_GAddSub:l; jne L220
movl #L222,sp@
jbsr _printf:l
L220:
movl #40,_Milestone:l
jbsr _Pause:l
movl #L223,sp@
jbsr _printf:l
clrl _RMult:l
clrl _RDiv:l
clrl _RAddSub:l
fmoved _Radix:l,fp3
fmoved _Two:l,fp2
fdivx fp2,fp3
fmoved fp3,_RadixD2:l
fmoved fp2,_A1:l
clrl _Done:l
L224:
fmoved _Radix:l,fp3
fmoved fp3,_AInvrse:l
L227:
fmoved _AInvrse:l,fp3
fmoved fp3,_X:l
fdivd _A1:l,fp3
fmoved fp3,_AInvrse:l
L228:
fmoved _AInvrse:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpd _AInvrse:l,fp0; fjeq L227
fmoved _X:l,fp3
fcmpd _One:l,fp3; fjeq L233
fmoved _A1:l,fp3
fcmpd _Three:l,fp3; fjle L231
L233:
movl #1,d7
jra L232
L231:
clrl d7
L232:
movl d7,_Done:l
tstl _Done:l; jne L234
fmoved _Nine:l,fp3
faddd _One:l,fp3
fmoved fp3,_A1:l
L234:
L225:
tstl _Done:l; jeq L224
fmoved _X:l,fp3
fcmpd _One:l,fp3; fjne L236
fmoved _Radix:l,fp3
fmoved fp3,_A1:l
L236:
fmoved _One:l,fp3
fmoved _A1:l,fp2
fdivx fp2,fp3
fmoved fp3,_AInvrse:l
fmoved fp2,_X:l
fmoved _AInvrse:l,fp3
fmoved fp3,_Y:l
clrl _Done:l
L238:
fmoved _X:l,fp3
fmuld _Y:l,fp3
fsubd _Half:l,fp3
fmoved fp3,_Z:l
movl #0,sp@
fmoved _Z:l,fp3
fcmpd _Half:l,fp3; fjne L243
movl #1,d7
jra L244
L243:
clrl d7
L244:
movl d7,sp@(4)
movl #L242,sp@(8)
jbsr _TstCond:l
fmoved _X:l,fp3
fcmpd _Radix:l,fp3; fjne L246
movl #1,d7
jra L247
L246:
clrl d7
L247:
movl d7,_Done:l
fmoved _Radix:l,fp3
fmoved fp3,_X:l
fmoved _One:l,fp3
fdivd _X:l,fp3
fmoved fp3,_Y:l
L239:
tstl _Done:l; jeq L238
fmoved _One:l,fp3
fmoved _U2:l,fp2
fmovex fp2,fp6
fmovex fp3,fp1; faddx fp2,fp1
fmoved fp1,_Y2:l
fsubx fp2,fp3
fmoved fp3,_Y1:l
fmoved _OneAndHalf:l,fp3
fmovex fp3,fp7
fmovex fp3,fp1; fsubx fp2,fp1
fmoved fp1,_X:l
fmovex fp3,fp1; faddx fp2,fp1
fmoved fp1,_Y:l
fmoved _X:l,fp1
fmovex fp1,fp0; fsubx fp2,fp0
fmoved _Y2:l,fp3
fmovex fp3,fp5
fmulx fp3,fp0
fmoved fp0,_Z:l
fmoved _Y:l,fp0
fmoved _Y1:l,fp2
fmovex fp0,fp3; fmulx fp2,fp3
fmoved fp3,_T:l
fmoved _Z:l,fp3
fsubx fp1,fp3
fmoved fp3,_Z:l
fmoved _T:l,fp3
fsubx fp1,fp3
fmoved fp3,_T:l
fmovex fp1,fp3; fmulx fp5,fp3
fmoved fp3,_X:l
fmovex fp0,fp3; faddx fp6,fp3
fmulx fp2,fp3
fmoved fp3,_Y:l
fmoved _X:l,fp3
fsubx fp7,fp3
fmoved fp3,_X:l
fmoved _Y:l,fp3
fsubx fp7,fp3
fmoved fp3,_Y:l
fmoved _X:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjne L248
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjne L248
fmoved _Z:l,fp3
fcmpx fp2,fp3; fjne L248
fmoved _T:l,fp3
fcmpx fp2,fp3; fjgt L248
fmoved _OneAndHalf:l,fp3
fmovex fp3,fp7
fmoved _U2:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmoved _Y2:l,fp0
fmovex fp0,fp6
fmovex fp1,fp3; fmulx fp0,fp3
fmoved fp3,_X:l
fmovex fp7,fp3; fsubx fp2,fp3
fmovex fp3,fp0; fsubx fp2,fp0
fmoved fp0,_Y:l
faddx fp2,fp1
fmoved fp1,_Z:l
fmoved _Y1:l,fp1
fmovex fp1,fp5
fmulx fp1,fp3
fmoved fp3,_T:l
fmoved _X:l,fp3
fmoved _Z:l,fp0
fmovex fp0,fp1; faddx fp2,fp1
fmovex fp1,fp4
fsubx fp1,fp3
fmoved fp3,_X:l
fmoved _Y:l,fp3
fmovex fp3,fp1; fmulx fp5,fp1
fmoved fp1,_StickyBit:l
fmovex fp0,fp1; fmulx fp6,fp1
fmoved fp1,_S:l
fmoved _T:l,fp1
fsubx fp3,fp1
fmoved fp1,_T:l
fmovex fp2,fp1; fsubx fp3,fp1
fmovex fp1,fp3; faddd _StickyBit:l,fp3
fmoved fp3,_Y:l
fmoved _S:l,fp3
fmovex fp4,fp1; faddx fp2,fp1
fsubx fp1,fp3
fmoved fp3,_Z:l
fmovex fp6,fp3; faddx fp2,fp3
fmulx fp5,fp3
fmoved fp3,_StickyBit:l
fmovex fp6,fp3; fmulx fp5,fp3
fmoved fp3,_Y1:l
fmoved _StickyBit:l,fp3
fsubx fp6,fp3
fmoved fp3,_StickyBit:l
fmoved _Y1:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp3
fmoved fp3,_Y1:l
fmoved _X:l,fp3
fmoved _Zero:l,fp1
fcmpx fp1,fp3; fjne L250
fmoved _Y:l,fp3
fcmpx fp1,fp3; fjne L250
fmoved _Z:l,fp3
fcmpx fp1,fp3; fjne L250
fmoved _T:l,fp3
fcmpx fp1,fp3; fjne L250
fmoved _StickyBit:l,fp3
fcmpx fp1,fp3; fjne L250
fmoved _Y1:l,fp3
fcmpx fp2,fp3; fjne L250
movl #1,_RMult:l
movl #L252,sp@
jbsr _printf:l
jra L251
L250:
fmoved _X:l,fp3
fmoved _U2:l,fp2
faddx fp2,fp3
fmoved _Zero:l,fp1
fcmpx fp1,fp3; fjne L253
fmoved _Y:l,fp3
fcmpx fp1,fp3; fjge L253
fmoved _Z:l,fp3
faddx fp2,fp3
fcmpx fp1,fp3; fjne L253
fmoved _T:l,fp3
fcmpx fp1,fp3; fjge L253
fmoved _StickyBit:l,fp3
faddx fp2,fp3
fcmpx fp1,fp3; fjne L253
fmoved _Y1:l,fp3
fcmpd _Half:l,fp3; fjge L253
movl #2,_RMult:l
movl #L255,sp@
jbsr _printf:l
jra L254
L253:
movl #L256,sp@
jbsr _printf:l
L254:
L251:
cmpl #1,_RMult:l; jne L249
tstl _GMult:l; jne L249
movl #L259,sp@
jbsr _notify:l
jra L249
L248:
movl #L256,sp@
jbsr _printf:l
L249:
movl #45,_Milestone:l
fmoved _One:l,fp3
fmoved _U2:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmoved fp1,_Y2:l
fsubx fp2,fp3
fmoved fp3,_Y1:l
fmoved _OneAndHalf:l,fp3
fmovex fp3,fp6
fmovex fp3,fp1; faddx fp2,fp1
fmovex fp1,fp7
fmovex fp1,fp0; faddx fp2,fp0
fmoved fp0,_Z:l
fmoved _Z:l,fp0
fmoved _Y2:l,fp1
fmovex fp1,fp5
fmovex fp0,fp3; fdivx fp1,fp3
fmoved fp3,_X:l
fmovex fp6,fp3; fsubx fp2,fp3
fsubx fp2,fp3
fmoved fp3,_T:l
fmoved _T:l,fp3
fmovex fp3,fp4
fmovex fp3,fp1; fsubx fp2,fp1
fmoved _Y1:l,fp3
fdivx fp3,fp1
fmoved fp1,_Y:l
fmovex fp0,fp1; faddx fp2,fp1
fdivx fp5,fp1
fmoved fp1,_Z:l
fmoved _X:l,fp1
fsubx fp6,fp1
fmoved fp1,_X:l
fmoved _Y:l,fp1
fsubx fp4,fp1
fmoved fp1,_Y:l
fmovex fp4,fp1; fdivx fp3,fp1
fmoved fp1,_T:l
fmoved _Z:l,fp3
fsubx fp7,fp3
fmoved fp3,_Z:l
fmovex fp2,fp3; fsubx fp6,fp3
faddd _T:l,fp3
fmoved fp3,_T:l
fmoved _X:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjgt L260
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjgt L260
fmoved _Z:l,fp3
fcmpx fp2,fp3; fjgt L260
fmoved _T:l,fp3
fcmpx fp2,fp3; fjgt L260
fmoved _OneAndHalf:l,fp3
fmoved _Y2:l,fp2
fmovex fp2,fp7
fmovex fp3,fp1; fdivx fp2,fp1
fmoved fp1,_X:l
fmoved _U2:l,fp1
fmovex fp1,fp6
fmovex fp3,fp0; fsubx fp1,fp0
fmoved fp0,_Y:l
fmovex fp3,fp0; faddx fp1,fp0
fmoved fp0,_Z:l
fmoved _X:l,fp0
fmoved _Y:l,fp2
fsubx fp2,fp0
fmoved fp0,_X:l
fmoved _Y1:l,fp0
fmovex fp3,fp1; fdivx fp0,fp1
fmoved fp1,_T:l
fdivx fp0,fp2
fmoved fp2,_Y:l
fmoved _T:l,fp2
fmoved _Z:l,fp1
fmovex fp1,fp0; faddx fp6,fp0
fsubx fp0,fp2
fmoved fp2,_T:l
fmoved _Y:l,fp2
fsubx fp1,fp2
fmoved fp2,_Y:l
fmovex fp1,fp2; fdivx fp7,fp2
fmoved fp2,_Z:l
fmovex fp7,fp2; faddx fp6,fp2
fdivx fp7,fp2
fmoved fp2,_Y1:l
fmoved _Z:l,fp2
fsubx fp3,fp2
fmoved fp2,_Z:l
fmoved _Y1:l,fp3
fsubx fp7,fp3
fmoved fp3,_Y2:l
fmoved _F9:l,fp3
fmovex fp3,fp2; fsubd _U1:l,fp2
fdivx fp3,fp2
fmoved fp2,_Y1:l
fmoved _X:l,fp2
fmoved _Zero:l,fp1
fcmpx fp1,fp2; fjne L262
fmoved _Y:l,fp2
fcmpx fp1,fp2; fjne L262
fmoved _Z:l,fp2
fcmpx fp1,fp2; fjne L262
fmoved _T:l,fp2
fcmpx fp1,fp2; fjne L262
fmoved _Y2:l,fp2
fcmpx fp1,fp2; fjne L262
fcmpx fp1,fp2; fjne L262
fmoved _Y1:l,fp2
fmoved _Half:l,fp1
fsubx fp1,fp2
fsubx fp1,fp3
fcmpx fp3,fp2; fjne L262
movl #1,_RDiv:l
movl #L264,sp@
jbsr _printf:l
tstl _GDiv:l; jne L263
movl #L267,sp@
jbsr _notify:l
jra L263
L262:
fmoved _X:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjge L268
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjge L268
fmoved _Z:l,fp3
fcmpx fp2,fp3; fjge L268
fmoved _T:l,fp3
fcmpx fp2,fp3; fjge L268
fmoved _Y2:l,fp3
fcmpx fp2,fp3; fjge L268
fmoved _Y1:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp3
fmoved _F9:l,fp1
fsubx fp2,fp1
fcmpx fp1,fp3; fjge L268
movl #2,_RDiv:l
movl #L270,sp@
jbsr _printf:l
L268:
L263:
L260:
tstl _RDiv:l; jne L271
movl #L273,sp@
jbsr _printf:l
L271:
fmoved _One:l,fp3
fdivd _Radix:l,fp3
fmoved fp3,_BInvrse:l
movl #0,sp@
fmoved _BInvrse:l,fp3
fmuld _Radix:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp3
fcmpx fp2,fp3; fjne L276
movl #1,d7
jra L277
L276:
clrl d7
L277:
movl d7,sp@(4)
movl #L275,sp@(8)
jbsr _TstCond:l
movl #50,_Milestone:l
movl #0,sp@
fmoved _F9:l,fp3
faddd _U1:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp3
fcmpx fp2,fp3; fjne L280
fmoved _BMinusU2:l,fp3
faddd _U2:l,fp3
fmoved _One:l,fp2
fsubx fp2,fp3
fmoved _Radix:l,fp1
fsubx fp2,fp1
fcmpx fp1,fp3; fjne L280
movl #1,d7
jra L281
L280:
clrl d7
L281:
movl d7,sp@(4)
movl #L279,sp@(8)
jbsr _TstCond:l
fmoved _One:l,fp3
fmoved _U1:l,fp2
fmovex fp2,fp1; fmulx fp2,fp1
fmovex fp3,fp2; fsubx fp1,fp2
fmoved fp2,_X:l
fmoved _U2:l,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmulx fp1,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmoved fp1,_Y:l
fmoved _F9:l,fp2
fmoved _Half:l,fp1
fsubx fp1,fp2
fmoved fp2,_Z:l
fmoved _X:l,fp2
fsubx fp1,fp2
fsubd _Z:l,fp2
fmoved fp2,_X:l
fmoved _Y:l,fp2
fsubx fp3,fp2
fmoved fp2,_Y:l
fmoved _X:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjne L282
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjne L282
movl #2,_RAddSub:l
movl #L284,sp@
jbsr _printf:l
L282:
cmpl #1,_GAddSub:l; jne L285
fmoved _Half:l,fp3
fmoved _U2:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmulx fp2,fp1
fmoved fp1,_X:l
fsubx fp2,fp3
fmulx fp2,fp3
fmoved fp3,_Y:l
fmoved _One:l,fp3
fmovex fp3,fp1; faddd _X:l,fp1
fmoved fp1,_X:l
fmovex fp3,fp1; faddd _Y:l,fp1
fmoved fp1,_Y:l
fmovex fp3,fp1; faddx fp2,fp1
fmovex fp1,fp2; fsubd _X:l,fp2
fmoved fp2,_X:l
fsubd _Y:l,fp3
fmoved fp3,_Y:l
fmoved _X:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjne L287
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjne L287
fmoved _Half:l,fp3
fmoved _U2:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmoved _U1:l,fp0
fmulx fp0,fp1
fmoved fp1,_X:l
fsubx fp2,fp3
fmulx fp0,fp3
fmoved fp3,_Y:l
fmoved _One:l,fp3
fmovex fp3,fp2; fsubd _X:l,fp2
fmoved fp2,_X:l
fmovex fp3,fp2; fsubd _Y:l,fp2
fmoved fp2,_Y:l
fmoved _F9:l,fp2
fsubd _X:l,fp2
fmoved fp2,_X:l
fsubd _Y:l,fp3
fmoved fp3,_Y:l
fmoved _X:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjne L289
fmoved _Y:l,fp3
fcmpx fp2,fp3; fjne L289
movl #1,_RAddSub:l
movl #L291,sp@
jbsr _printf:l
tstl _GAddSub:l; jne L286
movl #L294,sp@
jbsr _notify:l
jra L286
L289:
movl #L295,sp@
jbsr _printf:l
jra L286
L287:
movl #L295,sp@
jbsr _printf:l
jra L286
L285:
movl #L295,sp@
jbsr _printf:l
L286:
fmoved _One:l,fp3
fmoved fp3,_S:l
fmoved _Half:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmovex fp2,fp0; fmulx fp1,fp0
fmovex fp3,fp1; faddx fp0,fp1
fmoved fp1,_X:l
faddd _U2:l,fp3
fmulx fp2,fp3
fmoved fp3,_Y:l
fmoved _X:l,fp3
fmoved _Y:l,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmoved fp1,_Z:l
fsubx fp3,fp2
fmoved fp2,_T:l
fmoved _Z:l,fp3
faddd _T:l,fp3
fmoved fp3,_StickyBit:l
fmoved _StickyBit:l,fp3
fcmpd _Zero:l,fp3; fjeq L296
fmoved _Zero:l,fp3
fmoved fp3,_S:l
movl #3,sp@
movl #L298,sp@(4)
jbsr _BadCond:l
L296:
fmoved _Zero:l,fp3
fmoved fp3,_StickyBit:l
cmpl #1,_GMult:l; jne L299
cmpl #1,_GDiv:l; jne L299
cmpl #1,_GAddSub:l; jne L299
cmpl #1,_RMult:l; jne L299
cmpl #1,_RDiv:l; jne L299
cmpl #1,_RAddSub:l; jne L299
fmoved _RadixD2:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpd _RadixD2:l,fp0; fjne L299
movl #L301,sp@
jbsr _printf:l
fmoved _Half:l,fp3
fmovex fp3,fp2; faddd _U1:l,fp2
fmoved _U2:l,fp1
fmulx fp1,fp2
fmoved fp2,_X:l
fmulx fp1,fp3
fmoved fp3,_Y:l
fmoved _One:l,fp3
fmovex fp3,fp2; faddd _Y:l,fp2
fmoved fp2,_Z:l
fmovex fp3,fp2; faddd _X:l,fp2
fmoved fp2,_T:l
fmoved _Z:l,fp2
fsubx fp3,fp2
fcmpd _Zero:l,fp2; fjgt L302
fmoved _T:l,fp2
fsubx fp3,fp2
fcmpx fp1,fp2; fjlt L302
fmoved _T:l,fp3
fmovex fp3,fp2; faddd _Y:l,fp2
fmoved fp2,_Z:l
fmoved _Z:l,fp2
fmovex fp2,fp1; fsubd _X:l,fp1
fmoved fp1,_Y:l
fsubx fp3,fp2
fcmpd _U2:l,fp2; fjlt L304
fmoved _Y:l,fp2
fsubx fp3,fp2
fcmpd _Zero:l,fp2; fjne L304
fmoved _Half:l,fp3
fmoved _U1:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmulx fp2,fp1
fmoved fp1,_X:l
fmulx fp2,fp3
fmoved fp3,_Y:l
fmoved _One:l,fp3
fmovex fp3,fp2; fsubd _Y:l,fp2
fmoved fp2,_Z:l
fmovex fp3,fp2; fsubd _X:l,fp2
fmoved fp2,_T:l
fmoved _Z:l,fp2
fsubx fp3,fp2
fmoved _Zero:l,fp3
fcmpx fp3,fp2; fjne L306
fmoved _T:l,fp2
fsubd _F9:l,fp2
fcmpx fp3,fp2; fjne L306
fmoved _Half:l,fp3
fmoved _U1:l,fp2
fsubx fp2,fp3
fmulx fp2,fp3
fmoved fp3,_Z:l
fmoved _F9:l,fp3
fmovex fp3,fp1; fsubd _Z:l,fp1
fmoved fp1,_T:l
fmovex fp3,fp1; fsubd _Y:l,fp1
fmoved fp1,_Q:l
fmoved _T:l,fp1
fsubx fp3,fp1
fmoved _Zero:l,fp0
fcmpx fp0,fp1; fjne L308
fsubx fp2,fp3
fsubd _Q:l,fp3
fcmpx fp0,fp3; fjne L308
fmoved _One:l,fp3
fmoved _U2:l,fp2
fmovex fp2,fp7
fmovex fp3,fp1; faddx fp2,fp1
fmoved _OneAndHalf:l,fp0
fmulx fp0,fp1
fmoved fp1,_Z:l
fmovex fp0,fp1; faddx fp2,fp1
fsubd _Z:l,fp1
faddx fp2,fp1
fmoved fp1,_T:l
fmoved _Half:l,fp1
fmoved _Radix:l,fp0
fdivx fp0,fp1
fmovex fp3,fp2; faddx fp1,fp2
fmoved fp2,_X:l
fmovex fp0,fp2; fmulx fp7,fp2
faddx fp2,fp3
fmoved fp3,_Y:l
fmoved _X:l,fp3
fmovex fp3,fp1; fmuld _Y:l,fp1
fmoved fp1,_Z:l
fmoved _T:l,fp1
fmoved _Zero:l,fp0
fcmpx fp0,fp1; fjne L310
faddx fp2,fp3
fsubd _Z:l,fp3
fcmpx fp0,fp3; fjne L310
fmoved _Radix:l,fp3
fcmpd _Two:l,fp3; fjeq L312
fmoved _Two:l,fp3
fmovex fp3,fp2; faddd _U2:l,fp2
fmoved fp2,_X:l
fmoved _X:l,fp2
fdivx fp3,fp2
fmoved fp2,_Y:l
fmoved _Y:l,fp3
fsubd _One:l,fp3
fcmpd _Zero:l,fp3; fjne L313
fmoved _S:l,fp3
fmoved fp3,_StickyBit:l
jra L313
L312:
fmoved _S:l,fp3
fmoved fp3,_StickyBit:l
L313:
L310:
L308:
L306:
L304:
L302:
L299:
fmoved _StickyBit:l,fp3
fcmpd _One:l,fp3; fjne L316
movl #L318,sp@
jbsr _printf:l
jra L317
L316:
movl #L319,sp@
jbsr _printf:l
L317:
movl #3,sp@
tstl _GMult:l; jeq L322
tstl _GDiv:l; jeq L322
tstl _GAddSub:l; jeq L322
tstl _RMult:l; jeq L322
tstl _RDiv:l; jeq L322
tstl _RAddSub:l; jeq L322
movl #1,d7
jra L323
L322:
clrl d7
L323:
movl d7,sp@(4)
movl #L321,sp@(8)
jbsr _TstCond:l
movl #60,_Milestone:l
movl #L47,sp@
jbsr _printf:l
movl #L324,sp@
jbsr _printf:l
movl #L325,sp@
movl _NoTrials:l,sp@(4)
jbsr _printf:l
fmoved L326:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Random9:l
fmoved _Third:l,fp3
fmoved fp3,_Random1:l
movl #1,_I:l
L327:
jbsr _Random:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_X:l
jbsr _Random:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Y:l
fmoved _Y:l,fp3
fmoved _X:l,fp2
fmovex fp3,fp1; fmulx fp2,fp1
fmoved fp1,_Z9:l
fmulx fp3,fp2
fmoved fp2,_Z:l
fmoved _Z:l,fp3
fsubd _Z9:l,fp3
fmoved fp3,_Z9:l
addql #1,_I:l
L328:
movl _I:l,d4
cmpl _NoTrials:l,d4; jgt L330
fmoved _Z9:l,fp3
fcmpd _Zero:l,fp3; fjeq L327
L330:
movl _I:l,d4
cmpl _NoTrials:l,d4; jne L331
fmoved _One:l,fp3
fmoved _Half:l,fp2
fdivd _Three:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmoved fp1,_Random1:l
fmoved _U2:l,fp2
faddd _U1:l,fp2
faddx fp3,fp2
fmovex fp2,fp7
fmoved fp2,_Random2:l
fmoved _Random1:l,fp3
fmoved _Random2:l,fp0
fmovex fp3,fp2; fmulx fp0,fp2
fmoved fp2,_Z:l
fmovex fp0,fp2; fmulx fp3,fp2
fmoved fp2,_Y:l
fmovex fp1,fp3; fmulx fp7,fp3
fmovex fp3,fp2; fsubx fp3,fp2
fmoved fp2,_Z9:l
L331:
movl _I:l,d4
cmpl _NoTrials:l,d4; jeq L333
fmoved _Z9:l,fp3
fcmpd _Zero:l,fp3; fjeq L333
movl #2,sp@
movl #L335,sp@(4)
jbsr _BadCond:l
jra L334
L333:
movl #L336,sp@
movl _NoTrials:l,sp@(4)
jbsr _printf:l
L334:
movl #70,_Milestone:l
movl #L337,sp@
jbsr _printf:l
fmoved _Zero:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpx fp0,fp3; fjne L340
fnegd _Zero:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpx fp0,fp3; fjne L340
fmoved _One:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpx fp0,fp3; fjne L340
movl #1,d7
jra L341
L340:
clrl d7
L341:
movl #0,sp@
movl d7,sp@(4)
movl #L339,sp@(8)
jbsr _TstCond:l
fmoved _Zero:l,fp3
fmoved fp3,_MinSqEr:l
fmoved fp3,_MaxSqEr:l
fmoved fp3,_J:l
fmoved _Radix:l,fp3
fmoved fp3,_X:l
fmoved _U2:l,fp3
fmoved fp3,_OneUlp:l
movl #1,sp@
jbsr _SqXMinX:l
fmoved _BInvrse:l,fp3
fmoved fp3,_X:l
fmuld _U1:l,fp3
fmoved fp3,_OneUlp:l
movl #1,sp@
jbsr _SqXMinX:l
fmoved _U1:l,fp3
fmoved fp3,_X:l
fmovex fp3,fp2; fmulx fp3,fp2
fmoved fp2,_OneUlp:l
movl #1,sp@
jbsr _SqXMinX:l
fmoved _J:l,fp3
fcmpd _Zero:l,fp3; fjeq L342
jbsr _Pause:l
L342:
movl #L344,sp@
movl _NoTrials:l,sp@(4)
jbsr _printf:l
fmoved _Zero:l,fp3
fmoved fp3,_J:l
fmoved _Two:l,fp3
fmoved fp3,_X:l
fmoved _Radix:l,fp3
fmoved fp3,_Y:l
fcmpd _One:l,fp3; fjeq L345
L347:
fmoved _Y:l,fp3
fmoved fp3,_X:l
fmoved _Radix:l,fp2
fmulx fp3,fp2
fmoved fp2,_Y:l
L348:
fmoved _Y:l,fp3
fsubd _X:l,fp3
movl _NoTrials:l,d4
fcmpl d4,fp3; fjlt L347
L345:
fmoved _X:l,fp3
fmuld _U2:l,fp3
fmoved fp3,_OneUlp:l
movl #1,_I:l
jra L351
L350:
fmoved _X:l,fp3
faddd _One:l,fp3
fmoved fp3,_X:l
movl #2,sp@
jbsr _SqXMinX:l
fmoved _J:l,fp3
fcmpd _Zero:l,fp3; fjle L353
jra L352
L353:
addql #1,_I:l
L351:
movl _I:l,d4
cmpl _NoTrials:l,d4; jle L350
L352:
movl #L355,sp@
jbsr _printf:l
movl #-1,_I:l
fmoved _BMinusU2:l,fp3
fmoved fp3,_X:l
fmoved _Radix:l,fp3
fmoved fp3,_Y:l
fmovex fp3,fp2; fmuld _U2:l,fp2
faddx fp2,fp3
fmoved fp3,_Z:l
clrl _NotMonot:l
clrl _Monot:l
jra L357
L356:
addql #1,_I:l
fmoved _X:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_X:l
fmoved _Y:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Q:l
fmoved _Z:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Z:l
fmoved _X:l,fp3
fmoved _Q:l,fp2
fcmpx fp2,fp3; fjgt L361
fcmpd _Z:l,fp2; fjle L359
L361:
movl #1,_NotMonot:l
jra L360
L359:
fmoved _Q:l,fp3
faddd _Half:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Q:l
tstl _I:l; jgt L364
fmoved _Radix:l,fp3
fmoved _Q:l,fp2
fmovex fp2,fp1; fmulx fp2,fp1
fcmpx fp1,fp3; fjne L362
L364:
movl #1,_Monot:l
jra L363
L362:
tstl _I:l; jle L365
cmpl #1,_I:l; jle L367
movl #1,_Monot:l
jra L366
L367:
fmoved _Y:l,fp3
fmuld _BInvrse:l,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fmoved _U1:l,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmoved fp1,_X:l
faddx fp2,fp3
fmoved fp3,_Z:l
jra L366
L365:
fmoved _Q:l,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fmoved _U2:l,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmoved fp1,_X:l
faddx fp2,fp3
fmoved fp3,_Z:l
L366:
L363:
L360:
L357:
tstl _NotMonot:l; jne L369
tstl _Monot:l; jeq L356
L369:
tstl _Monot:l; jeq L370
movl #L372,sp@
jbsr _printf:l
jra L371
L370:
movl #2,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
movl #L373,sp@
fmoved _Y:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L371:
movl #80,_Milestone:l
fmoved _MinSqEr:l,fp3
fmoved _Half:l,fp2
faddx fp2,fp3
fmoved fp3,_MinSqEr:l
fmoved _MaxSqEr:l,fp3
fsubx fp2,fp3
fmoved fp3,_MaxSqEr:l
fmoved _One:l,fp3
faddd _U2:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _One:l,fp3
fmovex fp0,fp2; fsubx fp3,fp2
fmoved _U2:l,fp1
fdivx fp1,fp2
fmoved fp2,_Y:l
fmoved _Y:l,fp2
fsubx fp3,fp2
fmovex fp1,fp3; fdivd _Eight:l,fp3
faddx fp3,fp2
fmoved fp2,_SqEr:l
fmoved _SqEr:l,fp3
fcmpd _MaxSqEr:l,fp3; fjle L374
fmoved _SqEr:l,fp3
fmoved fp3,_MaxSqEr:l
L374:
fmoved _Y:l,fp3
fmoved _U2:l,fp2
fdivd _Eight:l,fp2
faddx fp2,fp3
fmoved fp3,_SqEr:l
fmoved _SqEr:l,fp3
fcmpd _MinSqEr:l,fp3; fjge L376
fmoved _SqEr:l,fp3
fmoved fp3,_MinSqEr:l
L376:
fmoved _F9:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _U2:l,fp3
fmovex fp0,fp2; fsubx fp3,fp2
fmoved _One:l,fp1
fsubx fp3,fp1
fmovex fp2,fp3; fsubx fp1,fp3
fmoved _U1:l,fp2
fdivx fp2,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fdivd _Eight:l,fp2
faddx fp2,fp3
fmoved fp3,_SqEr:l
fmoved _SqEr:l,fp3
fcmpd _MaxSqEr:l,fp3; fjle L378
fmoved _SqEr:l,fp3
fmoved fp3,_MaxSqEr:l
L378:
fmoved _Y:l,fp3
faddd _One:l,fp3
fmoved _U1:l,fp2
fdivd _Eight:l,fp2
faddx fp2,fp3
fmoved fp3,_SqEr:l
fmoved _SqEr:l,fp3
fcmpd _MinSqEr:l,fp3; fjge L380
fmoved _SqEr:l,fp3
fmoved fp3,_MinSqEr:l
L380:
fmoved _U2:l,fp3
fmoved fp3,_OneUlp:l
fmoved _OneUlp:l,fp3
fmoved fp3,_X:l
movl #1,_Indx:l
L382:
fmoved _X:l,fp3
fmovex fp3,fp2; faddd _U1:l,fp2
faddx fp3,fp2
fmovex fp2,fp3; faddd _F9:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Y:l
fmoved _Y:l,fp3
fmoved _U2:l,fp2
fsubx fp2,fp3
fmoved _One:l,fp1
fsubx fp2,fp1
fmoved _X:l,fp2
faddx fp2,fp1
fsubx fp1,fp3
fmoved _OneUlp:l,fp1
fdivx fp1,fp3
fmoved fp3,_Y:l
fmoved _U1:l,fp3
fsubx fp2,fp3
faddd _F9:l,fp3
fmoved _Half:l,fp0
fmulx fp0,fp3
fmulx fp2,fp3
fmulx fp2,fp3
fdivx fp1,fp3
fmoved fp3,_Z:l
fmoved _Y:l,fp3
faddx fp0,fp3
faddd _Z:l,fp3
fmoved fp3,_SqEr:l
fmoved _SqEr:l,fp3
fcmpd _MinSqEr:l,fp3; fjge L386
fmoved _SqEr:l,fp3
fmoved fp3,_MinSqEr:l
L386:
fmoved _Y:l,fp3
fsubd _Half:l,fp3
faddd _Z:l,fp3
fmoved fp3,_SqEr:l
fmoved _SqEr:l,fp3
fcmpd _MaxSqEr:l,fp3; fjle L388
fmoved _SqEr:l,fp3
fmoved fp3,_MaxSqEr:l
L388:
movl _Indx:l,d4
cmpl #1,d4; jeq L392
cmpl #3,d4; jne L390
L392:
fmoved _X:l,fp3
fmoved fp3,sp@(0)
jbsr _Sign:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp7
fmoved _OneUlp:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _Eight:l,fp3
fmoved _Nine:l,fp2
fmulx fp0,fp2
fdivx fp2,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _OneUlp:l,fp3
fmulx fp7,fp3
fmulx fp0,fp3
fmoved fp3,_X:l
jra L391
L390:
fmoved _U1:l,fp3
fmoved fp3,_OneUlp:l
fnegd _OneUlp:l,fp3
fmoved fp3,_X:l
L391:
L383:
addql #1,_Indx:l
cmpl #3,_Indx:l; jle L382
movl #85,_Milestone:l
clrl _SqRWrng:l
clrl _Anomaly:l
clrl _RSqrt:l
fmoved _Radix:l,fp3
fcmpd _One:l,fp3; fjeq L393
movl #L395,sp@
jbsr _printf:l
fmoved _Precision:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _Radix:l,fp2
fmoved fp2,sp@(0)
fmoved _One:l,fp2
faddx fp3,fp2
fmovex fp2,fp3; fsubx fp0,fp3
fmoved fp3,sp@(8)
jbsr _pow:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _Half:l,fp3
faddx fp0,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_D:l
fmoved _D:l,fp3
fmovex fp3,fp2; fdivd _Radix:l,fp2
fmoved fp2,_X:l
fdivd _A1:l,fp3
fmoved fp3,_Y:l
fmoved _X:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpx fp0,fp3; fjne L398
fmoved _Y:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpx fp0,fp3; fjeq L396
L398:
movl #1,_Anomaly:l
jra L397
L396:
fmoved _Zero:l,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fmoved fp3,_Z2:l
fmoved _One:l,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp2
fmoved fp2,_Y2:l
fmoved _Radix:l,fp2
fsubx fp3,fp2
fmoved fp2,_Z1:l
fmoved _Four:l,fp3
fmuld _D:l,fp3
fmoved fp3,_FourD:l
L399:
fmoved _Y2:l,fp3
fcmpd _Z2:l,fp3; fjle L402
fmoved _Radix:l,fp3
fmoved fp3,_Q:l
fmoved _Y:l,fp3
fmoved fp3,_Y1:l
L404:
fmoved _Half:l,fp3
fmoved _Q:l,fp2
fmovex fp2,fp1; fdivd _Y1:l,fp1
fsubx fp1,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp3; fmuld _Y1:l,fp3
faddx fp3,fp2
fmoved fp2,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_X1:l
fmoved _Y1:l,fp3
fmoved fp3,_Q:l
fmoved _X1:l,fp3
fmoved fp3,_Y1:l
L405:
fmoved _X1:l,fp3
fcmpd _Zero:l,fp3; fjgt L404
fmoved _Q:l,fp3
fcmpd _One:l,fp3; fjgt L407
fmoved _Y2:l,fp3
fmoved fp3,_Z2:l
fmoved _Y:l,fp3
fmoved fp3,_Z:l
L407:
L402:
fmoved _Y:l,fp3
faddd _Two:l,fp3
fmoved fp3,_Y:l
fmoved _X:l,fp3
faddd _Eight:l,fp3
fmoved fp3,_X:l
fmoved _Y2:l,fp3
faddd _X:l,fp3
fmoved fp3,_Y2:l
fmoved _Y2:l,fp3
fcmpd _FourD:l,fp3; fjlt L409
fmoved _Y2:l,fp3
fsubd _FourD:l,fp3
fmoved fp3,_Y2:l
L409:
L400:
fmoved _Y:l,fp3
fcmpd _D:l,fp3; fjlt L399
fmoved _FourD:l,fp3
fmovex fp3,fp2; fsubd _Z2:l,fp2
fmoved fp2,_X8:l
fmoved _X8:l,fp2
fmoved _Z:l,fp1
fmovex fp1,fp0; fmulx fp1,fp0
fmovex fp2,fp1; faddx fp0,fp1
fdivx fp3,fp1
fmoved fp1,_Q:l
fmovex fp2,fp3; fdivd _Eight:l,fp3
fmoved fp3,_X8:l
fmoved _Q:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpx fp0,fp3; fjeq L411
movl #1,_Anomaly:l
jra L412
L411:
clrl _Break:l
L413:
fmoved _Z1:l,fp3
fmuld _Z:l,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fmovex fp3,fp2; fdivd _Radix:l,fp2
fmoved fp2,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp2; fmuld _Radix:l,fp2
fsubx fp2,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fcmpd _One:l,fp3; fjne L416
movl #1,_Break:l
jra L417
L416:
fmoved _Z1:l,fp3
fsubd _One:l,fp3
fmoved fp3,_Z1:l
L417:
L414:
tstl _Break:l; jne L418
fmoved _Z1:l,fp3
fcmpd _Zero:l,fp3; fjgt L413
L418:
fmoved _Z1:l,fp3
fcmpd _Zero:l,fp3; fjgt L419
tstl _Break:l; jne L419
movl #1,_Anomaly:l
jra L420
L419:
fmoved _Z1:l,fp3
fcmpd _RadixD2:l,fp3; fjle L421
fmoved _Z1:l,fp3
fsubd _Radix:l,fp3
fmoved fp3,_Z1:l
L421:
L423:
jbsr _NewD:l
L424:
fmoved _U2:l,fp3
fmuld _D:l,fp3
fcmpd _F9:l,fp3; fjlt L423
fmoved _D:l,fp3
fmovex fp3,fp2; fmuld _Radix:l,fp2
fsubx fp3,fp2
fmoved _W:l,fp1
fsubx fp3,fp1
fcmpx fp1,fp2; fjeq L426
movl #1,_Anomaly:l
jra L427
L426:
fmoved _D:l,fp3
fmoved fp3,_Z2:l
clrl _I:l
fmoved _One:l,fp2
fmoved _Z:l,fp1
faddx fp1,fp2
fmuld _Half:l,fp2
fmovex fp3,fp0; faddx fp2,fp0
fmoved fp0,_Y:l
faddx fp1,fp3
faddd _Q:l,fp3
fmoved fp3,_X:l
jbsr _SR3750:l
fmoved _D:l,fp3
fmoved _One:l,fp2
fmoved _Z:l,fp1
fsubx fp1,fp2
fmuld _Half:l,fp2
fmovex fp3,fp0; faddx fp2,fp0
fmovex fp0,fp2; faddx fp3,fp2
fmoved fp2,_Y:l
fmovex fp3,fp2; fsubx fp1,fp2
faddx fp3,fp2
fmoved fp2,_X:l
fmoved _X:l,fp3
fmovex fp3,fp2; faddd _Q:l,fp2
faddx fp3,fp2
fmoved fp2,_X:l
jbsr _SR3750:l
jbsr _NewD:l
fmoved _D:l,fp3
fmoved _Z2:l,fp2
fsubx fp2,fp3
fmoved _W:l,fp1
fsubx fp2,fp1
fcmpx fp1,fp3; fjeq L428
movl #1,_Anomaly:l
jra L429
L428:
fmoved _D:l,fp3
fmoved _Z2:l,fp2
fsubx fp2,fp3
fmoved _One:l,fp1
fmoved _Z:l,fp0
fmovex fp0,fp7
fsubx fp0,fp1
fmuld _Half:l,fp1
fmovex fp2,fp0; faddx fp1,fp0
fmovex fp3,fp1; faddx fp0,fp1
fmoved fp1,_Y:l
fsubx fp7,fp2
faddd _Q:l,fp2
faddx fp2,fp3
fmoved fp3,_X:l
jbsr _SR3750:l
fmoved _One:l,fp3
faddd _Z:l,fp3
fmuld _Half:l,fp3
fmoved fp3,_Y:l
fmoved _Q:l,fp3
fmoved fp3,_X:l
jbsr _SR3750:l
tstl _I:l; jne L430
movl #1,_Anomaly:l
L430:
L429:
L427:
L420:
L412:
L397:
tstl _I:l; jeq L434
tstl _Anomaly:l; jeq L432
L434:
movl #0,sp@
movl #L435,sp@(4)
jbsr _BadCond:l
movl #L436,sp@
fmoved _W:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L437,sp@
jbsr _printf:l
movl #1,_SqRWrng:l
L432:
L393:
tstl _Anomaly:l; jne L438
fmoved _MinSqEr:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjlt L440
fmoved _MaxSqEr:l,fp3
fcmpx fp2,fp3; fjgt L440
movl #1,_RSqrt:l
movl #L442,sp@
jbsr _printf:l
jra L441
L440:
fmoved _MaxSqEr:l,fp3
fmoved _U2:l,fp2
faddx fp2,fp3
fmoved _Half:l,fp1
fsubx fp1,fp2
fcmpx fp2,fp3; fjgt L446
fmoved _MinSqEr:l,fp3
fcmpx fp1,fp3; fjgt L446
faddd _Radix:l,fp3
fcmpx fp1,fp3; fjge L443
L446:
movl #1,_SqRWrng:l
jra L444
L443:
movl #2,_RSqrt:l
movl #L447,sp@
jbsr _printf:l
L444:
L441:
L438:
tstl _SqRWrng:l; jeq L448
movl #L450,sp@
jbsr _printf:l
movl #L451,sp@
fmoved _MinSqEr:l,fp3
fsubd _Half:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L452,sp@
fmoved _Half:l,fp3
faddd _MaxSqEr:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #1,sp@
fmoved _MaxSqEr:l,fp3
fsubd _MinSqEr:l,fp3
fmoved _Radix:l,fp2
fmovex fp2,fp1; fmulx fp2,fp1
fcmpx fp1,fp3; fjge L455
movl #1,d7
jra L456
L455:
clrl d7
L456:
movl d7,sp@(4)
movl #L454,sp@(8)
jbsr _TstCond:l
L448:
movl #90,_Milestone:l
jbsr _Pause:l
movl #L457,sp@
jbsr _printf:l
clrl _N:l
clrl _I:l
fnegd _Zero:l,fp3
fmoved fp3,_Z:l
movl #3,_M:l
clrl _Break:l
L458:
fmoved _One:l,fp3
fmoved fp3,_X:l
jbsr _SR3980:l
cmpl #10,_I:l; jgt L461
movl #1023,_I:l
jbsr _SR3980:l
L461:
fmoved _Z:l,fp3
fcmpd _MinusOne:l,fp3; fjne L463
movl #1,_Break:l
jra L464
L463:
fmoved _MinusOne:l,fp3
fmoved fp3,_Z:l
jbsr _PrintIfNPositive:l
clrl _N:l
movl #-4,_I:l
L464:
L459:
tstl _Break:l; jeq L458
jbsr _PrintIfNPositive:l
movl _N:l,_N1:l
clrl _N:l
fmoved _A1:l,fp3
fmoved fp3,_Z:l
fmoved _W:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp7
fmoved _A1:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _Two:l,fp3
fmulx fp7,fp3
fdivx fp0,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fintrzx fp0,fp0; fmovel fp0,d4
movl d4,_M:l
clrl _Break:l
L465:
fmoved _Z:l,fp3
fmoved fp3,_X:l
movl #1,_I:l
jbsr _SR3980:l
fmoved _Z:l,fp3
fcmpd _AInvrse:l,fp3; fjne L468
movl #1,_Break:l
jra L469
L468:
fmoved _AInvrse:l,fp3
fmoved fp3,_Z:l
L469:
L466:
tstl _Break:l; jeq L465
movl #100,_Milestone:l
movl _NoTrials:l,_M:l
fmoved _Three:l,fp3
fmoved fp3,_Z:l
L470:
fmoved _Z:l,fp3
fmoved fp3,_X:l
movl #1,_I:l
jbsr _SR3980:l
L473:
fmoved _Z:l,fp3
faddd _Two:l,fp3
fmoved fp3,_Z:l
L474:
fmoved _Z:l,fp3
fmoved _Three:l,fp2
fdivx fp2,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp2,fp3; fmulx fp0,fp3
fcmpd _Z:l,fp3; fjeq L473
L471:
fmoved _Z:l,fp3
fmoved _Eight:l,fp2
fmuld _Three:l,fp2
fcmpx fp2,fp3; fjlt L470
tstl _N:l; jle L476
movl #L478,sp@
jbsr _printf:l
movl #L479,sp@
jbsr _printf:l
L476:
jbsr _PrintIfNPositive:l
movl _N:l,d4
addl _N1:l,d4
movl d4,_N:l
tstl _N:l; jne L480
movl #L482,sp@
jbsr _printf:l
L480:
tstl _N:l; jle L483
jbsr _Pause:l
jra L484
L483:
movl #L47,sp@
jbsr _printf:l
L484:
movl #110,_Milestone:l
movl #L485,sp@
jbsr _printf:l
fmoved _U1:l,fp3
fmoved fp3,_D:l
fmoved _Precision:l,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpx fp0,fp3; fjeq L486
fmoved _BInvrse:l,fp3
fmoved fp3,_D:l
fmoved _Precision:l,fp3
fmoved fp3,_X:l
L488:
fmoved _D:l,fp3
fmuld _BInvrse:l,fp3
fmoved fp3,_D:l
fmoved _X:l,fp3
fsubd _One:l,fp3
fmoved fp3,_X:l
L489:
fmoved _X:l,fp3
fcmpd _Zero:l,fp3; fjgt L488
L486:
fmoved _One:l,fp3
fmoved fp3,_Y:l
fmoved _D:l,fp3
fmoved fp3,_Z:l
L491:
fmoved _Y:l,fp3
fmoved fp3,_C:l
fmoved _Z:l,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fmovex fp3,fp2; fmulx fp3,fp2
fmoved fp2,_Z:l
L492:
fmoved _Y:l,fp3
fmoved _Z:l,fp2
fcmpx fp2,fp3; fjle L494
fmovex fp2,fp3; faddx fp2,fp3
fcmpx fp2,fp3; fjgt L491
L494:
fmoved _C:l,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fmuld _D:l,fp3
fmoved fp3,_Z:l
L495:
fmoved _Y:l,fp3
fmoved fp3,_C:l
fmoved _Z:l,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fmuld _D:l,fp3
fmoved fp3,_Z:l
L496:
fmoved _Y:l,fp3
fmoved _Z:l,fp2
fcmpx fp2,fp3; fjle L498
fmovex fp2,fp3; faddx fp2,fp3
fcmpx fp2,fp3; fjgt L495
L498:
fmoved _Radix:l,fp3
fcmpd _Two:l,fp3; fjge L499
fmoved _Two:l,fp3
fmoved fp3,_HInvrse:l
jra L500
L499:
fmoved _Radix:l,fp3
fmoved fp3,_HInvrse:l
L500:
fmoved _One:l,fp3
fmovex fp3,fp2; fdivd _HInvrse:l,fp2
fmoved fp2,_H:l
fmoved _C:l,fp2
fdivx fp2,fp3
fmoved fp3,_CInvrse:l
fmoved fp2,_E0:l
fmoved _E0:l,fp3
fmuld _H:l,fp3
fmoved fp3,_Z:l
L501:
fmoved _E0:l,fp3
fmoved fp3,_Y:l
fmoved _Z:l,fp3
fmoved fp3,_E0:l
fmoved _E0:l,fp3
fmuld _H:l,fp3
fmoved fp3,_Z:l
L502:
fmoved _E0:l,fp3
fmoved _Z:l,fp2
fcmpx fp2,fp3; fjle L504
fmovex fp2,fp3; faddx fp2,fp3
fcmpx fp2,fp3; fjgt L501
L504:
fmoved _E0:l,fp3
fmoved fp3,_UfThold:l
fmoved _Zero:l,fp3
fmoved fp3,_E1:l
fmoved fp3,_Q:l
fmoved _U2:l,fp3
fmoved fp3,_E9:l
fmoved _One:l,fp3
faddd _E9:l,fp3
fmoved fp3,_S:l
fmoved _C:l,fp3
fmovex fp3,fp2; fmuld _S:l,fp2
fmoved fp2,_D:l
fmoved _D:l,fp2
fcmpx fp3,fp2; fjgt L505
fmoved _Radix:l,fp3
fmuld _U2:l,fp3
fmoved fp3,_E9:l
fmoved _One:l,fp3
faddd _E9:l,fp3
fmoved fp3,_S:l
fmoved _C:l,fp3
fmovex fp3,fp2; fmuld _S:l,fp2
fmoved fp2,_D:l
fmoved _D:l,fp2
fcmpx fp3,fp2; fjgt L506
movl #0,sp@
movl #L509,sp@(4)
jbsr _BadCond:l
fmoved _E0:l,fp3
fmoved fp3,_Underflow:l
fmoved _Zero:l,fp3
fmoved fp3,_Y1:l
fmoved _Z:l,fp3
fmoved fp3,_PseudoZero:l
jbsr _Pause:l
jra L506
L505:
fmoved _D:l,fp3
fmoved fp3,_Underflow:l
fmoved _Underflow:l,fp3
fmuld _H:l,fp3
fmoved fp3,_PseudoZero:l
fmoved _Zero:l,fp3
fmoved fp3,_UfThold:l
L510:
fmoved _Underflow:l,fp3
fmoved fp3,_Y1:l
fmoved _PseudoZero:l,fp3
fmoved fp3,_Underflow:l
fmoved _E1:l,fp3
fmovex fp3,fp2; faddx fp3,fp2
fcmpx fp3,fp2; fjgt L513
fmoved _Underflow:l,fp3
fmuld _HInvrse:l,fp3
fmoved fp3,_Y2:l
fmoved _Y1:l,fp3
fsubd _Y2:l,fp3
fmoved fp3,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_E1:l
fmoved _Y1:l,fp3
fmoved fp3,_Q:l
fmoved _UfThold:l,fp2
fcmpd _Zero:l,fp2; fjne L515
fcmpd _Y2:l,fp3; fjeq L515
fmoved _Y1:l,fp3
fmoved fp3,_UfThold:l
L515:
L513:
fmoved _PseudoZero:l,fp3
fmuld _H:l,fp3
fmoved fp3,_PseudoZero:l
L511:
fmoved _Underflow:l,fp3
fmoved _PseudoZero:l,fp2
fcmpx fp2,fp3; fjle L517
fmovex fp2,fp3; faddx fp2,fp3
fcmpx fp2,fp3; fjgt L510
L517:
L506:
fmoved _PseudoZero:l,fp3
fcmpd _Zero:l,fp3; fjeq L518
movl #L47,sp@
jbsr _printf:l
fmoved _PseudoZero:l,fp3
fmoved fp3,_Z:l
fcmpd _Zero:l,fp3; fjgt L520
movl #0,sp@
movl #L522,sp@(4)
jbsr _BadCond:l
movl #L523,sp@
jbsr _printf:l
movl #L524,sp@
fmoved _PseudoZero:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
fnegd _PseudoZero:l,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fcmpd _Zero:l,fp3; fjgt L521
movl #L527,sp@
jbsr _printf:l
movl #L528,sp@
fmoved _X:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
jra L521
L520:
movl #3,sp@
movl #L529,sp@(4)
jbsr _BadCond:l
movl #L530,sp@
fmoved _PseudoZero:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L521:
jbsr _TstPtUf:l
L518:
movl #120,_Milestone:l
fmoved _CInvrse:l,fp3
fmovex fp3,fp2; fmuld _Y:l,fp2
fmuld _Y1:l,fp3
fcmpx fp3,fp2; fjle L531
fmoved _H:l,fp3
fmuld _S:l,fp3
fmoved fp3,_S:l
fmoved _Underflow:l,fp3
fmoved fp3,_E0:l
L531:
fmoved _E1:l,fp3
fcmpd _Zero:l,fp3; fjeq L533
fcmpd _E0:l,fp3; fjeq L533
movl #2,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
fmoved _E1:l,fp3
fcmpd _E0:l,fp3; fjge L535
movl #L537,sp@
jbsr _printf:l
movl #L538,sp@
jbsr _printf:l
fmoved _PseudoZero:l,fp3
fcmpd _Zero:l,fp3; fjne L536
fmoved _E1:l,fp3
fmoved fp3,_E0:l
jra L536
L535:
movl #L541,sp@
jbsr _printf:l
movl #L542,sp@
jbsr _printf:l
L536:
L533:
movl #L543,sp@
fmoved _E0:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
fmoved _E0:l,fp3
fmoved fp3,_Z:l
jbsr _TstPtUf:l
fmoved _E0:l,fp3
fmoved fp3,_Underflow:l
cmpl #1,_N:l; jne L544
fmoved _Y:l,fp3
fmoved fp3,_Underflow:l
L544:
movl #4,_I:l
fmoved _E1:l,fp3
fcmpd _Zero:l,fp3; fjne L546
movl #3,_I:l
L546:
fmoved _UfThold:l,fp3
fcmpd _Zero:l,fp3; fjne L548
subql #2,_I:l
L548:
movl #1,_UfNGrad:l
movl _I:l,d4
cmpl #1,d4; jlt L550
cmpl #4,d4; jgt L550
movl @(L574-4:l,d4:l:4),a2
jra a2@
L574:
.align 2; .long L552
.align 2; .long L559
.align 2; .long L564
.align 2; .long L565
L552:
fmoved _Underflow:l,fp3
fmoved fp3,_UfThold:l
fmoved _CInvrse:l,fp3
fmovex fp3,fp2; fmuld _Q:l,fp2
fmuld _Y:l,fp3
fmuld _S:l,fp3
fcmpx fp3,fp2; fjeq L553
fmoved _Y:l,fp3
fmoved fp3,_UfThold:l
movl #0,sp@
movl #L555,sp@(4)
jbsr _BadCond:l
movl #L556,sp@
fmoved _UfThold:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L557,sp@
fmoved _C:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L558,sp@
jbsr _printf:l
L553:
jbsr _Pause:l
jra L551
L559:
movl #0,sp@
movl #L560,sp@(4)
jbsr _BadCond:l
movl #L561,sp@
jbsr _printf:l
movl #L562,sp@
fmoved _Q:l,fp3
fmoved fp3,sp@(4)
fmoved _Y2:l,fp3
fmoved fp3,sp@(12)
jbsr _printf:l
fmoved _Q:l,fp3
fsubd _Y2:l,fp3
fmoved fp3,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
movl #L563,sp@
fmoved fp0,sp@(4)
jbsr _printf:l
fmoved _Q:l,fp3
fmoved fp3,_UfThold:l
jra L551
L564:
fmoved _X:l,fp3
fmoved fp3,_X:l
jra L551
L565:
fmoved _Q:l,fp3
fmoved _UfThold:l,fp2
fcmpx fp2,fp3; fjne L566
fmoved _E1:l,fp3
fcmpd _E0:l,fp3; fjne L566
fdivd _E9:l,fp3
fsubx fp3,fp2
fmoved fp2,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fcmpd _E1:l,fp0; fjgt L566
clrl _UfNGrad:l
movl #L568,sp@
jbsr _printf:l
movl #L569,sp@
jbsr _printf:l
fmoved _E0:l,fp3
fmoved _CInvrse:l,fp2
fmulx fp2,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fmoved _OneAndHalf:l,fp1
fmoved _U2:l,fp0
faddx fp0,fp1
fmulx fp1,fp3
fmoved fp3,_Y:l
fmoved _One:l,fp3
faddx fp0,fp3
fmulx fp3,fp2
fmoved fp2,_X:l
fmoved _Y:l,fp3
fdivd _X:l,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fcmpd _E0:l,fp3; fjne L571
movl #1,d7
jra L572
L571:
clrl d7
L572:
movl d7,_IEEE:l
L566:
L550:
L551:
tstl _UfNGrad:l; jeq L576
movl #L47,sp@
jbsr _printf:l
movl #_sigfpe,_sigsave:l
movl #_ovfl_buf,sp@
jbsr _setjmp:l
tstl d0; jeq L578
movl #L580,sp@
jbsr _printf:l
fmoved _H:l,fp3
fmovex fp3,fp2; faddx fp3,fp2
fmoved fp2,_R:l
jra L579
L578:
fmoved _Underflow:l,fp3
fdivd _UfThold:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_R:l
L579:
clrl _sigsave:l
fmoved _R:l,fp3
fcmpd _H:l,fp3; fjgt L581
fmoved _R:l,fp3
fmovex fp3,fp2; fmuld _UfThold:l,fp2
fmoved fp2,_Z:l
fmoved _Z:l,fp2
fmovex fp2,fp7
fmoved _One:l,fp1
fmoved _H:l,fp0
fmulx fp0,fp3
fmovex fp1,fp2; faddx fp0,fp2
fmulx fp2,fp3
fmovex fp1,fp2; faddx fp3,fp2
fmovex fp7,fp3; fmulx fp2,fp3
fmoved fp3,_X:l
jra L582
L581:
fmoved _UfThold:l,fp3
fmoved fp3,_Z:l
fmoved _Z:l,fp3
fmovex fp3,fp7
fmoved _One:l,fp2
fmoved _H:l,fp1
fmovex fp1,fp0; fmulx fp1,fp0
fmovex fp2,fp3; faddx fp1,fp3
fmovex fp0,fp1; fmulx fp3,fp1
fmovex fp2,fp3; faddx fp1,fp3
fmovex fp7,fp2; fmulx fp3,fp2
fmoved fp2,_X:l
L582:
fmoved _X:l,fp3
fmoved _Z:l,fp2
fcmpx fp2,fp3; fjeq L583
fsubx fp2,fp3
fcmpd _Zero:l,fp3; fjne L583
movl #3,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
movl #L585,sp@
fmoved _X:l,fp3
fmoved fp3,sp@(4)
fmoved _Z:l,fp3
fmoved fp3,sp@(12)
jbsr _printf:l
fmoved _X:l,fp3
fsubd _Z:l,fp3
fmoved fp3,_Z9:l
movl #L586,sp@
fmoved _Z9:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L587,sp@
jbsr _printf:l
movl #L588,sp@
jbsr _printf:l
movl #L589,sp@
jbsr _printf:l
movl #L590,sp@
jbsr _printf:l
movl #L591,sp@
jbsr _printf:l
movl #L592,sp@
jbsr _printf:l
movl #_sigfpe,_sigsave:l
movl #_ovfl_buf,sp@
jbsr _setjmp:l
tstl d0; jeq L593
movl #L595,sp@
jbsr _printf:l
jra L594
L593:
movl #L596,sp@
fmoved _X:l,fp3
fdivd _Z:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp3
fsubx fp2,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L594:
clrl _sigsave:l
L583:
L576:
movl #L597,sp@
fmoved _UfThold:l,fp3
fmoved fp3,sp@(4)
movl #L598,sp@(12)
jbsr _printf:l
movl #L599,sp@
jbsr _printf:l
movl #L600,sp@
jbsr _printf:l
fmoved _U1:l,fp3
fmovex fp3,fp2; fmulx fp3,fp2
fmoved fp2,_Y2:l
fmoved _Y2:l,fp2
fmovex fp2,fp1; fmulx fp2,fp1
fmoved fp1,_Y:l
fmoved _Y:l,fp2
fmulx fp3,fp2
fmoved fp2,_Y2:l
fmoved _Y2:l,fp3
fcmpd _UfThold:l,fp3; fjgt L601
fmoved _Y:l,fp3
fcmpd _E0:l,fp3; fjle L603
movl #2,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
movl #5,_I:l
jra L604
L603:
movl #1,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
movl #4,_I:l
L604:
movl #L605,sp@
movl _I:l,sp@(4)
jbsr _printf:l
L601:
movl #130,_Milestone:l
fmoved _UfThold:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp7
fmoved _HInvrse:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _Half:l,fp3
fmoved _TwoForty:l,fp2
fmulx fp7,fp2
fdivx fp0,fp2
fsubx fp2,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fnegx fp0,fp3
fdivd _TwoForty:l,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
fmovex fp3,fp2; faddx fp3,fp2
fmoved fp2,_Y2:l
movl #L606,sp@
jbsr _printf:l
movl #L607,sp@
fmoved _HInvrse:l,fp3
fmoved fp3,sp@(4)
fmoved _Y:l,fp3
fmoved fp3,sp@(12)
jbsr _printf:l
movl #L608,sp@
fmoved _HInvrse:l,fp3
fmoved fp3,sp@(4)
fmoved _Y:l,fp3
fmoved fp3,sp@(12)
jbsr _printf:l
fmoved _HInvrse:l,fp3
fmoved fp3,sp@(0)
fmoved _Y2:l,fp3
fmoved fp3,sp@(8)
jbsr _pow:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_V9:l
movl #L609,sp@
fmoved _V9:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
fmoved _V9:l,fp3
fcmpd _Zero:l,fp3; fjlt L612
fmoved _Radix:l,fp2
fmovex fp2,fp1; faddx fp2,fp1
fmovex fp1,fp2; faddd _E9:l,fp2
fmuld _UfThold:l,fp2
fcmpx fp2,fp3; fjle L610
L612:
movl #1,sp@
movl #L613,sp@(4)
jbsr _BadCond:l
movl #L614,sp@
fmoved _UfThold:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
jra L611
L610:
fmoved _V9:l,fp3
fmoved _UfThold:l,fp2
fmoved _One:l,fp1
faddd _E9:l,fp1
fmulx fp1,fp2
fcmpx fp2,fp3; fjgt L615
movl #L617,sp@
jbsr _printf:l
jra L616
L615:
movl #2,sp@
movl #L613,sp@(4)
jbsr _BadCond:l
movl #L614,sp@
fmoved _UfThold:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L616:
L611:
movl #140,_Milestone:l
movl #L47,sp@
jbsr _printf:l
fmoved _Zero:l,fp3
fmoved fp3,_X:l
movl #2,_I:l
fmoved _Two:l,fp2
fmuld _Three:l,fp2
fmoved fp2,_Y:l
fmoved fp3,_Q:l
clrl _N:l
L618:
fmoved _X:l,fp3
fmoved fp3,_Z:l
addql #1,_I:l
fmoved _Y:l,fp3
movl _I:l,d4
movl d4,d3; addl d4,d3
fdivl d3,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
faddd _Q:l,fp3
fmoved fp3,_R:l
fmoved _Z:l,fp3
fmoved _R:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmoved fp1,_X:l
fsubd _X:l,fp3
faddx fp2,fp3
fmoved fp3,_Q:l
L619:
fmoved _X:l,fp3
fcmpd _Z:l,fp3; fjgt L618
fmoved _OneAndHalf:l,fp3
fmoved _One:l,fp2
fdivd _Eight:l,fp2
fmovex fp3,fp1; faddx fp2,fp1
fmoved _X:l,fp2
fmuld _ThirtyTwo:l,fp3
fdivx fp3,fp2
fmovex fp1,fp3; faddx fp2,fp3
fmoved fp3,_Z:l
fmoved _Z:l,fp3
fmovex fp3,fp2; fmulx fp3,fp2
fmoved fp2,_X:l
fmoved _X:l,fp3
fmovex fp3,fp2; fmulx fp3,fp2
fmoved fp2,_Exp2:l
fmoved _F9:l,fp3
fmoved fp3,_X:l
fmoved _X:l,fp3
fsubd _U1:l,fp3
fmoved fp3,_Y:l
movl #L621,sp@
fmoved _Exp2:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #1,_I:l
L622:
fmoved _X:l,fp3
fmovex fp3,fp7
fmoved _BInvrse:l,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmoved fp1,_Z:l
fmoved _One:l,fp1
fmovex fp3,fp0; faddx fp1,fp0
fmoved _Z:l,fp3
fsubx fp2,fp1
fsubx fp1,fp3
fmovex fp0,fp2; fdivx fp3,fp2
fmoved fp2,_Z:l
fmoved fp7,sp@(0)
fmoved _Z:l,fp3
fmoved fp3,sp@(8)
jbsr _pow:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp3; fsubd _Exp2:l,fp3
fmoved fp3,_Q:l
fmoved _Q:l,fp3
fmoved fp3,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _TwoForty:l,fp3
fmuld _U2:l,fp3
fcmpx fp3,fp0; fjle L626
movl #1,_N:l
fmoved _X:l,fp3
fmoved _BInvrse:l,fp2
fsubx fp2,fp3
fmoved _One:l,fp1
fsubx fp2,fp1
fsubx fp1,fp3
fmoved fp3,_V9:l
movl #2,sp@
movl #L628,sp@(4)
jbsr _BadCond:l
fmoved _X:l,fp3
fmoved fp3,sp@(0)
fmoved _Z:l,fp3
fmoved fp3,sp@(8)
jbsr _pow:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
movl #L629,sp@
fmoved fp0,sp@(4)
jbsr _printf:l
movl #L630,sp@
fmoved _V9:l,fp3
fmoved fp3,sp@(4)
fmoved _Z:l,fp3
fmoved fp3,sp@(12)
jbsr _printf:l
movl #L631,sp@
fmoved _Q:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L632,sp@
jbsr _printf:l
movl #L633,sp@
jbsr _printf:l
jra L624
L626:
fmoved _Y:l,fp3
fmovex fp3,fp2; fsubd _X:l,fp2
fmuld _Two:l,fp2
faddx fp3,fp2
fmoved fp2,_Z:l
fmoved fp3,_X:l
fmoved _Z:l,fp3
fmoved fp3,_Y:l
fmoved _One:l,fp3
fmoved _X:l,fp2
fsubd _F9:l,fp2
fmovex fp2,fp1; fmulx fp2,fp1
fmovex fp3,fp2; faddx fp1,fp2
fmoved fp2,_Z:l
fmoved _Z:l,fp2
fcmpx fp3,fp2; fjle L634
movl _I:l,d4
cmpl _NoTrials:l,d4; jge L634
addql #1,_I:l
jra L622
L634:
fmoved _X:l,fp3
fcmpd _One:l,fp3; fjle L636
tstl _N:l; jne L624
movl #L640,sp@
jbsr _printf:l
jra L624
L636:
fmoved _One:l,fp3
fmoved _U2:l,fp2
faddx fp2,fp3
fmoved fp3,_X:l
fmovex fp2,fp3; faddx fp2,fp3
fmoved fp3,_Y:l
fmoved _Y:l,fp3
faddd _X:l,fp3
fmoved fp3,_Y:l
movl #1,_I:l
jra L622
L624:
movl #150,_Milestone:l
movl #L641,sp@
jbsr _printf:l
clrl _N:l
fmoved _A1:l,fp3
fmoved fp3,_Z:l
fmoved _C:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp7
fmoved _A1:l,fp3
fmoved fp3,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _Half:l,fp3
fmovex fp7,fp2; fdivx fp0,fp2
fsubx fp2,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Q:l
clrl _Break:l
L642:
fmoved _CInvrse:l,fp3
fmoved fp3,_X:l
fmoved _Z:l,fp3
fmoved fp3,sp@(0)
fmoved _Q:l,fp3
fmoved fp3,sp@(8)
jbsr _pow:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Y:l
jbsr _IsYeqX:l
fnegd _Q:l,fp3
fmoved fp3,_Q:l
fmoved _C:l,fp3
fmoved fp3,_X:l
fmoved _Z:l,fp3
fmoved fp3,sp@(0)
fmoved _Q:l,fp3
fmoved fp3,sp@(8)
jbsr _pow:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Y:l
jbsr _IsYeqX:l
fmoved _Z:l,fp3
fcmpd _One:l,fp3; fjge L645
movl #1,_Break:l
jra L646
L645:
fmoved _AInvrse:l,fp3
fmoved fp3,_Z:l
L646:
L643:
tstl _Break:l; jeq L642
jbsr _PrintIfNPositive:l
tstl _N:l; jne L647
movl #L649,sp@
jbsr _printf:l
L647:
movl #L47,sp@
jbsr _printf:l
movl #160,_Milestone:l
jbsr _Pause:l
movl #L650,sp@
jbsr _printf:l
movl #L651,sp@
jbsr _printf:l
fnegd _CInvrse:l,fp3
fmoved fp3,_Y:l
fmoved _HInvrse:l,fp3
fmuld _Y:l,fp3
fmoved fp3,_V9:l
movl #_sigfpe,_sigsave:l
movl #_ovfl_buf,sp@
jbsr _setjmp:l
tstl d0; jeq L652
clrl _I:l
fmoved _Y:l,fp3
fmoved fp3,_V9:l
jra L654
L652:
L655:
fmoved _Y:l,fp3
fmoved fp3,_V:l
fmoved _V9:l,fp3
fmoved fp3,_Y:l
fmoved _HInvrse:l,fp3
fmuld _Y:l,fp3
fmoved fp3,_V9:l
L656:
fmoved _V9:l,fp3
fcmpd _Y:l,fp3; fjlt L655
movl #1,_I:l
L654:
clrl _sigsave:l
fmoved _V9:l,fp3
fmoved fp3,_Z:l
movl #L658,sp@
jbsr _printf:l
movl #L659,sp@
fmoved _Y:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
fmoved _Y:l,fp3
fnegx fp3,fp2
fmoved fp2,_V9:l
fmoved _V9:l,fp2
fmoved fp2,_V0:l
fmoved _V:l,fp2
fmovex fp2,fp1; fsubx fp3,fp1
fmovex fp2,fp3; faddd _V0:l,fp3
fcmpx fp3,fp1; fjne L660
movl #L662,sp@
jbsr _printf:l
jra L661
L660:
movl #L663,sp@
jbsr _printf:l
movl #3,sp@
movl #L664,sp@(4)
jbsr _BadCond:l
L661:
fmoved _Z:l,fp3
fcmpd _Y:l,fp3; fjeq L665
movl #1,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
movl #L667,sp@
fmoved _Y:l,fp3
fmoved fp3,sp@(4)
fmoved _Z:l,fp3
fmoved fp3,sp@(12)
jbsr _printf:l
L665:
tstl _I:l; jeq L668
fmoved _V:l,fp3
fmoved _HInvrse:l,fp2
fmoved _U2:l,fp1
fmovex fp1,fp7
fmovex fp2,fp0; fmulx fp1,fp0
fsubx fp2,fp0
fmovex fp3,fp1; fmulx fp0,fp1
fmoved fp1,_Y:l
fmoved _Y:l,fp1
fmoved _One:l,fp0
fsubx fp2,fp0
fmovex fp0,fp2; fmulx fp7,fp2
fmulx fp3,fp2
fmovex fp1,fp3; faddx fp2,fp3
fmoved fp3,_Z:l
fmoved _Z:l,fp3
fcmpd _V0:l,fp3; fjge L670
fmoved _Z:l,fp3
fmoved fp3,_Y:l
L670:
fmoved _Y:l,fp3
fcmpd _V0:l,fp3; fjge L672
fmoved _Y:l,fp3
fmoved fp3,_V:l
L672:
fmoved _V0:l,fp3
fmovex fp3,fp2; fsubd _V:l,fp2
fcmpx fp3,fp2; fjge L669
fmoved _V0:l,fp3
fmoved fp3,_V:l
jra L669
L668:
fmoved _Y:l,fp3
fmoved _HInvrse:l,fp2
fmoved _U2:l,fp1
fmovex fp1,fp7
fmovex fp2,fp0; fmulx fp1,fp0
fsubx fp2,fp0
fmovex fp3,fp1; fmulx fp0,fp1
fmoved fp1,_V:l
fmoved _V:l,fp1
fmoved _One:l,fp0
fsubx fp2,fp0
fmovex fp0,fp2; fmulx fp7,fp2
fmulx fp3,fp2
fmovex fp1,fp3; faddx fp2,fp3
fmoved fp3,_V:l
L669:
movl #L676,sp@
fmoved _V:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
tstl _I:l; jeq L677
movl #L679,sp@
fmoved _V0:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
jra L678
L677:
movl #L680,sp@
jbsr _printf:l
L678:
fmoved _V:l,fp3
fmuld _One:l,fp3
fmoved fp3,_V9:l
movl #L681,sp@
fmoved _V9:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
fmoved _V:l,fp3
fdivd _One:l,fp3
fmoved fp3,_V9:l
movl #L682,sp@
fmoved _V9:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L683,sp@
jbsr _printf:l
movl #L684,sp@
jbsr _printf:l
movl #170,_Milestone:l
fmoved _V:l,fp3
fnegx fp3,fp2
fcmpx fp3,fp2; fjge L689
fmoved _V0:l,fp2
fnegx fp2,fp1
fcmpx fp2,fp1; fjge L689
fmoved _UfThold:l,fp2
fnegx fp2,fp1
fcmpx fp3,fp1; fjge L689
fcmpx fp3,fp2; fjlt L685
L689:
movl #0,sp@
movl #L690,sp@(4)
jbsr _BadCond:l
movl #L691,sp@
fmoved _V:l,fp3
fmoved fp3,sp@(4)
fmoved _V0:l,fp3
fmoved fp3,sp@(12)
fmoved _UfThold:l,fp3
fmoved fp3,sp@(20)
jbsr _printf:l
L685:
movl #175,_Milestone:l
movl #L47,sp@
jbsr _printf:l
movl #1,_Indx:l
L692:
movl _Indx:l,d4
cmpl #1,d4; jeq L698
cmpl #2,d4; jeq L699
cmpl #3,d4; jeq L700
jra L696
L698:
fmoved _UfThold:l,fp3
fmoved fp3,_Z:l
jra L697
L699:
fmoved _E0:l,fp3
fmoved fp3,_Z:l
jra L697
L700:
fmoved _PseudoZero:l,fp3
fmoved fp3,_Z:l
L696:
L697:
fmoved _Z:l,fp3
fcmpd _Zero:l,fp3; fjeq L701
fmoved _Z:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_V9:l
fmoved _V9:l,fp3
fmovex fp3,fp2; fmulx fp3,fp2
fmoved fp2,_Y:l
fmoved _Y:l,fp3
fmoved _One:l,fp2
fmovex fp2,fp7
fmoved _Radix:l,fp1
fmuld _E9:l,fp1
fmovex fp2,fp0; fsubx fp1,fp0
fmovex fp3,fp2; fdivx fp0,fp2
fmoved _Z:l,fp0
fcmpx fp0,fp2; fjlt L705
fmovex fp7,fp2; faddx fp1,fp2
fmulx fp0,fp2
fcmpx fp2,fp3; fjle L703
L705:
fmoved _V9:l,fp3
fcmpd _U1:l,fp3; fjle L706
movl #1,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
jra L707
L706:
movl #2,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
L707:
movl #L708,sp@
fmoved _Z:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L709,sp@
fmoved _Y:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L703:
L701:
L693:
addql #1,_Indx:l
cmpl #3,_Indx:l; jle L692
movl #180,_Milestone:l
movl #1,_Indx:l
L710:
cmpl #1,_Indx:l; jne L714
fmoved _V:l,fp3
fmoved fp3,_Z:l
jra L715
L714:
fmoved _V0:l,fp3
fmoved fp3,_Z:l
L715:
fmoved _Z:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_V9:l
fmoved _One:l,fp3
fmoved _Radix:l,fp2
fmoved _E9:l,fp1
fmovex fp1,fp7
fmovex fp2,fp0; fmulx fp1,fp0
fmovex fp3,fp1; fsubx fp0,fp1
fmoved _V9:l,fp0
fmulx fp0,fp1
fmoved fp1,_X:l
fmovex fp0,fp1; fmuld _X:l,fp1
fmoved fp1,_V9:l
fmoved _V9:l,fp1
fmoved _Two:l,fp0
fmulx fp2,fp0
fmovex fp0,fp2; fmulx fp7,fp2
fsubx fp2,fp3
fmoved _Z:l,fp2
fmulx fp2,fp3
fcmpx fp3,fp1; fjlt L718
fcmpx fp2,fp1; fjle L716
L718:
fmoved _V9:l,fp3
fmoved fp3,_Y:l
fmoved _X:l,fp3
fcmpd _W:l,fp3; fjge L719
movl #1,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
jra L720
L719:
movl #2,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
L720:
movl #L721,sp@
fmoved _Z:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L722,sp@
fmoved _Y:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L716:
L711:
addql #1,_Indx:l
cmpl #2,_Indx:l; jle L710
movl #190,_Milestone:l
jbsr _Pause:l
fmoved _UfThold:l,fp3
fmuld _V:l,fp3
fmoved fp3,_X:l
fmoved _Radix:l,fp3
fmovex fp3,fp2; fmulx fp3,fp2
fmoved fp2,_Y:l
fmoved _X:l,fp3
fmoved _Y:l,fp2
fmovex fp3,fp1; fmulx fp2,fp1
fcmpd _One:l,fp1; fjlt L725
fcmpx fp2,fp3; fjle L723
L725:
fmoved _X:l,fp3
fmoved _Y:l,fp2
fmovex fp3,fp1; fmulx fp2,fp1
fmoved _U1:l,fp0
fcmpx fp0,fp1; fjlt L728
fdivx fp0,fp2
fcmpx fp2,fp3; fjle L726
L728:
movl #2,sp@
movl #L729,sp@(4)
jbsr _BadCond:l
jra L727
L726:
movl #3,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
L727:
movl #L730,sp@
fmoved _X:l,fp3
fmoved fp3,sp@(4)
movl #L731,sp@(12)
jbsr _printf:l
L723:
movl #200,_Milestone:l
movl #1,_Indx:l
L732:
fmoved _F9:l,fp3
fmoved fp3,_X:l
movl _Indx:l,d4
cmpl #2,d4; jlt L736
cmpl #5,d4; jgt L736
movl @(L743-8:l,d4:l:4),a2
jra a2@
L743:
.align 2; .long L738
.align 2; .long L739
.align 2; .long L740
.align 2; .long L741
L738:
fmoved _One:l,fp3
faddd _U2:l,fp3
fmoved fp3,_X:l
jra L737
L739:
fmoved _V:l,fp3
fmoved fp3,_X:l
jra L737
L740:
fmoved _UfThold:l,fp3
fmoved fp3,_X:l
jra L737
L741:
fmoved _Radix:l,fp3
fmoved fp3,_X:l
L736:
L737:
fmoved _X:l,fp3
fmoved fp3,_Y:l
movl #_sigfpe,_sigsave:l
movl #_ovfl_buf,sp@
jbsr _setjmp:l
tstl d0; jeq L745
movl #L747,sp@
fmoved _X:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
jra L746
L745:
fmoved _Y:l,fp3
fdivd _X:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp3
fsubx fp2,fp3
fmoved fp3,_V9:l
fmoved _V9:l,fp3
fcmpd _Zero:l,fp3; fjne L748
jra L733
L748:
fmoved _V9:l,fp3
fnegd _U1:l,fp2
fcmpx fp2,fp3; fjne L750
cmpl #5,_Indx:l; jge L750
movl #3,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
jra L751
L750:
movl #1,sp@
movl #L160,sp@(4)
jbsr _BadCond:l
L751:
movl #L752,sp@
fmoved _X:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L753,sp@
fmoved _V9:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L746:
clrl _sigsave:l
L733:
addql #1,_Indx:l
cmpl #5,_Indx:l; jle L732
movl #210,_Milestone:l
fmoved _Zero:l,fp3
fmoved fp3,_MyZero:l
movl #L47,sp@
jbsr _printf:l
movl #L754,sp@
jbsr _printf:l
movl #_sigfpe,_sigsave:l
movl #L755,sp@
jbsr _printf:l
movl #_ovfl_buf,sp@
jbsr _setjmp:l
tstl d0; jne L756
movl #L758,sp@
fmoved _One:l,fp3
fdivd _MyZero:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L756:
clrl _sigsave:l
movl #_sigfpe,_sigsave:l
movl #L759,sp@
jbsr _printf:l
movl #_ovfl_buf,sp@
jbsr _setjmp:l
tstl d0; jne L760
movl #L758,sp@
fmoved _Zero:l,fp3
fdivd _MyZero:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L760:
clrl _sigsave:l
movl #220,_Milestone:l
jbsr _Pause:l
movl #L47,sp@
jbsr _printf:l
clrl d7
L767:
tstl @(_ErrCnt:l,d7:l:4); jeq L771
movl #L773,sp@
movl @(L762:l,d7:l:4),sp@(4)
movl @(_ErrCnt:l,d7:l:4),sp@(8)
jbsr _printf:l
L771:
L768:
addql #1,d7
cmpl #4,d7; jlt L767
movl #L47,sp@
jbsr _printf:l
movl _ErrCnt:l,d4
addl _ErrCnt+4:l,d4
addl _ErrCnt+8:l,d4
addl _ErrCnt+12:l,d4
tstl d4; jle L774
movl _ErrCnt:l,d4
addl _ErrCnt+4:l,d4
addl _ErrCnt+8:l,d4
tstl d4; jne L779
tstl _ErrCnt+12:l; jle L779
movl #L784,sp@
jbsr _printf:l
movl #L785,sp@
jbsr _printf:l
L779:
movl _ErrCnt:l,d4
addl _ErrCnt+4:l,d4
tstl d4; jne L786
tstl _ErrCnt+8:l; jle L786
movl #L790,sp@
jbsr _printf:l
movl #L791,sp@
jbsr _printf:l
L786:
movl _ErrCnt:l,d4
addl _ErrCnt+4:l,d4
tstl d4; jle L792
movl #L795,sp@
jbsr _printf:l
movl #L796,sp@
jbsr _printf:l
L792:
tstl _ErrCnt:l; jle L775
movl #L799,sp@
jbsr _printf:l
movl #L800,sp@
jbsr _printf:l
jra L775
L774:
movl #L801,sp@
jbsr _printf:l
cmpl #1,_RMult:l; jne L806
cmpl #1,_RDiv:l; jne L806
cmpl #1,_RAddSub:l; jne L806
cmpl #1,_RSqrt:l; jeq L802
L806:
movl #L807,sp@
jbsr _printf:l
jra L803
L802:
fmoved _StickyBit:l,fp3
fmoved _One:l,fp2
fcmpx fp2,fp3; fjlt L808
fmoved _Radix:l,fp3
fmovex fp3,fp1; fsubd _Two:l,fp1
fsubd _Nine:l,fp3
fsubx fp2,fp3
fmovex fp1,fp2; fmulx fp3,fp2
fcmpd _Zero:l,fp2; fjne L808
movl #L810,sp@
jbsr _printf:l
movl #L811,sp@
jbsr _printf:l
fmoved _Radix:l,fp3
fmoved _Two:l,fp2
fcmpx fp2,fp3; fjne L812
fmoved _Precision:l,fp3
fmoved _Four:l,fp1
fmuld _Three:l,fp1
fmulx fp2,fp1
fmovex fp3,fp2; fsubx fp1,fp2
fmoved _TwentySeven:l,fp1
fsubx fp1,fp3
fsubx fp1,fp3
faddd _One:l,fp3
fmulx fp3,fp2
fcmpd _Zero:l,fp2; fjne L812
movl #L814,sp@
jbsr _printf:l
jra L813
L812:
movl #L815,sp@
jbsr _printf:l
L813:
tstl _IEEE:l; jeq L816
movl #L818,sp@
jbsr _printf:l
jra L817
L816:
movl #L819,sp@
jbsr _printf:l
movl #L820,sp@
jbsr _printf:l
L817:
L808:
movl #L821,sp@
jbsr _printf:l
L803:
L775:
tstl _fpecount:l; jeq L822
movl #L824,sp@
movl _fpecount:l,sp@(4)
jbsr _printf:l
L822:
movl #L825,sp@
jbsr _printf:l
L6:
moveml a6@(-116),#0x498
fmovemx a6@(-100),#0xff
unlk a6
rts
.globl _Sign
.align 2
_Sign:link a6,#-36
fmovemx #0x91,a6@(-36)
fmoved a6@(8),fp3
fcmpd L10:l,fp3; fjlt L863
fmoved L11:l,fp7
jra L864
L863:
fmoved L865:l,fp7
L864:
fmovex fp7,fp0
L861:
fmoved fp0,sp@-; movl sp@+,d0; movl sp@+,d1
fmovemx a6@(-36),#0x91
unlk a6
rts
.globl _Pause
.align 2
_Pause:link a6,#-8
movl #L867,sp@
movl _Milestone:l,sp@(4)
jbsr _printf:l
movl #L868,sp@
movl _PageNo:l,sp@(4)
jbsr _printf:l
addql #1,_Milestone:l
addql #1,_PageNo:l
L866:
unlk a6
rts
.globl _TstCond
.align 2
_TstCond:link a6,#-8
tstl a6@(12); jne L870
movl a6@(8),sp@
movl a6@(16),sp@(4)
jbsr _BadCond:l
movl #L818,sp@
jbsr _printf:l
L870:
L869:
unlk a6
rts
.data
.align 2; L873:.long L874
.long L875
.long L876
.long L877
.text
.globl _BadCond
.align 2
_BadCond:link a6,#-20
moveml #0x480,a6@(-8)
movl a6@(8),d7
lea @(_ErrCnt:l,d7:l:4),a2
addql #1,a2@
movl #L878,sp@
movl @(L873:l,d7:l:4),sp@(4)
movl a6@(12),sp@(8)
jbsr _printf:l
L872:
moveml a6@(-8),#0x480
unlk a6
rts
.globl _Random
.align 2
_Random:link a6,#-68
fmovemx #0xb3,a6@(-60)
fmoved _Random1:l,fp3
faddd _Random9:l,fp3
fmovex fp3,fp7
fmovex fp7,fp3; fmulx fp7,fp3
fmovex fp3,fp6
fmovex fp6,fp3; fmulx fp6,fp3
fmovex fp3,fp6
fmovex fp7,fp3; fmulx fp6,fp3
fmovex fp3,fp7
fmoved fp7,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp7,fp3; fsubx fp0,fp3
fmovex fp3,fp6
fmoved L880:l,fp3
fmulx fp7,fp3
fmovex fp6,fp2; faddx fp3,fp2
fmoved fp2,_Random1:l
fmoved _Random1:l,fp0
L879:
fmoved fp0,sp@-; movl sp@+,d0; movl sp@+,d1
fmovemx a6@(-60),#0xb3
unlk a6
rts
.globl _SqXMinX
.align 2
_SqXMinX:link a6,#-84
fmovemx #0xb1,a6@(-56)
fmoved _X:l,fp3
fmovex fp3,fp2; fmuld _BInvrse:l,fp2
fmovex fp2,fp7
fmovex fp3,fp2; fsubx fp7,fp2
fmoved fp2,a6@(-8)
fmovex fp3,fp2; fmulx fp3,fp2
fmoved fp2,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp3; fsubx fp7,fp3
fsubd a6@(-8),fp3
fdivd _OneUlp:l,fp3
fmoved fp3,_SqEr:l
fmoved _SqEr:l,fp3
fcmpd _Zero:l,fp3; fjeq L882
fmoved _SqEr:l,fp3
fcmpd _MinSqEr:l,fp3; fjge L884
fmoved _SqEr:l,fp3
fmoved fp3,_MinSqEr:l
L884:
fmoved _SqEr:l,fp3
fcmpd _MaxSqEr:l,fp3; fjle L886
fmoved _SqEr:l,fp3
fmoved fp3,_MaxSqEr:l
L886:
fmoved _J:l,fp3
faddd L11:l,fp3
fmoved fp3,_J:l
movl a6@(8),sp@
movl #L47,sp@(4)
jbsr _BadCond:l
movl #L888,sp@
fmoved _X:l,fp3
fmovex fp3,fp2; fmulx fp3,fp2
fmoved fp2,sp@(4)
fmoved fp3,sp@(12)
fmoved _OneUlp:l,fp3
fmuld _SqEr:l,fp3
fmoved fp3,sp@(20)
jbsr _printf:l
movl #L889,sp@
jbsr _printf:l
L882:
L881:
fmovemx a6@(-56),#0xb1
unlk a6
rts
.globl _NewD
.align 2
_NewD:link a6,#-92
fmovemx #0xf7,a6@(-84)
fmoved _Z1:l,fp3
fmuld _Q:l,fp3
fmoved fp3,_X:l
fmoved _Half:l,fp3
fmoved _X:l,fp2
fdivd _Radix:l,fp2
fsubx fp2,fp3
fmoved fp3,sp@(0)
jbsr _floor:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _Radix:l,fp3
fmovex fp3,fp7
fmovex fp0,fp2; fmulx fp3,fp2
faddd _X:l,fp2
fmoved fp2,_X:l
fmoved _Q:l,fp2
fmoved _X:l,fp1
fmovex fp1,fp5
fmoved _Z:l,fp0
fmovex fp0,fp6
fmovex fp1,fp3; fmulx fp0,fp3
fsubx fp3,fp2
fmovex fp2,fp3; fdivx fp7,fp3
fmovex fp1,fp2; fmulx fp1,fp2
fmoved _D:l,fp0
fmovex fp0,fp1; fdivx fp7,fp1
fmulx fp1,fp2
faddx fp2,fp3
fmoved fp3,_Q:l
fmoved _Two:l,fp3
fmulx fp5,fp3
fmulx fp0,fp3
fmovex fp6,fp2; fsubx fp3,fp2
fmoved fp2,_Z:l
fmoved _Z:l,fp3
fcmpd _Zero:l,fp3; fjgt L891
fnegd _Z:l,fp3
fmoved fp3,_Z:l
fnegd _Z1:l,fp3
fmoved fp3,_Z1:l
L891:
fmoved _Radix:l,fp3
fmuld _D:l,fp3
fmoved fp3,_D:l
L890:
fmovemx a6@(-84),#0xf7
unlk a6
rts
.globl _SR3750
.align 2
_SR3750:link a6,#-68
fmovemx #0xf1,a6@(-60)
fmoved _X:l,fp3
fmovex fp3,fp7
fmoved _Radix:l,fp2
fmovex fp3,fp1; fsubx fp2,fp1
fmoved _Z2:l,fp0
fmovex fp0,fp3; fsubx fp2,fp3
fcmpx fp3,fp1; fjlt L897
fmovex fp7,fp3; fsubx fp0,fp3
fmoved _W:l,fp2
fsubx fp0,fp2
fcmpx fp2,fp3; fjgt L897
addql #1,_I:l
fmoved _X:l,fp3
fmuld _D:l,fp3
fmoved fp3,sp@(0)
jbsr _sqrt:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_X2:l
fmoved _X2:l,fp3
fmoved _Z2:l,fp2
fsubx fp2,fp3
fmoved _Y:l,fp1
fmovex fp1,fp0; fsubx fp2,fp0
fsubx fp0,fp3
fmoved fp3,_Y2:l
fmoved _X8:l,fp3
fmoved _Half:l,fp2
fsubx fp2,fp1
fdivx fp1,fp3
fmoved fp3,_X2:l
fmoved _X2:l,fp3
fmovex fp2,fp1; fmulx fp3,fp1
fmulx fp3,fp1
fsubx fp1,fp3
fmoved fp3,_X2:l
fmoved _Y2:l,fp3
faddx fp2,fp3
fsubd _X2:l,fp2
faddx fp2,fp3
fmoved fp3,_SqEr:l
fmoved _SqEr:l,fp3
fcmpd _MinSqEr:l,fp3; fjge L899
fmoved _SqEr:l,fp3
fmoved fp3,_MinSqEr:l
L899:
fmoved _Y2:l,fp3
fsubd _X2:l,fp3
fmoved fp3,_SqEr:l
fmoved _SqEr:l,fp3
fcmpd _MaxSqEr:l,fp3; fjle L901
fmoved _SqEr:l,fp3
fmoved fp3,_MaxSqEr:l
L901:
L897:
L896:
fmovemx a6@(-60),#0xf1
unlk a6
rts
.globl _IsYeqX
.align 2
_IsYeqX:link a6,#-44
fmovemx #0x30,a6@(-24)
fmoved _Y:l,fp3
fcmpd _X:l,fp3; fjeq L905
tstl _N:l; jgt L907
fmoved _Z:l,fp3
fmoved _Zero:l,fp2
fcmpx fp2,fp3; fjne L909
fmoved _Q:l,fp3
fcmpx fp2,fp3; fjgt L909
movl #L911,sp@
jbsr _printf:l
jra L910
L909:
movl #2,sp@
movl #L912,sp@(4)
jbsr _BadCond:l
L910:
movl #L913,sp@
fmoved _Z:l,fp3
fmoved fp3,sp@(4)
fmoved _Q:l,fp3
fmoved fp3,sp@(12)
jbsr _printf:l
movl #L914,sp@
fmoved _Y:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L915,sp@
fmoved _X:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L916,sp@
fmoved _Y:l,fp3
fsubd _X:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L907:
addql #1,_N:l
L905:
L904:
fmovemx a6@(-24),#0x30
unlk a6
rts
.globl _SR3980
.align 2
_SR3980:link a6,#-44
fmovemx #0x90,a6@(-24)
moveml #0x10,a6@(-28)
L918:
movl _I:l,d4
fmovel d4,fp3
fmoved fp3,_Q:l
fmoved _Z:l,fp3
fmoved fp3,sp@(0)
fmoved _Q:l,fp3
fmoved fp3,sp@(8)
jbsr _pow:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved fp0,_Y:l
jbsr _IsYeqX:l
movl _I:l,d4
addql #1,d4
movl d4,_I:l
cmpl _M:l,d4; jle L921
jra L920
L921:
fmoved _Z:l,fp3
fmuld _X:l,fp3
fmoved fp3,_X:l
L919:
fmoved _X:l,fp3
fcmpd _W:l,fp3; fjlt L918
L920:
L917:
moveml a6@(-28),#0x10
fmovemx a6@(-24),#0x90
unlk a6
rts
.globl _PrintIfNPositive
.align 2
_PrintIfNPositive:link a6,#-8
tstl _N:l; jle L924
movl #L926,sp@
movl _N:l,sp@(4)
jbsr _printf:l
L924:
L923:
unlk a6
rts
.globl _TstPtUf
.align 2
_TstPtUf:link a6,#-64
fmovemx #0xf0,a6@(-48)
moveml #0x10,a6@(-52)
clrl _N:l
fmoved _Z:l,fp3
fcmpd _Zero:l,fp3; fjeq L928
movl #L930,sp@
jbsr _printf:l
movl #L931,sp@
jbsr _printf:l
movl #_sigfpe,_sigsave:l
movl #_ovfl_buf,sp@
jbsr _setjmp:l
tstl d0; jeq L932
jra L934
L932:
fmoved _Z:l,fp3
fmovex fp3,fp2; faddx fp3,fp2
fdivx fp3,fp2
fmoved fp2,_Q9:l
movl #L935,sp@
fmoved _Q9:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
fmoved _Q9:l,fp3
fsubd _Two:l,fp3
fmoved fp3,sp@(0)
jbsr _fabs:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmoved _Radix:l,fp3
fmuld _U2:l,fp3
fcmpx fp3,fp0; fjge L936
movl #L938,sp@
jbsr _printf:l
movl #L939,sp@
jbsr _printf:l
jra L937
L936:
fmoved _Q9:l,fp3
fcmpd _One:l,fp3; fjlt L942
fcmpd _Two:l,fp3; fjle L940
L942:
L934:
movl #1,_N:l
movl _ErrCnt+4:l,d4
addql #1,d4
movl d4,_ErrCnt+4:l
movl #L945,sp@
jbsr _printf:l
jra L941
L940:
movl #1,_N:l
movl _ErrCnt+8:l,d4
addql #1,d4
movl d4,_ErrCnt+8:l
movl #L948,sp@
jbsr _printf:l
L941:
L937:
clrl _sigsave:l
fmoved _Z:l,fp3
fmoved _One:l,fp2
fmovex fp3,fp1; fmulx fp2,fp1
fmoved fp1,_V9:l
fmoved _V9:l,fp1
fmoved fp1,_Random1:l
fmovex fp2,fp1; fmulx fp3,fp1
fmoved fp1,_V9:l
fmoved _V9:l,fp1
fmoved fp1,_Random2:l
fmovex fp3,fp1; fdivx fp2,fp1
fmoved fp1,_V9:l
fcmpd _Random1:l,fp3; fjne L949
fcmpd _Random2:l,fp3; fjne L949
fcmpd _V9:l,fp3; fjne L949
tstl _N:l; jle L950
jbsr _Pause:l
jra L950
L949:
movl #1,_N:l
movl #2,sp@
movl #L953,sp@(4)
jbsr _BadCond:l
movl #L954,sp@
fmoved _Z:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
fmoved _Z:l,fp3
fcmpd _Random1:l,fp3; fjeq L955
movl #L957,sp@
fmoved _Random1:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L955:
fmoved _Z:l,fp3
fmoved _Random2:l,fp2
fcmpx fp2,fp3; fjeq L958
fcmpd _Random1:l,fp2; fjeq L958
movl #L960,sp@
fmoved _Random2:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L958:
fmoved _Z:l,fp3
fcmpd _V9:l,fp3; fjeq L961
movl #L963,sp@
fmoved _V9:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L961:
fmoved _Random2:l,fp3
fcmpd _Random1:l,fp3; fjeq L964
movl _ErrCnt+8:l,d4
addql #1,d4
movl d4,_ErrCnt+8:l
movl #2,sp@
movl #L968,sp@(4)
jbsr _BadCond:l
movl #L969,sp@
fmoved _Random2:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
movl #L970,sp@
fmoved _Random1:l,fp3
fmoved fp3,sp@(4)
jbsr _printf:l
L964:
jbsr _Pause:l
L950:
L928:
L927:
moveml a6@(-52),#0x10
fmovemx a6@(-48),#0xf0
unlk a6
rts
.globl _notify
.align 2
_notify:link a6,#-8
movl #L972,sp@
movl a6@(8),sp@(4)
jbsr _printf:l
movl #L973,sp@
jbsr _printf:l
L971:
unlk a6
rts
.globl _msglist
.align 2
_msglist:link a6,#-16
moveml #0x2400,a6@(-8)
movl a6@(8),a5
jra L976
L975:
movl #L978,sp@
movl a5,a2
lea a2@(4),a5
movl a2@,sp@(4)
jbsr _printf:l
L976:
tstl a5@; jne L975
L974:
moveml a6@(-8),#0x2400
unlk a6
rts
.data
.align 2; L980:.long L981
.long L982
.long L983
.long L984
.long L985
.long L986
.long L987
.long L988
.long L989
.long 0x0
.text
.globl _Instructions
.align 2
_Instructions:link a6,#-4
movl #L980,sp@
jbsr _msglist:l
L979:
unlk a6
rts
.data
.align 2; L991:.long L992
.long L993
.long L994
.long L995
.long L996
.long L997
.long L998
.long L999
.long L1000
.long L1001
.long L1002
.long L1003
.long L1004
.long L1005
.long 0x0
.text
.globl _Heading
.align 2
_Heading:link a6,#-4
movl #L991,sp@
jbsr _msglist:l
L990:
unlk a6
rts
.data
.align 2; L1007:.long L1008
.long L1009
.long L1010
.long L1011
.long L1012
.long L1013
.long L1014
.long L1015
.long L1016
.long L1017
.long L1018
.long L1019
.long L1020
.long L1021
.long L1022
.long L1023
.long L1024
.long L1025
.long L1026
.long 0x0
.text
.globl _Characteristics
.align 2
_Characteristics:link a6,#-4
movl #L1007,sp@
jbsr _msglist:l
L1006:
unlk a6
rts
.data
.align 2; L1028:.long L1029
.long L1030
.long L1031
.long L1032
.long L1033
.long L1034
.long L1035
.long L1036
.long L1037
.long L1038
.long L1039
.long L1040
.long L1041
.long L1042
.long L1043
.long L1044
.long L1045
.long 0x0
.text
.globl _History
.align 2
_History:link a6,#-4
movl #L1028,sp@
jbsr _msglist:l
L1027:
unlk a6
rts
.globl _pow
.align 2
_pow:link a6,#-104
fmovemx #0x97,a6@(-76)
moveml #0x4d0,a6@(-92)
fmoved a6@(8),fp7
fmoved a6@(16),fp6
clrl d6
clrl a6@(-8)
fcmpd L10:l,fp6; fjne L1047
fmoved L11:l,fp0
jra L1046
L1047:
fcmpd L1052:l,fp6; fjlt L1051
fcmpd L1053:l,fp6; fjle L1049
L1051:
fcmpd L865:l,fp7; fjeq L1049
fmoved fp7,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp6,fp3; fmulx fp0,fp3
fmoved fp3,sp@(0)
jbsr _exp:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
jra L1046
L1049:
fcmpd L10:l,fp6; fjge L1054
fnegx fp6,fp3
fmovex fp3,fp6
movl #1,a6@(-8)
L1054:
fmoved fp6,sp@(0)
lea a6@(-16),a2
movl a2,sp@(8)
jbsr _modf:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp6
fcmpd L10:l,fp6; fjeq L1056
fmoved fp7,sp@(0)
jbsr _log:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp6,fp3; fmulx fp0,fp3
fmoved fp3,sp@(0)
jbsr _exp:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp5
jra L1057
L1056:
fmoved L11:l,fp5
L1057:
fmoved fp7,sp@(0)
lea a6@(-4),a2
movl a2,sp@(8)
jbsr _frexp:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
fmovex fp0,fp7
fmoved a6@(-16),fp3
fintrzx fp3,fp0; fmovel fp0,d4
movl d4,d7
tstl d4; jeq L1058
L1060:
movl d7,d4; andl #1,d4
tstl d4; jeq L1064
fmovex fp5,fp3; fmulx fp7,fp3
fmovex fp3,fp5
movl d6,d4; addl a6@(-4),d4
movl d4,d6
L1064:
movl d7,d4; asrl #1,d4
movl d4,d7
tstl d4; jne L1066
jra L1062
L1066:
fmovex fp7,fp3; fmulx fp7,fp3
fmovex fp3,fp7
movl a6@(-4),d4
asll #1,d4
movl d4,a6@(-4)
fcmpd L1070:l,fp7; fjge L1060
fmoved L1071:l,fp3
fmulx fp7,fp3
fmovex fp3,fp7
subql #1,a6@(-4)
jra L1060
L1062:
L1058:
tstl a6@(-8); jeq L1072
fmoved L11:l,fp3
fdivx fp5,fp3
fmovex fp3,fp5
movl d6,d4; negl d4
movl d4,d6
L1072:
fmoved fp5,sp@(0)
movl d6,sp@(8)
jbsr _ldexp:l; movl d1,sp@-; movl d0,sp@-; fmoved sp@+,fp0
L1046:
fmoved fp0,sp@-; movl sp@+,d0; movl sp@+,d1
moveml a6@(-92),#0x4d0
fmovemx a6@(-76),#0x97
unlk a6
rts
.bss
.globl _UfNGrad
.comm _UfNGrad,4
.globl _SqRWrng
.comm _SqRWrng,4
.globl _IEEE
.comm _IEEE,4
.globl _Anomaly
.comm _Anomaly,4
.globl _Monot
.comm _Monot,4
.globl _NotMonot
.comm _NotMonot,4
.globl _Done
.comm _Done,4
.globl _Break
.comm _Break,4
.globl _RSqrt
.comm _RSqrt,4
.globl _RAddSub
.comm _RAddSub,4
.globl _RDiv
.comm _RDiv,4
.globl _RMult
.comm _RMult,4
.globl _GAddSub
.comm _GAddSub,4
.globl _GDiv
.comm _GDiv,4
.globl _GMult
.comm _GMult,4
.globl _N1
.comm _N1,4
.globl _N
.comm _N,4
.globl _M
.comm _M,4
.globl _PageNo
.comm _PageNo,4
.globl _Milestone
.comm _Milestone,4
.globl _fpecount
.comm _fpecount,4
.globl _ErrCnt
.comm _ErrCnt,16
.globl _Z9
.comm _Z9,8
.globl _Z2
.comm _Z2,8
.globl _Z1
.comm _Z1,8
.globl _PseudoZero
.comm _PseudoZero,8
.globl _Z
.comm _Z,8
.globl _Random2
.comm _Random2,8
.globl _Y2
.comm _Y2,8
.globl _Y1
.comm _Y1,8
.globl _Y
.comm _Y,8
.globl _Random1
.comm _Random1,8
.globl _X8
.comm _X8,8
.globl _X2
.comm _X2,8
.globl _X1
.comm _X1,8
.globl _X
.comm _X,8
.globl _W
.comm _W,8
.globl _V9
.comm _V9,8
.globl _V0
.comm _V0,8
.globl _V
.comm _V,8
.globl _U2
.comm _U2,8
.globl _U1
.comm _U1,8
.globl _UfThold
.comm _UfThold,8
.globl _OneUlp
.comm _OneUlp,8
.globl _S
.comm _S,8
.globl _Underflow
.comm _Underflow,8
.globl _T
.comm _T,8
.globl _Random9
.comm _Random9,8
.globl _R
.comm _R,8
.globl _Q9
.comm _Q9,8
.globl _Q
.comm _Q,8
.globl _Precision
.comm _Precision,8
.globl _MyZero
.comm _MyZero,8
.globl _J
.comm _J,8
.globl _StickyBit
.comm _StickyBit,8
.globl _I
.comm _I,4
.globl _HInvrse
.comm _HInvrse,8
.globl _H
.comm _H,8
.globl _F9
.comm _F9,8
.globl _F6
.comm _F6,8
.globl _Third
.comm _Third,8
.globl _E9
.comm _E9,8
.globl _MaxSqEr
.comm _MaxSqEr,8
.globl _SqEr
.comm _SqEr,8
.globl _MinSqEr
.comm _MinSqEr,8
.globl _E3
.comm _E3,8
.globl _Exp2
.comm _Exp2,8
.globl _E1
.comm _E1,8
.globl _E0
.comm _E0,8
.globl _FourD
.comm _FourD,8
.globl _D
.comm _D,8
.globl _CInvrse
.comm _CInvrse,8
.globl _C
.comm _C,8
.globl _A1
.comm _A1,8
.globl _AInvrse
.comm _AInvrse,8
.globl _ch
.comm _ch,8
.globl _Indx
.comm _Indx,4
.globl _BMinusU2
.comm _BMinusU2,8
.globl _RadixD2
.comm _RadixD2,8
.globl _BInvrse
.comm _BInvrse,8
.globl _Radix
.comm _Radix,8
.globl _sigsave
.comm _sigsave,4
.globl _ovfl_buf
.comm _ovfl_buf,232
.text
.align 2; L1071:.long 0x40000000,0x0
.align 2; L1070:.long 0x3fe00000,0x0
.align 2; L1053:.long 0x40913000,0x0
.align 2; L1052:.long 0xc0913000,0x0
.align 2; L1045:.ascii "see source comments for more history.\000"
.align 2; L1044:.ascii "BASIC version of this program (C) 1983 by Prof. W. M. Kahan;\000"
.align 2; L1043:.ascii "as used by certain early WANG machines.\012\000"
.align 2; L1042:.ascii "floating-point numbers, but also allows logarithmic encoding\000"
.align 2; L1041:.ascii "\012The program is based upon a conventional radix representatio"
.ascii "n for\000"
.align 2; L1040:.ascii "of pathologies, and to say how well the arithmetic is implemente"
.ascii "d.\000"
.align 2; L1039:.ascii "of the arithmetic, this program tries to cope with a wider varie"
.ascii "ty\000"
.align 2; L1038:.ascii "the Radix, Precision and range (over/underflow thresholds)\000"
.align 2; L1037:.ascii "W. J. Cody and W. Waite. Although both programs try to discover\000"
.align 2; L1036:.ascii "book  `Software Manual for the Elementary Functions' (1980) by\000"
.align 2; L1035:.ascii "program called `MACHAR', which can be found at the end of the\000"
.align 2; L1034:.ascii "The diagnostic capabilities of this program go beyond an earlier"
.ascii "\000"
.align 2; L1033:.ascii "Failures may confound subsequent diagnoses.\012\000"
.align 2; L1032:.ascii "   FAILUREs, like 2+2 == 5 .\000"
.align 2; L1031:.ascii "   Serious DEFECTs, like lack of a guard digit, and\000"
.align 2; L1030:.ascii "   FLAWs, like lack of a sticky bit,\000"
.align 2; L1029:.ascii "The program attempts to discriminate among\000"
.align 2; L1026:.ascii "     Decimal-Binary conversion is NOT YET tested for accuracy.\000"
.align 2; L1025:.ascii "     Extra-precise subexpressions are revealed but NOT YET teste"
.ascii "d.\000"
.align 2; L1024:.ascii "     Sqrt is tested.  Y^X is not tested.\000"
.align 2; L1023:.ascii "\011and for contamination with pseudo-zeros.\000"
.align 2; L1022:.ascii "     Comparisions are checked for consistency with subtraction\000"
.align 2; L1021:.ascii "     V0  tells, roughly, whether  Infinity  is represented.\000"
.align 2; L1020:.ascii "     V = an overflow threshold, roughly.\000"
.align 2; L1019:.ascii "     E0 and PseudoZero tell whether underflow is abrupt, gradual"
.ascii ", or fuzzy.\000"
.align 2; L1018:.ascii "     UnderflowThreshold = an underflow threshold.\000"
.align 2; L1017:.ascii "     Whether a Sticky Bit used correctly for rounding.\000"
.align 2; L1016:.ascii "\011for Mult., Div., Add/Subt. and Sqrt.\000"
.align 2; L1015:.ascii "     Whether arithmetic is chopped, correctly rounded, or someth"
.ascii "ing else\000"
.align 2; L1014:.ascii "     Adequacy of guard digits for Mult., Div. and Subt.\000"
.align 2; L1013:.ascii "     U1 = 1/Radix^Precision = One Ulp of numbers a little less t"
.ascii "han 1.0 .\000"
.align 2; L1012:.ascii "\011(OneUlpnit in the Last Place) of 1.000xxx .\000"
.align 2; L1011:.ascii "     U2 = Radix/Radix^Precision = One Ulp\000"
.align 2; L1010:.ascii "     Precision = number of significant digits carried.\000"
.align 2; L1009:.ascii "     Radix = 1, 2, 4, 8, 10, 16, 100, 256 ...\000"
.align 2; L1008:.ascii "Running this program should reveal these characteristics:\000"
.align 2; L1005:.ascii "\011Other relevant compiler options:\000"
.align 2; L1004:.ascii "\011Optimization level:\012\000"
.align 2; L1003:.ascii "\011Compiler:\012\000"
.align 2; L1002:.ascii "\011Computer:\012\000"
.align 2; L1001:.ascii "\011Version:\01110 February 1989;\000"
.align 2; L1000:.ascii "\011Precision:\011double;\000"
.align 2; L999:.ascii "In doing so, please include the following information:\000"
.align 2; L998:.ascii "\011San Francisco, CA 94143-0704, USA\012\000"
.align 2; L997:.ascii "\011University of California\000"
.align 2; L996:.ascii "\011Computer Center U-76\000"
.align 2; L995:.ascii "\011Richard Karpinski\000"
.align 2; L994:.ascii "Please send suggestions and interesting results to\000"
.align 2; L993:.ascii "cope with unanticipated and newly uncovered arithmetic pathologi"
.ascii "es.\012\000"
.align 2; L992:.ascii "Users are invited to help debug and augment this program so it w"
.ascii "ill\000"
.align 2; L989:.ascii "Answer questions with Y, y, N or n (unless otherwise indicated)."
.ascii "\012\000"
.align 2; L988:.ascii "amend it to make further progress.\012\000"
.align 2; L987:.ascii "program anyway to see how many milestones it passes, and then\000"
.align 2; L986:.ascii "warning.  If persuasion avails naught, don't despair but run thi"
.ascii "s\000"
.align 2; L985:.ascii "to persevere with a surrogate value after, perhaps, displaying s"
.ascii "ome\000"
.align 2; L984:.ascii "error like Over/Underflow or Division by Zero occurs, but rather"
.ascii "\000"
.align 2; L983:.ascii "try to persuade the computer NOT to terminate execution when an\000"
.align 2; L982:.ascii "    `END OF TEST',\012\000"
.align 2; L981:.ascii "Lest this program stop prematurely, i.e. before displaying\012\000"
.align 2; L978:.byte 37,115,10,0
.align 2; L973:.ascii "   PLEASE NOTIFY KARPINKSI!\012\000"
.align 2; L972:.ascii "%s test appears to be inconsistent...\012\000"
.align 2; L970:.ascii "\011differs from Z * 1 = %.17e\012\000"
.align 2; L969:.ascii "\011Comparison alleges that 1 * Z = %.17e\012\000"
.align 2; L968:.ascii "Multiplication does not commute!\012\000"
.align 2; L963:.ascii "Z / 1 = %.17e\012\000"
.align 2; L960:.ascii "1 * Z == %g\012\000"
.align 2; L957:.ascii "Z * 1 = %.17e \000"
.align 2; L954:.ascii "%.17e\012\011compares different from  \000"
.align 2; L953:.ascii "What prints as Z = \000"
.align 2; L948:.ascii "This is a DEFECT!\012\000"
.align 2; L945:.ascii "This is a VERY SERIOUS DEFECT!\012\000"
.align 2; L939:.ascii " has NOT just been signaled.\012\000"
.align 2; L938:.ascii "This is O.K., provided Over/Underflow\000"
.align 2; L935:.ascii "What the machine gets for (Z + Z) / Z is  %.17e .\012\000"
.align 2; L931:.ascii "(Z + Z) / Z should be safe.\012\000"
.align 2; L930:.ascii "Since comparison denies Z = 0, evaluating \000"
.align 2; L926:.ascii "Similar discrepancies have occurred %d times.\012\000"
.align 2; L916:.ascii "\011\011they differ by %.17e .\012\000"
.align 2; L915:.ascii "\011which compared unequal to correct %.17e ;\012\000"
.align 2; L914:.ascii "\011yielded %.17e;\012\000"
.align 2; L913:.ascii "\011(%.17e) ^ (%.17e)\012\000"
.align 2; L912:.ascii "computing\012\000"
.align 2; L911:.ascii "WARNING:  computing\012\000"
.align 2; L889:.ascii "\011instead of correct value 0 .\012\000"
.align 2; L888:.ascii "sqrt( %.17e) - %.17e  = %.17e\012\000"
.align 2; L880:.long 0x3ed4f8b5,0x88e368f0
.align 2; L878:.ascii "%s:  %s\000"
.align 2; L877:.ascii "FLAW\000"
.align 2; L876:.ascii "DEFECT\000"
.align 2; L875:.ascii "SERIOUS DEFECT\000"
.align 2; L874:.ascii "FAILURE\000"
.align 2; L868:.ascii "          Page: %d\012\012\000"
.align 2; L867:.ascii "\012Diagnosis resumes after milestone Number %d\000"
.align 2; L865:.long 0xbff00000,0x0
.align 2; L825:.ascii "END OF TEST.\012\000"
.align 2; L824:.ascii "\012A total of %d floating point exceptions were registered.\012"
.ascii "\000"
.align 2; L821:.ascii "The arithmetic diagnosed appears to be Excellent!\012\000"
.align 2; L820:.ascii " during Gradual Underflow.\012\000"
.align 2; L819:.ascii ",\012except for possibly Double Rounding\000"
.align 2; L818:.byte 46,10,0
.align 2; L815:.ascii "854\000"
.align 2; L814:.ascii "754\000"
.align 2; L811:.ascii "the proposed IEEE standard P\000"
.align 2; L810:.ascii "Rounding appears to conform to \000"
.align 2; L807:.ascii "The arithmetic diagnosed seems Satisfactory.\012\000"
.align 2; L801:.ascii "No failures, defects nor flaws have been discovered.\012\000"
.align 2; L800:.ascii " program's subsequent diagnoses.\012\000"
.align 2; L799:.ascii "Potentially fatal FAILURE may have spoiled this\000"
.align 2; L796:.ascii "unacceptable Serious Defects.\012\000"
.align 2; L795:.ascii "The arithmetic diagnosed has \000"
.align 2; L791:.ascii "despite inconvenient Defects.\012\000"
.align 2; L790:.ascii "The arithmetic diagnosed may be Acceptable\012\000"
.align 2; L785:.ascii "Satisfactory though flawed.\012\000"
.align 2; L784:.ascii "The arithmetic diagnosed seems \000"
.align 2; L773:.ascii "The number of  %-29s %d.\012\000"
.align 2; L766:.ascii "FLAWs  discovered =\000"
.align 2; L765:.ascii "DEFECTs  discovered =\000"
.align 2; L764:.ascii "SERIOUS DEFECTs  discovered =\000"
.align 2; L763:.ascii "FAILUREs  encountered =\000"
.align 2; L759:.ascii "\012    Trying to compute 0 / 0 produces ...\000"
.align 2; L758:.ascii "  %.7e .\012\000"
.align 2; L755:.ascii "    Trying to compute 1 / 0 produces ...\000"
.align 2; L754:.ascii "What message and/or values does Division by Zero produce?\012\000"
.align 2; L753:.ascii "  instead, X / X - 1/2 - 1/2 = %.17e .\012\000"
.align 2; L752:.ascii "  X / X differs from 1 when X = %.17e\012\000"
.align 2; L747:.ascii "  X / X  traps when X = %g\012\000"
.align 2; L731:.ascii "is too far from 1.\012\000"
.align 2; L730:.ascii " unbalanced range; UfThold * V = %.17e\012\011%s\012\000"
.align 2; L729:.ascii "Badly\000"
.align 2; L722:.ascii " is too far from sqrt(Z) ^ 2 (%.17e) .\012\000"
.align 2; L721:.ascii "Comparison alleges that Z = %17e\012\000"
.align 2; L709:.ascii " is too far from sqrt(Z) ^ 2 = %.17e .\012\000"
.align 2; L708:.ascii "Comparison alleges that what prints as Z = %.17e\012\000"
.align 2; L691:.ascii "+-%g, +-%g\012and +-%g are confused by Overflow.\000"
.align 2; L690:.ascii "Comparisons involving \000"
.align 2; L684:.ascii "above is a DEFECT.\012\000"
.align 2; L683:.ascii "Any overflow signal separating this * from the one\012\000"
.align 2; L682:.ascii "                           nor for V / 1 = %.17e .\012\000"
.align 2; L681:.ascii "No Overflow should be signaled for V * 1 = %.17e\012\000"
.align 2; L680:.ascii "There is no saturation value because the system traps on overflo"
.ascii "w.\012\000"
.align 2; L679:.ascii "Overflow saturates at V0 = %.17e .\012\000"
.align 2; L676:.ascii "Overflow threshold is V  = %.17e .\012\000"
.align 2; L667:.ascii "overflow past %.17e\012\011shrinks to %.17e .\012\000"
.align 2; L664:.ascii "-(-Y) differs from Y.\012\000"
.align 2; L663:.ascii "finds a \000"
.align 2; L662:.ascii "Seems O.K.\012\000"
.align 2; L659:.ascii "Trying it on Y = %.17e .\012\000"
.align 2; L658:.ascii "Can `Z = -Y' overflow?\012\000"
.align 2; L651:.ascii "This may generate an error.\012\000"
.align 2; L650:.ascii "Searching for Overflow threshold:\012\000"
.align 2; L649:.ascii " ... no discrepancies found.\012\000"
.align 2; L641:.ascii "Testing powers Z^Q at four nearly extreme values.\012\000"
.align 2; L640:.ascii "Accuracy seems adequate.\012\000"
.align 2; L633:.ascii "\011calculations involving tiny interest rates.\012\000"
.align 2; L632:.ascii "\011This much error may spoil financial\012\000"
.align 2; L631:.ascii "\011differs from correct value by %.17e .\012\000"
.align 2; L630:.ascii "\011(1 + (%.17e) ^ (%.17e);\012\000"
.align 2; L629:.ascii " %.17e for\012\000"
.align 2; L628:.ascii "Calculated\000"
.align 2; L621:.ascii "Testing X^((X + 1) / (X - 1)) vs. exp(2) = %.17e as X -> 1.\012\000"
.align 2; L617:.ascii "This computed value is O.K.\012\000"
.align 2; L614:.ascii "   threshold = %.17e .\012\000"
.align 2; L613:.ascii "this is not between 0 and underflow\012\000"
.align 2; L609:.ascii "actually calculating yields: %.17e .\012\000"
.align 2; L608:.ascii "should afflict the expression\012\011(%.17e) ^ (%.17e);\012\000"
.align 2; L607:.ascii "UfThold = (%.17e) ^ (%.17e)\012only underflow \000"
.align 2; L606:.ascii "Since underflow occurs below the threshold\012\000"
.align 2; L605:.ascii "Range is too narrow; U1^%d Underflows.\012\000"
.align 2; L600:.ascii "merely roundoff.\012\000"
.align 2; L599:.ascii "calculation may suffer larger Relative error than \000"
.align 2; L598:.ascii " below which\000"
.align 2; L597:.ascii "The Underflow threshold is %.17e, %s\012\000"
.align 2; L596:.ascii "X / Z = 1 + %g .\012\000"
.align 2; L595:.ascii "X / Z fails!\012\000"
.align 2; L592:.ascii "encounter Division by Zero although actually\012\000"
.align 2; L591:.ascii "  ... (f(X) - f(Z)) / (X - Z) ...\012\000"
.align 2; L590:.ascii "    if (X == Z)  ...  else\000"
.align 2; L589:.ascii "confusion when innocent statements like\012\000"
.align 2; L588:.ascii "this is a SERIOUS DEFECT\012that causes \000"
.align 2; L587:.ascii "    Should this NOT signal Underflow, \000"
.align 2; L586:.ascii "yet X - Z yields %.17e .\012\000"
.align 2; L585:.ascii "X = %.17e\012\011is not equal to Z = %.17e .\012\000"
.align 2; L580:.ascii "Underflow / UfThold failed!\012\000"
.align 2; L569:.ascii "(roundoff in UfThold) < E0.\012\000"
.align 2; L568:.ascii "Underflow is gradual; it incurs Absolute Error =\012\000"
.align 2; L563:.ascii "|Q - Y| = %.17e .\012\000"
.align 2; L562:.ascii "print out as Q = %.17e, Y = %.17e .\012\000"
.align 2; L561:.ascii "Q == Y while denying that |Q - Y| == 0; these values\012\000"
.align 2; L560:.ascii "Underflow confuses Comparison, which alleges that\012\000"
.align 2; L558:.ascii " or else multiplication gets too many last digits wrong.\012\000"
.align 2; L557:.ascii " coming down from %.17e\012\000"
.align 2; L556:.ascii "approach a threshold = %.17e\012\000"
.align 2; L555:.ascii "Either accuracy deteriorates as numbers\012\000"
.align 2; L543:.ascii "Smallest strictly positive number found is E0 = %g .\012\000"
.align 2; L542:.ascii " threshold than products.\012\000"
.align 2; L541:.ascii "Difference underflows at a higher\000"
.align 2; L538:.ascii " threshold than differences.\012\000"
.align 2; L537:.ascii "Products underflow at a higher\000"
.align 2; L530:.ascii "value PseudoZero that prints out as %g .\012\000"
.align 2; L529:.ascii "Underflow can stick at an allegedly positive\012\000"
.align 2; L528:.ascii "positive, isn't; it prints out as  %g .\012\000"
.align 2; L527:.ascii "But -PseudoZero, which should be\012\000"
.align 2; L524:.ascii "PseudoZero that prints out as: %g .\012\000"
.align 2; L523:.ascii "allegedly negative value\012\000"
.align 2; L522:.ascii "Positive expressions can underflow to an\012\000"
.align 2; L509:.ascii "multiplication gets too many last digits wrong.\012\000"
.align 2; L485:.ascii "Seeking Underflow thresholds UfThold and E0.\012\000"
.align 2; L482:.ascii "... no discrepancis found.\012\000"
.align 2; L479:.ascii "\011involving interest rates.\012\000"
.align 2; L478:.ascii "Errors like this may invalidate financial calculations\012\000"
.align 2; L457:.ascii "Testing powers Z^i for small Integers Z and i.\012\000"
.align 2; L454:.ascii "sqrt gets too many last digits wrong\000"
.align 2; L452:.ascii "to %.7e ulps.\012\000"
.align 2; L451:.ascii "Observed errors run from %.7e \000"
.align 2; L450:.ascii "Square root is neither chopped nor correctly rounded.\012\000"
.align 2; L447:.ascii "Square root appears to be chopped.\012\000"
.align 2; L442:.ascii "Square root appears to be correctly rounded.\012\000"
.align 2; L437:.ascii " fails test whether sqrt rounds or chops.\012\000"
.align 2; L436:.ascii "Radix^Precision = %.7e\012\000"
.align 2; L435:.ascii "Anomalous arithmetic with Integer < \000"
.align 2; L395:.ascii "Testing whether sqrt is rounded or chopped.\012\000"
.align 2; L373:.ascii "sqrt(X) is non-monotonic for X near %.7e .\012\000"
.align 2; L372:.ascii "sqrt has passed a test for Monotonicity.\012\000"
.align 2; L355:.ascii "Test for sqrt monotonicity.\012\000"
.align 2; L344:.ascii "Testing if sqrt(X * X) == X for %d Integers X.\012\000"
.align 2; L339:.ascii "Square root of 0.0, -0.0 or 1.0 wrong\000"
.align 2; L337:.ascii "\012Running test of square root(x).\012\000"
.align 2; L336:.ascii "     No failures found in %d integer pairs.\012\000"
.align 2; L335:.ascii "X * Y == Y * X trial fails.\012\000"
.align 2; L326:.long 0x40080000,0x0
.align 2; L325:.ascii "Testing on %d random pairs.\012\000"
.align 2; L324:.ascii "Does Multiplication commute?  \000"
.align 2; L321:.ascii "lack(s) of guard digits or failure(s) to correctly round or chop"
.ascii "\012(noted above) count as one flaw in the final tally below\000"
.align 2; L319:.ascii "Sticky bit used incorrectly or not at all.\012\000"
.align 2; L318:.ascii "Sticky bit apparently used correctly.\012\000"
.align 2; L301:.ascii "Checking for sticky bit.\012\000"
.align 2; L298:.ascii "(X - Y) + (Y - X) is non zero!\012\000"
.align 2; L295:.ascii "Addition/Subtraction neither rounds nor chops.\012\000"
.align 2; L294:.ascii "Add/Subtract\000"
.align 2; L291:.ascii "Addition/Subtraction appears to round correctly.\012\000"
.align 2; L284:.ascii "Add/Subtract appears to be chopped.\012\000"
.align 2; L279:.ascii "Incomplete carry-propagation in Addition\000"
.align 2; L275:.ascii "Radix * ( 1 / Radix ) differs from 1\000"
.align 2; L273:.ascii "/ is neither chopped nor correctly rounded.\012\000"
.align 2; L270:.ascii "Division appears to chop.\012\000"
.align 2; L267:.ascii "Division\000"
.align 2; L264:.ascii "Division appears to round correctly.\012\000"
.align 2; L259:.ascii "Multiplication\000"
.align 2; L256:.ascii "* is neither chopped nor correctly rounded.\012\000"
.align 2; L255:.ascii "Multiplication appears to chop.\012\000"
.align 2; L252:.ascii "Multiplication appears to round correctly.\012\000"
.align 2; L242:.ascii "X * (1/X) differs from 1\000"
.align 2; L223:.ascii "Checking rounding on multiply, divide and add/subtract.\012\000"
.align 2; L222:.ascii "     *, /, and - appear to have guard digits, as they should.\012"
.ascii "\000"
.align 2; L219:.ascii "  ...  if (X == 1.0) {.....} else {.../(X-1.0)...}\012\000"
.align 2; L218:.ascii "  such precautions against division by zero as\012\000"
.align 2; L217:.ascii "  subtraction yields  (1-U1) - 1 = 0 , thereby vitiating\012\000"
.align 2; L216:.ascii "comparison alleges  (1-U1) < 1  although\012\000"
.align 2; L213:.ascii "- lacks Guard Digit, so cancellation is obscured\000"
.align 2; L208:.ascii "* and/or / gets too many last digits wrong\000"
.align 2; L204:.ascii "Computed value of 1/1.000..1 >= 1\000"
.align 2; L202:.ascii "Division lacks a Guard Digit, so X/1 != X\000"
.align 2; L197:.ascii "Division lacks a Guard Digit, so error can exceed 1 ulp\012or  1"
.ascii "/3  and  3/9  and  9/27 may disagree\000"
.align 2; L193:.ascii "* gets too many final digits wrong.\012\000"
.align 2; L191:.ascii "* lacks a Guard Digit, so 1*X != X\000"
.align 2; L188:.ascii "\012Checking for guard digit in *, /, and -.\012\000"
.align 2; L187:.ascii "Subtraction appears to be normalized, as it should be.\000"
.align 2; L182:.ascii "Subtraction is not normalized X=Y,X+Z != Y+Z!\000"
.align 2; L178:.ascii "roughly %g extra significant decimals.\012\000"
.align 2; L177:.ascii "precisely with about %g extra B-digits, i.e.\012\000"
.align 2; L176:.ascii "Some subexpressions appear to be calculated extra\012\000"
.align 2; L170:.ascii "of an\012extra-precision\000"
.align 2; L169:.ascii "Z1 = %.7e, or Z2 = %.7e \000"
.align 2; L168:.ascii ", or exact rational arithmetic a result\012\000"
.align 2; L167:.ascii "Because of unusual Radix = %f\000"
.align 2; L163:.ascii "\011U2 = %.7e, Z2 - U2 = %.7e\012\000"
.align 2; L162:.ascii "\011U1 = %.7e, Z1 - U1 = %.7e\012\000"
.align 2; L161:.ascii "Precision\000"
.align 2; L160:.byte 0
.align 2; L153:.ascii "That feature is not tested further by this program.\012\000"
.align 2; L148:.ascii "Possibly some part of this\000"
.align 2; L147:.ascii "by extra-precise evaluation of arithmetic subexpressions.\012\000"
.align 2; L146:.ascii "are symptoms of inconsistencies introduced\012\000"
.align 2; L145:.ascii "respectively  %.7e,  %.7e,  %.7e,\012\000"
.align 2; L144:.ascii "Disagreements among the values X1, Y1, Z1,\012\000"
.align 2; L122:.ascii "Precision worse than 5 decimal figures  \000"
.align 2; L120:.ascii "The number of significant digits of the Radix is %f .\012\000"
.align 2; L119:.ascii "logarithmic encoding has precision characterized solely by U1.\012"
.ascii "\000"
.align 2; L116:.ascii "of significant digits but, by itself, this is a minor flaw.\012\000"
.align 2; L115:.ascii "Precision cannot be characterized by an Integer number\012\000"
.align 2; L102:.ascii "Comparison is fuzzy,X=1 but X-1/2-1/2 != 0\000"
.align 2; L98:.ascii "(1-U1)-1/2 < 1/2 is FALSE, prog. fails?\000"
.align 2; L96:.long 0x40240000,0x0
.align 2; L91:.ascii "Radix is not as good as 2 or 10\000"
.align 2; L87:.ascii "Radix is too big: roundoff problems\000"
.align 2; L85:.ascii "MYSTERY: recalculated Radix = %.7e .\012\000"
.align 2; L84:.ascii "Radix confirmed.\012\000"
.align 2; L81:.long 0x3f847ae1,0x47ae147a
.align 2; L80:.ascii "gets better closest relative separation U1 = %.7e .\012\000"
.align 2; L79:.ascii "confirms closest relative separation U1 .\012\000"
.align 2; L64:.ascii "Recalculating radix and precision\012 \000"
.align 2; L63:.ascii "Closest relative separation found is U1 = %.7e .\012\012\000"
.align 2; L57:.ascii "Radix = %f .\012\000"
.align 2; L48:.ascii "Searching for Radix and Precision.\012\000"
.align 2; L47:.byte 10,0
.align 2; L46:.ascii "-1, 0, 1/2, 1, 2, 3, 4, 5, 9, 27, 32 & 240 are O.K.\012\000"
.align 2; L41:.ascii "5 != 4+1, 240/3 != 80, 240/4 != 60, or 240/5 != 48\000"
.align 2; L37:.ascii "9 != 3*3, 27 != 9*3, 32 != 8*4, or 32-27-4-1 != 0\000"
.align 2; L33:.ascii "1/2 + (-1) + 1/2 != 0\000"
.align 2; L29:.ascii "-1+1 != 0, (-1)+abs(1) != 0, or -1+(-1)*(-1) != 0\000"
.align 2; L25:.ascii "3 != 2+1, 4 != 3+1, 4+2*(-2) != 0, or 4-3-1 != 0\000"
.align 2; L23:.long 0x3f50624d,0xd2f1a9fb
.align 2; L22:.ascii "Comparison alleges that -0.0 is Non-zero!\012\000"
.align 2; L17:.ascii "0+0 != 0, 1-1 != 0, 1 <= 0, or 1+1 != 2\000"
.align 2; L15:.ascii "Program is now RUNNING tests on small integers:\012\000"
.align 2; L11:.long 0x3ff00000,0x0
.align 2; L10:.long 0x0,0x0
.align 2; L9:.ascii "double\000"
.align 2; L8:.ascii "precision\000"
.align 2; L7:.ascii "set\000"
.align 2; L2:.ascii "\012* * * FLOATING-POINT ERROR * * *\012\000"
