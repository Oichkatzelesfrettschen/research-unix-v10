.seg "data"
.global _Zero
.align 8; _Zero:.word 0x0,0x0
.global _Half
.align 8; _Half:.word 0x3fe00000,0x0
.global _One
.align 8; _One:.word 0x3ff00000,0x0
.global _Two
.align 8; _Two:.word 0x40000000,0x0
.global _Three
.align 8; _Three:.word 0x40080000,0x0
.global _Four
.align 8; _Four:.word 0x40100000,0x0
.global _Five
.align 8; _Five:.word 0x40140000,0x0
.global _Eight
.align 8; _Eight:.word 0x40200000,0x0
.global _Nine
.align 8; _Nine:.word 0x40220000,0x0
.global _TwentySeven
.align 8; _TwentySeven:.word 0x403b0000,0x0
.global _ThirtyTwo
.align 8; _ThirtyTwo:.word 0x40400000,0x0
.global _TwoForty
.align 8; _TwoForty:.word 0x406e0000,0x0
.global _MinusOne
.align 8; _MinusOne:.word 0xbff00000,0x0
.global _OneAndHalf
.align 8; _OneAndHalf:.word 0x3ff80000,0x0
.global _NoTrials
.align 4; _NoTrials:.word 20
.seg "text"
.global _sigfpe
.align 4
.proc 4
_sigfpe:save %sp,-96,%sp
set _fpecount,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set L2,%r8
call _printf; nop
set __iob+20,%r8
call _fflush; nop
set _sigsave,%r29
ld [%r29],%r29
cmp %r29,%r0; be L4; nop
set 8,%r8
set _sigsave,%r29
ld [%r29],%r9
call _signal; nop
set _sigsave,%r29
st %r0,[%r29]
set _ovfl_buf,%r8
set 1,%r9
call _longjmp; nop
L4:
call _abort; nop
L1:
ret; restore
.seg "data"
.align 4; _759:.word L760
.word L761
.word L762
.word L763
.seg "text"
.global _main
.align 4
.proc 4
_main:save %sp,-176,%sp
set L7,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L8,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f30,%f28
set _Two,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f28,%f30,%f26
set _Three,%r29
st %f26,[%r29]; st %f27,[%r29+4]
ld [%r29],%f26; ld [%r29+4],%f27
faddd %f26,%f30,%f24
set _Four,%r29
st %f24,[%r29]; st %f25,[%r29+4]
ld [%r29],%f24; ld [%r29+4],%f25
faddd %f24,%f30,%f22
set _Five,%r29
st %f22,[%r29]; st %f23,[%r29+4]
faddd %f24,%f24,%f22
set _Eight,%r28
st %f22,[%r28]; st %f23,[%r28+4]
fmuld %f26,%f26,%f22
set _Nine,%r27
st %f22,[%r27]; st %f23,[%r27+4]
ld [%r27],%f22; ld [%r27+4],%f23
fmuld %f22,%f26,%f22
set _TwentySeven,%r27
st %f22,[%r27]; st %f23,[%r27+4]
ld [%r28],%f22; ld [%r28+4],%f23
fmuld %f24,%f22,%f22
set _ThirtyTwo,%r28
st %f22,[%r28]; st %f23,[%r28+4]
ld [%r29],%f22; ld [%r29+4],%f23
fmuld %f24,%f22,%f22
fmuld %f22,%f26,%f26
fmuld %f26,%f24,%f26
set _TwoForty,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fnegs %f30,%f26; fmovs %f31,%f27
set _MinusOne,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fdivd %f30,%f28,%f28
set _Half,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _OneAndHalf,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _ErrCnt,%r29
st %r0,[%r29]
set _ErrCnt+4,%r29
st %r0,[%r29]
set _ErrCnt+8,%r29
st %r0,[%r29]
set _ErrCnt+12,%r29
st %r0,[%r29]
set 1,%r29
set _PageNo,%r28
st %r29,[%r28]
set _Milestone,%r29
st %r0,[%r29]
set 8,%r8
set _sigfpe,%r9
call _signal; nop
call _Instructions; nop
call _Pause; nop
call _Heading; nop
call _Pause; nop
call _Characteristics; nop
call _Pause; nop
call _History; nop
call _Pause; nop
set 7,%r29
set _Milestone,%r28
st %r29,[%r28]
set L12,%r8
call _printf; nop
mov %r0,%r8
set _Zero,%r28
ld [%r28],%f30; ld [%r28+4],%f31
faddd %f30,%f30,%f28
fcmped %f28,%f30; nop; fbne L15; nop
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f28,%f28,%f26
fcmped %f26,%f30; nop; fbne L15; nop
fcmped %f28,%f30; nop; fbule L15; nop
faddd %f28,%f28,%f30
set _Two,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L15; nop
set 1,%r29
ba L16; nop
L15:
mov %r0,%r29
L16:
mov %r29,%r9
set L14,%r10
call _TstCond; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set L7,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L17; nop
set _ErrCnt,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set L19,%r8
call _printf; nop
set L20,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L8,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Radix,%r29
st %f30,[%r29]; st %f31,[%r29+4]
call _TstPtUf; nop
L17:
mov %r0,%r8
set _Three,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Two,%r28
ld [%r28],%f28; ld [%r28+4],%f29
set _One,%r28
ld [%r28],%f26; ld [%r28+4],%f27
faddd %f28,%f26,%f24
fcmped %f30,%f24; nop; fbne L23; nop
set _Four,%r28
ld [%r28],%f24; ld [%r28+4],%f25
faddd %f30,%f26,%f22
fcmped %f24,%f22; nop; fbne L23; nop
fnegs %f28,%f22; fmovs %f29,%f23
fmuld %f28,%f22,%f28
faddd %f24,%f28,%f28
set _Zero,%r28
ld [%r28],%f22; ld [%r28+4],%f23
fcmped %f28,%f22; nop; fbne L23; nop
fsubd %f24,%f30,%f30
fsubd %f30,%f26,%f30
fcmped %f30,%f22; nop; fbne L23; nop
set 1,%r29
ba L24; nop
L23:
mov %r0,%r29
L24:
mov %r29,%r9
set L22,%r10
call _TstCond; nop
set _MinusOne,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%fp+-8]; st %f31,[%fp+-8+4]
set L7,%r28
ld [%r28],%f28; ld [%r28+4],%f29
set _One,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fsubd %f28,%f26,%f28
fcmped %f30,%f28; nop; fbne L27; nop
faddd %f30,%f26,%f28
set _Zero,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fcmped %f28,%f24; nop; fbne L27; nop
faddd %f26,%f30,%f28
fcmped %f28,%f24; nop; fbne L27; nop
st %f26,[%sp+4*0+68]
st %f27,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
ld [%fp+-8],%f30; ld [%fp+-8+4],%f31
faddd %f30,%f0,%f30
set _Zero,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L27; nop
set _MinusOne,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fmuld %f30,%f30,%f26
faddd %f30,%f26,%f30
fcmped %f30,%f28; nop; fbne L27; nop
set 1,%r29
ba L28; nop
L27:
mov %r0,%r29
L28:
mov %r0,%r8
mov %r29,%r9
set L26,%r10
call _TstCond; nop
mov %r0,%r8
set _Half,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _MinusOne,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f28
faddd %f28,%f30,%f30
set _Zero,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L31; nop
set 1,%r29
ba L32; nop
L31:
mov %r0,%r29
L32:
mov %r29,%r9
set L30,%r10
call _TstCond; nop
set 10,%r28
set _Milestone,%r27
st %r28,[%r27]
mov %r0,%r8
set _Nine,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Three,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f28,%f28,%f26
fcmped %f30,%f26; nop; fbne L35; nop
set _TwentySeven,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fmuld %f30,%f28,%f30
fcmped %f26,%f30; nop; fbne L35; nop
set _Eight,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Four,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f28,%f28,%f24
fcmped %f30,%f24; nop; fbne L35; nop
set _ThirtyTwo,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fmuld %f30,%f28,%f30
fcmped %f24,%f30; nop; fbne L35; nop
fsubd %f24,%f26,%f30
fsubd %f30,%f28,%f30
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
set _Zero,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L35; nop
set 1,%r29
ba L36; nop
L35:
mov %r0,%r29
L36:
mov %r29,%r9
set L34,%r10
call _TstCond; nop
mov %r0,%r8
set _Five,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Four,%r28
ld [%r28],%f28; ld [%r28+4],%f29
set _One,%r28
ld [%r28],%f26; ld [%r28+4],%f27
faddd %f28,%f26,%f26
fcmped %f30,%f26; nop; fbne L39; nop
set _TwoForty,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fmuld %f28,%f30,%f24
set _Three,%r28
ld [%r28],%f22; ld [%r28+4],%f23
fmuld %f24,%f22,%f24
fmuld %f24,%f28,%f24
fcmped %f26,%f24; nop; fbne L39; nop
fdivd %f26,%f22,%f24
fmuld %f28,%f28,%f20
fmuld %f20,%f30,%f20
fsubd %f24,%f20,%f24
set _Zero,%r28
ld [%r28],%f20; ld [%r28+4],%f21
fcmped %f24,%f20; nop; fbne L39; nop
fdivd %f26,%f28,%f24
fmuld %f30,%f22,%f18
fmuld %f18,%f28,%f18
fsubd %f24,%f18,%f24
fcmped %f24,%f20; nop; fbne L39; nop
fdivd %f26,%f30,%f30
fmuld %f28,%f22,%f26
fmuld %f26,%f28,%f28
fsubd %f30,%f28,%f30
fcmped %f30,%f20; nop; fbne L39; nop
set 1,%r29
ba L40; nop
L39:
mov %r0,%r29
L40:
mov %r29,%r9
set L38,%r10
call _TstCond; nop
set _ErrCnt,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L41; nop
set L43,%r8
call _printf; nop
set L44,%r8
call _printf; nop
L41:
set L45,%r8
call _printf; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _W,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L46:
set _W,%r29
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
set _Y,%r29
st %f26,[%r29]; st %f27,[%r29+4]
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f26,%f30,%f30
set _Z,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
fsubd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L47:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _MinusOne,%r29
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f0,%f30
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L46; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Precision,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L49:
set _W,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
set _Radix,%r28
st %f26,[%r28]; st %f27,[%r28+4]
faddd %f28,%f28,%f28
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f28,%f30,%f30
st %f30,[%r28]; st %f31,[%r28+4]
L50:
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L49; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Two,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L52; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Radix,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L52:
set L54,%r8
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set L8,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L55; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _W,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L57:
set _Precision,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _W,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Radix,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fmuld %f30,%f26,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f28,%f30
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L58:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _W,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L57; nop
L55:
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _W,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _U1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Radix,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _U2,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L60,%r8
st %f28,[%sp+4*1+68]
st %f29,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L61,%r8
call _printf; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E0,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _U2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Precision,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E3,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Four,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Three,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
set _Third,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Half,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
set _F6,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
faddd %f30,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
st %f0,[%r29]; st %f1,[%r29+4]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L62; nop
set _U2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L62:
L64:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Half,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
set _ThirtyTwo,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fmuld %f26,%f28,%f26
fmuld %f26,%f28,%f28
faddd %f30,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _One,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f28,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L65:
set _U2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L67; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f28,%f30; nop; fbug L64; nop
L67:
set _Two,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Three,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Half,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
set _F6,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
faddd %f30,%f30,%f26
set _Third,%r28
st %f26,[%r28]; st %f27,[%r28+4]
ld [%r28],%f26; ld [%r28+4],%f27
fsubd %f26,%f28,%f28
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f28,%f30,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
st %f0,[%r29]; st %f1,[%r29+4]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L68; nop
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L68:
L70:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Half,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f26
set _ThirtyTwo,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fmuld %f24,%f28,%f24
fmuld %f24,%f28,%f28
faddd %f26,%f28,%f28
set _Y,%r28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f28
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L71:
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L73; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f28,%f30; nop; fbug L70; nop
L73:
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L74; nop
set L76,%r8
call _printf; nop
ba L75; nop
L74:
set L77,%r8
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L75:
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _W,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fsubd %f30,%f28,%f26
faddd %f26,%f30,%f30
set _F9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _U2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fdivd %f30,%f28,%f30
set L78,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _Radix,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E0,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L79; nop
set L81,%r8
call _printf; nop
ba L80; nop
L79:
set L82,%r8
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L80:
set 2,%r8
set _Radix,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Eight,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f28,%f28,%f28
fcmped %f30,%f28; nop; fbug L85; nop
set 1,%r29
ba L86; nop
L85:
mov %r0,%r29
L86:
mov %r29,%r9
set L84,%r10
call _TstCond; nop
set 3,%r8
set _Radix,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Two,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbue L92; nop
set L93,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbue L92; nop
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L89; nop
L92:
set 1,%r29
ba L90; nop
L89:
mov %r0,%r29
L90:
mov %r29,%r9
set L88,%r10
call _TstCond; nop
set 20,%r28
set _Milestone,%r27
st %r28,[%r27]
mov %r0,%r8
set _F9,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Half,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
fcmped %f30,%f28; nop; fbuge L96; nop
set 1,%r29
ba L97; nop
L96:
mov %r0,%r29
L97:
mov %r29,%r9
set L95,%r10
call _TstCond; nop
set _F9,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _X,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set 1,%r27
set _I,%r26
st %r27,[%r26]
ld [%r28],%f30; ld [%r28+4],%f31
set _Half,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
fsubd %f30,%f28,%f30
set _Z,%r28
st %f30,[%r28]; st %f31,[%r28+4]
mov %r0,%r8
set _X,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L102; nop
set _Z,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Zero,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L100; nop
L102:
set 1,%r29
ba L101; nop
L100:
mov %r0,%r29
L101:
mov %r29,%r9
set L99,%r10
call _TstCond; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
set _X,%r29
st %f26,[%r29]; st %f27,[%r29+4]
set _I,%r29
st %r0,[%r29]
set 25,%r29
set _Milestone,%r28
st %r29,[%r28]
set _Radix,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f26,%f30,%f24
set _BMinusU2,%r29
st %f24,[%r29]; st %f25,[%r29+4]
ld [%r29],%f24; ld [%r29+4],%f25
fsubd %f24,%f28,%f28
faddd %f28,%f30,%f28
st %f28,[%r29]; st %f29,[%r29+4]
fcmped %f26,%f30; nop; fbue L103; nop
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
st %f0,[%fp+-16]; st %f1,[%fp+-16+4]
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
set _TwoForty,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
ld [%fp+-16],%f28; ld [%fp+-16+4],%f29
fmuld %f30,%f28,%f30
fdivd %f30,%f0,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _Y,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _Four,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fmuld %f0,%f30,%f30
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L105; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L105:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _TwoForty,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _Precision,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Half,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _Y,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _Precision,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _TwoForty,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fmuld %f0,%f30,%f30
set _Half,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L107; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Precision,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L107:
L103:
set _Precision,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%fp+-16]; st %f31,[%fp+-16+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
ld [%fp+-16],%f30; ld [%fp+-16+4],%f31
fcmped %f30,%f0; nop; fbne L111; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L109; nop
L111:
set L112,%r8
call _printf; nop
set L113,%r8
call _printf; nop
L109:
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L114; nop
set L116,%r8
call _printf; nop
ba L115; nop
L114:
set L117,%r8
set _Precision,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L115:
set 1,%r8
set _U2,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Nine,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
fmuld %f30,%f28,%f30
set _TwoForty,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbuge L120; nop
set 1,%r29
ba L121; nop
L120:
mov %r0,%r29
L121:
mov %r29,%r9
set L119,%r10
call _TstCond; nop
set 30,%r29
set _Milestone,%r28
st %r29,[%r28]
set _Four,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Three,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f26
set _One,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fsubd %f26,%f24,%f26
fdivd %f24,%f30,%f30
fsubd %f26,%f30,%f26
fmuld %f26,%f28,%f28
fsubd %f28,%f30,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _X,%r29
st %f0,[%r29]; st %f1,[%r29+4]
L122:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z2,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _One,%r27
ld [%r27],%f30; ld [%r27+4],%f31
set _Half,%r27
ld [%r27],%f28; ld [%r27+4],%f29
ld [%r28],%f26; ld [%r28+4],%f27
fmuld %f28,%f26,%f28
set _ThirtyTwo,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fmuld %f24,%f26,%f24
fmuld %f24,%f26,%f26
faddd %f28,%f26,%f28
faddd %f30,%f28,%f28
fsubd %f28,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L123:
set _Z2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L125; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f28,%f30; nop; fbug L122; nop
L125:
set _Three,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Four,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f26
set _Two,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fdivd %f24,%f30,%f24
fsubd %f26,%f24,%f26
fmuld %f26,%f30,%f30
set _One,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fdivd %f26,%f28,%f28
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _Z,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _Y,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _X,%r29
st %f0,[%r29]; st %f1,[%r29+4]
L126:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z1,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _One,%r27
ld [%r27],%f30; ld [%r27+4],%f31
set _Two,%r27
ld [%r27],%f28; ld [%r27+4],%f29
fdivd %f30,%f28,%f30
set _Half,%r27
ld [%r27],%f28; ld [%r27+4],%f29
ld [%r28],%f26; ld [%r28+4],%f27
fmuld %f28,%f26,%f28
set _ThirtyTwo,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fmuld %f24,%f26,%f24
fmuld %f24,%f26,%f26
faddd %f28,%f26,%f28
fsubd %f30,%f28,%f28
faddd %f28,%f30,%f28
fsubd %f30,%f28,%f28
faddd %f28,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L127:
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L129; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f28,%f30; nop; fbug L126; nop
L129:
L130:
L133:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y1,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Half,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f26
set _ThirtyTwo,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fmuld %f24,%f28,%f24
fmuld %f24,%f28,%f28
faddd %f26,%f28,%f28
fsubd %f30,%f28,%f28
faddd %f28,%f30,%f28
fsubd %f30,%f28,%f28
faddd %f28,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L134:
set _Y1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L136; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f28,%f30; nop; fbug L133; nop
L136:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X1,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Half,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
set _ThirtyTwo,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fmuld %f26,%f28,%f26
fmuld %f26,%f28,%f28
faddd %f30,%f28,%f30
set _F9,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
faddd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L131:
set _X1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L137; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f28,%f30; nop; fbug L130; nop
L137:
set _X1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L140; nop
set _Z1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L138; nop
L140:
set 1,%r8
set L141,%r9
call _BadCond; nop
set L142,%r8
set _X1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Y1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*5+68]
st %f31,[%sp+4*6+68]
ld [%sp+4*5+68],%o5
call _printf; nop
set L143,%r8
call _printf; nop
set L144,%r8
call _printf; nop
set L145,%r8
call _notify; nop
set _X1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L149; nop
set _Y1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbue L149; nop
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbne L139; nop
L149:
set L150,%r8
call _printf; nop
ba L139; nop
L138:
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L153; nop
set _Z2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L151; nop
L153:
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L156; nop
set _Z2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L154; nop
L156:
mov %r0,%r8
set L157,%r9
call _BadCond; nop
set L158,%r8
call _notify; nop
set L159,%r8
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Z1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f28,%f30,%f30
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
call _printf; nop
set L160,%r8
set _U2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Z2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f28,%f30,%f30
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
call _printf; nop
ba L155; nop
L154:
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L163; nop
set _Z2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbug L161; nop
L163:
set L164,%r8
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L165,%r8
call _printf; nop
set L166,%r8
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Z2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
call _printf; nop
set L167,%r8
call _notify; nop
L161:
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L170; nop
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L168; nop
L170:
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Z2,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _U2,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L171; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L171:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
fnegs %f0,%f30; fmovs %f1,%f31
set _Q,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L173,%r8
call _printf; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
set L174,%r8
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fdivd %f30,%f0,%f30
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L93,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
set L175,%r8
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fdivd %f30,%f0,%f30
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L168:
set L150,%r8
call _printf; nop
L155:
L151:
L139:
call _Pause; nop
set 35,%r29
set _Milestone,%r28
st %r29,[%r28]
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Two,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L176; nop
set _W,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Radix,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f28,%f28,%f28
fdivd %f30,%f28,%f30
set _X,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
set _One,%r27
ld [%r27],%f28; ld [%r27+4],%f29
faddd %f30,%f28,%f28
set _Y,%r27
st %f28,[%r27]; st %f29,[%r27+4]
ld [%r27],%f28; ld [%r27+4],%f29
fsubd %f28,%f30,%f30
set _Z,%r27
st %f30,[%r27]; st %f31,[%r27+4]
ld [%r27],%f30; ld [%r27+4],%f31
set _U2,%r27
ld [%r27],%f28; ld [%r27+4],%f29
faddd %f30,%f28,%f28
set _T,%r27
st %f28,[%r27]; st %f29,[%r27+4]
ld [%r27],%f28; ld [%r27+4],%f29
fsubd %f28,%f30,%f30
st %f30,[%r28]; st %f31,[%r28+4]
mov %r0,%r8
set _X,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _U2,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L180; nop
set 1,%r29
ba L181; nop
L180:
mov %r0,%r29
L181:
mov %r29,%r9
set L179,%r10
call _TstCond; nop
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L182; nop
set L184,%r8
call _printf; nop
L182:
L176:
set L185,%r8
call _printf; nop
set _F9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f26
set _Y,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fmuld %f28,%f30,%f26
set _Z,%r28
st %f26,[%r28]; st %f27,[%r28+4]
set _Half,%r27
ld [%r27],%f26; ld [%r27+4],%f27
fsubd %f30,%f26,%f30
set _X,%r27
st %f30,[%r27]; st %f31,[%r27+4]
ld [%r29],%f30; ld [%r29+4],%f31
fsubd %f30,%f26,%f30
ld [%r27],%f24; ld [%r27+4],%f25
fsubd %f30,%f24,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r28],%f30; ld [%r28+4],%f31
fsubd %f30,%f26,%f30
fsubd %f30,%f24,%f30
st %f30,[%r28]; st %f31,[%r28+4]
set _U2,%r26
ld [%r26],%f30; ld [%r26+4],%f31
faddd %f28,%f30,%f26
st %f26,[%r27]; st %f27,[%r27+4]
ld [%r27],%f26; ld [%r27+4],%f27
set _Radix,%r26
ld [%r26],%f24; ld [%r26+4],%f25
fmuld %f26,%f24,%f22
set _T,%r26
st %f22,[%r26]; st %f23,[%r26+4]
fmuld %f24,%f26,%f26
set _R,%r25
st %f26,[%r25]; st %f27,[%r25+4]
ld [%r26],%f26; ld [%r26+4],%f27
fsubd %f26,%f24,%f26
st %f26,[%r27]; st %f27,[%r27+4]
ld [%r27],%f26; ld [%r27+4],%f27
fmuld %f24,%f30,%f30
fsubd %f26,%f30,%f26
st %f26,[%r27]; st %f27,[%r27+4]
ld [%r25],%f26; ld [%r25+4],%f27
fsubd %f26,%f24,%f26
st %f26,[%r26]; st %f27,[%r26+4]
ld [%r26],%f26; ld [%r26+4],%f27
fsubd %f26,%f30,%f30
st %f30,[%r26]; st %f31,[%r26+4]
ld [%r27],%f30; ld [%r27+4],%f31
fsubd %f24,%f28,%f28
fmuld %f30,%f28,%f30
st %f30,[%r27]; st %f31,[%r27+4]
ld [%r26],%f30; ld [%r26+4],%f31
fmuld %f30,%f28,%f30
st %f30,[%r26]; st %f31,[%r26+4]
ld [%r27],%f30; ld [%r27+4],%f31
set _Zero,%r27
ld [%r27],%f28; ld [%r27+4],%f29
fcmped %f30,%f28; nop; fbne L186; nop
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbne L186; nop
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbne L186; nop
ld [%r26],%f30; ld [%r26+4],%f31
fcmped %f30,%f28; nop; fbne L186; nop
set 1,%r29
set _GMult,%r28
st %r29,[%r28]
ba L187; nop
L186:
set _GMult,%r29
st %r0,[%r29]
set 1,%r8
mov %r0,%r9
set L188,%r10
call _TstCond; nop
L187:
set _Radix,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _U2,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
set _Z,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _One,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
set _X,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
faddd %f30,%f28,%f28
fmuld %f30,%f30,%f30
fsubd %f28,%f30,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _U2,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fsubd %f0,%f30,%f28
set _Y,%r28
st %f28,[%r28]; st %f29,[%r28+4]
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f28,%f30,%f28
set _X,%r28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f28,%f30,%f30
fmuld %f28,%f28,%f28
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _U1,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fsubd %f0,%f30,%f30
set _Z,%r28
st %f30,[%r28]; st %f31,[%r28+4]
mov %r0,%r8
set _Y,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Zero,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbug L191; nop
set _Z,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbug L191; nop
set 1,%r29
ba L192; nop
L191:
mov %r0,%r29
L192:
mov %r29,%r9
set L190,%r10
call _TstCond; nop
set _One,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _U2,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f26
set _Y,%r28
st %f26,[%r28]; st %f27,[%r28+4]
faddd %f30,%f28,%f28
set _X,%r27
st %f28,[%r27]; st %f29,[%r27+4]
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f28
set _Z,%r26
st %f28,[%r26]; st %f29,[%r26+4]
ld [%r26],%f28; ld [%r26+4],%f29
ld [%r27],%f26; ld [%r27+4],%f27
fsubd %f28,%f26,%f28
st %f28,[%r28]; st %f29,[%r28+4]
set _Three,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f30
st %f30,[%r27]; st %f31,[%r27+4]
set _Nine,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fdivd %f28,%f30,%f28
st %f28,[%r26]; st %f29,[%r26+4]
ld [%r27],%f28; ld [%r27+4],%f29
ld [%r26],%f26; ld [%r26+4],%f27
fsubd %f28,%f26,%f28
st %f28,[%r27]; st %f29,[%r27+4]
set _TwentySeven,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f30
set _T,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
fsubd %f26,%f30,%f30
st %f30,[%r26]; st %f31,[%r26+4]
set 2,%r8
set _X,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Zero,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L195; nop
set _Y,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbne L195; nop
set _Z,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbne L195; nop
set 1,%r29
ba L196; nop
L195:
mov %r0,%r29
L196:
mov %r29,%r9
set L194,%r10
call _TstCond; nop
set _F9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f26
set _Y,%r29
st %f26,[%r29]; st %f27,[%r29+4]
set _Half,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fsubd %f30,%f26,%f30
set _X,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r29],%f30; ld [%r29+4],%f31
fsubd %f30,%f26,%f30
ld [%r28],%f26; ld [%r28+4],%f27
fsubd %f30,%f26,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _U2,%r27
ld [%r27],%f30; ld [%r27+4],%f31
faddd %f28,%f30,%f30
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
fdivd %f30,%f28,%f28
set _T,%r27
st %f28,[%r27]; st %f29,[%r27+4]
ld [%r27],%f28; ld [%r27+4],%f29
fsubd %f28,%f30,%f30
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
set _Zero,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L197; nop
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbne L197; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbne L197; nop
set 1,%r29
set _GDiv,%r28
st %r29,[%r28]
ba L198; nop
L197:
set _GDiv,%r29
st %r0,[%r29]
set 1,%r8
mov %r0,%r9
set L199,%r10
call _TstCond; nop
L198:
set _One,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _U2,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f28
fdivd %f30,%f28,%f30
set _X,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
set _Half,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
fsubd %f30,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set 1,%r8
set _Y,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Zero,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbuge L202; nop
set 1,%r29
ba L203; nop
L202:
mov %r0,%r29
L203:
mov %r29,%r9
set L201,%r10
call _TstCond; nop
set _One,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _U2,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f26
set _X,%r28
st %f26,[%r28]; st %f27,[%r28+4]
set _Radix,%r27
ld [%r27],%f26; ld [%r27+4],%f27
fmuld %f26,%f28,%f28
faddd %f30,%f28,%f30
set _Y,%r27
st %f30,[%r27]; st %f31,[%r27+4]
ld [%r28],%f30; ld [%r28+4],%f31
fmuld %f30,%f26,%f28
set _Z,%r26
st %f28,[%r26]; st %f29,[%r26+4]
ld [%r27],%f28; ld [%r27+4],%f29
fmuld %f28,%f26,%f24
set _T,%r25
st %f24,[%r25]; st %f25,[%r25+4]
ld [%r26],%f24; ld [%r26+4],%f25
fdivd %f24,%f26,%f24
set _R,%r26
st %f24,[%r26]; st %f25,[%r26+4]
ld [%r25],%f24; ld [%r25+4],%f25
fdivd %f24,%f26,%f26
set _StickyBit,%r25
st %f26,[%r25]; st %f27,[%r25+4]
ld [%r26],%f26; ld [%r26+4],%f27
fsubd %f26,%f30,%f30
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r25],%f30; ld [%r25+4],%f31
fsubd %f30,%f28,%f30
st %f30,[%r27]; st %f31,[%r27+4]
mov %r0,%r8
set _X,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Zero,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L206; nop
set _Y,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbne L206; nop
set 1,%r29
ba L207; nop
L206:
mov %r0,%r29
L207:
mov %r29,%r9
set L205,%r10
call _TstCond; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f26
set _Y,%r29
st %f26,[%r29]; st %f27,[%r29+4]
set _F9,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fsubd %f30,%f26,%f26
set _X,%r28
st %f26,[%r28]; st %f27,[%r28+4]
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f30,%f26,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _Radix,%r27
ld [%r27],%f30; ld [%r27+4],%f31
set _U2,%r27
ld [%r27],%f26; ld [%r27+4],%f27
fsubd %f30,%f26,%f24
set _T,%r27
st %f24,[%r27]; st %f25,[%r27+4]
set _BMinusU2,%r26
ld [%r26],%f24; ld [%r26+4],%f25
fsubd %f30,%f24,%f24
set _Z,%r26
st %f24,[%r26]; st %f25,[%r26+4]
ld [%r27],%f24; ld [%r27+4],%f25
fsubd %f30,%f24,%f30
st %f30,[%r27]; st %f31,[%r27+4]
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbne L208; nop
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbne L208; nop
ld [%r26],%f30; ld [%r26+4],%f31
fcmped %f30,%f26; nop; fbne L208; nop
ld [%r27],%f30; ld [%r27+4],%f31
fcmped %f30,%f26; nop; fbne L208; nop
set 1,%r29
set _GAddSub,%r28
st %r29,[%r28]
ba L209; nop
L208:
set _GAddSub,%r29
st %r0,[%r29]
set 1,%r8
mov %r0,%r9
set L210,%r10
call _TstCond; nop
L209:
set _F9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L211; nop
fsubd %f30,%f28,%f30
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L211; nop
set 1,%r8
set L213,%r9
call _BadCond; nop
set L214,%r8
call _printf; nop
set L215,%r8
call _printf; nop
set L216,%r8
call _printf; nop
L211:
set _GMult,%r29
ld [%r29],%r29
cmp %r29,1; bne L217; nop
set _GDiv,%r29
ld [%r29],%r29
cmp %r29,1; bne L217; nop
set _GAddSub,%r29
ld [%r29],%r29
cmp %r29,1; bne L217; nop
set L219,%r8
call _printf; nop
L217:
set 40,%r29
set _Milestone,%r28
st %r29,[%r28]
call _Pause; nop
set L220,%r8
call _printf; nop
set _RMult,%r29
st %r0,[%r29]
set _RDiv,%r29
st %r0,[%r29]
set _RAddSub,%r29
st %r0,[%r29]
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Two,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _RadixD2,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _A1,%r29
st %f28,[%r29]; st %f29,[%r29+4]
set _Done,%r29
st %r0,[%r29]
L221:
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _AInvrse,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L224:
set _AInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _A1,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L225:
set _AInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _AInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f0,%f30; nop; fbue L224; nop
set _X,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbue L230; nop
set _A1,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Three,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbule L228; nop
L230:
set 1,%r29
ba L229; nop
L228:
mov %r0,%r29
L229:
set _Done,%r28
st %r29,[%r28]
set _Done,%r28
ld [%r28],%r28
cmp %r28,%r0; bne L231; nop
set _Nine,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _A1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L231:
L222:
set _Done,%r29
ld [%r29],%r29
cmp %r29,%r0; be L221; nop
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L233; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _A1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L233:
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _A1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _AInvrse,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _X,%r28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Done,%r29
st %r0,[%r29]
L235:
set _X,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Y,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
set _Half,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
set _Z,%r28
st %f30,[%r28]; st %f31,[%r28+4]
mov %r0,%r8
set _Z,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Half,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L240; nop
set 1,%r29
ba L241; nop
L240:
mov %r0,%r29
L241:
mov %r29,%r9
set L239,%r10
call _TstCond; nop
set _X,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Radix,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L243; nop
set 1,%r29
ba L244; nop
L243:
mov %r0,%r29
L244:
set _Done,%r28
st %r29,[%r28]
set _Radix,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _X,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _One,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
L236:
set _Done,%r29
ld [%r29],%r29
cmp %r29,%r0; be L235; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
set _Y2,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fsubd %f30,%f28,%f30
set _Y1,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _OneAndHalf,%r27
ld [%r27],%f30; ld [%r27+4],%f31
fsubd %f30,%f28,%f26
set _X,%r27
st %f26,[%r27]; st %f27,[%r27+4]
faddd %f30,%f28,%f26
set _Y,%r26
st %f26,[%r26]; st %f27,[%r26+4]
ld [%r27],%f26; ld [%r27+4],%f27
fsubd %f26,%f28,%f24
ld [%r29],%f22; ld [%r29+4],%f23
fmuld %f24,%f22,%f24
set _Z,%r29
st %f24,[%r29]; st %f25,[%r29+4]
ld [%r26],%f24; ld [%r26+4],%f25
ld [%r28],%f20; ld [%r28+4],%f21
fmuld %f24,%f20,%f18
set _T,%r28
st %f18,[%r28]; st %f19,[%r28+4]
ld [%r29],%f18; ld [%r29+4],%f19
fsubd %f18,%f26,%f18
st %f18,[%r29]; st %f19,[%r29+4]
ld [%r28],%f18; ld [%r28+4],%f19
fsubd %f18,%f26,%f18
st %f18,[%r28]; st %f19,[%r28+4]
fmuld %f26,%f22,%f26
st %f26,[%r27]; st %f27,[%r27+4]
faddd %f24,%f28,%f28
fmuld %f28,%f20,%f28
st %f28,[%r26]; st %f29,[%r26+4]
ld [%r27],%f28; ld [%r27+4],%f29
fsubd %f28,%f30,%f28
st %f28,[%r27]; st %f29,[%r27+4]
ld [%r26],%f28; ld [%r26+4],%f29
fsubd %f28,%f30,%f30
st %f30,[%r26]; st %f31,[%r26+4]
ld [%r27],%f30; ld [%r27+4],%f31
set _Zero,%r27
ld [%r27],%f28; ld [%r27+4],%f29
fcmped %f30,%f28; nop; fbne L245; nop
ld [%r26],%f30; ld [%r26+4],%f31
fcmped %f30,%f28; nop; fbne L245; nop
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbne L245; nop
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbug L245; nop
set _OneAndHalf,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
set _Y2,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fmuld %f26,%f24,%f22
set _X,%r29
st %f22,[%r29]; st %f23,[%r29+4]
fsubd %f30,%f28,%f30
fsubd %f30,%f28,%f22
set _Y,%r28
st %f22,[%r28]; st %f23,[%r28+4]
faddd %f26,%f28,%f26
set _Z,%r27
st %f26,[%r27]; st %f27,[%r27+4]
set _Y1,%r26
ld [%r26],%f26; ld [%r26+4],%f27
fmuld %f30,%f26,%f30
set _T,%r25
st %f30,[%r25]; st %f31,[%r25+4]
ld [%r29],%f30; ld [%r29+4],%f31
ld [%r27],%f22; ld [%r27+4],%f23
faddd %f22,%f28,%f20
fsubd %f30,%f20,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r28],%f30; ld [%r28+4],%f31
fmuld %f30,%f26,%f18
set _StickyBit,%r24
st %f18,[%r24]; st %f19,[%r24+4]
fmuld %f22,%f24,%f22
set _S,%r23
st %f22,[%r23]; st %f23,[%r23+4]
ld [%r25],%f22; ld [%r25+4],%f23
fsubd %f22,%f30,%f22
st %f22,[%r25]; st %f23,[%r25+4]
fsubd %f28,%f30,%f30
ld [%r24],%f22; ld [%r24+4],%f23
faddd %f30,%f22,%f30
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r23],%f30; ld [%r23+4],%f31
faddd %f20,%f28,%f22
fsubd %f30,%f22,%f30
st %f30,[%r27]; st %f31,[%r27+4]
faddd %f24,%f28,%f30
fmuld %f30,%f26,%f30
st %f30,[%r24]; st %f31,[%r24+4]
fmuld %f24,%f26,%f30
st %f30,[%r26]; st %f31,[%r26+4]
ld [%r24],%f30; ld [%r24+4],%f31
fsubd %f30,%f24,%f30
st %f30,[%r24]; st %f31,[%r24+4]
ld [%r26],%f30; ld [%r26+4],%f31
set _Half,%r23
ld [%r23],%f28; ld [%r23+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%r26]; st %f31,[%r26+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fcmped %f30,%f26; nop; fbne L247; nop
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f26; nop; fbne L247; nop
ld [%r27],%f30; ld [%r27+4],%f31
fcmped %f30,%f26; nop; fbne L247; nop
ld [%r25],%f30; ld [%r25+4],%f31
fcmped %f30,%f26; nop; fbne L247; nop
ld [%r24],%f30; ld [%r24+4],%f31
fcmped %f30,%f26; nop; fbne L247; nop
ld [%r26],%f30; ld [%r26+4],%f31
fcmped %f30,%f28; nop; fbne L247; nop
set 1,%r29
set _RMult,%r28
st %r29,[%r28]
set L249,%r8
call _printf; nop
ba L248; nop
L247:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _Zero,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fcmped %f30,%f26; nop; fbne L250; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f26; nop; fbuge L250; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f28,%f30
fcmped %f30,%f26; nop; fbne L250; nop
set _T,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f26; nop; fbuge L250; nop
set _StickyBit,%r29
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f28,%f30
fcmped %f30,%f26; nop; fbne L250; nop
set _Y1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Half,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L250; nop
set 2,%r29
set _RMult,%r28
st %r29,[%r28]
set L252,%r8
call _printf; nop
ba L251; nop
L250:
set L253,%r8
call _printf; nop
L251:
L248:
set _RMult,%r29
ld [%r29],%r29
cmp %r29,1; bne L246; nop
set _GMult,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L246; nop
set L256,%r8
call _notify; nop
ba L246; nop
L245:
set L253,%r8
call _printf; nop
L246:
set 45,%r29
set _Milestone,%r28
st %r29,[%r28]
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
set _Y2,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fsubd %f30,%f28,%f30
set _Y1,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _OneAndHalf,%r27
ld [%r27],%f30; ld [%r27+4],%f31
faddd %f30,%f28,%f26
faddd %f26,%f28,%f24
set _Z,%r27
st %f24,[%r27]; st %f25,[%r27+4]
ld [%r27],%f24; ld [%r27+4],%f25
ld [%r29],%f22; ld [%r29+4],%f23
fdivd %f24,%f22,%f20
set _X,%r29
st %f20,[%r29]; st %f21,[%r29+4]
fsubd %f30,%f28,%f20
fsubd %f20,%f28,%f20
set _T,%r26
st %f20,[%r26]; st %f21,[%r26+4]
ld [%r26],%f20; ld [%r26+4],%f21
fsubd %f20,%f28,%f18
ld [%r28],%f16; ld [%r28+4],%f17
fdivd %f18,%f16,%f18
set _Y,%r28
st %f18,[%r28]; st %f19,[%r28+4]
faddd %f24,%f28,%f24
fdivd %f24,%f22,%f24
st %f24,[%r27]; st %f25,[%r27+4]
ld [%r29],%f24; ld [%r29+4],%f25
fsubd %f24,%f30,%f24
st %f24,[%r29]; st %f25,[%r29+4]
ld [%r28],%f24; ld [%r28+4],%f25
fsubd %f24,%f20,%f24
st %f24,[%r28]; st %f25,[%r28+4]
fdivd %f20,%f16,%f24
st %f24,[%r26]; st %f25,[%r26+4]
ld [%r27],%f24; ld [%r27+4],%f25
fsubd %f24,%f26,%f26
st %f26,[%r27]; st %f27,[%r27+4]
fsubd %f28,%f30,%f30
ld [%r26],%f28; ld [%r26+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r26]; st %f31,[%r26+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L257; nop
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbug L257; nop
ld [%r27],%f30; ld [%r27+4],%f31
fcmped %f30,%f28; nop; fbug L257; nop
ld [%r26],%f30; ld [%r26+4],%f31
fcmped %f30,%f28; nop; fbug L257; nop
set _OneAndHalf,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f26
set _X,%r28
st %f26,[%r28]; st %f27,[%r28+4]
set _U2,%r27
ld [%r27],%f26; ld [%r27+4],%f27
fsubd %f30,%f26,%f24
set _Y,%r27
st %f24,[%r27]; st %f25,[%r27+4]
faddd %f30,%f26,%f24
set _Z,%r26
st %f24,[%r26]; st %f25,[%r26+4]
ld [%r28],%f24; ld [%r28+4],%f25
ld [%r27],%f22; ld [%r27+4],%f23
fsubd %f24,%f22,%f24
st %f24,[%r28]; st %f25,[%r28+4]
set _Y1,%r25
ld [%r25],%f24; ld [%r25+4],%f25
fdivd %f30,%f24,%f20
set _T,%r24
st %f20,[%r24]; st %f21,[%r24+4]
fdivd %f22,%f24,%f24
st %f24,[%r27]; st %f25,[%r27+4]
ld [%r24],%f24; ld [%r24+4],%f25
ld [%r26],%f22; ld [%r26+4],%f23
faddd %f22,%f26,%f20
fsubd %f24,%f20,%f24
st %f24,[%r24]; st %f25,[%r24+4]
ld [%r27],%f24; ld [%r27+4],%f25
fsubd %f24,%f22,%f24
st %f24,[%r27]; st %f25,[%r27+4]
fdivd %f22,%f28,%f24
st %f24,[%r26]; st %f25,[%r26+4]
faddd %f28,%f26,%f26
fdivd %f26,%f28,%f26
st %f26,[%r25]; st %f27,[%r25+4]
ld [%r26],%f26; ld [%r26+4],%f27
fsubd %f26,%f30,%f30
st %f30,[%r26]; st %f31,[%r26+4]
ld [%r25],%f30; ld [%r25+4],%f31
fsubd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _F9,%r23
ld [%r23],%f30; ld [%r23+4],%f31
set _U1,%r23
ld [%r23],%f28; ld [%r23+4],%f29
fsubd %f30,%f28,%f28
fdivd %f28,%f30,%f28
st %f28,[%r25]; st %f29,[%r25+4]
ld [%r28],%f28; ld [%r28+4],%f29
set _Zero,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fcmped %f28,%f26; nop; fbne L259; nop
ld [%r27],%f28; ld [%r27+4],%f29
fcmped %f28,%f26; nop; fbne L259; nop
ld [%r26],%f28; ld [%r26+4],%f29
fcmped %f28,%f26; nop; fbne L259; nop
ld [%r24],%f28; ld [%r24+4],%f29
fcmped %f28,%f26; nop; fbne L259; nop
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f28,%f26; nop; fbne L259; nop
fcmped %f28,%f26; nop; fbne L259; nop
ld [%r25],%f28; ld [%r25+4],%f29
set _Half,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f28,%f26,%f28
fsubd %f30,%f26,%f30
fcmped %f28,%f30; nop; fbne L259; nop
set 1,%r29
set _RDiv,%r28
st %r29,[%r28]
set L261,%r8
call _printf; nop
set _GDiv,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L260; nop
set L264,%r8
call _notify; nop
ba L260; nop
L259:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L265; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbuge L265; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbuge L265; nop
set _T,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbuge L265; nop
set _Y2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbuge L265; nop
set _Y1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Half,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _F9,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f26,%f28,%f28
fcmped %f30,%f28; nop; fbuge L265; nop
set 2,%r29
set _RDiv,%r28
st %r29,[%r28]
set L267,%r8
call _printf; nop
L265:
L260:
L257:
set _RDiv,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L268; nop
set L270,%r8
call _printf; nop
L268:
set _One,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Radix,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f30
set _BInvrse,%r28
st %f30,[%r28]; st %f31,[%r28+4]
mov %r0,%r8
set _BInvrse,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Radix,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
set _Half,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
fcmped %f30,%f28; nop; fbne L273; nop
set 1,%r29
ba L274; nop
L273:
mov %r0,%r29
L274:
mov %r29,%r9
set L272,%r10
call _TstCond; nop
set 50,%r28
set _Milestone,%r27
st %r28,[%r27]
mov %r0,%r8
set _F9,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _U1,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
set _Half,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
fcmped %f30,%f28; nop; fbne L277; nop
set _BMinusU2,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _U2,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
set _Radix,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fsubd %f26,%f28,%f28
fcmped %f30,%f28; nop; fbne L277; nop
set 1,%r29
ba L278; nop
L277:
mov %r0,%r29
L278:
mov %r29,%r9
set L276,%r10
call _TstCond; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f28,%f28,%f28
fsubd %f30,%f28,%f28
set _X,%r29
st %f28,[%r29]; st %f29,[%r29+4]
set _U2,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f26
fmuld %f28,%f26,%f28
faddd %f30,%f28,%f28
set _Y,%r28
st %f28,[%r28]; st %f29,[%r28+4]
set _F9,%r27
ld [%r27],%f28; ld [%r27+4],%f29
set _Half,%r27
ld [%r27],%f26; ld [%r27+4],%f27
fsubd %f28,%f26,%f28
set _Z,%r27
st %f28,[%r27]; st %f29,[%r27+4]
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f28,%f26,%f28
ld [%r27],%f26; ld [%r27+4],%f27
fsubd %f28,%f26,%f28
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f28,%f30,%f30
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L279; nop
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbne L279; nop
set 2,%r29
set _RAddSub,%r28
st %r29,[%r28]
set L281,%r8
call _printf; nop
L279:
set _GAddSub,%r29
ld [%r29],%r29
cmp %r29,1; bne L282; nop
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
fmuld %f26,%f28,%f26
set _X,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fsubd %f30,%f28,%f30
fmuld %f30,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _One,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r29],%f26; ld [%r29+4],%f27
faddd %f30,%f26,%f26
st %f26,[%r29]; st %f27,[%r29+4]
ld [%r28],%f26; ld [%r28+4],%f27
faddd %f30,%f26,%f26
st %f26,[%r28]; st %f27,[%r28+4]
faddd %f30,%f28,%f28
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f28,%f26,%f28
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L284; nop
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbne L284; nop
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
set _U1,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fmuld %f26,%f24,%f26
set _X,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fsubd %f30,%f28,%f30
fmuld %f30,%f24,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _One,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f28
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f28
st %f28,[%r28]; st %f29,[%r28+4]
set _F9,%r27
ld [%r27],%f28; ld [%r27+4],%f29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f28,%f26,%f28
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L286; nop
ld [%r28],%f30; ld [%r28+4],%f31
fcmped %f30,%f28; nop; fbne L286; nop
set 1,%r29
set _RAddSub,%r28
st %r29,[%r28]
set L288,%r8
call _printf; nop
set _GAddSub,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L283; nop
set L291,%r8
call _notify; nop
ba L283; nop
L286:
set L292,%r8
call _printf; nop
ba L283; nop
L284:
set L292,%r8
call _printf; nop
ba L283; nop
L282:
set L292,%r8
call _printf; nop
L283:
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _S,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Half,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
fmuld %f28,%f26,%f26
faddd %f30,%f26,%f26
set _X,%r29
st %f26,[%r29]; st %f27,[%r29+4]
set _U2,%r28
ld [%r28],%f26; ld [%r28+4],%f27
faddd %f30,%f26,%f30
fmuld %f30,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r29],%f30; ld [%r29+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f26
set _Z,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fsubd %f28,%f30,%f30
set _T,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r29],%f30; ld [%r29+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
set _StickyBit,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L293; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _S,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 3,%r8
set L295,%r9
call _BadCond; nop
L293:
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _StickyBit,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _GMult,%r29
ld [%r29],%r29
cmp %r29,1; bne L296; nop
set _GDiv,%r29
ld [%r29],%r29
cmp %r29,1; bne L296; nop
set _GAddSub,%r29
ld [%r29],%r29
cmp %r29,1; bne L296; nop
set _RMult,%r29
ld [%r29],%r29
cmp %r29,1; bne L296; nop
set _RDiv,%r29
ld [%r29],%r29
cmp %r29,1; bne L296; nop
set _RAddSub,%r29
ld [%r29],%r29
cmp %r29,1; bne L296; nop
set _RadixD2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _RadixD2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f0,%f30; nop; fbne L296; nop
set L298,%r8
call _printf; nop
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f28
set _U2,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f28,%f26,%f28
set _X,%r29
st %f28,[%r29]; st %f29,[%r29+4]
fmuld %f30,%f26,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _One,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f28
set _Z,%r28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f28
set _T,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f28,%f30,%f28
set _Zero,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fcmped %f28,%f24; nop; fbug L299; nop
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f28,%f30,%f30
fcmped %f30,%f26; nop; fbul L299; nop
set _T,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f28
set _Z,%r28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r28],%f28; ld [%r28+4],%f29
set _X,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fsubd %f28,%f26,%f26
st %f26,[%r29]; st %f27,[%r29+4]
fsubd %f28,%f30,%f28
set _U2,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fcmped %f28,%f26; nop; fbul L301; nop
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f28,%f30,%f30
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L301; nop
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
fmuld %f26,%f28,%f26
set _X,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fmuld %f30,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _One,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f28
set _Z,%r28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f28
set _T,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f28,%f30,%f30
set _Zero,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L303; nop
ld [%r29],%f30; ld [%r29+4],%f31
set _F9,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f30,%f26,%f30
fcmped %f30,%f28; nop; fbne L303; nop
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
fmuld %f30,%f28,%f30
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _F9,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f30,%f26,%f26
set _T,%r29
st %f26,[%r29]; st %f27,[%r29+4]
set _Y,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fsubd %f30,%f26,%f26
set _Q,%r28
st %f26,[%r28]; st %f27,[%r28+4]
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f26,%f30,%f26
set _Zero,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fcmped %f26,%f24; nop; fbne L305; nop
fsubd %f30,%f28,%f30
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
fcmped %f30,%f24; nop; fbne L305; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f26
set _OneAndHalf,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fmuld %f26,%f24,%f26
set _Z,%r29
st %f26,[%r29]; st %f27,[%r29+4]
faddd %f24,%f28,%f26
ld [%r29],%f24; ld [%r29+4],%f25
fsubd %f26,%f24,%f26
faddd %f26,%f28,%f26
set _T,%r28
st %f26,[%r28]; st %f27,[%r28+4]
set _Half,%r27
ld [%r27],%f26; ld [%r27+4],%f27
set _Radix,%r27
ld [%r27],%f24; ld [%r27+4],%f25
fdivd %f26,%f24,%f26
faddd %f30,%f26,%f26
set _X,%r27
st %f26,[%r27]; st %f27,[%r27+4]
fmuld %f24,%f28,%f28
faddd %f30,%f28,%f30
set _Y,%r26
st %f30,[%r26]; st %f31,[%r26+4]
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r26],%f26; ld [%r26+4],%f27
fmuld %f30,%f26,%f26
st %f26,[%r29]; st %f27,[%r29+4]
ld [%r28],%f26; ld [%r28+4],%f27
set _Zero,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fcmped %f26,%f24; nop; fbne L307; nop
faddd %f30,%f28,%f30
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
fcmped %f30,%f24; nop; fbne L307; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Two,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L309; nop
set _Two,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f28
set _X,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f28,%f30,%f30
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L310; nop
set _S,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _StickyBit,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L310; nop
L309:
set _S,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _StickyBit,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L310:
L307:
L305:
L303:
L301:
L299:
L296:
set _StickyBit,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L313; nop
set L315,%r8
call _printf; nop
ba L314; nop
L313:
set L316,%r8
call _printf; nop
L314:
set 3,%r8
set _GMult,%r28
ld [%r28],%r28
cmp %r28,%r0; be L319; nop
set _GDiv,%r28
ld [%r28],%r28
cmp %r28,%r0; be L319; nop
set _GAddSub,%r28
ld [%r28],%r28
cmp %r28,%r0; be L319; nop
set _RMult,%r28
ld [%r28],%r28
cmp %r28,%r0; be L319; nop
set _RDiv,%r28
ld [%r28],%r28
cmp %r28,%r0; be L319; nop
set _RAddSub,%r28
ld [%r28],%r28
cmp %r28,%r0; be L319; nop
set 1,%r29
ba L320; nop
L319:
mov %r0,%r29
L320:
mov %r29,%r9
set L318,%r10
call _TstCond; nop
set 60,%r29
set _Milestone,%r28
st %r29,[%r28]
set L44,%r8
call _printf; nop
set L321,%r8
call _printf; nop
set L322,%r8
set _NoTrials,%r29
ld [%r29],%r9
call _printf; nop
set L323,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
set _Random9,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _Third,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Random1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 1,%r29
set _I,%r28
st %r29,[%r28]
L324:
call _Random; nop
set _X,%r29
st %f0,[%r29]; st %f1,[%r29+4]
call _Random; nop
set _Y,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f26
set _Z9,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fmuld %f28,%f30,%f30
set _Z,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _I,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
L325:
set _I,%r29
ld [%r29],%r29
set _NoTrials,%r28
ld [%r28],%r28
cmp %r29,%r28; bg L327; nop
set _Z9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L324; nop
L327:
set _I,%r29
ld [%r29],%r29
set _NoTrials,%r28
ld [%r28],%r28
cmp %r29,%r28; bne L328; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Half,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _Three,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fdivd %f28,%f26,%f28
faddd %f30,%f28,%f28
set _Random1,%r29
st %f28,[%r29]; st %f29,[%r29+4]
set _U2,%r28
ld [%r28],%f26; ld [%r28+4],%f27
set _U1,%r28
ld [%r28],%f24; ld [%r28+4],%f25
faddd %f26,%f24,%f26
faddd %f26,%f30,%f30
set _Random2,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r29],%f26; ld [%r29+4],%f27
ld [%r28],%f24; ld [%r28+4],%f25
fmuld %f26,%f24,%f22
set _Z,%r29
st %f22,[%r29]; st %f23,[%r29+4]
fmuld %f24,%f26,%f26
set _Y,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fmuld %f28,%f30,%f30
fsubd %f30,%f30,%f30
set _Z9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L328:
set _I,%r29
ld [%r29],%r29
set _NoTrials,%r28
ld [%r28],%r28
cmp %r29,%r28; be L330; nop
set _Z9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L330; nop
set 2,%r8
set L332,%r9
call _BadCond; nop
ba L331; nop
L330:
set L333,%r8
set _NoTrials,%r29
ld [%r29],%r9
call _printf; nop
L331:
set 70,%r29
set _Milestone,%r28
st %r29,[%r28]
set L334,%r8
call _printf; nop
set _Zero,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%fp+-24]; st %f31,[%fp+-24+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
ld [%fp+-24],%f30; ld [%fp+-24+4],%f31
fcmped %f30,%f0; nop; fbne L337; nop
set _Zero,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
st %f30,[%fp+-32]; st %f31,[%fp+-32+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
ld [%fp+-32],%f30; ld [%fp+-32+4],%f31
fcmped %f30,%f0; nop; fbne L337; nop
set _One,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%fp+-40]; st %f31,[%fp+-40+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
ld [%fp+-40],%f30; ld [%fp+-40+4],%f31
fcmped %f30,%f0; nop; fbne L337; nop
set 1,%r29
ba L338; nop
L337:
mov %r0,%r29
L338:
mov %r0,%r8
mov %r29,%r9
set L336,%r10
call _TstCond; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _MaxSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _J,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _U2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _OneUlp,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 1,%r8
call _SqXMinX; nop
set _BInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _OneUlp,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 1,%r8
call _SqXMinX; nop
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
fmuld %f30,%f30,%f30
set _OneUlp,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 1,%r8
call _SqXMinX; nop
set _J,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L339; nop
call _Pause; nop
L339:
set L341,%r8
set _NoTrials,%r29
ld [%r29],%r9
call _printf; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _J,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Two,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L342; nop
L344:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Radix,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f28,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L345:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _NoTrials,%r29
ld [%r29],%r29
st %r29,[%sp+64]; ld [%sp+64],%f28; fitod %f28,%f28
fcmped %f30,%f28; nop; fbul L344; nop
L342:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _OneUlp,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 1,%r29
set _I,%r28
st %r29,[%r28]
ba L348; nop
L347:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set 2,%r8
call _SqXMinX; nop
set _J,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L350; nop
ba L349; nop
L350:
set _I,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
L348:
set _I,%r29
ld [%r29],%r29
set _NoTrials,%r28
ld [%r28],%r28
cmp %r29,%r28; ble L347; nop
L349:
set L352,%r8
call _printf; nop
set -1,%r29
set _I,%r28
st %r29,[%r28]
set _BMinusU2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f28
faddd %f30,%f28,%f30
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _NotMonot,%r29
st %r0,[%r29]
set _Monot,%r29
st %r0,[%r29]
ba L354; nop
L353:
set _I,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
st %f0,[%r29]; st %f1,[%r29+4]
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
set _Q,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
st %f0,[%r29]; st %f1,[%r29+4]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Q,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L358; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f28,%f30; nop; fbule L356; nop
L358:
set 1,%r29
set _NotMonot,%r28
st %r29,[%r28]
ba L357; nop
L356:
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Half,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
st %f0,[%r29]; st %f1,[%r29+4]
set _I,%r29
ld [%r29],%r29
cmp %r29,%r0; bg L361; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Q,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f28,%f28,%f28
fcmped %f30,%f28; nop; fbne L359; nop
L361:
set 1,%r29
set _Monot,%r28
st %r29,[%r28]
ba L360; nop
L359:
set _I,%r29
ld [%r29],%r29
cmp %r29,%r0; ble L362; nop
set _I,%r29
ld [%r29],%r29
cmp %r29,1; ble L364; nop
set 1,%r29
set _Monot,%r28
st %r29,[%r28]
ba L363; nop
L364:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _BInvrse,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f26
set _X,%r29
st %f26,[%r29]; st %f27,[%r29+4]
faddd %f30,%f28,%f30
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L363; nop
L362:
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f26
set _X,%r29
st %f26,[%r29]; st %f27,[%r29+4]
faddd %f30,%f28,%f30
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L363:
L360:
L357:
L354:
set _NotMonot,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L366; nop
set _Monot,%r29
ld [%r29],%r29
cmp %r29,%r0; be L353; nop
L366:
set _Monot,%r29
ld [%r29],%r29
cmp %r29,%r0; be L367; nop
set L369,%r8
call _printf; nop
ba L368; nop
L367:
set 2,%r8
set L157,%r9
call _BadCond; nop
set L370,%r8
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L368:
set 80,%r29
set _Milestone,%r28
st %r29,[%r28]
set _MinSqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Half,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _MaxSqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fsubd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fsubd %f0,%f30,%f28
set _U2,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fdivd %f28,%f26,%f28
set _Y,%r29
st %f28,[%r29]; st %f29,[%r29+4]
set _Y,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f28,%f30,%f30
set _Eight,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f26,%f28,%f28
faddd %f30,%f28,%f30
set _SqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L371; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L371:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _Eight,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fdivd %f28,%f26,%f28
faddd %f30,%f28,%f30
set _SqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L373; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L373:
set _F9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
set _U2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fsubd %f0,%f30,%f28
set _One,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f26,%f30,%f30
fsubd %f28,%f30,%f30
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Eight,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fdivd %f28,%f26,%f28
faddd %f30,%f28,%f30
set _SqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L375; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L375:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _Eight,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fdivd %f28,%f26,%f28
faddd %f30,%f28,%f30
set _SqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L377; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L377:
set _U2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _OneUlp,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 1,%r29
set _Indx,%r28
st %r29,[%r28]
L379:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f28
faddd %f28,%f30,%f30
set _F9,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
set _Y,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
set _One,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fsubd %f26,%f28,%f28
set _X,%r28
ld [%r28],%f26; ld [%r28+4],%f27
faddd %f28,%f26,%f28
fsubd %f30,%f28,%f30
set _OneUlp,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _U1,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fsubd %f30,%f26,%f30
set _F9,%r28
ld [%r28],%f24; ld [%r28+4],%f25
faddd %f30,%f24,%f30
set _Half,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fmuld %f30,%f24,%f30
fmuld %f30,%f26,%f30
fmuld %f30,%f26,%f30
fdivd %f30,%f28,%f30
set _Z,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f24,%f30
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
set _SqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L383; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L383:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Half,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _SqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L385; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L385:
set _Indx,%r29
ld [%r29],%r29
cmp %r29,1; be L389; nop
cmp %r29,3; bne L387; nop
L389:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _Sign; nop
st %f0,[%fp+-48]; st %f1,[%fp+-48+4]
set _OneUlp,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
set _Eight,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _Nine,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f28,%f0,%f28
fdivd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _OneUlp,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%fp+-48],%f28; ld [%fp+-48+4],%f29
fmuld %f30,%f28,%f30
fmuld %f30,%f0,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ba L388; nop
L387:
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _OneUlp,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L388:
L380:
set _Indx,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set _Indx,%r29
ld [%r29],%r29
cmp %r29,3; ble L379; nop
set 85,%r29
set _Milestone,%r28
st %r29,[%r28]
set _SqRWrng,%r29
st %r0,[%r29]
set _Anomaly,%r29
st %r0,[%r29]
set _RSqrt,%r29
st %r0,[%r29]
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L390; nop
set L392,%r8
call _printf; nop
set _Precision,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%fp+-48]; st %f31,[%fp+-48+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
ld [%fp+-48],%f28; ld [%fp+-48+4],%f29
faddd %f30,%f28,%f30
fsubd %f30,%f0,%f30
st %f30,[%sp+4*2+68]
st %f31,[%sp+4*3+68]
ld [%sp+4*2+68],%o2
ld [%sp+4*3+68],%o3
call _pow; nop
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f0,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _D,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _D,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Radix,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f28
set _X,%r29
st %f28,[%r29]; st %f29,[%r29+4]
set _A1,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%fp+-56]; st %f31,[%fp+-56+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
ld [%fp+-56],%f30; ld [%fp+-56+4],%f31
fcmped %f30,%f0; nop; fbne L395; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%fp+-64]; st %f31,[%fp+-64+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
ld [%fp+-64],%f30; ld [%fp+-64+4],%f31
fcmped %f30,%f0; nop; fbue L393; nop
L395:
set 1,%r29
set _Anomaly,%r28
st %r29,[%r28]
ba L394; nop
L393:
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Z2,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
set _Y2,%r29
st %f28,[%r29]; st %f29,[%r29+4]
set _Radix,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f28,%f30,%f30
set _Z1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Four,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _D,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _FourD,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L396:
set _Y2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L399; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Q,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L401:
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Q,%r29
ld [%r29],%f28; ld [%r29+4],%f29
st %f28,[%fp+-72]; st %f29,[%fp+-72+4]
set _Y1,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fdivd %f28,%f26,%f26
fsubd %f30,%f26,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _Y1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fmuld %f0,%f30,%f30
ld [%fp+-72],%f28; ld [%fp+-72+4],%f29
faddd %f28,%f30,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _X1,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _Y1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Q,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _X1,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%r29]; st %f31,[%r29+4]
L402:
set _X1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L401; nop
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L404; nop
set _Y2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z2,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L404:
L399:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Two,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Eight,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _Y2,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
set _FourD,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L406; nop
set _Y2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _FourD,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L406:
L397:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _D,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L396; nop
set _FourD,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f28
set _X8,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
set _Z,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fmuld %f26,%f26,%f26
faddd %f28,%f26,%f26
fdivd %f26,%f30,%f30
set _Q,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Eight,%r27
ld [%r27],%f30; ld [%r27+4],%f31
fdivd %f28,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%fp+-72]; st %f31,[%fp+-72+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
ld [%fp+-72],%f30; ld [%fp+-72+4],%f31
fcmped %f30,%f0; nop; fbue L408; nop
set 1,%r29
set _Anomaly,%r28
st %r29,[%r28]
ba L409; nop
L408:
set _Break,%r29
st %r0,[%r29]
L410:
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%fp+-80]; st %f31,[%fp+-80+4]
set _Radix,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f28
st %f28,[%sp+4*0+68]
st %f29,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _Radix,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fmuld %f0,%f30,%f30
ld [%fp+-80],%f28; ld [%fp+-80+4],%f29
fsubd %f28,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L413; nop
set 1,%r29
set _Break,%r28
st %r29,[%r28]
ba L414; nop
L413:
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L414:
L411:
set _Break,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L415; nop
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L410; nop
L415:
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L416; nop
set _Break,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L416; nop
set 1,%r29
set _Anomaly,%r28
st %r29,[%r28]
ba L417; nop
L416:
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _RadixD2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L418; nop
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Radix,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L418:
L420:
call _NewD; nop
L421:
set _U2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _D,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _F9,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L420; nop
set _D,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Radix,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f28
fsubd %f28,%f30,%f28
set _W,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f26,%f30,%f30
fcmped %f28,%f30; nop; fbue L423; nop
set 1,%r29
set _Anomaly,%r28
st %r29,[%r28]
ba L424; nop
L423:
set _D,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z2,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _I,%r29
st %r0,[%r29]
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _Z,%r29
ld [%r29],%f26; ld [%r29+4],%f27
faddd %f28,%f26,%f28
set _Half,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fmuld %f28,%f24,%f28
faddd %f30,%f28,%f28
set _Y,%r29
st %f28,[%r29]; st %f29,[%r29+4]
faddd %f30,%f26,%f30
set _Q,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
call _SR3750; nop
set _D,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _Z,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f28,%f26,%f28
set _Half,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fmuld %f28,%f24,%f28
faddd %f30,%f28,%f28
faddd %f28,%f30,%f28
set _Y,%r29
st %f28,[%r29]; st %f29,[%r29+4]
fsubd %f30,%f26,%f28
faddd %f28,%f30,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Q,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f28
faddd %f28,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
call _SR3750; nop
call _NewD; nop
set _D,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _W,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f26,%f28,%f28
fcmped %f30,%f28; nop; fbue L425; nop
set 1,%r29
set _Anomaly,%r28
st %r29,[%r28]
ba L426; nop
L425:
set _D,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _One,%r29
ld [%r29],%f26; ld [%r29+4],%f27
set _Z,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fsubd %f26,%f24,%f26
set _Half,%r29
ld [%r29],%f22; ld [%r29+4],%f23
fmuld %f26,%f22,%f26
faddd %f28,%f26,%f26
faddd %f30,%f26,%f26
set _Y,%r29
st %f26,[%r29]; st %f27,[%r29+4]
fsubd %f28,%f24,%f28
set _Q,%r29
ld [%r29],%f26; ld [%r29+4],%f27
faddd %f28,%f26,%f28
faddd %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
call _SR3750; nop
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _Half,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
call _SR3750; nop
set _I,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L427; nop
set 1,%r29
set _Anomaly,%r28
st %r29,[%r28]
L427:
L426:
L424:
L417:
L409:
L394:
set _I,%r29
ld [%r29],%r29
cmp %r29,%r0; be L431; nop
set _Anomaly,%r29
ld [%r29],%r29
cmp %r29,%r0; be L429; nop
L431:
mov %r0,%r8
set L432,%r9
call _BadCond; nop
set L433,%r8
set _W,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L434,%r8
call _printf; nop
set 1,%r29
set _SqRWrng,%r28
st %r29,[%r28]
L429:
L390:
set _Anomaly,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L435; nop
set _MinSqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L437; nop
set _MaxSqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbug L437; nop
set 1,%r29
set _RSqrt,%r28
st %r29,[%r28]
set L439,%r8
call _printf; nop
ba L438; nop
L437:
set _MaxSqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _Half,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f28,%f26,%f28
fcmped %f30,%f28; nop; fbug L443; nop
set _MinSqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f26; nop; fbug L443; nop
set _Radix,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
fcmped %f30,%f26; nop; fbuge L440; nop
L443:
set 1,%r29
set _SqRWrng,%r28
st %r29,[%r28]
ba L441; nop
L440:
set 2,%r29
set _RSqrt,%r28
st %r29,[%r28]
set L444,%r8
call _printf; nop
L441:
L438:
L435:
set _SqRWrng,%r29
ld [%r29],%r29
cmp %r29,%r0; be L445; nop
set L447,%r8
call _printf; nop
set L448,%r8
set _MinSqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Half,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L449,%r8
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set 1,%r8
set _MaxSqEr,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _MinSqEr,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
set _Radix,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f28,%f28,%f28
fcmped %f30,%f28; nop; fbuge L452; nop
set 1,%r29
ba L453; nop
L452:
mov %r0,%r29
L453:
mov %r29,%r9
set L451,%r10
call _TstCond; nop
L445:
set 90,%r29
set _Milestone,%r28
st %r29,[%r28]
call _Pause; nop
set L454,%r8
call _printf; nop
set _N,%r29
st %r0,[%r29]
set _I,%r29
st %r0,[%r29]
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 3,%r29
set _M,%r28
st %r29,[%r28]
set _Break,%r29
st %r0,[%r29]
L455:
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
call _SR3980; nop
set _I,%r29
ld [%r29],%r29
cmp %r29,10; bg L458; nop
set 1023,%r29
set _I,%r28
st %r29,[%r28]
call _SR3980; nop
L458:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MinusOne,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L460; nop
set 1,%r29
set _Break,%r28
st %r29,[%r28]
ba L461; nop
L460:
set _MinusOne,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
call _PrintIfNPositive; nop
set _N,%r29
st %r0,[%r29]
set -4,%r29
set _I,%r28
st %r29,[%r28]
L461:
L456:
set _Break,%r29
ld [%r29],%r29
cmp %r29,%r0; be L455; nop
call _PrintIfNPositive; nop
set _N,%r29
ld [%r29],%r28
set _N1,%r27
st %r28,[%r27]
st %r0,[%r29]
set _A1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _W,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
st %f0,[%fp+-48]; st %f1,[%fp+-48+4]
set _A1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
set _Two,%r29
ld [%r29],%f30; ld [%r29+4],%f31
ld [%fp+-48],%f28; ld [%fp+-48+4],%f29
fmuld %f30,%f28,%f30
fdivd %f30,%f0,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
fdtoi %f0,%f0; st %f0,[%sp+64]; ld [%sp+64],%r29
set _M,%r28
st %r29,[%r28]
set _Break,%r29
st %r0,[%r29]
L462:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 1,%r29
set _I,%r28
st %r29,[%r28]
call _SR3980; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _AInvrse,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L465; nop
set 1,%r29
set _Break,%r28
st %r29,[%r28]
ba L466; nop
L465:
set _AInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L466:
L463:
set _Break,%r29
ld [%r29],%r29
cmp %r29,%r0; be L462; nop
set 100,%r29
set _Milestone,%r28
st %r29,[%r28]
set _NoTrials,%r29
ld [%r29],%r29
set _M,%r28
st %r29,[%r28]
set _Three,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L467:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 1,%r29
set _I,%r28
st %r29,[%r28]
call _SR3980; nop
L470:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Two,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L471:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Three,%r29
ld [%r29],%f28; ld [%r29+4],%f29
st %f28,[%fp+-56]; st %f29,[%fp+-56+4]
fdivd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
ld [%fp+-56],%f30; ld [%fp+-56+4],%f31
fmuld %f30,%f0,%f30
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L470; nop
L468:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Eight,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _Three,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f28,%f26,%f28
fcmped %f30,%f28; nop; fbul L467; nop
set _N,%r29
ld [%r29],%r29
cmp %r29,%r0; ble L473; nop
set L475,%r8
call _printf; nop
set L476,%r8
call _printf; nop
L473:
call _PrintIfNPositive; nop
set _N,%r29
ld [%r29],%r28
set _N1,%r27
ld [%r27],%r27
add %r28,%r27,%r28
st %r28,[%r29]
ld [%r29],%r29
cmp %r29,%r0; bne L477; nop
set L479,%r8
call _printf; nop
L477:
set _N,%r29
ld [%r29],%r29
cmp %r29,%r0; ble L480; nop
call _Pause; nop
ba L481; nop
L480:
set L44,%r8
call _printf; nop
L481:
set 110,%r29
set _Milestone,%r28
st %r29,[%r28]
set L482,%r8
call _printf; nop
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _D,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Precision,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%fp+-56]; st %f31,[%fp+-56+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
ld [%fp+-56],%f30; ld [%fp+-56+4],%f31
fcmped %f30,%f0; nop; fbue L483; nop
set _BInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _D,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Precision,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L485:
set _D,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _BInvrse,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L486:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L485; nop
L483:
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _D,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L488:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _C,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Z,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
fmuld %f30,%f30,%f30
st %f30,[%r28]; st %f31,[%r28+4]
L489:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L491; nop
faddd %f28,%f28,%f30
fcmped %f30,%f28; nop; fbug L488; nop
L491:
set _C,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _D,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L492:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _C,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Z,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _D,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%r28]; st %f31,[%r28+4]
L493:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L495; nop
faddd %f28,%f28,%f30
fcmped %f30,%f28; nop; fbug L492; nop
L495:
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Two,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L496; nop
set _Two,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _HInvrse,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L497; nop
L496:
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _HInvrse,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L497:
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _HInvrse,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f28
set _H,%r29
st %f28,[%r29]; st %f29,[%r29+4]
set _C,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fdivd %f30,%f28,%f30
set _CInvrse,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _E0,%r28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L498:
set _E0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Z,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _H,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%r28]; st %f31,[%r28+4]
L499:
set _E0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L501; nop
faddd %f28,%f28,%f30
fcmped %f30,%f28; nop; fbug L498; nop
L501:
set _E0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Q,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _U2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _One,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _S,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _C,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f28
set _D,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f28,%f30; nop; fbug L502; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _E9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _One,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _S,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _C,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f28
set _D,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f28,%f30; nop; fbug L503; nop
mov %r0,%r8
set L506,%r9
call _BadCond; nop
set _E0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Underflow,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _PseudoZero,%r29
st %f30,[%r29]; st %f31,[%r29+4]
call _Pause; nop
ba L503; nop
L502:
set _D,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Underflow,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _H,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _PseudoZero,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L507:
set _Underflow,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y1,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _PseudoZero,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%r29]; st %f31,[%r29+4]
set _E1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f30,%f28
fcmped %f28,%f30; nop; fbug L510; nop
set _Underflow,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _HInvrse,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _Y2,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Y1,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _E1,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _Y1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Q,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _UfThold,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _Zero,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fcmped %f28,%f26; nop; fbne L512; nop
set _Y2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L512; nop
set _Y1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L512:
L510:
set _PseudoZero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _H,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L508:
set _Underflow,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _PseudoZero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L514; nop
faddd %f28,%f28,%f30
fcmped %f30,%f28; nop; fbug L507; nop
L514:
L503:
set _PseudoZero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L515; nop
set L44,%r8
call _printf; nop
set _PseudoZero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L517; nop
mov %r0,%r8
set L519,%r9
call _BadCond; nop
set L520,%r8
call _printf; nop
set L521,%r8
set _PseudoZero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set _PseudoZero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L518; nop
set L524,%r8
call _printf; nop
set L525,%r8
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
ba L518; nop
L517:
set 3,%r8
set L526,%r9
call _BadCond; nop
set L527,%r8
set _PseudoZero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L518:
call _TstPtUf; nop
L515:
set 120,%r29
set _Milestone,%r28
st %r29,[%r28]
set _CInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f28
set _Y1,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f30,%f26,%f30
fcmped %f28,%f30; nop; fbule L528; nop
set _H,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _S,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _Underflow,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E0,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L528:
set _E1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L530; nop
set _E0,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L530; nop
set 2,%r8
set L157,%r9
call _BadCond; nop
set _E1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E0,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L532; nop
set L534,%r8
call _printf; nop
set L535,%r8
call _printf; nop
set _PseudoZero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L533; nop
set _E1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E0,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L533; nop
L532:
set L538,%r8
call _printf; nop
set L539,%r8
call _printf; nop
L533:
L530:
set L540,%r8
set _E0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set _E0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
call _TstPtUf; nop
set _E0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Underflow,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _N,%r29
ld [%r29],%r29
cmp %r29,1; bne L541; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Underflow,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L541:
set 4,%r29
set _I,%r28
st %r29,[%r28]
set _E1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L543; nop
set 3,%r29
set _I,%r28
st %r29,[%r28]
L543:
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L545; nop
set _I,%r29
ld [%r29],%r28
sub %r28,2,%r28
st %r28,[%r29]
L545:
set 1,%r29
set _UfNGrad,%r28
st %r29,[%r28]
set _I,%r29
ld [%r29],%r29
cmp %r29,1; bl L547; nop
cmp %r29,4; bg L547; nop
sll %r29,2,%r29
set L571-4,%r28
ld [%r29+%r28],%r29
jmp %r29; nop
L571:
.align 4; .word L549
.align 4; .word L556
.align 4; .word L561
.align 4; .word L562
L549:
set _Underflow,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _CInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Q,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f28
set _Y,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f30,%f26,%f30
set _S,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f30,%f26,%f30
fcmped %f28,%f30; nop; fbue L550; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
st %f30,[%r29]; st %f31,[%r29+4]
mov %r0,%r8
set L552,%r9
call _BadCond; nop
set L553,%r8
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L554,%r8
set _C,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L555,%r8
call _printf; nop
L550:
call _Pause; nop
ba L548; nop
L556:
mov %r0,%r8
set L557,%r9
call _BadCond; nop
set L558,%r8
call _printf; nop
set L559,%r8
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Y2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
call _printf; nop
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set L560,%r8
st %f0,[%sp+4*1+68]
st %f1,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L548; nop
L561:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%r29]; st %f31,[%r29+4]
ba L548; nop
L562:
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L563; nop
set _E1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E0,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fcmped %f30,%f26; nop; fbne L563; nop
set _E9,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fdivd %f30,%f26,%f30
fsubd %f28,%f30,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _E1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f0,%f30; nop; fbug L563; nop
set _UfNGrad,%r29
st %r0,[%r29]
set L565,%r8
call _printf; nop
set L566,%r8
call _printf; nop
set _E0,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _CInvrse,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
set _OneAndHalf,%r27
ld [%r27],%f26; ld [%r27+4],%f27
set _U2,%r27
ld [%r27],%f24; ld [%r27+4],%f25
faddd %f26,%f24,%f26
fmuld %f30,%f26,%f30
st %f30,[%r28]; st %f31,[%r28+4]
set _One,%r27
ld [%r27],%f30; ld [%r27+4],%f31
faddd %f30,%f24,%f30
fmuld %f28,%f30,%f30
set _X,%r27
st %f30,[%r27]; st %f31,[%r27+4]
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r27],%f28; ld [%r27+4],%f29
fdivd %f30,%f28,%f30
st %f30,[%r28]; st %f31,[%r28+4]
set _Y,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _E0,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L568; nop
set 1,%r29
ba L569; nop
L568:
mov %r0,%r29
L569:
set _IEEE,%r28
st %r29,[%r28]
L563:
L547:
L548:
set _UfNGrad,%r29
ld [%r29],%r29
cmp %r29,%r0; be L573; nop
set L44,%r8
call _printf; nop
set _sigfpe,%r29
set _sigsave,%r28
st %r29,[%r28]
set _ovfl_buf,%r8
call _setjmp; nop
cmp %r8,%r0; be L575; nop
set L577,%r8
call _printf; nop
set _H,%r29
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f30,%f30
set _R,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L576; nop
L575:
set _Underflow,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
set _R,%r29
st %f0,[%r29]; st %f1,[%r29+4]
L576:
set _sigsave,%r29
st %r0,[%r29]
set _R,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _H,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L578; nop
set _R,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f28
set _Z,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
set _One,%r29
ld [%r29],%f26; ld [%r29+4],%f27
set _H,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fmuld %f30,%f24,%f30
faddd %f26,%f24,%f24
fmuld %f30,%f24,%f30
faddd %f26,%f30,%f30
fmuld %f28,%f30,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L579; nop
L578:
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _H,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f26,%f26,%f24
faddd %f28,%f26,%f26
fmuld %f24,%f26,%f26
faddd %f28,%f26,%f28
fmuld %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L579:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L580; nop
fsubd %f30,%f28,%f30
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L580; nop
set 3,%r8
set L157,%r9
call _BadCond; nop
set L582,%r8
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
call _printf; nop
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _Z9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L583,%r8
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L584,%r8
call _printf; nop
set L585,%r8
call _printf; nop
set L586,%r8
call _printf; nop
set L587,%r8
call _printf; nop
set L588,%r8
call _printf; nop
set L589,%r8
call _printf; nop
set _sigfpe,%r29
set _sigsave,%r28
st %r29,[%r28]
set _ovfl_buf,%r8
call _setjmp; nop
cmp %r8,%r0; be L590; nop
set L592,%r8
call _printf; nop
ba L591; nop
L590:
set L593,%r8
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _Half,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
fsubd %f30,%f28,%f30
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L591:
set _sigsave,%r29
st %r0,[%r29]
L580:
L573:
set L594,%r8
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set L595,%r11
call _printf; nop
set L596,%r8
call _printf; nop
set L597,%r8
call _printf; nop
set _U1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fmuld %f30,%f30,%f28
set _Y2,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f28,%f28,%f28
set _Y,%r28
st %f28,[%r28]; st %f29,[%r28+4]
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f28,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L598; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _E0,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L600; nop
set 2,%r8
set L157,%r9
call _BadCond; nop
set 5,%r29
set _I,%r28
st %r29,[%r28]
ba L601; nop
L600:
set 1,%r8
set L157,%r9
call _BadCond; nop
set 4,%r29
set _I,%r28
st %r29,[%r28]
L601:
set L602,%r8
set _I,%r29
ld [%r29],%r9
call _printf; nop
L598:
set 130,%r29
set _Milestone,%r28
st %r29,[%r28]
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
st %f0,[%fp+-64]; st %f1,[%fp+-64+4]
set _HInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _TwoForty,%r29
ld [%r29],%f28; ld [%r29+4],%f29
ld [%fp+-64],%f26; ld [%fp+-64+4],%f27
fmuld %f28,%f26,%f28
fdivd %f28,%f0,%f28
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
fnegs %f0,%f30; fmovs %f1,%f31
set _TwoForty,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f30,%f30
set _Y2,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L603,%r8
call _printf; nop
set L604,%r8
set _HInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
call _printf; nop
set L605,%r8
set _HInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
call _printf; nop
set _HInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
set _Y2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*2+68]
st %f31,[%sp+4*3+68]
ld [%sp+4*2+68],%o2
ld [%sp+4*3+68],%o3
call _pow; nop
set _V9,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set L606,%r8
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L609; nop
set _Radix,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f28,%f28,%f28
set _E9,%r29
ld [%r29],%f26; ld [%r29+4],%f27
faddd %f28,%f26,%f28
set _UfThold,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f28,%f26,%f28
fcmped %f30,%f28; nop; fbule L607; nop
L609:
set 1,%r8
set L610,%r9
call _BadCond; nop
set L611,%r8
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
ba L608; nop
L607:
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _UfThold,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _One,%r29
ld [%r29],%f26; ld [%r29+4],%f27
set _E9,%r29
ld [%r29],%f24; ld [%r29+4],%f25
faddd %f26,%f24,%f26
fmuld %f28,%f26,%f28
fcmped %f30,%f28; nop; fbug L612; nop
set L614,%r8
call _printf; nop
ba L613; nop
L612:
set 2,%r8
set L610,%r9
call _BadCond; nop
set L611,%r8
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L613:
L608:
set 140,%r29
set _Milestone,%r28
st %r29,[%r28]
set L44,%r8
call _printf; nop
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 2,%r29
set _I,%r28
st %r29,[%r28]
set _Two,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _Three,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f28,%f26,%f28
set _Y,%r29
st %f28,[%r29]; st %f29,[%r29+4]
set _Q,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _N,%r29
st %r0,[%r29]
L615:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _I,%r27
ld [%r27],%r26
add %r26,1,%r26
st %r26,[%r27]
set _Y,%r26
ld [%r26],%f30; ld [%r26+4],%f31
ld [%r27],%r27
add %r27,%r27,%r27
st %r27,[%sp+64]; ld [%sp+64],%f28; fitod %f28,%f28
fdivd %f30,%f28,%f30
st %f30,[%r26]; st %f31,[%r26+4]
ld [%r26],%f30; ld [%r26+4],%f31
set _Q,%r27
ld [%r27],%f28; ld [%r27+4],%f29
faddd %f30,%f28,%f30
set _R,%r26
st %f30,[%r26]; st %f31,[%r26+4]
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r26],%f28; ld [%r26+4],%f29
faddd %f30,%f28,%f26
st %f26,[%r29]; st %f27,[%r29+4]
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f30,%f26,%f30
faddd %f30,%f28,%f30
st %f30,[%r27]; st %f31,[%r27+4]
L616:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L615; nop
set _OneAndHalf,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _Eight,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fdivd %f28,%f26,%f28
faddd %f30,%f28,%f28
set _X,%r29
ld [%r29],%f26; ld [%r29+4],%f27
set _ThirtyTwo,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fmuld %f30,%f24,%f30
fdivd %f26,%f30,%f30
faddd %f28,%f30,%f30
set _Z,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
fmuld %f30,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
fmuld %f30,%f30,%f30
set _Exp2,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _F9,%r27
ld [%r27],%f30; ld [%r27+4],%f31
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L618,%r8
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set 1,%r29
set _I,%r28
st %r29,[%r28]
L619:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _BInvrse,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f26
set _Z,%r29
st %f26,[%r29]; st %f27,[%r29+4]
set _One,%r28
ld [%r28],%f26; ld [%r28+4],%f27
faddd %f30,%f26,%f24
ld [%r29],%f22; ld [%r29+4],%f23
fsubd %f26,%f28,%f28
fsubd %f22,%f28,%f28
fdivd %f24,%f28,%f28
st %f28,[%r29]; st %f29,[%r29+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*2+68]
st %f31,[%sp+4*3+68]
ld [%sp+4*2+68],%o2
ld [%sp+4*3+68],%o3
call _pow; nop
set _Exp2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fsubd %f0,%f30,%f30
set _Q,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _TwoForty,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
fcmped %f0,%f30; nop; fbule L623; nop
set 1,%r29
set _N,%r28
st %r29,[%r28]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _BInvrse,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _One,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f26,%f28,%f28
fsubd %f30,%f28,%f30
set _V9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set 2,%r8
set L625,%r9
call _BadCond; nop
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*2+68]
st %f31,[%sp+4*3+68]
ld [%sp+4*2+68],%o2
ld [%sp+4*3+68],%o3
call _pow; nop
set L626,%r8
st %f0,[%sp+4*1+68]
st %f1,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L627,%r8
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
call _printf; nop
set L628,%r8
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L629,%r8
call _printf; nop
set L630,%r8
call _printf; nop
ba L621; nop
L623:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f28
set _Two,%r27
ld [%r27],%f26; ld [%r27+4],%f27
fmuld %f28,%f26,%f28
faddd %f28,%f30,%f28
set _Z,%r27
st %f28,[%r27]; st %f29,[%r27+4]
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r27],%f30; ld [%r27+4],%f31
st %f30,[%r29]; st %f31,[%r29+4]
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
set _F9,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f28,%f26,%f28
fmuld %f28,%f28,%f28
faddd %f30,%f28,%f28
st %f28,[%r27]; st %f29,[%r27+4]
ld [%r27],%f28; ld [%r27+4],%f29
fcmped %f28,%f30; nop; fbule L631; nop
set _I,%r29
ld [%r29],%r29
set _NoTrials,%r28
ld [%r28],%r28
cmp %r29,%r28; bge L631; nop
set _I,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
ba L619; nop
L631:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L633; nop
set _N,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L621; nop
set L637,%r8
call _printf; nop
ba L621; nop
L633:
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
faddd %f28,%f28,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r28]; st %f31,[%r28+4]
set 1,%r29
set _I,%r28
st %r29,[%r28]
ba L619; nop
L621:
set 150,%r29
set _Milestone,%r28
st %r29,[%r28]
set L638,%r8
call _printf; nop
set _N,%r29
st %r0,[%r29]
set _A1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _C,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
st %f0,[%fp+-72]; st %f1,[%fp+-72+4]
set _A1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
set _Half,%r29
ld [%r29],%f30; ld [%r29+4],%f31
ld [%fp+-72],%f28; ld [%fp+-72+4],%f29
fdivd %f28,%f0,%f28
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _Q,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _Break,%r29
st %r0,[%r29]
L639:
set _CInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*2+68]
st %f31,[%sp+4*3+68]
ld [%sp+4*2+68],%o2
ld [%sp+4*3+68],%o3
call _pow; nop
set _Y,%r29
st %f0,[%r29]; st %f1,[%r29+4]
call _IsYeqX; nop
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
st %f30,[%r29]; st %f31,[%r29+4]
set _C,%r28
ld [%r28],%f30; ld [%r28+4],%f31
set _X,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _Z,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*2+68]
st %f31,[%sp+4*3+68]
ld [%sp+4*2+68],%o2
ld [%sp+4*3+68],%o3
call _pow; nop
set _Y,%r29
st %f0,[%r29]; st %f1,[%r29+4]
call _IsYeqX; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L642; nop
set 1,%r29
set _Break,%r28
st %r29,[%r28]
ba L643; nop
L642:
set _AInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L643:
L640:
set _Break,%r29
ld [%r29],%r29
cmp %r29,%r0; be L639; nop
call _PrintIfNPositive; nop
set _N,%r29
ld [%r29],%r29
cmp %r29,%r0; bne L644; nop
set L646,%r8
call _printf; nop
L644:
set L44,%r8
call _printf; nop
set 160,%r29
set _Milestone,%r28
st %r29,[%r28]
call _Pause; nop
set L647,%r8
call _printf; nop
set L648,%r8
call _printf; nop
set _CInvrse,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _HInvrse,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _V9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _sigfpe,%r29
set _sigsave,%r28
st %r29,[%r28]
set _ovfl_buf,%r8
call _setjmp; nop
cmp %r8,%r0; be L649; nop
set _I,%r29
st %r0,[%r29]
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _V9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L651; nop
L649:
L652:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _V,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _V9,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%r29]; st %f31,[%r29+4]
set _HInvrse,%r27
ld [%r27],%f30; ld [%r27+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%r28]; st %f31,[%r28+4]
L653:
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L652; nop
set 1,%r29
set _I,%r28
st %r29,[%r28]
L651:
set _sigsave,%r29
st %r0,[%r29]
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L655,%r8
call _printf; nop
set L656,%r8
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f28; fmovs %f31,%f29
set _V9,%r29
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r29],%f28; ld [%r29+4],%f29
set _V0,%r29
st %f28,[%r29]; st %f29,[%r29+4]
set _V,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f28,%f30,%f30
ld [%r29],%f26; ld [%r29+4],%f27
faddd %f28,%f26,%f28
fcmped %f30,%f28; nop; fbne L657; nop
set L659,%r8
call _printf; nop
ba L658; nop
L657:
set L660,%r8
call _printf; nop
set 3,%r8
set L661,%r9
call _BadCond; nop
L658:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L662; nop
set 1,%r8
set L157,%r9
call _BadCond; nop
set L664,%r8
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
call _printf; nop
L662:
set _I,%r29
ld [%r29],%r29
cmp %r29,%r0; be L665; nop
set _V,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _HInvrse,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _U2,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f28,%f26,%f24
fsubd %f24,%f28,%f24
fmuld %f30,%f24,%f24
set _Y,%r29
st %f24,[%r29]; st %f25,[%r29+4]
ld [%r29],%f24; ld [%r29+4],%f25
set _One,%r29
ld [%r29],%f22; ld [%r29+4],%f23
fsubd %f22,%f28,%f28
fmuld %f28,%f26,%f28
fmuld %f28,%f30,%f30
faddd %f24,%f30,%f30
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _V0,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L667; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L667:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _V0,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L669; nop
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _V,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L669:
set _V0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _V,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f28
fcmped %f28,%f30; nop; fbuge L666; nop
set _V0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _V,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L666; nop
L665:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _HInvrse,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _U2,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f28,%f26,%f24
fsubd %f24,%f28,%f24
fmuld %f30,%f24,%f24
set _V,%r29
st %f24,[%r29]; st %f25,[%r29+4]
ld [%r29],%f24; ld [%r29+4],%f25
set _One,%r28
ld [%r28],%f22; ld [%r28+4],%f23
fsubd %f22,%f28,%f28
fmuld %f28,%f26,%f28
fmuld %f28,%f30,%f30
faddd %f24,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L666:
set L673,%r8
set _V,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set _I,%r29
ld [%r29],%r29
cmp %r29,%r0; be L674; nop
set L676,%r8
set _V0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
ba L675; nop
L674:
set L677,%r8
call _printf; nop
L675:
set _V,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _V9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L678,%r8
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set _V,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _V9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L679,%r8
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L680,%r8
call _printf; nop
set L681,%r8
call _printf; nop
set 170,%r29
set _Milestone,%r28
st %r29,[%r28]
set _V,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f28; fmovs %f31,%f29
fcmped %f28,%f30; nop; fbuge L686; nop
set _V0,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fnegs %f28,%f26; fmovs %f29,%f27
fcmped %f26,%f28; nop; fbuge L686; nop
set _UfThold,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fnegs %f28,%f26; fmovs %f29,%f27
fcmped %f26,%f30; nop; fbuge L686; nop
fcmped %f28,%f30; nop; fbul L682; nop
L686:
mov %r0,%r8
set L687,%r9
call _BadCond; nop
set L688,%r8
set _V,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _V0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*5+68]
st %f31,[%sp+4*6+68]
ld [%sp+4*5+68],%o5
call _printf; nop
L682:
set 175,%r29
set _Milestone,%r28
st %r29,[%r28]
set L44,%r8
call _printf; nop
set 1,%r29
set _Indx,%r28
st %r29,[%r28]
L689:
set _Indx,%r29
ld [%r29],%r29
cmp %r29,1; be L695; nop
cmp %r29,2; be L696; nop
cmp %r29,3; be L697; nop
ba L693; nop
L695:
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L694; nop
L696:
set _E0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L694; nop
L697:
set _PseudoZero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L693:
L694:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L698; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
set _V9,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fmuld %f30,%f30,%f30
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _Radix,%r29
ld [%r29],%f26; ld [%r29+4],%f27
set _E9,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fmuld %f26,%f24,%f26
fsubd %f28,%f26,%f24
fdivd %f30,%f24,%f24
set _Z,%r29
ld [%r29],%f22; ld [%r29+4],%f23
fcmped %f24,%f22; nop; fbul L702; nop
faddd %f28,%f26,%f28
fmuld %f28,%f22,%f28
fcmped %f30,%f28; nop; fbule L700; nop
L702:
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L703; nop
set 1,%r8
set L157,%r9
call _BadCond; nop
ba L704; nop
L703:
set 2,%r8
set L157,%r9
call _BadCond; nop
L704:
set L705,%r8
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L706,%r8
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L700:
L698:
L690:
set _Indx,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set _Indx,%r29
ld [%r29],%r29
cmp %r29,3; ble L689; nop
set 180,%r29
set _Milestone,%r28
st %r29,[%r28]
set 1,%r29
set _Indx,%r28
st %r29,[%r28]
L707:
set _Indx,%r29
ld [%r29],%r29
cmp %r29,1; bne L711; nop
set _V,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L712; nop
L711:
set _V0,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L712:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
set _V9,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Radix,%r29
ld [%r29],%f28; ld [%r29+4],%f29
set _E9,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fmuld %f28,%f26,%f24
fsubd %f30,%f24,%f24
set _V9,%r29
ld [%r29],%f22; ld [%r29+4],%f23
fmuld %f24,%f22,%f24
set _X,%r28
st %f24,[%r28]; st %f25,[%r28+4]
ld [%r28],%f24; ld [%r28+4],%f25
fmuld %f22,%f24,%f24
st %f24,[%r29]; st %f25,[%r29+4]
ld [%r29],%f24; ld [%r29+4],%f25
set _Two,%r29
ld [%r29],%f22; ld [%r29+4],%f23
fmuld %f22,%f28,%f28
fmuld %f28,%f26,%f28
fsubd %f30,%f28,%f30
set _Z,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
fcmped %f24,%f30; nop; fbul L715; nop
fcmped %f24,%f28; nop; fbule L713; nop
L715:
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _W,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L716; nop
set 1,%r8
set L157,%r9
call _BadCond; nop
ba L717; nop
L716:
set 2,%r8
set L157,%r9
call _BadCond; nop
L717:
set L718,%r8
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L719,%r8
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L713:
L708:
set _Indx,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set _Indx,%r29
ld [%r29],%r29
cmp %r29,2; ble L707; nop
set 190,%r29
set _Milestone,%r28
st %r29,[%r28]
call _Pause; nop
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _V,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Radix,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fmuld %f30,%f30,%f30
set _Y,%r28
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r29],%f30; ld [%r29+4],%f31
ld [%r28],%f28; ld [%r28+4],%f29
fmuld %f30,%f28,%f26
set _One,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fcmped %f26,%f24; nop; fbul L722; nop
fcmped %f30,%f28; nop; fbule L720; nop
L722:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f26
set _U1,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fcmped %f26,%f24; nop; fbul L725; nop
fdivd %f28,%f24,%f28
fcmped %f30,%f28; nop; fbule L723; nop
L725:
set 2,%r8
set L726,%r9
call _BadCond; nop
ba L724; nop
L723:
set 3,%r8
set L157,%r9
call _BadCond; nop
L724:
set L727,%r8
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set L728,%r11
call _printf; nop
L720:
set 200,%r29
set _Milestone,%r28
st %r29,[%r28]
set 1,%r29
set _Indx,%r28
st %r29,[%r28]
L729:
set _F9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Indx,%r29
ld [%r29],%r29
cmp %r29,2; bl L733; nop
cmp %r29,5; bg L733; nop
sll %r29,2,%r29
set L740-8,%r28
ld [%r29+%r28],%r29
jmp %r29; nop
L740:
.align 4; .word L735
.align 4; .word L736
.align 4; .word L737
.align 4; .word L738
L735:
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L734; nop
L736:
set _V,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L734; nop
L737:
set _UfThold,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ba L734; nop
L738:
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L733:
L734:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Y,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _sigfpe,%r29
set _sigsave,%r28
st %r29,[%r28]
set _ovfl_buf,%r8
call _setjmp; nop
cmp %r8,%r0; be L742; nop
set L744,%r8
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
ba L743; nop
L742:
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _Half,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
fsubd %f30,%f28,%f30
set _V9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L745; nop
ba L730; nop
L745:
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fnegs %f28,%f28; fmovs %f29,%f29
fcmped %f30,%f28; nop; fbne L747; nop
set _Indx,%r29
ld [%r29],%r29
cmp %r29,5; bge L747; nop
set 3,%r8
set L157,%r9
call _BadCond; nop
ba L748; nop
L747:
set 1,%r8
set L157,%r9
call _BadCond; nop
L748:
set L749,%r8
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L750,%r8
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L743:
set _sigsave,%r29
st %r0,[%r29]
L730:
set _Indx,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set _Indx,%r29
ld [%r29],%r29
cmp %r29,5; ble L729; nop
set 210,%r29
set _Milestone,%r28
st %r29,[%r28]
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MyZero,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L44,%r8
call _printf; nop
set L751,%r8
call _printf; nop
set _sigfpe,%r29
set _sigsave,%r28
st %r29,[%r28]
set L752,%r8
call _printf; nop
set _ovfl_buf,%r8
call _setjmp; nop
cmp %r8,%r0; bne L753; nop
set L755,%r8
set _One,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MyZero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L753:
set _sigsave,%r29
st %r0,[%r29]
set _sigfpe,%r28
st %r28,[%r29]
set L756,%r8
call _printf; nop
set _ovfl_buf,%r8
call _setjmp; nop
cmp %r8,%r0; bne L757; nop
set L755,%r8
set _Zero,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MyZero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L757:
set _sigsave,%r29
st %r0,[%r29]
set 220,%r29
set _Milestone,%r28
st %r29,[%r28]
call _Pause; nop
set L44,%r8
call _printf; nop
mov %r0,%r29
L764:
sll %r29,2,%r28
set _ErrCnt,%r27
ld [%r28+%r27],%r28
cmp %r28,%r0; be L768; nop
set L770,%r8
sll %r29,2,%r28
set _759,%r27
ld [%r28+%r27],%r9
set _ErrCnt,%r27
ld [%r28+%r27],%r10
call _printf; nop
L768:
L765:
add %r29,1,%r29
cmp %r29,4; bl L764; nop
set L44,%r8
call _printf; nop
set _ErrCnt,%r29
ld [%r29],%r29
set _ErrCnt+4,%r28
ld [%r28],%r28
add %r29,%r28,%r29
set _ErrCnt+8,%r28
ld [%r28],%r28
add %r29,%r28,%r29
set _ErrCnt+12,%r28
ld [%r28],%r28
add %r29,%r28,%r29
cmp %r29,%r0; ble L771; nop
set _ErrCnt,%r29
ld [%r29],%r29
set _ErrCnt+4,%r28
ld [%r28],%r28
add %r29,%r28,%r29
set _ErrCnt+8,%r28
ld [%r28],%r28
add %r29,%r28,%r29
cmp %r29,%r0; bne L776; nop
set _ErrCnt+12,%r29
ld [%r29],%r29
cmp %r29,%r0; ble L776; nop
set L781,%r8
call _printf; nop
set L782,%r8
call _printf; nop
L776:
set _ErrCnt,%r29
ld [%r29],%r29
set _ErrCnt+4,%r28
ld [%r28],%r28
add %r29,%r28,%r29
cmp %r29,%r0; bne L783; nop
set _ErrCnt+8,%r29
ld [%r29],%r29
cmp %r29,%r0; ble L783; nop
set L787,%r8
call _printf; nop
set L788,%r8
call _printf; nop
L783:
set _ErrCnt,%r29
ld [%r29],%r29
set _ErrCnt+4,%r28
ld [%r28],%r28
add %r29,%r28,%r29
cmp %r29,%r0; ble L789; nop
set L792,%r8
call _printf; nop
set L793,%r8
call _printf; nop
L789:
set _ErrCnt,%r29
ld [%r29],%r29
cmp %r29,%r0; ble L772; nop
set L796,%r8
call _printf; nop
set L797,%r8
call _printf; nop
ba L772; nop
L771:
set L798,%r8
call _printf; nop
set _RMult,%r29
ld [%r29],%r29
cmp %r29,1; bne L803; nop
set _RDiv,%r29
ld [%r29],%r29
cmp %r29,1; bne L803; nop
set _RAddSub,%r29
ld [%r29],%r29
cmp %r29,1; bne L803; nop
set _RSqrt,%r29
ld [%r29],%r29
cmp %r29,1; be L799; nop
L803:
set L804,%r8
call _printf; nop
ba L800; nop
L799:
set _StickyBit,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L805; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Two,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f30,%f26,%f26
set _Nine,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fsubd %f30,%f24,%f30
fsubd %f30,%f28,%f30
fmuld %f26,%f30,%f30
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L805; nop
set L807,%r8
call _printf; nop
set L808,%r8
call _printf; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Two,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L809; nop
set _Precision,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Four,%r29
ld [%r29],%f26; ld [%r29+4],%f27
set _Three,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fmuld %f26,%f24,%f26
fmuld %f26,%f28,%f28
fsubd %f30,%f28,%f28
set _TwentySeven,%r29
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f30,%f26,%f30
fsubd %f30,%f26,%f30
set _One,%r29
ld [%r29],%f26; ld [%r29+4],%f27
faddd %f30,%f26,%f30
fmuld %f28,%f30,%f30
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L809; nop
set L811,%r8
call _printf; nop
ba L810; nop
L809:
set L812,%r8
call _printf; nop
L810:
set _IEEE,%r29
ld [%r29],%r29
cmp %r29,%r0; be L813; nop
set L815,%r8
call _printf; nop
ba L814; nop
L813:
set L816,%r8
call _printf; nop
set L817,%r8
call _printf; nop
L814:
L805:
set L818,%r8
call _printf; nop
L800:
L772:
set _fpecount,%r29
ld [%r29],%r29
cmp %r29,%r0; be L819; nop
set L821,%r8
set _fpecount,%r29
ld [%r29],%r9
call _printf; nop
L819:
set L822,%r8
call _printf; nop
L6:
ret; restore
.global _Sign
.align 4
.proc 4
_Sign:save %sp,-104,%sp
st %r24,[%fp+68]
st %r25,[%fp+72]
ld [%fp+68],%f30; ld [%fp+68+4],%f31
set L7,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L843; nop
set L8,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%fp+-8]; st %f31,[%fp+-8+4]
ba L844; nop
L843:
set L845,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%fp+-8]; st %f31,[%fp+-8+4]
L844:
ld [%fp+-8],%f0; ld [%fp+-8+4],%f1
L841:
ret; restore
.global _Pause
.align 4
.proc 4
_Pause:save %sp,-96,%sp
set L847,%r8
set _Milestone,%r29
ld [%r29],%r9
call _printf; nop
set L848,%r8
set _PageNo,%r29
ld [%r29],%r9
call _printf; nop
set _Milestone,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set _PageNo,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
L846:
ret; restore
.global _TstCond
.align 4
.proc 4
_TstCond:save %sp,-96,%sp
cmp %r25,%r0; bne L850; nop
mov %r24,%r8
mov %r26,%r9
call _BadCond; nop
set L815,%r8
call _printf; nop
L850:
L849:
ret; restore
.seg "data"
.align 4; _853:.word L854
.word L855
.word L856
.word L857
.seg "text"
.global _BadCond
.align 4
.proc 4
_BadCond:save %sp,-96,%sp
sll %r24,2,%r29
set _ErrCnt,%r28
add %r29,%r28,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set L858,%r8
sll %r24,2,%r29
set _853,%r28
ld [%r29+%r28],%r9
mov %r25,%r10
call _printf; nop
L852:
ret; restore
.global _Random
.align 4
.proc 4
_Random:save %sp,-120,%sp
set _Random1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Random9,%r29
ld [%r29],%f28; ld [%r29+4],%f29
faddd %f30,%f28,%f30
st %f30,[%fp+-8]; st %f31,[%fp+-8+4]
ld [%fp+-8],%f30; ld [%fp+-8+4],%f31
fmuld %f30,%f30,%f28
st %f28,[%fp+-16]; st %f29,[%fp+-16+4]
ld [%fp+-16],%f28; ld [%fp+-16+4],%f29
fmuld %f28,%f28,%f28
st %f28,[%fp+-16]; st %f29,[%fp+-16+4]
ld [%fp+-16],%f28; ld [%fp+-16+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%fp+-8]; st %f31,[%fp+-8+4]
ld [%fp+-8],%f30; ld [%fp+-8+4],%f31
st %f30,[%fp+-24]; st %f31,[%fp+-24+4]
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
ld [%fp+-24],%f30; ld [%fp+-24+4],%f31
fsubd %f30,%f0,%f30
st %f30,[%fp+-16]; st %f31,[%fp+-16+4]
ld [%fp+-16],%f30; ld [%fp+-16+4],%f31
set L860,%r29
ld [%r29],%f28; ld [%r29+4],%f29
ld [%fp+-8],%f26; ld [%fp+-8+4],%f27
fmuld %f28,%f26,%f28
faddd %f30,%f28,%f30
set _Random1,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f0; ld [%r29+4],%f1
L859:
ret; restore
.global _SqXMinX
.align 4
.proc 4
_SqXMinX:save %sp,-112,%sp
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _BInvrse,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f28
st %f28,[%fp+-8]; st %f29,[%fp+-8+4]
ld [%fp+-8],%f28; ld [%fp+-8+4],%f29
fsubd %f30,%f28,%f28
st %f28,[%fp+-16]; st %f29,[%fp+-16+4]
fmuld %f30,%f30,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
ld [%fp+-8],%f30; ld [%fp+-8+4],%f31
fsubd %f0,%f30,%f30
ld [%fp+-16],%f28; ld [%fp+-16+4],%f29
fsubd %f30,%f28,%f30
set _OneUlp,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fdivd %f30,%f28,%f30
set _SqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L863; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L865; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L865:
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L867; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L867:
set _J,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set L8,%r28
ld [%r28],%f28; ld [%r28+4],%f29
faddd %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
mov %r24,%r8
set L44,%r9
call _BadCond; nop
set L869,%r8
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fmuld %f30,%f30,%f28
st %f28,[%sp+4*1+68]
st %f29,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
set _OneUlp,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _SqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%sp+4*5+68]
st %f31,[%sp+4*6+68]
ld [%sp+4*5+68],%o5
call _printf; nop
set L870,%r8
call _printf; nop
L863:
L862:
ret; restore
.global _NewD
.align 4
.proc 4
_NewD:save %sp,-96,%sp
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Q,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
set _X,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Half,%r28
ld [%r28],%f30; ld [%r28+4],%f31
ld [%r29],%f28; ld [%r29+4],%f29
set _Radix,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fdivd %f28,%f26,%f28
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _floor; nop
set _Radix,%r28
ld [%r28],%f30; ld [%r28+4],%f31
fmuld %f0,%f30,%f28
set _X,%r28
ld [%r28],%f26; ld [%r28+4],%f27
faddd %f28,%f26,%f28
st %f28,[%r29]; st %f29,[%r29+4]
set _Q,%r29
ld [%r29],%f28; ld [%r29+4],%f29
ld [%r28],%f26; ld [%r28+4],%f27
set _Z,%r28
ld [%r28],%f24; ld [%r28+4],%f25
fmuld %f26,%f24,%f22
fsubd %f28,%f22,%f28
fdivd %f28,%f30,%f28
fmuld %f26,%f26,%f22
set _D,%r27
ld [%r27],%f20; ld [%r27+4],%f21
fdivd %f20,%f30,%f30
fmuld %f22,%f30,%f30
faddd %f28,%f30,%f30
st %f30,[%r29]; st %f31,[%r29+4]
set _Two,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fmuld %f30,%f26,%f30
fmuld %f30,%f20,%f30
fsubd %f24,%f30,%f30
st %f30,[%r28]; st %f31,[%r28+4]
ld [%r28],%f30; ld [%r28+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbug L872; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
st %f30,[%r29]; st %f31,[%r29+4]
set _Z1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
st %f30,[%r29]; st %f31,[%r29+4]
L872:
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _D,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L871:
ret; restore
.global _SR3750
.align 4
.proc 4
_SR3750:save %sp,-96,%sp
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Radix,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f26
set _Z2,%r29
ld [%r29],%f24; ld [%r29+4],%f25
fsubd %f24,%f28,%f28
fcmped %f26,%f28; nop; fbul L875; nop
fsubd %f30,%f24,%f30
set _W,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f28,%f24,%f28
fcmped %f30,%f28; nop; fbug L875; nop
set _I,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _D,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _sqrt; nop
set _X2,%r29
st %f0,[%r29]; st %f1,[%r29+4]
set _X2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Z2,%r28
ld [%r28],%f28; ld [%r28+4],%f29
fsubd %f30,%f28,%f30
set _Y,%r28
ld [%r28],%f26; ld [%r28+4],%f27
fsubd %f26,%f28,%f28
fsubd %f30,%f28,%f30
set _Y2,%r28
st %f30,[%r28]; st %f31,[%r28+4]
set _X8,%r27
ld [%r27],%f30; ld [%r27+4],%f31
set _Half,%r27
ld [%r27],%f28; ld [%r27+4],%f29
fsubd %f26,%f28,%f26
fdivd %f30,%f26,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
fmuld %f28,%f30,%f26
fmuld %f26,%f30,%f26
fsubd %f30,%f26,%f30
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r28],%f30; ld [%r28+4],%f31
faddd %f30,%f28,%f30
ld [%r29],%f26; ld [%r29+4],%f27
fsubd %f28,%f26,%f28
faddd %f30,%f28,%f30
set _SqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbuge L877; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MinSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L877:
set _Y2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
set _SqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L879; nop
set _SqEr,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _MaxSqEr,%r29
st %f30,[%r29]; st %f31,[%r29+4]
L879:
L875:
L874:
ret; restore
.global _IsYeqX
.align 4
.proc 4
_IsYeqX:save %sp,-96,%sp
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L882; nop
set _N,%r29
ld [%r29],%r29
cmp %r29,%r0; bg L884; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L886; nop
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f30,%f28; nop; fbug L886; nop
set L888,%r8
call _printf; nop
ba L887; nop
L886:
set 2,%r8
set L889,%r9
call _BadCond; nop
L887:
set L890,%r8
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
set _Q,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*3+68]
st %f31,[%sp+4*4+68]
ld [%sp+4*3+68],%o3
ld [%sp+4*4+68],%o4
call _printf; nop
set L891,%r8
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L892,%r8
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L893,%r8
set _Y,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L884:
set _N,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
L882:
L881:
ret; restore
.global _SR3980
.align 4
.proc 4
_SR3980:save %sp,-96,%sp
L895:
set _I,%r29
ld [%r29],%r29
st %r29,[%sp+64]; ld [%sp+64],%f30; fitod %f30,%f30
set _Q,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set _Z,%r28
ld [%r28],%f30; ld [%r28+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*2+68]
st %f31,[%sp+4*3+68]
ld [%sp+4*2+68],%o2
ld [%sp+4*3+68],%o3
call _pow; nop
set _Y,%r29
st %f0,[%r29]; st %f1,[%r29+4]
call _IsYeqX; nop
set _I,%r29
ld [%r29],%r28
add %r28,1,%r28
st %r28,[%r29]
set _M,%r29
ld [%r29],%r29
cmp %r28,%r29; ble L898; nop
ba L897; nop
L898:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _X,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%r29]; st %f31,[%r29+4]
L896:
set _X,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _W,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L895; nop
L897:
L894:
ret; restore
.global _PrintIfNPositive
.align 4
.proc 4
_PrintIfNPositive:save %sp,-96,%sp
set _N,%r29
ld [%r29],%r29
cmp %r29,%r0; ble L901; nop
set L903,%r8
set _N,%r29
ld [%r29],%r9
call _printf; nop
L901:
L900:
ret; restore
.global _TstPtUf
.align 4
.proc 4
_TstPtUf:save %sp,-96,%sp
set _N,%r29
st %r0,[%r29]
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Zero,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L905; nop
set L907,%r8
call _printf; nop
set L908,%r8
call _printf; nop
set _sigfpe,%r29
set _sigsave,%r28
st %r29,[%r28]
set _ovfl_buf,%r8
call _setjmp; nop
cmp %r8,%r0; be L909; nop
ba L911; nop
L909:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
faddd %f30,%f30,%f28
fdivd %f28,%f30,%f30
set _Q9,%r29
st %f30,[%r29]; st %f31,[%r29+4]
set L912,%r8
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set _Q9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Two,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fsubd %f30,%f28,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _fabs; nop
set _Radix,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _U2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f30
fcmped %f0,%f30; nop; fbuge L913; nop
set L915,%r8
call _printf; nop
set L916,%r8
call _printf; nop
ba L914; nop
L913:
set _Q9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbul L919; nop
set _Two,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbule L917; nop
L919:
L911:
set 1,%r29
set _N,%r28
st %r29,[%r28]
set _ErrCnt+4,%r29
ld [%r29],%r29
add %r29,1,%r29
set _ErrCnt+4,%r28
st %r29,[%r28]
set L922,%r8
call _printf; nop
ba L918; nop
L917:
set 1,%r29
set _N,%r28
st %r29,[%r28]
set _ErrCnt+8,%r29
ld [%r29],%r29
add %r29,1,%r29
set _ErrCnt+8,%r28
st %r29,[%r28]
set L925,%r8
call _printf; nop
L918:
L914:
set _sigsave,%r29
st %r0,[%r29]
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _One,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fmuld %f30,%f28,%f26
set _V9,%r29
st %f26,[%r29]; st %f27,[%r29+4]
ld [%r29],%f26; ld [%r29+4],%f27
set _Random1,%r28
st %f26,[%r28]; st %f27,[%r28+4]
fmuld %f28,%f30,%f26
st %f26,[%r29]; st %f27,[%r29+4]
ld [%r29],%f26; ld [%r29+4],%f27
set _Random2,%r27
st %f26,[%r27]; st %f27,[%r27+4]
fdivd %f30,%f28,%f28
st %f28,[%r29]; st %f29,[%r29+4]
ld [%r28],%f28; ld [%r28+4],%f29
fcmped %f30,%f28; nop; fbne L926; nop
ld [%r27],%f28; ld [%r27+4],%f29
fcmped %f30,%f28; nop; fbne L926; nop
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbne L926; nop
set _N,%r29
ld [%r29],%r29
cmp %r29,%r0; ble L927; nop
call _Pause; nop
ba L927; nop
L926:
set 1,%r29
set _N,%r28
st %r29,[%r28]
set 2,%r8
set L930,%r9
call _BadCond; nop
set L931,%r8
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Random1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L932; nop
set L934,%r8
set _Random1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L932:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Random2,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L935; nop
set _Random1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
fcmped %f28,%f30; nop; fbue L935; nop
set L937,%r8
set _Random2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L935:
set _Z,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _V9,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L938; nop
set L940,%r8
set _V9,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L938:
set _Random2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
set _Random1,%r29
ld [%r29],%f28; ld [%r29+4],%f29
fcmped %f30,%f28; nop; fbue L941; nop
set _ErrCnt+8,%r29
ld [%r29],%r29
add %r29,1,%r29
set _ErrCnt+8,%r28
st %r29,[%r28]
set 2,%r8
set L945,%r9
call _BadCond; nop
set L946,%r8
set _Random2,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
set L947,%r8
set _Random1,%r29
ld [%r29],%f30; ld [%r29+4],%f31
st %f30,[%sp+4*1+68]
st %f31,[%sp+4*2+68]
ld [%sp+4*1+68],%o1
ld [%sp+4*2+68],%o2
call _printf; nop
L941:
call _Pause; nop
L927:
L905:
L904:
ret; restore
.global _notify
.align 4
.proc 4
_notify:save %sp,-96,%sp
set L949,%r8
mov %r24,%r9
call _printf; nop
set L950,%r8
call _printf; nop
L948:
ret; restore
.global _msglist
.align 4
.proc 4
_msglist:save %sp,-96,%sp
ba L953; nop
L952:
set L955,%r8
mov %r24,%r29
add %r29,4,%r24
ld [%r29],%r9
call _printf; nop
L953:
ld [%r24],%r29
cmp %r29,%r0; bne L952; nop
L951:
ret; restore
.seg "data"
.align 4; _957:.word L958
.word L959
.word L960
.word L961
.word L962
.word L963
.word L964
.word L965
.word L966
.word 0x0
.seg "text"
.global _Instructions
.align 4
.proc 4
_Instructions:save %sp,-96,%sp
set _957,%r8
call _msglist; nop
L956:
ret; restore
.seg "data"
.align 4; _968:.word L969
.word L970
.word L971
.word L972
.word L973
.word L974
.word L975
.word L976
.word L977
.word L978
.word L979
.word L980
.word L981
.word L982
.word 0x0
.seg "text"
.global _Heading
.align 4
.proc 4
_Heading:save %sp,-96,%sp
set _968,%r8
call _msglist; nop
L967:
ret; restore
.seg "data"
.align 4; _984:.word L985
.word L986
.word L987
.word L988
.word L989
.word L990
.word L991
.word L992
.word L993
.word L994
.word L995
.word L996
.word L997
.word L998
.word L999
.word L1000
.word L1001
.word L1002
.word L1003
.word 0x0
.seg "text"
.global _Characteristics
.align 4
.proc 4
_Characteristics:save %sp,-96,%sp
set _984,%r8
call _msglist; nop
L983:
ret; restore
.seg "data"
.align 4; _1005:.word L1006
.word L1007
.word L1008
.word L1009
.word L1010
.word L1011
.word L1012
.word L1013
.word L1014
.word L1015
.word L1016
.word L1017
.word L1018
.word L1019
.word L1020
.word L1021
.word L1022
.word 0x0
.seg "text"
.global _History
.align 4
.proc 4
_History:save %sp,-96,%sp
set _1005,%r8
call _msglist; nop
L1004:
ret; restore
.global _pow
.align 4
.proc 4
_pow:save %sp,-120,%sp
st %r24,[%fp+68]
st %r25,[%fp+72]
st %r26,[%fp+76]
st %r27,[%fp+80]
mov %r0,%r28
mov %r0,%r27
ld [%fp+76],%f30; ld [%fp+76+4],%f31
set L7,%r26
ld [%r26],%f28; ld [%r26+4],%f29
fcmped %f30,%f28; nop; fbne L1024; nop
set L8,%r26
ld [%r26],%f0; ld [%r26+4],%f1
ba L1023; nop
L1024:
ld [%fp+76],%f30; ld [%fp+76+4],%f31
set L1029,%r26
ld [%r26],%f28; ld [%r26+4],%f29
fcmped %f30,%f28; nop; fbul L1028; nop
set L1030,%r26
ld [%r26],%f28; ld [%r26+4],%f29
fcmped %f30,%f28; nop; fbule L1026; nop
L1028:
ld [%fp+68],%f30; ld [%fp+68+4],%f31
set L845,%r26
ld [%r26],%f28; ld [%r26+4],%f29
fcmped %f30,%f28; nop; fbue L1026; nop
ld [%fp+68],%f30; ld [%fp+68+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
ld [%fp+76],%f30; ld [%fp+76+4],%f31
fmuld %f30,%f0,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _exp; nop
ba L1023; nop
L1026:
ld [%fp+76],%f30; ld [%fp+76+4],%f31
set L7,%r26
ld [%r26],%f28; ld [%r26+4],%f29
fcmped %f30,%f28; nop; fbuge L1031; nop
ld [%fp+76],%f30; ld [%fp+76+4],%f31
fnegs %f30,%f30; fmovs %f31,%f31
st %f30,[%fp+76]; st %f31,[%fp+76+4]
set 1,%r27
L1031:
ld [%fp+76],%f30; ld [%fp+76+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
add -24,%fp,%r10
call _modf; nop
st %f0,[%fp+76]; st %f1,[%fp+76+4]
ld [%fp+76],%f30; ld [%fp+76+4],%f31
set L7,%r26
ld [%r26],%f28; ld [%r26+4],%f29
fcmped %f30,%f28; nop; fbue L1033; nop
ld [%fp+68],%f30; ld [%fp+68+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _log; nop
ld [%fp+76],%f30; ld [%fp+76+4],%f31
fmuld %f30,%f0,%f30
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
call _exp; nop
st %f0,[%fp+-16]; st %f1,[%fp+-16+4]
ba L1034; nop
L1033:
set L8,%r26
ld [%r26],%f30; ld [%r26+4],%f31
st %f30,[%fp+-16]; st %f31,[%fp+-16+4]
L1034:
ld [%fp+68],%f30; ld [%fp+68+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
add -4,%fp,%r10
call _frexp; nop
st %f0,[%fp+68]; st %f1,[%fp+68+4]
ld [%fp+-24],%f30; ld [%fp+-24+4],%f31
fdtoi %f30,%f0; st %f0,[%sp+64]; ld [%sp+64],%r26
mov %r26,%r29
cmp %r26,%r0; be L1035; nop
L1037:
and %r29,1,%r26
cmp %r26,%r0; be L1041; nop
ld [%fp+-16],%f30; ld [%fp+-16+4],%f31
ld [%fp+68],%f28; ld [%fp+68+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%fp+-16]; st %f31,[%fp+-16+4]
ld [%fp+-4],%r26
add %r28,%r26,%r28
L1041:
sra %r29,1,%r26
mov %r26,%r29
cmp %r26,%r0; bne L1043; nop
ba L1039; nop
L1043:
ld [%fp+68],%f30; ld [%fp+68+4],%f31
fmuld %f30,%f30,%f30
st %f30,[%fp+68]; st %f31,[%fp+68+4]
ld [%fp+-4],%r26
sll %r26,1,%r26
st %r26,[%fp+-4]
ld [%fp+68],%f30; ld [%fp+68+4],%f31
set L1047,%r26
ld [%r26],%f28; ld [%r26+4],%f29
fcmped %f30,%f28; nop; fbuge L1037; nop
set L1048,%r26
ld [%r26],%f30; ld [%r26+4],%f31
ld [%fp+68],%f28; ld [%fp+68+4],%f29
fmuld %f30,%f28,%f30
st %f30,[%fp+68]; st %f31,[%fp+68+4]
ld [%fp+-4],%r26
sub %r26,1,%r26
st %r26,[%fp+-4]
ba L1037; nop
L1039:
L1035:
cmp %r27,%r0; be L1049; nop
set L8,%r26
ld [%r26],%f30; ld [%r26+4],%f31
ld [%fp+-16],%f28; ld [%fp+-16+4],%f29
fdivd %f30,%f28,%f30
st %f30,[%fp+-16]; st %f31,[%fp+-16+4]
sub %g0,%r28,%r28
L1049:
ld [%fp+-16],%f30; ld [%fp+-16+4],%f31
st %f30,[%sp+4*0+68]
st %f31,[%sp+4*1+68]
ld [%sp+4*0+68],%o0
ld [%sp+4*1+68],%o1
mov %r28,%r10
call _ldexp; nop
L1023:
ret; restore
.seg "bss"
.global _UfNGrad
.align 4; .common _UfNGrad,4
.global _SqRWrng
.align 4; .common _SqRWrng,4
.global _IEEE
.align 4; .common _IEEE,4
.global _Anomaly
.align 4; .common _Anomaly,4
.global _Monot
.align 4; .common _Monot,4
.global _NotMonot
.align 4; .common _NotMonot,4
.global _Done
.align 4; .common _Done,4
.global _Break
.align 4; .common _Break,4
.global _RSqrt
.align 4; .common _RSqrt,4
.global _RAddSub
.align 4; .common _RAddSub,4
.global _RDiv
.align 4; .common _RDiv,4
.global _RMult
.align 4; .common _RMult,4
.global _GAddSub
.align 4; .common _GAddSub,4
.global _GDiv
.align 4; .common _GDiv,4
.global _GMult
.align 4; .common _GMult,4
.global _N1
.align 4; .common _N1,4
.global _N
.align 4; .common _N,4
.global _M
.align 4; .common _M,4
.global _PageNo
.align 4; .common _PageNo,4
.global _Milestone
.align 4; .common _Milestone,4
.global _fpecount
.align 4; .common _fpecount,4
.global _ErrCnt
.align 4; .common _ErrCnt,16
.global _Z9
.align 8; .common _Z9,8
.global _Z2
.align 8; .common _Z2,8
.global _Z1
.align 8; .common _Z1,8
.global _PseudoZero
.align 8; .common _PseudoZero,8
.global _Z
.align 8; .common _Z,8
.global _Random2
.align 8; .common _Random2,8
.global _Y2
.align 8; .common _Y2,8
.global _Y1
.align 8; .common _Y1,8
.global _Y
.align 8; .common _Y,8
.global _Random1
.align 8; .common _Random1,8
.global _X8
.align 8; .common _X8,8
.global _X2
.align 8; .common _X2,8
.global _X1
.align 8; .common _X1,8
.global _X
.align 8; .common _X,8
.global _W
.align 8; .common _W,8
.global _V9
.align 8; .common _V9,8
.global _V0
.align 8; .common _V0,8
.global _V
.align 8; .common _V,8
.global _U2
.align 8; .common _U2,8
.global _U1
.align 8; .common _U1,8
.global _UfThold
.align 8; .common _UfThold,8
.global _OneUlp
.align 8; .common _OneUlp,8
.global _S
.align 8; .common _S,8
.global _Underflow
.align 8; .common _Underflow,8
.global _T
.align 8; .common _T,8
.global _Random9
.align 8; .common _Random9,8
.global _R
.align 8; .common _R,8
.global _Q9
.align 8; .common _Q9,8
.global _Q
.align 8; .common _Q,8
.global _Precision
.align 8; .common _Precision,8
.global _MyZero
.align 8; .common _MyZero,8
.global _J
.align 8; .common _J,8
.global _StickyBit
.align 8; .common _StickyBit,8
.global _I
.align 4; .common _I,4
.global _HInvrse
.align 8; .common _HInvrse,8
.global _H
.align 8; .common _H,8
.global _F9
.align 8; .common _F9,8
.global _F6
.align 8; .common _F6,8
.global _Third
.align 8; .common _Third,8
.global _E9
.align 8; .common _E9,8
.global _MaxSqEr
.align 8; .common _MaxSqEr,8
.global _SqEr
.align 8; .common _SqEr,8
.global _MinSqEr
.align 8; .common _MinSqEr,8
.global _E3
.align 8; .common _E3,8
.global _Exp2
.align 8; .common _Exp2,8
.global _E1
.align 8; .common _E1,8
.global _E0
.align 8; .common _E0,8
.global _FourD
.align 8; .common _FourD,8
.global _D
.align 8; .common _D,8
.global _CInvrse
.align 8; .common _CInvrse,8
.global _C
.align 8; .common _C,8
.global _A1
.align 8; .common _A1,8
.global _AInvrse
.align 8; .common _AInvrse,8
.global _ch
.common _ch,8
.global _Indx
.align 4; .common _Indx,4
.global _BMinusU2
.align 8; .common _BMinusU2,8
.global _RadixD2
.align 8; .common _RadixD2,8
.global _BInvrse
.align 8; .common _BInvrse,8
.global _Radix
.align 8; .common _Radix,8
.global _sigsave
.align 4; .common _sigsave,4
.global _ovfl_buf
.align 4; .common _ovfl_buf,36
.seg "text"
.align 8; L1048:.word 0x40000000,0x0
.align 8; L1047:.word 0x3fe00000,0x0
.align 8; L1030:.word 0x40913000,0x0
.align 8; L1029:.word 0xc0913000,0x0
L1022:.ascii "see source comments for more history.\000"
L1021:.ascii "BASIC version of this program (C) 1983 by Prof. W. M. Kahan;\000"
L1020:.ascii "as used by certain early WANG machines.\012\000"
L1019:.ascii "floating-point numbers, but also allows logarithmic encoding\000"
L1018:.ascii "\012The program is based upon a conventional radix representatio"
.ascii "n for\000"
L1017:.ascii "of pathologies, and to say how well the arithmetic is implemente"
.ascii "d.\000"
L1016:.ascii "of the arithmetic, this program tries to cope with a wider varie"
.ascii "ty\000"
L1015:.ascii "the Radix, Precision and range (over/underflow thresholds)\000"
L1014:.ascii "W. J. Cody and W. Waite. Although both programs try to discover\000"
L1013:.ascii "book  `Software Manual for the Elementary Functions' (1980) by\000"
L1012:.ascii "program called `MACHAR', which can be found at the end of the\000"
L1011:.ascii "The diagnostic capabilities of this program go beyond an earlier"
.ascii "\000"
L1010:.ascii "Failures may confound subsequent diagnoses.\012\000"
L1009:.ascii "   FAILUREs, like 2+2 == 5 .\000"
L1008:.ascii "   Serious DEFECTs, like lack of a guard digit, and\000"
L1007:.ascii "   FLAWs, like lack of a sticky bit,\000"
L1006:.ascii "The program attempts to discriminate among\000"
L1003:.ascii "     Decimal-Binary conversion is NOT YET tested for accuracy.\000"
L1002:.ascii "     Extra-precise subexpressions are revealed but NOT YET teste"
.ascii "d.\000"
L1001:.ascii "     Sqrt is tested.  Y^X is not tested.\000"
L1000:.ascii "\011and for contamination with pseudo-zeros.\000"
L999:.ascii "     Comparisions are checked for consistency with subtraction\000"
L998:.ascii "     V0  tells, roughly, whether  Infinity  is represented.\000"
L997:.ascii "     V = an overflow threshold, roughly.\000"
L996:.ascii "     E0 and PseudoZero tell whether underflow is abrupt, gradual"
.ascii ", or fuzzy.\000"
L995:.ascii "     UnderflowThreshold = an underflow threshold.\000"
L994:.ascii "     Whether a Sticky Bit used correctly for rounding.\000"
L993:.ascii "\011for Mult., Div., Add/Subt. and Sqrt.\000"
L992:.ascii "     Whether arithmetic is chopped, correctly rounded, or someth"
.ascii "ing else\000"
L991:.ascii "     Adequacy of guard digits for Mult., Div. and Subt.\000"
L990:.ascii "     U1 = 1/Radix^Precision = One Ulp of numbers a little less t"
.ascii "han 1.0 .\000"
L989:.ascii "\011(OneUlpnit in the Last Place) of 1.000xxx .\000"
L988:.ascii "     U2 = Radix/Radix^Precision = One Ulp\000"
L987:.ascii "     Precision = number of significant digits carried.\000"
L986:.ascii "     Radix = 1, 2, 4, 8, 10, 16, 100, 256 ...\000"
L985:.ascii "Running this program should reveal these characteristics:\000"
L982:.ascii "\011Other relevant compiler options:\000"
L981:.ascii "\011Optimization level:\012\000"
L980:.ascii "\011Compiler:\012\000"
L979:.ascii "\011Computer:\012\000"
L978:.ascii "\011Version:\01110 February 1989;\000"
L977:.ascii "\011Precision:\011double;\000"
L976:.ascii "In doing so, please include the following information:\000"
L975:.ascii "\011San Francisco, CA 94143-0704, USA\012\000"
L974:.ascii "\011University of California\000"
L973:.ascii "\011Computer Center U-76\000"
L972:.ascii "\011Richard Karpinski\000"
L971:.ascii "Please send suggestions and interesting results to\000"
L970:.ascii "cope with unanticipated and newly uncovered arithmetic pathologi"
.ascii "es.\012\000"
L969:.ascii "Users are invited to help debug and augment this program so it w"
.ascii "ill\000"
L966:.ascii "Answer questions with Y, y, N or n (unless otherwise indicated)."
.ascii "\012\000"
L965:.ascii "amend it to make further progress.\012\000"
L964:.ascii "program anyway to see how many milestones it passes, and then\000"
L963:.ascii "warning.  If persuasion avails naught, don't despair but run thi"
.ascii "s\000"
L962:.ascii "to persevere with a surrogate value after, perhaps, displaying s"
.ascii "ome\000"
L961:.ascii "error like Over/Underflow or Division by Zero occurs, but rather"
.ascii "\000"
L960:.ascii "try to persuade the computer NOT to terminate execution when an\000"
L959:.ascii "    `END OF TEST',\012\000"
L958:.ascii "Lest this program stop prematurely, i.e. before displaying\012\000"
L955:.byte 37,115,10,0
L950:.ascii "   PLEASE NOTIFY KARPINKSI!\012\000"
L949:.ascii "%s test appears to be inconsistent...\012\000"
L947:.ascii "\011differs from Z * 1 = %.17e\012\000"
L946:.ascii "\011Comparison alleges that 1 * Z = %.17e\012\000"
L945:.ascii "Multiplication does not commute!\012\000"
L940:.ascii "Z / 1 = %.17e\012\000"
L937:.ascii "1 * Z == %g\012\000"
L934:.ascii "Z * 1 = %.17e \000"
L931:.ascii "%.17e\012\011compares different from  \000"
L930:.ascii "What prints as Z = \000"
L925:.ascii "This is a DEFECT!\012\000"
L922:.ascii "This is a VERY SERIOUS DEFECT!\012\000"
L916:.ascii " has NOT just been signaled.\012\000"
L915:.ascii "This is O.K., provided Over/Underflow\000"
L912:.ascii "What the machine gets for (Z + Z) / Z is  %.17e .\012\000"
L908:.ascii "(Z + Z) / Z should be safe.\012\000"
L907:.ascii "Since comparison denies Z = 0, evaluating \000"
L903:.ascii "Similar discrepancies have occurred %d times.\012\000"
L893:.ascii "\011\011they differ by %.17e .\012\000"
L892:.ascii "\011which compared unequal to correct %.17e ;\012\000"
L891:.ascii "\011yielded %.17e;\012\000"
L890:.ascii "\011(%.17e) ^ (%.17e)\012\000"
L889:.ascii "computing\012\000"
L888:.ascii "WARNING:  computing\012\000"
L870:.ascii "\011instead of correct value 0 .\012\000"
L869:.ascii "sqrt( %.17e) - %.17e  = %.17e\012\000"
.align 8; L860:.word 0x3ed4f8b5,0x88e368f0
L858:.ascii "%s:  %s\000"
L857:.ascii "FLAW\000"
L856:.ascii "DEFECT\000"
L855:.ascii "SERIOUS DEFECT\000"
L854:.ascii "FAILURE\000"
L848:.ascii "          Page: %d\012\012\000"
L847:.ascii "\012Diagnosis resumes after milestone Number %d\000"
.align 8; L845:.word 0xbff00000,0x0
L822:.ascii "END OF TEST.\012\000"
L821:.ascii "\012A total of %d floating point exceptions were registered.\012"
.ascii "\000"
L818:.ascii "The arithmetic diagnosed appears to be Excellent!\012\000"
L817:.ascii " during Gradual Underflow.\012\000"
L816:.ascii ",\012except for possibly Double Rounding\000"
L815:.byte 46,10,0
L812:.ascii "854\000"
L811:.ascii "754\000"
L808:.ascii "the proposed IEEE standard P\000"
L807:.ascii "Rounding appears to conform to \000"
L804:.ascii "The arithmetic diagnosed seems Satisfactory.\012\000"
L798:.ascii "No failures, defects nor flaws have been discovered.\012\000"
L797:.ascii " program's subsequent diagnoses.\012\000"
L796:.ascii "Potentially fatal FAILURE may have spoiled this\000"
L793:.ascii "unacceptable Serious Defects.\012\000"
L792:.ascii "The arithmetic diagnosed has \000"
L788:.ascii "despite inconvenient Defects.\012\000"
L787:.ascii "The arithmetic diagnosed may be Acceptable\012\000"
L782:.ascii "Satisfactory though flawed.\012\000"
L781:.ascii "The arithmetic diagnosed seems \000"
L770:.ascii "The number of  %-29s %d.\012\000"
L763:.ascii "FLAWs  discovered =\000"
L762:.ascii "DEFECTs  discovered =\000"
L761:.ascii "SERIOUS DEFECTs  discovered =\000"
L760:.ascii "FAILUREs  encountered =\000"
L756:.ascii "\012    Trying to compute 0 / 0 produces ...\000"
L755:.ascii "  %.7e .\012\000"
L752:.ascii "    Trying to compute 1 / 0 produces ...\000"
L751:.ascii "What message and/or values does Division by Zero produce?\012\000"
L750:.ascii "  instead, X / X - 1/2 - 1/2 = %.17e .\012\000"
L749:.ascii "  X / X differs from 1 when X = %.17e\012\000"
L744:.ascii "  X / X  traps when X = %g\012\000"
L728:.ascii "is too far from 1.\012\000"
L727:.ascii " unbalanced range; UfThold * V = %.17e\012\011%s\012\000"
L726:.ascii "Badly\000"
L719:.ascii " is too far from sqrt(Z) ^ 2 (%.17e) .\012\000"
L718:.ascii "Comparison alleges that Z = %17e\012\000"
L706:.ascii " is too far from sqrt(Z) ^ 2 = %.17e .\012\000"
L705:.ascii "Comparison alleges that what prints as Z = %.17e\012\000"
L688:.ascii "+-%g, +-%g\012and +-%g are confused by Overflow.\000"
L687:.ascii "Comparisons involving \000"
L681:.ascii "above is a DEFECT.\012\000"
L680:.ascii "Any overflow signal separating this * from the one\012\000"
L679:.ascii "                           nor for V / 1 = %.17e .\012\000"
L678:.ascii "No Overflow should be signaled for V * 1 = %.17e\012\000"
L677:.ascii "There is no saturation value because the system traps on overflo"
.ascii "w.\012\000"
L676:.ascii "Overflow saturates at V0 = %.17e .\012\000"
L673:.ascii "Overflow threshold is V  = %.17e .\012\000"
L664:.ascii "overflow past %.17e\012\011shrinks to %.17e .\012\000"
L661:.ascii "-(-Y) differs from Y.\012\000"
L660:.ascii "finds a \000"
L659:.ascii "Seems O.K.\012\000"
L656:.ascii "Trying it on Y = %.17e .\012\000"
L655:.ascii "Can `Z = -Y' overflow?\012\000"
L648:.ascii "This may generate an error.\012\000"
L647:.ascii "Searching for Overflow threshold:\012\000"
L646:.ascii " ... no discrepancies found.\012\000"
L638:.ascii "Testing powers Z^Q at four nearly extreme values.\012\000"
L637:.ascii "Accuracy seems adequate.\012\000"
L630:.ascii "\011calculations involving tiny interest rates.\012\000"
L629:.ascii "\011This much error may spoil financial\012\000"
L628:.ascii "\011differs from correct value by %.17e .\012\000"
L627:.ascii "\011(1 + (%.17e) ^ (%.17e);\012\000"
L626:.ascii " %.17e for\012\000"
L625:.ascii "Calculated\000"
L618:.ascii "Testing X^((X + 1) / (X - 1)) vs. exp(2) = %.17e as X -> 1.\012\000"
L614:.ascii "This computed value is O.K.\012\000"
L611:.ascii "   threshold = %.17e .\012\000"
L610:.ascii "this is not between 0 and underflow\012\000"
L606:.ascii "actually calculating yields: %.17e .\012\000"
L605:.ascii "should afflict the expression\012\011(%.17e) ^ (%.17e);\012\000"
L604:.ascii "UfThold = (%.17e) ^ (%.17e)\012only underflow \000"
L603:.ascii "Since underflow occurs below the threshold\012\000"
L602:.ascii "Range is too narrow; U1^%d Underflows.\012\000"
L597:.ascii "merely roundoff.\012\000"
L596:.ascii "calculation may suffer larger Relative error than \000"
L595:.ascii " below which\000"
L594:.ascii "The Underflow threshold is %.17e, %s\012\000"
L593:.ascii "X / Z = 1 + %g .\012\000"
L592:.ascii "X / Z fails!\012\000"
L589:.ascii "encounter Division by Zero although actually\012\000"
L588:.ascii "  ... (f(X) - f(Z)) / (X - Z) ...\012\000"
L587:.ascii "    if (X == Z)  ...  else\000"
L586:.ascii "confusion when innocent statements like\012\000"
L585:.ascii "this is a SERIOUS DEFECT\012that causes \000"
L584:.ascii "    Should this NOT signal Underflow, \000"
L583:.ascii "yet X - Z yields %.17e .\012\000"
L582:.ascii "X = %.17e\012\011is not equal to Z = %.17e .\012\000"
L577:.ascii "Underflow / UfThold failed!\012\000"
L566:.ascii "(roundoff in UfThold) < E0.\012\000"
L565:.ascii "Underflow is gradual; it incurs Absolute Error =\012\000"
L560:.ascii "|Q - Y| = %.17e .\012\000"
L559:.ascii "print out as Q = %.17e, Y = %.17e .\012\000"
L558:.ascii "Q == Y while denying that |Q - Y| == 0; these values\012\000"
L557:.ascii "Underflow confuses Comparison, which alleges that\012\000"
L555:.ascii " or else multiplication gets too many last digits wrong.\012\000"
L554:.ascii " coming down from %.17e\012\000"
L553:.ascii "approach a threshold = %.17e\012\000"
L552:.ascii "Either accuracy deteriorates as numbers\012\000"
L540:.ascii "Smallest strictly positive number found is E0 = %g .\012\000"
L539:.ascii " threshold than products.\012\000"
L538:.ascii "Difference underflows at a higher\000"
L535:.ascii " threshold than differences.\012\000"
L534:.ascii "Products underflow at a higher\000"
L527:.ascii "value PseudoZero that prints out as %g .\012\000"
L526:.ascii "Underflow can stick at an allegedly positive\012\000"
L525:.ascii "positive, isn't; it prints out as  %g .\012\000"
L524:.ascii "But -PseudoZero, which should be\012\000"
L521:.ascii "PseudoZero that prints out as: %g .\012\000"
L520:.ascii "allegedly negative value\012\000"
L519:.ascii "Positive expressions can underflow to an\012\000"
L506:.ascii "multiplication gets too many last digits wrong.\012\000"
L482:.ascii "Seeking Underflow thresholds UfThold and E0.\012\000"
L479:.ascii "... no discrepancis found.\012\000"
L476:.ascii "\011involving interest rates.\012\000"
L475:.ascii "Errors like this may invalidate financial calculations\012\000"
L454:.ascii "Testing powers Z^i for small Integers Z and i.\012\000"
L451:.ascii "sqrt gets too many last digits wrong\000"
L449:.ascii "to %.7e ulps.\012\000"
L448:.ascii "Observed errors run from %.7e \000"
L447:.ascii "Square root is neither chopped nor correctly rounded.\012\000"
L444:.ascii "Square root appears to be chopped.\012\000"
L439:.ascii "Square root appears to be correctly rounded.\012\000"
L434:.ascii " fails test whether sqrt rounds or chops.\012\000"
L433:.ascii "Radix^Precision = %.7e\012\000"
L432:.ascii "Anomalous arithmetic with Integer < \000"
L392:.ascii "Testing whether sqrt is rounded or chopped.\012\000"
L370:.ascii "sqrt(X) is non-monotonic for X near %.7e .\012\000"
L369:.ascii "sqrt has passed a test for Monotonicity.\012\000"
L352:.ascii "Test for sqrt monotonicity.\012\000"
L341:.ascii "Testing if sqrt(X * X) == X for %d Integers X.\012\000"
L336:.ascii "Square root of 0.0, -0.0 or 1.0 wrong\000"
L334:.ascii "\012Running test of square root(x).\012\000"
L333:.ascii "     No failures found in %d integer pairs.\012\000"
L332:.ascii "X * Y == Y * X trial fails.\012\000"
.align 8; L323:.word 0x40080000,0x0
L322:.ascii "Testing on %d random pairs.\012\000"
L321:.ascii "Does Multiplication commute?  \000"
L318:.ascii "lack(s) of guard digits or failure(s) to correctly round or chop"
.ascii "\012(noted above) count as one flaw in the final tally below\000"
L316:.ascii "Sticky bit used incorrectly or not at all.\012\000"
L315:.ascii "Sticky bit apparently used correctly.\012\000"
L298:.ascii "Checking for sticky bit.\012\000"
L295:.ascii "(X - Y) + (Y - X) is non zero!\012\000"
L292:.ascii "Addition/Subtraction neither rounds nor chops.\012\000"
L291:.ascii "Add/Subtract\000"
L288:.ascii "Addition/Subtraction appears to round correctly.\012\000"
L281:.ascii "Add/Subtract appears to be chopped.\012\000"
L276:.ascii "Incomplete carry-propagation in Addition\000"
L272:.ascii "Radix * ( 1 / Radix ) differs from 1\000"
L270:.ascii "/ is neither chopped nor correctly rounded.\012\000"
L267:.ascii "Division appears to chop.\012\000"
L264:.ascii "Division\000"
L261:.ascii "Division appears to round correctly.\012\000"
L256:.ascii "Multiplication\000"
L253:.ascii "* is neither chopped nor correctly rounded.\012\000"
L252:.ascii "Multiplication appears to chop.\012\000"
L249:.ascii "Multiplication appears to round correctly.\012\000"
L239:.ascii "X * (1/X) differs from 1\000"
L220:.ascii "Checking rounding on multiply, divide and add/subtract.\012\000"
L219:.ascii "     *, /, and - appear to have guard digits, as they should.\012"
.ascii "\000"
L216:.ascii "  ...  if (X == 1.0) {.....} else {.../(X-1.0)...}\012\000"
L215:.ascii "  such precautions against division by zero as\012\000"
L214:.ascii "  subtraction yields  (1-U1) - 1 = 0 , thereby vitiating\012\000"
L213:.ascii "comparison alleges  (1-U1) < 1  although\012\000"
L210:.ascii "- lacks Guard Digit, so cancellation is obscured\000"
L205:.ascii "* and/or / gets too many last digits wrong\000"
L201:.ascii "Computed value of 1/1.000..1 >= 1\000"
L199:.ascii "Division lacks a Guard Digit, so X/1 != X\000"
L194:.ascii "Division lacks a Guard Digit, so error can exceed 1 ulp\012or  1"
.ascii "/3  and  3/9  and  9/27 may disagree\000"
L190:.ascii "* gets too many final digits wrong.\012\000"
L188:.ascii "* lacks a Guard Digit, so 1*X != X\000"
L185:.ascii "\012Checking for guard digit in *, /, and -.\012\000"
L184:.ascii "Subtraction appears to be normalized, as it should be.\000"
L179:.ascii "Subtraction is not normalized X=Y,X+Z != Y+Z!\000"
L175:.ascii "roughly %g extra significant decimals.\012\000"
L174:.ascii "precisely with about %g extra B-digits, i.e.\012\000"
L173:.ascii "Some subexpressions appear to be calculated extra\012\000"
L167:.ascii "of an\012extra-precision\000"
L166:.ascii "Z1 = %.7e, or Z2 = %.7e \000"
L165:.ascii ", or exact rational arithmetic a result\012\000"
L164:.ascii "Because of unusual Radix = %f\000"
L160:.ascii "\011U2 = %.7e, Z2 - U2 = %.7e\012\000"
L159:.ascii "\011U1 = %.7e, Z1 - U1 = %.7e\012\000"
L158:.ascii "Precision\000"
L157:.byte 0
L150:.ascii "That feature is not tested further by this program.\012\000"
L145:.ascii "Possibly some part of this\000"
L144:.ascii "by extra-precise evaluation of arithmetic subexpressions.\012\000"
L143:.ascii "are symptoms of inconsistencies introduced\012\000"
L142:.ascii "respectively  %.7e,  %.7e,  %.7e,\012\000"
L141:.ascii "Disagreements among the values X1, Y1, Z1,\012\000"
L119:.ascii "Precision worse than 5 decimal figures  \000"
L117:.ascii "The number of significant digits of the Radix is %f .\012\000"
L116:.ascii "logarithmic encoding has precision characterized solely by U1.\012"
.ascii "\000"
L113:.ascii "of significant digits but, by itself, this is a minor flaw.\012\000"
L112:.ascii "Precision cannot be characterized by an Integer number\012\000"
L99:.ascii "Comparison is fuzzy,X=1 but X-1/2-1/2 != 0\000"
L95:.ascii "(1-U1)-1/2 < 1/2 is FALSE, prog. fails?\000"
.align 8; L93:.word 0x40240000,0x0
L88:.ascii "Radix is not as good as 2 or 10\000"
L84:.ascii "Radix is too big: roundoff problems\000"
L82:.ascii "MYSTERY: recalculated Radix = %.7e .\012\000"
L81:.ascii "Radix confirmed.\012\000"
.align 8; L78:.word 0x3f847ae1,0x47ae147a
L77:.ascii "gets better closest relative separation U1 = %.7e .\012\000"
L76:.ascii "confirms closest relative separation U1 .\012\000"
L61:.ascii "Recalculating radix and precision\012 \000"
L60:.ascii "Closest relative separation found is U1 = %.7e .\012\012\000"
L54:.ascii "Radix = %f .\012\000"
L45:.ascii "Searching for Radix and Precision.\012\000"
L44:.byte 10,0
L43:.ascii "-1, 0, 1/2, 1, 2, 3, 4, 5, 9, 27, 32 & 240 are O.K.\012\000"
L38:.ascii "5 != 4+1, 240/3 != 80, 240/4 != 60, or 240/5 != 48\000"
L34:.ascii "9 != 3*3, 27 != 9*3, 32 != 8*4, or 32-27-4-1 != 0\000"
L30:.ascii "1/2 + (-1) + 1/2 != 0\000"
L26:.ascii "-1+1 != 0, (-1)+abs(1) != 0, or -1+(-1)*(-1) != 0\000"
L22:.ascii "3 != 2+1, 4 != 3+1, 4+2*(-2) != 0, or 4-3-1 != 0\000"
.align 8; L20:.word 0x3f50624d,0xd2f1a9fb
L19:.ascii "Comparison alleges that -0.0 is Non-zero!\012\000"
L14:.ascii "0+0 != 0, 1-1 != 0, 1 <= 0, or 1+1 != 2\000"
L12:.ascii "Program is now RUNNING tests on small integers:\012\000"
.align 8; L8:.word 0x3ff00000,0x0
.align 8; L7:.word 0x0,0x0
L2:.ascii "\012* * * FLOATING-POINT ERROR * * *\012\000"
