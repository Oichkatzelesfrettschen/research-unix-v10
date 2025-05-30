.set reorder
.globl Zero
.sdata; .align 3; Zero:.word 0x0
.word 0x0
.globl Half
.sdata; .align 3; Half:.word 0x3fe00000
.word 0x0
.globl One
.sdata; .align 3; One:.word 0x3ff00000
.word 0x0
.globl Two
.sdata; .align 3; Two:.word 0x40000000
.word 0x0
.globl Three
.sdata; .align 3; Three:.word 0x40080000
.word 0x0
.globl Four
.sdata; .align 3; Four:.word 0x40100000
.word 0x0
.globl Five
.sdata; .align 3; Five:.word 0x40140000
.word 0x0
.globl Eight
.sdata; .align 3; Eight:.word 0x40200000
.word 0x0
.globl Nine
.sdata; .align 3; Nine:.word 0x40220000
.word 0x0
.globl TwentySeven
.sdata; .align 3; TwentySeven:.word 0x403b0000
.word 0x0
.globl ThirtyTwo
.sdata; .align 3; ThirtyTwo:.word 0x40400000
.word 0x0
.globl TwoForty
.sdata; .align 3; TwoForty:.word 0x406e0000
.word 0x0
.globl MinusOne
.sdata; .align 3; MinusOne:.word 0xbff00000
.word 0x0
.globl OneAndHalf
.sdata; .align 3; OneAndHalf:.word 0x3ff80000
.word 0x0
.globl NoTrials
.sdata; .align 2; NoTrials:.word 0x14
.text
.globl sigfpe
.text
.align 2; .ent sigfpe
sigfpe:
$fp1=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
sw $4,24($sp)
lw $25,fpecount
addu $25,$25,1
sw $25,fpecount
la $4,L.2
jal printf  # int
la $4,_iob+16
jal fflush  # int
lw $25,sigsave
beq $25,$0,L.4
li $4,8
lw $5,sigsave
jal signal  # int
sw $0,sigsave
la $4,ovfl_buf
li $5,1
jal longjmp  # int
L.4:
jal abort  # int
L.1:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end sigfpe
.data; .align 2; L.759:.word L.760
.word L.761
.word L.762
.word L.763
.text
.globl main
.text
.align 2; .ent main
main:
$fp2=64
.frame $sp,64,$31
addu $sp,$sp,-64
.fmask 0xfc000000,-16
s.d $f26,32($sp)
s.d $f28,40($sp)
s.d $f30,48($sp)
.mask 0xc0000000,-4
sw $30,56($sp)
sw $31,60($sp)
l.d $f18,L.7
s.d $f18,Zero
l.d $f18,L.8
s.d $f18,One
l.d $f18,One
add.d $f16,$f18,$f18
s.d $f16,Two
l.d $f16,Two
add.d $f10,$f16,$f18
s.d $f10,Three
l.d $f10,Three
add.d $f8,$f10,$f18
s.d $f8,Four
l.d $f8,Four
add.d $f6,$f8,$f18
s.d $f6,Five
add.d $f6,$f8,$f8
s.d $f6,Eight
mul.d $f6,$f10,$f10
s.d $f6,Nine
l.d $f6,Nine
mul.d $f6,$f6,$f10
s.d $f6,TwentySeven
l.d $f6,Eight
mul.d $f6,$f8,$f6
s.d $f6,ThirtyTwo
l.d $f6,Five
mul.d $f6,$f8,$f6
mul.d $f10,$f6,$f10
mul.d $f10,$f10,$f8
s.d $f10,TwoForty
neg.d $f10,$f18
s.d $f10,MinusOne
div.d $f16,$f18,$f16
s.d $f16,Half
l.d $f16,Half
add.d $f18,$f18,$f16
s.d $f18,OneAndHalf
sw $0,ErrCnt
sw $0,ErrCnt+4
sw $0,ErrCnt+8
sw $0,ErrCnt+12
li $25,1
sw $25,PageNo
sw $0,Milestone
li $4,8
la $5,sigfpe
jal signal  # int
jal Instructions  # int
jal Pause  # int
jal Heading  # int
jal Pause  # int
jal Characteristics  # int
jal Pause  # int
jal History  # int
jal Pause  # int
li $25,7
sw $25,Milestone
la $4,L.12
jal printf  # int
move $4,$0
l.d $f18,Zero
add.d $f16,$f18,$f18
c.eq.d $f16,$f18; bc1f L.15
l.d $f16,One
sub.d $f10,$f16,$f16
c.eq.d $f10,$f18; bc1f L.15
c.le.d $f16,$f18; bc1t L.15
add.d $f18,$f16,$f16
l.d $f16,Two
c.eq.d $f18,$f16; bc1f L.15
li $30,1
b L.16
L.15:
move $30,$0
L.16:
move $5,$30
la $6,L.14
jal TstCond  # int
l.d $f18,Zero
neg.d $f18,$f18
s.d $f18,Z
l.d $f18,Z
l.d $f16,L.7
c.eq.d $f18,$f16; bc1t L.17
lw $25,ErrCnt
addu $25,$25,1
sw $25,ErrCnt
la $4,L.19
jal printf  # int
l.d $f18,L.20
s.d $f18,U1
l.d $f18,L.8
s.d $f18,Radix
jal TstPtUf  # int
L.17:
move $4,$0
l.d $f18,Three
l.d $f16,Two
l.d $f10,One
add.d $f8,$f16,$f10
c.eq.d $f18,$f8; bc1f L.23
l.d $f8,Four
add.d $f6,$f18,$f10
c.eq.d $f8,$f6; bc1f L.23
neg.d $f6,$f16
mul.d $f16,$f16,$f6
add.d $f16,$f8,$f16
l.d $f6,Zero
c.eq.d $f16,$f6; bc1f L.23
sub.d $f18,$f8,$f18
sub.d $f18,$f18,$f10
c.eq.d $f18,$f6; bc1f L.23
li $30,1
b L.24
L.23:
move $30,$0
L.24:
move $5,$30
la $6,L.22
jal TstCond  # int
l.d $f18,MinusOne
mov.d $f30,$f18
l.d $f16,L.7
l.d $f10,One
sub.d $f16,$f16,$f10
c.eq.d $f18,$f16; bc1f L.27
add.d $f16,$f18,$f10
l.d $f8,Zero
c.eq.d $f16,$f8; bc1f L.27
add.d $f16,$f10,$f18
c.eq.d $f16,$f8; bc1f L.27
mov.d $f12,$f10
jal fabs  # real
add.d $f18,$f30,$f0
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.27
l.d $f18,MinusOne
mul.d $f10,$f18,$f18
add.d $f18,$f18,$f10
c.eq.d $f18,$f16; bc1f L.27
li $30,1
b L.28
L.27:
move $30,$0
L.28:
move $4,$0
move $5,$30
la $6,L.26
jal TstCond  # int
move $4,$0
l.d $f18,Half
l.d $f16,MinusOne
add.d $f16,$f18,$f16
add.d $f18,$f16,$f18
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.31
li $30,1
b L.32
L.31:
move $30,$0
L.32:
move $5,$30
la $6,L.30
jal TstCond  # int
li $25,10
sw $25,Milestone
move $4,$0
l.d $f18,Nine
l.d $f16,Three
mul.d $f10,$f16,$f16
c.eq.d $f18,$f10; bc1f L.35
l.d $f10,TwentySeven
mul.d $f18,$f18,$f16
c.eq.d $f10,$f18; bc1f L.35
l.d $f18,Eight
l.d $f16,Four
add.d $f8,$f16,$f16
c.eq.d $f18,$f8; bc1f L.35
l.d $f8,ThirtyTwo
mul.d $f18,$f18,$f16
c.eq.d $f8,$f18; bc1f L.35
sub.d $f18,$f8,$f10
sub.d $f18,$f18,$f16
l.d $f16,One
sub.d $f18,$f18,$f16
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.35
li $30,1
b L.36
L.35:
move $30,$0
L.36:
move $5,$30
la $6,L.34
jal TstCond  # int
move $4,$0
l.d $f18,Five
l.d $f16,Four
l.d $f10,One
add.d $f10,$f16,$f10
c.eq.d $f18,$f10; bc1f L.39
l.d $f10,TwoForty
mov.d $f30,$f10
mul.d $f8,$f16,$f18
l.d $f6,Three
mul.d $f8,$f8,$f6
mul.d $f8,$f8,$f16
c.eq.d $f10,$f8; bc1f L.39
div.d $f8,$f10,$f6
mul.d $f4,$f16,$f16
mul.d $f4,$f4,$f18
sub.d $f8,$f8,$f4
l.d $f4,Zero
c.eq.d $f8,$f4; bc1f L.39
div.d $f8,$f10,$f16
mul.d $f10,$f18,$f6
mul.d $f10,$f10,$f16
sub.d $f10,$f8,$f10
c.eq.d $f10,$f4; bc1f L.39
div.d $f18,$f30,$f18
mul.d $f10,$f16,$f6
mul.d $f16,$f10,$f16
sub.d $f18,$f18,$f16
c.eq.d $f18,$f4; bc1f L.39
li $30,1
b L.40
L.39:
move $30,$0
L.40:
move $5,$30
la $6,L.38
jal TstCond  # int
lw $25,ErrCnt
bne $25,$0,L.41
la $4,L.43
jal printf  # int
la $4,L.44
jal printf  # int
L.41:
la $4,L.45
jal printf  # int
l.d $f18,One
s.d $f18,W
L.46:
l.d $f18,W
add.d $f18,$f18,$f18
s.d $f18,W
l.d $f18,W
l.d $f16,One
add.d $f10,$f18,$f16
s.d $f10,Y
l.d $f10,Y
sub.d $f18,$f10,$f18
s.d $f18,Z
l.d $f18,Z
sub.d $f18,$f18,$f16
s.d $f18,Y
L.47:
l.d $f12,Y
jal fabs  # real
l.d $f18,MinusOne
add.d $f18,$f18,$f0
l.d $f16,Zero
c.lt.d $f18,$f16; bc1t L.46
l.d $f18,Zero
s.d $f18,Precision
l.d $f18,One
s.d $f18,Y
L.49:
l.d $f18,W
l.d $f16,Y
add.d $f10,$f18,$f16
s.d $f10,Radix
add.d $f16,$f16,$f16
s.d $f16,Y
l.d $f16,Radix
sub.d $f18,$f16,$f18
s.d $f18,Radix
L.50:
l.d $f18,Radix
l.d $f16,Zero
c.eq.d $f18,$f16; bc1t L.49
l.d $f18,Radix
l.d $f16,Two
c.lt.d $f18,$f16; bc1f L.52
l.d $f18,One
s.d $f18,Radix
L.52:
la $4,L.54
l.d $f18,Radix
mfc1.d $6,$f18
jal printf  # int
l.d $f18,Radix
l.d $f16,L.8
c.eq.d $f18,$f16; bc1t L.55
l.d $f18,One
s.d $f18,W
L.57:
l.d $f18,Precision
l.d $f16,One
add.d $f18,$f18,$f16
s.d $f18,Precision
l.d $f18,W
l.d $f10,Radix
mul.d $f18,$f18,$f10
s.d $f18,W
l.d $f18,W
add.d $f18,$f18,$f16
s.d $f18,Y
L.58:
l.d $f18,Y
l.d $f16,W
sub.d $f18,$f18,$f16
l.d $f16,One
c.eq.d $f18,$f16; bc1t L.57
L.55:
l.d $f18,One
l.d $f16,W
div.d $f18,$f18,$f16
s.d $f18,U1
l.d $f18,Radix
l.d $f16,U1
mul.d $f18,$f18,$f16
s.d $f18,U2
la $4,L.60
mfc1.d $6,$f16
jal printf  # int
la $4,L.61
jal printf  # int
l.d $f18,Radix
s.d $f18,E0
l.d $f18,U1
s.d $f18,E1
l.d $f18,U2
s.d $f18,E9
l.d $f18,Precision
s.d $f18,E3
l.d $f18,Four
l.d $f16,Three
div.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,X
l.d $f16,One
sub.d $f18,$f18,$f16
s.d $f18,Third
l.d $f18,Half
l.d $f16,Third
sub.d $f18,$f18,$f16
s.d $f18,F6
l.d $f18,F6
add.d $f18,$f18,$f18
s.d $f18,X
l.d $f18,X
sub.d $f12,$f18,$f16
jal fabs  # real
s.d $f0,X
l.d $f18,X
l.d $f16,U2
c.lt.d $f18,$f16; bc1f L.62
l.d $f18,U2
s.d $f18,X
L.62:
L.64:
l.d $f18,X
s.d $f18,U2
l.d $f18,Half
l.d $f16,U2
mul.d $f18,$f18,$f16
l.d $f10,ThirtyTwo
mul.d $f10,$f10,$f16
mul.d $f16,$f10,$f16
add.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,One
l.d $f16,Y
add.d $f16,$f18,$f16
s.d $f16,Y
l.d $f16,Y
sub.d $f18,$f16,$f18
s.d $f18,X
L.65:
l.d $f18,U2
l.d $f16,X
c.le.d $f18,$f16; bc1t L.67
l.d $f18,Zero
c.le.d $f16,$f18; bc1f L.64
L.67:
l.d $f18,Two
l.d $f16,Three
div.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,X
l.d $f16,Half
sub.d $f18,$f18,$f16
s.d $f18,F6
l.d $f18,F6
add.d $f10,$f18,$f18
s.d $f10,Third
l.d $f10,Third
sub.d $f16,$f10,$f16
s.d $f16,X
l.d $f16,X
add.d $f12,$f16,$f18
jal fabs  # real
s.d $f0,X
l.d $f18,X
l.d $f16,U1
c.lt.d $f18,$f16; bc1f L.68
l.d $f18,U1
s.d $f18,X
L.68:
L.70:
l.d $f18,X
s.d $f18,U1
l.d $f18,Half
l.d $f16,U1
mul.d $f10,$f18,$f16
l.d $f8,ThirtyTwo
mul.d $f8,$f8,$f16
mul.d $f16,$f8,$f16
add.d $f16,$f10,$f16
s.d $f16,Y
l.d $f16,Y
sub.d $f16,$f18,$f16
s.d $f16,Y
l.d $f16,Y
add.d $f16,$f18,$f16
s.d $f16,X
l.d $f16,X
sub.d $f16,$f18,$f16
s.d $f16,Y
l.d $f16,Y
add.d $f18,$f18,$f16
s.d $f18,X
L.71:
l.d $f18,U1
l.d $f16,X
c.le.d $f18,$f16; bc1t L.73
l.d $f18,Zero
c.le.d $f16,$f18; bc1f L.70
L.73:
l.d $f18,U1
l.d $f16,E1
c.eq.d $f18,$f16; bc1f L.74
la $4,L.76
jal printf  # int
b L.75
L.74:
la $4,L.77
l.d $f18,U1
mfc1.d $6,$f18
jal printf  # int
L.75:
l.d $f18,One
l.d $f16,U1
div.d $f18,$f18,$f16
s.d $f18,W
l.d $f18,Half
sub.d $f10,$f18,$f16
add.d $f18,$f10,$f18
s.d $f18,F9
l.d $f18,U2
div.d $f18,$f18,$f16
l.d $f16,L.78
add.d $f12,$f18,$f16
jal floor  # real
s.d $f0,Radix
l.d $f18,Radix
l.d $f16,E0
c.eq.d $f18,$f16; bc1f L.79
la $4,L.81
jal printf  # int
b L.80
L.79:
la $4,L.82
l.d $f18,Radix
mfc1.d $6,$f18
jal printf  # int
L.80:
li $4,2
l.d $f18,Radix
l.d $f16,Eight
add.d $f16,$f16,$f16
c.le.d $f18,$f16; bc1f L.85
li $30,1
b L.86
L.85:
move $30,$0
L.86:
move $5,$30
la $6,L.84
jal TstCond  # int
li $4,3
l.d $f18,Radix
l.d $f16,Two
c.eq.d $f18,$f16; bc1t L.92
l.d $f16,L.93
c.eq.d $f18,$f16; bc1t L.92
l.d $f16,One
c.eq.d $f18,$f16; bc1f L.89
L.92:
li $30,1
b L.90
L.89:
move $30,$0
L.90:
move $5,$30
la $6,L.88
jal TstCond  # int
li $25,20
sw $25,Milestone
move $4,$0
l.d $f18,F9
l.d $f16,Half
sub.d $f18,$f18,$f16
c.lt.d $f18,$f16; bc1f L.96
li $30,1
b L.97
L.96:
move $30,$0
L.97:
move $5,$30
la $6,L.95
jal TstCond  # int
l.d $f18,F9
s.d $f18,X
li $25,1
sw $25,I
l.d $f18,X
l.d $f16,Half
sub.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,Y
sub.d $f18,$f18,$f16
s.d $f18,Z
move $4,$0
l.d $f18,X
l.d $f16,One
c.eq.d $f18,$f16; bc1f L.102
l.d $f18,Z
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.100
L.102:
li $30,1
b L.101
L.100:
move $30,$0
L.101:
move $5,$30
la $6,L.99
jal TstCond  # int
l.d $f18,One
l.d $f16,U2
add.d $f10,$f18,$f16
s.d $f10,X
sw $0,I
li $25,25
sw $25,Milestone
l.d $f10,Radix
sub.d $f8,$f10,$f18
s.d $f8,BMinusU2
l.d $f8,BMinusU2
sub.d $f16,$f8,$f16
add.d $f16,$f16,$f18
s.d $f16,BMinusU2
c.eq.d $f10,$f18; bc1t L.103
l.d $f12,U1
jal log  # real
mov.d $f30,$f0
l.d $f12,Radix
jal log  # real
l.d $f18,TwoForty
neg.d $f18,$f18
mul.d $f18,$f18,$f30
div.d $f18,$f18,$f0
s.d $f18,X
l.d $f18,Half
l.d $f16,X
add.d $f12,$f18,$f16
jal floor  # real
s.d $f0,Y
l.d $f18,X
l.d $f16,Y
sub.d $f12,$f18,$f16
jal fabs  # real
l.d $f18,Four
mul.d $f18,$f0,$f18
l.d $f16,One
c.lt.d $f18,$f16; bc1f L.105
l.d $f18,Y
s.d $f18,X
L.105:
l.d $f18,X
l.d $f16,TwoForty
div.d $f18,$f18,$f16
s.d $f18,Precision
l.d $f18,Half
l.d $f16,Precision
add.d $f12,$f18,$f16
jal floor  # real
s.d $f0,Y
l.d $f18,Precision
l.d $f16,Y
sub.d $f12,$f18,$f16
jal fabs  # real
l.d $f18,TwoForty
mul.d $f18,$f0,$f18
l.d $f16,Half
c.lt.d $f18,$f16; bc1f L.107
l.d $f18,Y
s.d $f18,Precision
L.107:
L.103:
l.d $f18,Precision
mov.d $f30,$f18
mov.d $f12,$f18
jal floor  # real
c.eq.d $f30,$f0; bc1f L.111
l.d $f18,Radix
l.d $f16,One
c.eq.d $f18,$f16; bc1f L.109
L.111:
la $4,L.112
jal printf  # int
la $4,L.113
jal printf  # int
L.109:
l.d $f18,Radix
l.d $f16,One
c.eq.d $f18,$f16; bc1f L.114
la $4,L.116
jal printf  # int
b L.115
L.114:
la $4,L.117
l.d $f18,Precision
mfc1.d $6,$f18
jal printf  # int
L.115:
li $4,1
l.d $f18,U2
l.d $f16,Nine
mul.d $f18,$f18,$f16
mul.d $f18,$f18,$f16
l.d $f16,TwoForty
mul.d $f18,$f18,$f16
l.d $f16,One
c.lt.d $f18,$f16; bc1f L.120
li $30,1
b L.121
L.120:
move $30,$0
L.121:
move $5,$30
la $6,L.119
jal TstCond  # int
li $25,30
sw $25,Milestone
l.d $f18,Four
l.d $f16,Three
div.d $f10,$f18,$f16
l.d $f8,One
sub.d $f10,$f10,$f8
div.d $f18,$f8,$f18
sub.d $f10,$f10,$f18
mul.d $f16,$f10,$f16
sub.d $f12,$f16,$f18
jal fabs  # real
s.d $f0,X
L.122:
l.d $f18,X
s.d $f18,Z2
l.d $f18,One
l.d $f16,Half
l.d $f10,Z2
mul.d $f16,$f16,$f10
l.d $f8,ThirtyTwo
mul.d $f8,$f8,$f10
mul.d $f10,$f8,$f10
add.d $f16,$f16,$f10
add.d $f16,$f18,$f16
sub.d $f18,$f16,$f18
s.d $f18,X
L.123:
l.d $f18,Z2
l.d $f16,X
c.le.d $f18,$f16; bc1t L.125
l.d $f18,Zero
c.le.d $f16,$f18; bc1f L.122
L.125:
l.d $f18,Three
l.d $f16,Four
div.d $f10,$f18,$f16
l.d $f8,Two
div.d $f8,$f8,$f18
sub.d $f10,$f10,$f8
mul.d $f18,$f10,$f18
l.d $f10,One
div.d $f16,$f10,$f16
sub.d $f12,$f18,$f16
jal fabs  # real
s.d $f0,Z
s.d $f0,Y
s.d $f0,X
L.126:
l.d $f18,Z
s.d $f18,Z1
l.d $f18,One
l.d $f16,Two
div.d $f18,$f18,$f16
l.d $f16,Half
l.d $f10,Z1
mul.d $f16,$f16,$f10
l.d $f8,ThirtyTwo
mul.d $f8,$f8,$f10
mul.d $f10,$f8,$f10
add.d $f16,$f16,$f10
sub.d $f16,$f18,$f16
add.d $f16,$f16,$f18
sub.d $f16,$f18,$f16
add.d $f18,$f16,$f18
s.d $f18,Z
L.127:
l.d $f18,Z1
l.d $f16,Z
c.le.d $f18,$f16; bc1t L.129
l.d $f18,Zero
c.le.d $f16,$f18; bc1f L.126
L.129:
L.130:
L.133:
l.d $f18,Y
s.d $f18,Y1
l.d $f18,Half
l.d $f16,Y1
mul.d $f10,$f18,$f16
l.d $f8,ThirtyTwo
mul.d $f8,$f8,$f16
mul.d $f16,$f8,$f16
add.d $f16,$f10,$f16
sub.d $f16,$f18,$f16
add.d $f16,$f16,$f18
sub.d $f16,$f18,$f16
add.d $f18,$f16,$f18
s.d $f18,Y
L.134:
l.d $f18,Y1
l.d $f16,Y
c.le.d $f18,$f16; bc1t L.136
l.d $f18,Zero
c.le.d $f16,$f18; bc1f L.133
L.136:
l.d $f18,X
s.d $f18,X1
l.d $f18,Half
l.d $f16,X1
mul.d $f18,$f18,$f16
l.d $f10,ThirtyTwo
mul.d $f10,$f10,$f16
mul.d $f16,$f10,$f16
add.d $f18,$f18,$f16
l.d $f16,F9
sub.d $f18,$f18,$f16
add.d $f18,$f18,$f16
s.d $f18,X
L.131:
l.d $f18,X1
l.d $f16,X
c.le.d $f18,$f16; bc1t L.137
l.d $f18,Zero
c.le.d $f16,$f18; bc1f L.130
L.137:
l.d $f18,X1
l.d $f16,Y1
c.eq.d $f18,$f16; bc1f L.140
l.d $f16,Z1
c.eq.d $f18,$f16; bc1t L.138
L.140:
li $4,1
la $5,L.141
jal BadCond  # int
la $4,L.142
l.d $f18,X1
mfc1.d $6,$f18
l.d $f18,Y1
s.d $f18,16($sp)
l.d $f18,Z1
s.d $f18,24($sp)
jal printf  # int
la $4,L.143
jal printf  # int
la $4,L.144
jal printf  # int
la $4,L.145
jal notify  # int
l.d $f18,X1
l.d $f16,U1
c.eq.d $f18,$f16; bc1t L.149
l.d $f18,Y1
c.eq.d $f18,$f16; bc1t L.149
l.d $f18,Z1
c.eq.d $f18,$f16; bc1f L.139
L.149:
la $4,L.150
jal printf  # int
b L.139
L.138:
l.d $f18,Z1
l.d $f16,U1
c.eq.d $f18,$f16; bc1f L.153
l.d $f18,Z2
l.d $f16,U2
c.eq.d $f18,$f16; bc1t L.151
L.153:
l.d $f18,Z1
l.d $f16,U1
c.lt.d $f18,$f16; bc1f L.156
l.d $f18,Z2
l.d $f16,U2
c.lt.d $f18,$f16; bc1t L.154
L.156:
move $4,$0
la $5,L.157
jal BadCond  # int
la $4,L.158
jal notify  # int
la $4,L.159
l.d $f18,U1
mfc1.d $6,$f18
l.d $f16,Z1
sub.d $f18,$f16,$f18
s.d $f18,16($sp)
jal printf  # int
la $4,L.160
l.d $f18,U2
mfc1.d $6,$f18
l.d $f16,Z2
sub.d $f18,$f16,$f18
s.d $f18,16($sp)
jal printf  # int
b L.155
L.154:
l.d $f18,Z1
l.d $f16,Zero
c.le.d $f18,$f16; bc1t L.163
l.d $f18,Z2
c.le.d $f18,$f16; bc1f L.161
L.163:
la $4,L.164
l.d $f18,Radix
mfc1.d $6,$f18
jal printf  # int
la $4,L.165
jal printf  # int
la $4,L.166
l.d $f18,Z1
mfc1.d $6,$f18
l.d $f18,Z2
s.d $f18,16($sp)
jal printf  # int
la $4,L.167
jal notify  # int
L.161:
l.d $f18,Z1
l.d $f16,Z2
c.eq.d $f18,$f16; bc1f L.170
l.d $f16,Zero
c.le.d $f18,$f16; bc1t L.168
L.170:
l.d $f18,Z1
l.d $f16,U1
div.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,Z2
l.d $f16,U2
div.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,Y
l.d $f16,X
c.le.d $f18,$f16; bc1t L.171
l.d $f18,Y
s.d $f18,X
L.171:
l.d $f12,X
jal log  # real
neg.d $f18,$f0
s.d $f18,Q
la $4,L.173
jal printf  # int
l.d $f12,Radix
jal log  # real
la $4,L.174
l.d $f18,Q
div.d $f18,$f18,$f0
mfc1.d $6,$f18
jal printf  # int
l.d $f12,L.93
jal log  # real
la $4,L.175
l.d $f18,Q
div.d $f18,$f18,$f0
mfc1.d $6,$f18
jal printf  # int
L.168:
la $4,L.150
jal printf  # int
L.155:
L.151:
L.139:
jal Pause  # int
li $25,35
sw $25,Milestone
l.d $f18,Radix
l.d $f16,Two
c.lt.d $f18,$f16; bc1t L.176
l.d $f18,W
l.d $f16,Radix
mul.d $f16,$f16,$f16
div.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,X
l.d $f16,One
add.d $f16,$f18,$f16
s.d $f16,Y
l.d $f16,Y
sub.d $f18,$f16,$f18
s.d $f18,Z
l.d $f18,Z
l.d $f16,U2
add.d $f16,$f18,$f16
s.d $f16,T
l.d $f16,T
sub.d $f18,$f16,$f18
s.d $f18,X
move $4,$0
l.d $f18,X
l.d $f16,U2
c.eq.d $f18,$f16; bc1f L.180
li $30,1
b L.181
L.180:
move $30,$0
L.181:
move $5,$30
la $6,L.179
jal TstCond  # int
l.d $f18,X
l.d $f16,U2
c.eq.d $f18,$f16; bc1f L.182
la $4,L.184
jal printf  # int
L.182:
L.176:
la $4,L.185
jal printf  # int
l.d $f18,F9
l.d $f16,One
mul.d $f10,$f18,$f16
s.d $f10,Y
mul.d $f10,$f16,$f18
s.d $f10,Z
l.d $f10,Half
sub.d $f18,$f18,$f10
s.d $f18,X
l.d $f18,Y
sub.d $f18,$f18,$f10
l.d $f8,X
sub.d $f18,$f18,$f8
s.d $f18,Y
l.d $f18,Z
sub.d $f18,$f18,$f10
sub.d $f18,$f18,$f8
s.d $f18,Z
l.d $f18,U2
add.d $f10,$f16,$f18
s.d $f10,X
l.d $f10,X
l.d $f8,Radix
mul.d $f6,$f10,$f8
s.d $f6,T
mul.d $f10,$f8,$f10
s.d $f10,R
l.d $f10,T
sub.d $f10,$f10,$f8
s.d $f10,X
l.d $f10,X
mul.d $f18,$f8,$f18
sub.d $f10,$f10,$f18
s.d $f10,X
l.d $f10,R
sub.d $f10,$f10,$f8
s.d $f10,T
l.d $f10,T
sub.d $f18,$f10,$f18
s.d $f18,T
l.d $f18,X
sub.d $f16,$f8,$f16
mul.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,T
mul.d $f18,$f18,$f16
s.d $f18,T
l.d $f18,X
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.186
l.d $f18,Y
c.eq.d $f18,$f16; bc1f L.186
l.d $f18,Z
c.eq.d $f18,$f16; bc1f L.186
l.d $f18,T
c.eq.d $f18,$f16; bc1f L.186
li $25,1
sw $25,GMult
b L.187
L.186:
sw $0,GMult
li $4,1
move $5,$0
la $6,L.188
jal TstCond  # int
L.187:
l.d $f18,Radix
l.d $f16,U2
mul.d $f18,$f18,$f16
s.d $f18,Z
l.d $f18,One
l.d $f16,Z
add.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,X
add.d $f16,$f18,$f16
mul.d $f18,$f18,$f18
sub.d $f12,$f16,$f18
jal fabs  # real
l.d $f18,U2
sub.d $f16,$f0,$f18
s.d $f16,Y
l.d $f16,One
sub.d $f16,$f16,$f18
s.d $f16,X
l.d $f16,X
sub.d $f18,$f16,$f18
mul.d $f16,$f16,$f16
sub.d $f12,$f18,$f16
jal fabs  # real
l.d $f18,U1
sub.d $f18,$f0,$f18
s.d $f18,Z
move $4,$0
l.d $f18,Y
l.d $f16,Zero
c.le.d $f18,$f16; bc1f L.191
l.d $f18,Z
c.le.d $f18,$f16; bc1f L.191
li $30,1
b L.192
L.191:
move $30,$0
L.192:
move $5,$30
la $6,L.190
jal TstCond  # int
l.d $f18,One
l.d $f16,U2
sub.d $f10,$f18,$f16
s.d $f10,Y
add.d $f16,$f18,$f16
s.d $f16,X
l.d $f16,Y
div.d $f16,$f18,$f16
s.d $f16,Z
l.d $f16,Z
l.d $f10,X
sub.d $f16,$f16,$f10
s.d $f16,Y
l.d $f16,Three
div.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,Nine
div.d $f16,$f16,$f18
s.d $f16,Z
l.d $f16,X
l.d $f10,Z
sub.d $f16,$f16,$f10
s.d $f16,X
l.d $f16,TwentySeven
div.d $f18,$f18,$f16
s.d $f18,T
l.d $f18,T
sub.d $f18,$f10,$f18
s.d $f18,Z
li $4,2
l.d $f18,X
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.195
l.d $f18,Y
c.eq.d $f18,$f16; bc1f L.195
l.d $f18,Z
c.eq.d $f18,$f16; bc1f L.195
li $30,1
b L.196
L.195:
move $30,$0
L.196:
move $5,$30
la $6,L.194
jal TstCond  # int
l.d $f18,F9
l.d $f16,One
div.d $f10,$f18,$f16
s.d $f10,Y
l.d $f10,Half
sub.d $f18,$f18,$f10
s.d $f18,X
l.d $f18,Y
sub.d $f18,$f18,$f10
l.d $f10,X
sub.d $f18,$f18,$f10
s.d $f18,Y
l.d $f18,U2
add.d $f18,$f16,$f18
s.d $f18,X
l.d $f18,X
div.d $f16,$f18,$f16
s.d $f16,T
l.d $f16,T
sub.d $f18,$f16,$f18
s.d $f18,X
l.d $f18,X
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.197
l.d $f18,Y
c.eq.d $f18,$f16; bc1f L.197
l.d $f18,Z
c.eq.d $f18,$f16; bc1f L.197
li $25,1
sw $25,GDiv
b L.198
L.197:
sw $0,GDiv
li $4,1
move $5,$0
la $6,L.199
jal TstCond  # int
L.198:
l.d $f18,One
l.d $f16,U2
add.d $f16,$f18,$f16
div.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,X
l.d $f16,Half
sub.d $f18,$f18,$f16
sub.d $f18,$f18,$f16
s.d $f18,Y
li $4,1
l.d $f18,Y
l.d $f16,Zero
c.lt.d $f18,$f16; bc1f L.202
li $30,1
b L.203
L.202:
move $30,$0
L.203:
move $5,$30
la $6,L.201
jal TstCond  # int
l.d $f18,One
l.d $f16,U2
sub.d $f10,$f18,$f16
s.d $f10,X
l.d $f10,Radix
mul.d $f16,$f10,$f16
add.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,X
mul.d $f16,$f18,$f10
s.d $f16,Z
l.d $f16,Y
mul.d $f8,$f16,$f10
s.d $f8,T
l.d $f8,Z
div.d $f8,$f8,$f10
s.d $f8,R
l.d $f8,T
div.d $f10,$f8,$f10
s.d $f10,StickyBit
l.d $f10,R
sub.d $f18,$f10,$f18
s.d $f18,X
l.d $f18,StickyBit
sub.d $f18,$f18,$f16
s.d $f18,Y
move $4,$0
l.d $f18,X
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.206
l.d $f18,Y
c.eq.d $f18,$f16; bc1f L.206
li $30,1
b L.207
L.206:
move $30,$0
L.207:
move $5,$30
la $6,L.205
jal TstCond  # int
l.d $f18,One
l.d $f16,U1
sub.d $f10,$f18,$f16
s.d $f10,Y
l.d $f10,F9
sub.d $f10,$f18,$f10
s.d $f10,X
l.d $f10,Y
sub.d $f18,$f18,$f10
s.d $f18,Y
l.d $f18,Radix
l.d $f10,U2
sub.d $f8,$f18,$f10
s.d $f8,T
l.d $f8,BMinusU2
sub.d $f8,$f18,$f8
s.d $f8,Z
l.d $f8,T
sub.d $f18,$f18,$f8
s.d $f18,T
l.d $f18,X
c.eq.d $f18,$f16; bc1f L.208
l.d $f18,Y
c.eq.d $f18,$f16; bc1f L.208
l.d $f18,Z
c.eq.d $f18,$f10; bc1f L.208
l.d $f18,T
c.eq.d $f18,$f10; bc1f L.208
li $25,1
sw $25,GAddSub
b L.209
L.208:
sw $0,GAddSub
li $4,1
move $5,$0
la $6,L.210
jal TstCond  # int
L.209:
l.d $f18,F9
l.d $f16,One
c.eq.d $f18,$f16; bc1t L.211
sub.d $f18,$f18,$f16
l.d $f16,Zero
c.lt.d $f18,$f16; bc1t L.211
li $4,1
la $5,L.213
jal BadCond  # int
la $4,L.214
jal printf  # int
la $4,L.215
jal printf  # int
la $4,L.216
jal printf  # int
L.211:
lw $25,GMult
bne $25,1,L.217
lw $25,GDiv
bne $25,1,L.217
lw $25,GAddSub
bne $25,1,L.217
la $4,L.219
jal printf  # int
L.217:
li $25,40
sw $25,Milestone
jal Pause  # int
la $4,L.220
jal printf  # int
sw $0,RMult
sw $0,RDiv
sw $0,RAddSub
l.d $f18,Radix
l.d $f16,Two
div.d $f18,$f18,$f16
s.d $f18,RadixD2
s.d $f16,A1
sw $0,Done
L.221:
l.d $f18,Radix
s.d $f18,AInvrse
L.224:
l.d $f18,AInvrse
s.d $f18,X
l.d $f16,A1
div.d $f18,$f18,$f16
s.d $f18,AInvrse
L.225:
l.d $f12,AInvrse
jal floor  # real
l.d $f18,AInvrse
c.eq.d $f0,$f18; bc1t L.224
l.d $f18,X
l.d $f16,One
c.eq.d $f18,$f16; bc1t L.230
l.d $f18,A1
l.d $f16,Three
c.le.d $f18,$f16; bc1t L.228
L.230:
li $30,1
b L.229
L.228:
move $30,$0
L.229:
sw $30,Done
lw $25,Done
bne $25,$0,L.231
l.d $f18,Nine
l.d $f16,One
add.d $f18,$f18,$f16
s.d $f18,A1
L.231:
L.222:
lw $25,Done
beq $25,$0,L.221
l.d $f18,X
l.d $f16,One
c.eq.d $f18,$f16; bc1f L.233
l.d $f18,Radix
s.d $f18,A1
L.233:
l.d $f18,One
l.d $f16,A1
div.d $f18,$f18,$f16
s.d $f18,AInvrse
s.d $f16,X
l.d $f18,AInvrse
s.d $f18,Y
sw $0,Done
L.235:
l.d $f18,X
l.d $f16,Y
mul.d $f18,$f18,$f16
l.d $f16,Half
sub.d $f18,$f18,$f16
s.d $f18,Z
move $4,$0
l.d $f18,Z
l.d $f16,Half
c.eq.d $f18,$f16; bc1f L.240
li $30,1
b L.241
L.240:
move $30,$0
L.241:
move $5,$30
la $6,L.239
jal TstCond  # int
l.d $f18,X
l.d $f16,Radix
c.eq.d $f18,$f16; bc1f L.243
li $30,1
b L.244
L.243:
move $30,$0
L.244:
sw $30,Done
l.d $f18,Radix
s.d $f18,X
l.d $f18,One
l.d $f16,X
div.d $f18,$f18,$f16
s.d $f18,Y
L.236:
lw $25,Done
beq $25,$0,L.235
l.d $f18,One
l.d $f16,U2
add.d $f10,$f18,$f16
s.d $f10,Y2
sub.d $f18,$f18,$f16
s.d $f18,Y1
l.d $f18,OneAndHalf
mov.d $f30,$f18
sub.d $f10,$f18,$f16
s.d $f10,X
add.d $f10,$f18,$f16
s.d $f10,Y
l.d $f10,X
sub.d $f8,$f10,$f16
l.d $f6,Y2
mul.d $f8,$f8,$f6
s.d $f8,Z
l.d $f8,Y
l.d $f4,Y1
mul.d $f18,$f8,$f4
s.d $f18,T
l.d $f18,Z
sub.d $f18,$f18,$f10
s.d $f18,Z
l.d $f18,T
sub.d $f18,$f18,$f10
s.d $f18,T
mul.d $f18,$f10,$f6
s.d $f18,X
add.d $f18,$f8,$f16
mul.d $f18,$f18,$f4
s.d $f18,Y
l.d $f18,X
sub.d $f18,$f18,$f30
s.d $f18,X
l.d $f18,Y
sub.d $f18,$f18,$f30
s.d $f18,Y
l.d $f18,X
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.245
l.d $f18,Y
c.eq.d $f18,$f16; bc1f L.245
l.d $f18,Z
c.eq.d $f18,$f16; bc1f L.245
l.d $f18,T
c.le.d $f18,$f16; bc1f L.245
l.d $f18,OneAndHalf
l.d $f16,U2
add.d $f10,$f18,$f16
l.d $f8,Y2
mul.d $f6,$f10,$f8
s.d $f6,X
sub.d $f18,$f18,$f16
sub.d $f6,$f18,$f16
s.d $f6,Y
add.d $f10,$f10,$f16
s.d $f10,Z
l.d $f10,Y1
mul.d $f18,$f18,$f10
s.d $f18,T
l.d $f18,X
l.d $f6,Z
add.d $f4,$f6,$f16
mov.d $f30,$f4
sub.d $f18,$f18,$f4
s.d $f18,X
l.d $f18,Y
mul.d $f4,$f18,$f10
s.d $f4,StickyBit
mul.d $f6,$f6,$f8
s.d $f6,S
l.d $f6,T
sub.d $f6,$f6,$f18
s.d $f6,T
sub.d $f18,$f16,$f18
l.d $f6,StickyBit
add.d $f18,$f18,$f6
s.d $f18,Y
l.d $f18,S
add.d $f6,$f30,$f16
sub.d $f18,$f18,$f6
s.d $f18,Z
add.d $f18,$f8,$f16
mul.d $f18,$f18,$f10
s.d $f18,StickyBit
mul.d $f18,$f8,$f10
s.d $f18,Y1
l.d $f18,StickyBit
sub.d $f18,$f18,$f8
s.d $f18,StickyBit
l.d $f18,Y1
l.d $f16,Half
sub.d $f18,$f18,$f16
s.d $f18,Y1
l.d $f18,X
l.d $f10,Zero
c.eq.d $f18,$f10; bc1f L.247
l.d $f18,Y
c.eq.d $f18,$f10; bc1f L.247
l.d $f18,Z
c.eq.d $f18,$f10; bc1f L.247
l.d $f18,T
c.eq.d $f18,$f10; bc1f L.247
l.d $f18,StickyBit
c.eq.d $f18,$f10; bc1f L.247
l.d $f18,Y1
c.eq.d $f18,$f16; bc1f L.247
li $25,1
sw $25,RMult
la $4,L.249
jal printf  # int
b L.248
L.247:
l.d $f18,X
l.d $f16,U2
add.d $f18,$f18,$f16
l.d $f10,Zero
c.eq.d $f18,$f10; bc1f L.250
l.d $f18,Y
c.lt.d $f18,$f10; bc1f L.250
l.d $f18,Z
add.d $f18,$f18,$f16
c.eq.d $f18,$f10; bc1f L.250
l.d $f18,T
c.lt.d $f18,$f10; bc1f L.250
l.d $f18,StickyBit
add.d $f18,$f18,$f16
c.eq.d $f18,$f10; bc1f L.250
l.d $f18,Y1
l.d $f16,Half
c.lt.d $f18,$f16; bc1f L.250
li $25,2
sw $25,RMult
la $4,L.252
jal printf  # int
b L.251
L.250:
la $4,L.253
jal printf  # int
L.251:
L.248:
lw $25,RMult
bne $25,1,L.246
lw $25,GMult
bne $25,$0,L.246
la $4,L.256
jal notify  # int
b L.246
L.245:
la $4,L.253
jal printf  # int
L.246:
li $25,45
sw $25,Milestone
l.d $f18,One
l.d $f16,U2
add.d $f10,$f18,$f16
s.d $f10,Y2
sub.d $f18,$f18,$f16
s.d $f18,Y1
l.d $f18,OneAndHalf
add.d $f10,$f18,$f16
mov.d $f30,$f10
add.d $f8,$f10,$f16
s.d $f8,Z
l.d $f8,Z
l.d $f6,Y2
div.d $f4,$f8,$f6
s.d $f4,X
sub.d $f4,$f18,$f16
sub.d $f4,$f4,$f16
s.d $f4,T
l.d $f4,T
mov.d $f28,$f4
sub.d $f10,$f4,$f16
l.d $f4,Y1
div.d $f10,$f10,$f4
s.d $f10,Y
add.d $f10,$f8,$f16
div.d $f10,$f10,$f6
s.d $f10,Z
l.d $f10,X
sub.d $f10,$f10,$f18
s.d $f10,X
l.d $f10,Y
sub.d $f10,$f10,$f28
s.d $f10,Y
div.d $f10,$f28,$f4
s.d $f10,T
l.d $f10,Z
sub.d $f10,$f10,$f30
s.d $f10,Z
sub.d $f18,$f16,$f18
l.d $f16,T
add.d $f18,$f18,$f16
s.d $f18,T
l.d $f18,X
l.d $f16,Zero
c.le.d $f18,$f16; bc1f L.257
l.d $f18,Y
c.le.d $f18,$f16; bc1f L.257
l.d $f18,Z
c.le.d $f18,$f16; bc1f L.257
l.d $f18,T
c.le.d $f18,$f16; bc1f L.257
l.d $f18,OneAndHalf
l.d $f16,Y2
div.d $f10,$f18,$f16
s.d $f10,X
l.d $f10,U2
sub.d $f8,$f18,$f10
s.d $f8,Y
add.d $f8,$f18,$f10
s.d $f8,Z
l.d $f8,X
l.d $f6,Y
sub.d $f8,$f8,$f6
s.d $f8,X
l.d $f8,Y1
div.d $f4,$f18,$f8
s.d $f4,T
div.d $f8,$f6,$f8
s.d $f8,Y
l.d $f8,T
l.d $f6,Z
add.d $f4,$f6,$f10
sub.d $f8,$f8,$f4
s.d $f8,T
l.d $f8,Y
sub.d $f8,$f8,$f6
s.d $f8,Y
div.d $f8,$f6,$f16
s.d $f8,Z
add.d $f10,$f16,$f10
div.d $f10,$f10,$f16
s.d $f10,Y1
l.d $f10,Z
sub.d $f18,$f10,$f18
s.d $f18,Z
l.d $f18,Y1
sub.d $f18,$f18,$f16
s.d $f18,Y2
l.d $f18,F9
l.d $f16,U1
sub.d $f16,$f18,$f16
div.d $f16,$f16,$f18
s.d $f16,Y1
l.d $f16,X
l.d $f10,Zero
c.eq.d $f16,$f10; bc1f L.259
l.d $f16,Y
c.eq.d $f16,$f10; bc1f L.259
l.d $f16,Z
c.eq.d $f16,$f10; bc1f L.259
l.d $f16,T
c.eq.d $f16,$f10; bc1f L.259
l.d $f16,Y2
c.eq.d $f16,$f10; bc1f L.259
c.eq.d $f16,$f10; bc1f L.259
l.d $f16,Y1
l.d $f10,Half
sub.d $f16,$f16,$f10
sub.d $f18,$f18,$f10
c.eq.d $f16,$f18; bc1f L.259
li $25,1
sw $25,RDiv
la $4,L.261
jal printf  # int
lw $25,GDiv
bne $25,$0,L.260
la $4,L.264
jal notify  # int
b L.260
L.259:
l.d $f18,X
l.d $f16,Zero
c.lt.d $f18,$f16; bc1f L.265
l.d $f18,Y
c.lt.d $f18,$f16; bc1f L.265
l.d $f18,Z
c.lt.d $f18,$f16; bc1f L.265
l.d $f18,T
c.lt.d $f18,$f16; bc1f L.265
l.d $f18,Y2
c.lt.d $f18,$f16; bc1f L.265
l.d $f18,Y1
l.d $f16,Half
sub.d $f18,$f18,$f16
l.d $f10,F9
sub.d $f16,$f10,$f16
c.lt.d $f18,$f16; bc1f L.265
li $25,2
sw $25,RDiv
la $4,L.267
jal printf  # int
L.265:
L.260:
L.257:
lw $25,RDiv
bne $25,$0,L.268
la $4,L.270
jal printf  # int
L.268:
l.d $f18,One
l.d $f16,Radix
div.d $f18,$f18,$f16
s.d $f18,BInvrse
move $4,$0
l.d $f18,BInvrse
l.d $f16,Radix
mul.d $f18,$f18,$f16
l.d $f16,Half
sub.d $f18,$f18,$f16
c.eq.d $f18,$f16; bc1f L.273
li $30,1
b L.274
L.273:
move $30,$0
L.274:
move $5,$30
la $6,L.272
jal TstCond  # int
li $25,50
sw $25,Milestone
move $4,$0
l.d $f18,F9
l.d $f16,U1
add.d $f18,$f18,$f16
l.d $f16,Half
sub.d $f18,$f18,$f16
c.eq.d $f18,$f16; bc1f L.277
l.d $f18,BMinusU2
l.d $f16,U2
add.d $f18,$f18,$f16
l.d $f16,One
sub.d $f18,$f18,$f16
l.d $f10,Radix
sub.d $f16,$f10,$f16
c.eq.d $f18,$f16; bc1f L.277
li $30,1
b L.278
L.277:
move $30,$0
L.278:
move $5,$30
la $6,L.276
jal TstCond  # int
l.d $f18,One
l.d $f16,U1
mul.d $f16,$f16,$f16
sub.d $f16,$f18,$f16
s.d $f16,X
l.d $f16,U2
sub.d $f10,$f18,$f16
mul.d $f16,$f16,$f10
add.d $f16,$f18,$f16
s.d $f16,Y
l.d $f16,F9
l.d $f10,Half
sub.d $f16,$f16,$f10
s.d $f16,Z
l.d $f16,X
sub.d $f16,$f16,$f10
l.d $f10,Z
sub.d $f16,$f16,$f10
s.d $f16,X
l.d $f16,Y
sub.d $f18,$f16,$f18
s.d $f18,Y
l.d $f18,X
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.279
l.d $f18,Y
c.eq.d $f18,$f16; bc1f L.279
li $25,2
sw $25,RAddSub
la $4,L.281
jal printf  # int
L.279:
lw $25,GAddSub
bne $25,1,L.282
l.d $f18,Half
l.d $f16,U2
add.d $f10,$f18,$f16
mul.d $f10,$f10,$f16
s.d $f10,X
sub.d $f18,$f18,$f16
mul.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,One
l.d $f10,X
add.d $f10,$f18,$f10
s.d $f10,X
l.d $f10,Y
add.d $f10,$f18,$f10
s.d $f10,Y
add.d $f16,$f18,$f16
l.d $f10,X
sub.d $f16,$f16,$f10
s.d $f16,X
l.d $f16,Y
sub.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,X
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.284
l.d $f18,Y
c.eq.d $f18,$f16; bc1f L.284
l.d $f18,Half
l.d $f16,U2
add.d $f10,$f18,$f16
l.d $f8,U1
mul.d $f10,$f10,$f8
s.d $f10,X
sub.d $f18,$f18,$f16
mul.d $f18,$f18,$f8
s.d $f18,Y
l.d $f18,One
l.d $f16,X
sub.d $f16,$f18,$f16
s.d $f16,X
l.d $f16,Y
sub.d $f16,$f18,$f16
s.d $f16,Y
l.d $f16,F9
l.d $f10,X
sub.d $f16,$f16,$f10
s.d $f16,X
l.d $f16,Y
sub.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,X
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.286
l.d $f18,Y
c.eq.d $f18,$f16; bc1f L.286
li $25,1
sw $25,RAddSub
la $4,L.288
jal printf  # int
lw $25,GAddSub
bne $25,$0,L.283
la $4,L.291
jal notify  # int
b L.283
L.286:
la $4,L.292
jal printf  # int
b L.283
L.284:
la $4,L.292
jal printf  # int
b L.283
L.282:
la $4,L.292
jal printf  # int
L.283:
l.d $f18,One
s.d $f18,S
l.d $f16,Half
add.d $f10,$f18,$f16
mul.d $f10,$f16,$f10
add.d $f10,$f18,$f10
s.d $f10,X
l.d $f10,U2
add.d $f18,$f18,$f10
mul.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,X
l.d $f16,Y
sub.d $f10,$f18,$f16
s.d $f10,Z
sub.d $f18,$f16,$f18
s.d $f18,T
l.d $f18,Z
l.d $f16,T
add.d $f18,$f18,$f16
s.d $f18,StickyBit
l.d $f18,StickyBit
l.d $f16,Zero
c.eq.d $f18,$f16; bc1t L.293
l.d $f18,Zero
s.d $f18,S
li $4,3
la $5,L.295
jal BadCond  # int
L.293:
l.d $f18,Zero
s.d $f18,StickyBit
lw $25,GMult
bne $25,1,L.296
lw $25,GDiv
bne $25,1,L.296
lw $25,GAddSub
bne $25,1,L.296
lw $25,RMult
bne $25,1,L.296
lw $25,RDiv
bne $25,1,L.296
lw $25,RAddSub
bne $25,1,L.296
l.d $f12,RadixD2
jal floor  # real
l.d $f18,RadixD2
c.eq.d $f0,$f18; bc1f L.296
la $4,L.298
jal printf  # int
l.d $f18,Half
l.d $f16,U1
add.d $f16,$f18,$f16
l.d $f10,U2
mul.d $f16,$f16,$f10
s.d $f16,X
mul.d $f18,$f18,$f10
s.d $f18,Y
l.d $f18,One
l.d $f16,Y
add.d $f16,$f18,$f16
s.d $f16,Z
l.d $f16,X
add.d $f16,$f18,$f16
s.d $f16,T
l.d $f16,Z
sub.d $f16,$f16,$f18
l.d $f8,Zero
c.le.d $f16,$f8; bc1f L.299
l.d $f16,T
sub.d $f18,$f16,$f18
c.lt.d $f18,$f10; bc1t L.299
l.d $f18,T
l.d $f16,Y
add.d $f16,$f18,$f16
s.d $f16,Z
l.d $f16,Z
l.d $f10,X
sub.d $f10,$f16,$f10
s.d $f10,Y
sub.d $f16,$f16,$f18
l.d $f10,U2
c.lt.d $f16,$f10; bc1t L.301
l.d $f16,Y
sub.d $f18,$f16,$f18
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.301
l.d $f18,Half
l.d $f16,U1
add.d $f10,$f18,$f16
mul.d $f10,$f10,$f16
s.d $f10,X
mul.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,One
l.d $f16,Y
sub.d $f16,$f18,$f16
s.d $f16,Z
l.d $f16,X
sub.d $f16,$f18,$f16
s.d $f16,T
l.d $f16,Z
sub.d $f18,$f16,$f18
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.303
l.d $f18,T
l.d $f10,F9
sub.d $f18,$f18,$f10
c.eq.d $f18,$f16; bc1f L.303
l.d $f18,Half
l.d $f16,U1
sub.d $f18,$f18,$f16
mul.d $f18,$f18,$f16
s.d $f18,Z
l.d $f18,F9
l.d $f10,Z
sub.d $f10,$f18,$f10
s.d $f10,T
l.d $f10,Y
sub.d $f10,$f18,$f10
s.d $f10,Q
l.d $f10,T
sub.d $f10,$f10,$f18
l.d $f8,Zero
c.eq.d $f10,$f8; bc1f L.305
sub.d $f18,$f18,$f16
l.d $f16,Q
sub.d $f18,$f18,$f16
c.eq.d $f18,$f8; bc1f L.305
l.d $f18,One
l.d $f16,U2
add.d $f10,$f18,$f16
l.d $f8,OneAndHalf
mul.d $f10,$f10,$f8
s.d $f10,Z
add.d $f10,$f8,$f16
l.d $f8,Z
sub.d $f10,$f10,$f8
add.d $f10,$f10,$f16
s.d $f10,T
l.d $f10,Half
l.d $f8,Radix
div.d $f10,$f10,$f8
add.d $f10,$f18,$f10
s.d $f10,X
mul.d $f16,$f8,$f16
add.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,X
l.d $f10,Y
mul.d $f10,$f18,$f10
s.d $f10,Z
l.d $f10,T
l.d $f8,Zero
c.eq.d $f10,$f8; bc1f L.307
add.d $f18,$f18,$f16
l.d $f16,Z
sub.d $f18,$f18,$f16
c.eq.d $f18,$f8; bc1f L.307
l.d $f18,Radix
l.d $f16,Two
c.eq.d $f18,$f16; bc1t L.309
l.d $f18,Two
l.d $f16,U2
add.d $f16,$f18,$f16
s.d $f16,X
l.d $f16,X
div.d $f18,$f16,$f18
s.d $f18,Y
l.d $f18,Y
l.d $f16,One
sub.d $f18,$f18,$f16
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.310
l.d $f18,S
s.d $f18,StickyBit
b L.310
L.309:
l.d $f18,S
s.d $f18,StickyBit
L.310:
L.307:
L.305:
L.303:
L.301:
L.299:
L.296:
l.d $f18,StickyBit
l.d $f16,One
c.eq.d $f18,$f16; bc1f L.313
la $4,L.315
jal printf  # int
b L.314
L.313:
la $4,L.316
jal printf  # int
L.314:
li $4,3
lw $25,GMult
beq $25,$0,L.319
lw $25,GDiv
beq $25,$0,L.319
lw $25,GAddSub
beq $25,$0,L.319
lw $25,RMult
beq $25,$0,L.319
lw $25,RDiv
beq $25,$0,L.319
lw $25,RAddSub
beq $25,$0,L.319
li $30,1
b L.320
L.319:
move $30,$0
L.320:
move $5,$30
la $6,L.318
jal TstCond  # int
li $25,60
sw $25,Milestone
la $4,L.44
jal printf  # int
la $4,L.321
jal printf  # int
la $4,L.322
lw $5,NoTrials
jal printf  # int
l.d $f12,L.323
jal sqrt  # real
s.d $f0,Random9
l.d $f18,Third
s.d $f18,Random1
li $25,1
sw $25,I
L.324:
jal Random  # real
s.d $f0,X
jal Random  # real
s.d $f0,Y
l.d $f18,Y
l.d $f16,X
mul.d $f10,$f18,$f16
s.d $f10,Z9
mul.d $f18,$f16,$f18
s.d $f18,Z
l.d $f18,Z
l.d $f16,Z9
sub.d $f18,$f18,$f16
s.d $f18,Z9
lw $25,I
addu $25,$25,1
sw $25,I
L.325:
lw $25,I
lw $24,NoTrials
bgt $25,$24,L.327
l.d $f18,Z9
l.d $f16,Zero
c.eq.d $f18,$f16; bc1t L.324
L.327:
lw $25,I
lw $24,NoTrials
bne $25,$24,L.328
l.d $f18,One
l.d $f16,Half
l.d $f10,Three
div.d $f16,$f16,$f10
add.d $f16,$f18,$f16
s.d $f16,Random1
l.d $f10,U2
l.d $f8,U1
add.d $f10,$f10,$f8
add.d $f18,$f10,$f18
s.d $f18,Random2
l.d $f10,Random1
l.d $f8,Random2
mul.d $f6,$f10,$f8
s.d $f6,Z
mul.d $f10,$f8,$f10
s.d $f10,Y
mul.d $f18,$f16,$f18
sub.d $f18,$f18,$f18
s.d $f18,Z9
L.328:
lw $25,I
lw $24,NoTrials
beq $25,$24,L.330
l.d $f18,Z9
l.d $f16,Zero
c.eq.d $f18,$f16; bc1t L.330
li $4,2
la $5,L.332
jal BadCond  # int
b L.331
L.330:
la $4,L.333
lw $5,NoTrials
jal printf  # int
L.331:
li $25,70
sw $25,Milestone
la $4,L.334
jal printf  # int
l.d $f18,Zero
mov.d $f30,$f18
mov.d $f12,$f18
jal sqrt  # real
c.eq.d $f30,$f0; bc1f L.337
l.d $f18,Zero
neg.d $f18,$f18
mov.d $f28,$f18
mov.d $f12,$f18
jal sqrt  # real
c.eq.d $f28,$f0; bc1f L.337
l.d $f18,One
mov.d $f26,$f18
mov.d $f12,$f18
jal sqrt  # real
c.eq.d $f26,$f0; bc1f L.337
li $30,1
b L.338
L.337:
move $30,$0
L.338:
move $4,$0
move $5,$30
la $6,L.336
jal TstCond  # int
l.d $f18,Zero
s.d $f18,MinSqEr
s.d $f18,MaxSqEr
s.d $f18,J
l.d $f18,Radix
s.d $f18,X
l.d $f18,U2
s.d $f18,OneUlp
li $4,1
jal SqXMinX  # int
l.d $f18,BInvrse
s.d $f18,X
l.d $f16,U1
mul.d $f18,$f18,$f16
s.d $f18,OneUlp
li $4,1
jal SqXMinX  # int
l.d $f18,U1
s.d $f18,X
mul.d $f18,$f18,$f18
s.d $f18,OneUlp
li $4,1
jal SqXMinX  # int
l.d $f18,J
l.d $f16,Zero
c.eq.d $f18,$f16; bc1t L.339
jal Pause  # int
L.339:
la $4,L.341
lw $5,NoTrials
jal printf  # int
l.d $f18,Zero
s.d $f18,J
l.d $f18,Two
s.d $f18,X
l.d $f18,Radix
s.d $f18,Y
l.d $f16,One
c.eq.d $f18,$f16; bc1t L.342
L.344:
l.d $f18,Y
s.d $f18,X
l.d $f16,Radix
mul.d $f18,$f16,$f18
s.d $f18,Y
L.345:
l.d $f18,Y
l.d $f16,X
sub.d $f18,$f18,$f16
lw $25,NoTrials
mtc1 $25,$f16; cvt.d.w $f16,$f16
c.lt.d $f18,$f16; bc1t L.344
L.342:
l.d $f18,X
l.d $f16,U2
mul.d $f18,$f18,$f16
s.d $f18,OneUlp
li $25,1
sw $25,I
b L.348
L.347:
l.d $f18,X
l.d $f16,One
add.d $f18,$f18,$f16
s.d $f18,X
li $4,2
jal SqXMinX  # int
l.d $f18,J
l.d $f16,Zero
c.le.d $f18,$f16; bc1t L.350
b L.349
L.350:
lw $25,I
addu $25,$25,1
sw $25,I
L.348:
lw $25,I
lw $24,NoTrials
ble $25,$24,L.347
L.349:
la $4,L.352
jal printf  # int
li $25,-1
sw $25,I
l.d $f18,BMinusU2
s.d $f18,X
l.d $f18,Radix
s.d $f18,Y
l.d $f16,U2
mul.d $f16,$f18,$f16
add.d $f18,$f18,$f16
s.d $f18,Z
sw $0,NotMonot
sw $0,Monot
b L.354
L.353:
lw $25,I
addu $25,$25,1
sw $25,I
l.d $f12,X
jal sqrt  # real
s.d $f0,X
l.d $f12,Y
jal sqrt  # real
s.d $f0,Q
l.d $f12,Z
jal sqrt  # real
s.d $f0,Z
l.d $f18,X
l.d $f16,Q
c.le.d $f18,$f16; bc1f L.358
l.d $f18,Z
c.le.d $f16,$f18; bc1t L.356
L.358:
li $25,1
sw $25,NotMonot
b L.357
L.356:
l.d $f18,Q
l.d $f16,Half
add.d $f12,$f18,$f16
jal floor  # real
s.d $f0,Q
lw $25,I
bgt $25,$0,L.361
l.d $f18,Radix
l.d $f16,Q
mul.d $f16,$f16,$f16
c.eq.d $f18,$f16; bc1f L.359
L.361:
li $25,1
sw $25,Monot
b L.360
L.359:
lw $25,I
ble $25,$0,L.362
lw $25,I
ble $25,1,L.364
li $25,1
sw $25,Monot
b L.363
L.364:
l.d $f18,Y
l.d $f16,BInvrse
mul.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,Y
l.d $f16,U1
sub.d $f10,$f18,$f16
s.d $f10,X
add.d $f18,$f18,$f16
s.d $f18,Z
b L.363
L.362:
l.d $f18,Q
s.d $f18,Y
l.d $f18,Y
l.d $f16,U2
sub.d $f10,$f18,$f16
s.d $f10,X
add.d $f18,$f18,$f16
s.d $f18,Z
L.363:
L.360:
L.357:
L.354:
lw $25,NotMonot
bne $25,$0,L.366
lw $25,Monot
beq $25,$0,L.353
L.366:
lw $25,Monot
beq $25,$0,L.367
la $4,L.369
jal printf  # int
b L.368
L.367:
li $4,2
la $5,L.157
jal BadCond  # int
la $4,L.370
l.d $f18,Y
mfc1.d $6,$f18
jal printf  # int
L.368:
li $25,80
sw $25,Milestone
l.d $f18,MinSqEr
l.d $f16,Half
add.d $f18,$f18,$f16
s.d $f18,MinSqEr
l.d $f18,MaxSqEr
sub.d $f18,$f18,$f16
s.d $f18,MaxSqEr
l.d $f18,One
l.d $f16,U2
add.d $f12,$f18,$f16
jal sqrt  # real
l.d $f18,One
sub.d $f16,$f0,$f18
l.d $f10,U2
div.d $f16,$f16,$f10
s.d $f16,Y
l.d $f16,Y
sub.d $f18,$f16,$f18
l.d $f16,Eight
div.d $f16,$f10,$f16
add.d $f18,$f18,$f16
s.d $f18,SqEr
l.d $f18,SqEr
l.d $f16,MaxSqEr
c.le.d $f18,$f16; bc1t L.371
l.d $f18,SqEr
s.d $f18,MaxSqEr
L.371:
l.d $f18,Y
l.d $f16,U2
l.d $f10,Eight
div.d $f16,$f16,$f10
add.d $f18,$f18,$f16
s.d $f18,SqEr
l.d $f18,SqEr
l.d $f16,MinSqEr
c.lt.d $f18,$f16; bc1f L.373
l.d $f18,SqEr
s.d $f18,MinSqEr
L.373:
l.d $f12,F9
jal sqrt  # real
l.d $f18,U2
sub.d $f16,$f0,$f18
l.d $f10,One
sub.d $f18,$f10,$f18
sub.d $f18,$f16,$f18
l.d $f16,U1
div.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,Y
l.d $f10,Eight
div.d $f16,$f16,$f10
add.d $f18,$f18,$f16
s.d $f18,SqEr
l.d $f18,SqEr
l.d $f16,MaxSqEr
c.le.d $f18,$f16; bc1t L.375
l.d $f18,SqEr
s.d $f18,MaxSqEr
L.375:
l.d $f18,Y
l.d $f16,One
add.d $f18,$f18,$f16
l.d $f16,U1
l.d $f10,Eight
div.d $f16,$f16,$f10
add.d $f18,$f18,$f16
s.d $f18,SqEr
l.d $f18,SqEr
l.d $f16,MinSqEr
c.lt.d $f18,$f16; bc1f L.377
l.d $f18,SqEr
s.d $f18,MinSqEr
L.377:
l.d $f18,U2
s.d $f18,OneUlp
l.d $f18,OneUlp
s.d $f18,X
li $25,1
sw $25,Indx
L.379:
l.d $f18,X
l.d $f16,U1
add.d $f16,$f18,$f16
add.d $f18,$f16,$f18
l.d $f16,F9
add.d $f12,$f18,$f16
jal sqrt  # real
s.d $f0,Y
l.d $f18,Y
l.d $f16,U2
sub.d $f18,$f18,$f16
l.d $f10,One
sub.d $f16,$f10,$f16
l.d $f10,X
add.d $f16,$f16,$f10
sub.d $f18,$f18,$f16
l.d $f16,OneUlp
div.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,U1
sub.d $f18,$f18,$f10
l.d $f8,F9
add.d $f18,$f18,$f8
l.d $f8,Half
mul.d $f18,$f18,$f8
mul.d $f18,$f18,$f10
mul.d $f18,$f18,$f10
div.d $f18,$f18,$f16
s.d $f18,Z
l.d $f18,Y
add.d $f18,$f18,$f8
l.d $f16,Z
add.d $f18,$f18,$f16
s.d $f18,SqEr
l.d $f18,SqEr
l.d $f16,MinSqEr
c.lt.d $f18,$f16; bc1f L.383
l.d $f18,SqEr
s.d $f18,MinSqEr
L.383:
l.d $f18,Y
l.d $f16,Half
sub.d $f18,$f18,$f16
l.d $f16,Z
add.d $f18,$f18,$f16
s.d $f18,SqEr
l.d $f18,SqEr
l.d $f16,MaxSqEr
c.le.d $f18,$f16; bc1t L.385
l.d $f18,SqEr
s.d $f18,MaxSqEr
L.385:
lw $25,Indx
beq $25,1,L.389
bne $25,3,L.387
L.389:
l.d $f12,X
jal Sign  # real
mov.d $f30,$f0
l.d $f12,OneUlp
jal sqrt  # real
l.d $f18,Eight
l.d $f16,Nine
mul.d $f16,$f16,$f0
div.d $f12,$f18,$f16
jal floor  # real
l.d $f18,OneUlp
mul.d $f18,$f18,$f30
mul.d $f18,$f18,$f0
s.d $f18,X
b L.388
L.387:
l.d $f18,U1
s.d $f18,OneUlp
l.d $f18,OneUlp
neg.d $f18,$f18
s.d $f18,X
L.388:
L.380:
lw $25,Indx
addu $25,$25,1
sw $25,Indx
lw $25,Indx
ble $25,3,L.379
li $25,85
sw $25,Milestone
sw $0,SqRWrng
sw $0,Anomaly
sw $0,RSqrt
l.d $f18,Radix
l.d $f16,One
c.eq.d $f18,$f16; bc1t L.390
la $4,L.392
jal printf  # int
l.d $f18,Precision
mov.d $f30,$f18
mov.d $f12,$f18
jal floor  # real
l.d $f12,Radix
l.d $f18,One
add.d $f18,$f18,$f30
sub.d $f14,$f18,$f0
jal pow  # real
l.d $f18,Half
add.d $f12,$f18,$f0
jal floor  # real
s.d $f0,D
l.d $f18,D
l.d $f16,Radix
div.d $f16,$f18,$f16
s.d $f16,X
l.d $f16,A1
div.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,X
mov.d $f30,$f18
mov.d $f12,$f18
jal floor  # real
c.eq.d $f30,$f0; bc1f L.395
l.d $f18,Y
mov.d $f28,$f18
mov.d $f12,$f18
jal floor  # real
c.eq.d $f28,$f0; bc1t L.393
L.395:
li $25,1
sw $25,Anomaly
b L.394
L.393:
l.d $f18,Zero
s.d $f18,X
l.d $f18,X
s.d $f18,Z2
l.d $f18,One
s.d $f18,Y
l.d $f16,Y
s.d $f16,Y2
l.d $f16,Radix
sub.d $f18,$f16,$f18
s.d $f18,Z1
l.d $f18,Four
l.d $f16,D
mul.d $f18,$f18,$f16
s.d $f18,FourD
L.396:
l.d $f18,Y2
l.d $f16,Z2
c.le.d $f18,$f16; bc1t L.399
l.d $f18,Radix
s.d $f18,Q
l.d $f18,Y
s.d $f18,Y1
L.401:
l.d $f18,Half
l.d $f16,Q
mov.d $f30,$f16
l.d $f10,Y1
div.d $f10,$f16,$f10
sub.d $f12,$f18,$f10
jal floor  # real
l.d $f18,Y1
mul.d $f18,$f0,$f18
add.d $f12,$f30,$f18
jal fabs  # real
s.d $f0,X1
l.d $f18,Y1
s.d $f18,Q
l.d $f18,X1
s.d $f18,Y1
L.402:
l.d $f18,X1
l.d $f16,Zero
c.le.d $f18,$f16; bc1f L.401
l.d $f18,Q
l.d $f16,One
c.le.d $f18,$f16; bc1f L.404
l.d $f18,Y2
s.d $f18,Z2
l.d $f18,Y
s.d $f18,Z
L.404:
L.399:
l.d $f18,Y
l.d $f16,Two
add.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,X
l.d $f16,Eight
add.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,Y2
l.d $f16,X
add.d $f18,$f18,$f16
s.d $f18,Y2
l.d $f18,Y2
l.d $f16,FourD
c.lt.d $f18,$f16; bc1t L.406
l.d $f18,Y2
l.d $f16,FourD
sub.d $f18,$f18,$f16
s.d $f18,Y2
L.406:
L.397:
l.d $f18,Y
l.d $f16,D
c.lt.d $f18,$f16; bc1t L.396
l.d $f18,FourD
l.d $f16,Z2
sub.d $f16,$f18,$f16
s.d $f16,X8
l.d $f16,X8
l.d $f10,Z
mul.d $f10,$f10,$f10
add.d $f10,$f16,$f10
div.d $f18,$f10,$f18
s.d $f18,Q
l.d $f18,Eight
div.d $f18,$f16,$f18
s.d $f18,X8
l.d $f18,Q
mov.d $f30,$f18
mov.d $f12,$f18
jal floor  # real
c.eq.d $f30,$f0; bc1t L.408
li $25,1
sw $25,Anomaly
b L.409
L.408:
sw $0,Break
L.410:
l.d $f18,Z1
l.d $f16,Z
mul.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,X
mov.d $f30,$f18
l.d $f16,Radix
div.d $f12,$f18,$f16
jal floor  # real
l.d $f18,Radix
mul.d $f18,$f0,$f18
sub.d $f18,$f30,$f18
s.d $f18,X
l.d $f18,X
l.d $f16,One
c.eq.d $f18,$f16; bc1f L.413
li $25,1
sw $25,Break
b L.414
L.413:
l.d $f18,Z1
l.d $f16,One
sub.d $f18,$f18,$f16
s.d $f18,Z1
L.414:
L.411:
lw $25,Break
bne $25,$0,L.415
l.d $f18,Z1
l.d $f16,Zero
c.le.d $f18,$f16; bc1f L.410
L.415:
l.d $f18,Z1
l.d $f16,Zero
c.le.d $f18,$f16; bc1f L.416
lw $25,Break
bne $25,$0,L.416
li $25,1
sw $25,Anomaly
b L.417
L.416:
l.d $f18,Z1
l.d $f16,RadixD2
c.le.d $f18,$f16; bc1t L.418
l.d $f18,Z1
l.d $f16,Radix
sub.d $f18,$f18,$f16
s.d $f18,Z1
L.418:
L.420:
jal NewD  # int
L.421:
l.d $f18,U2
l.d $f16,D
mul.d $f18,$f18,$f16
l.d $f16,F9
c.lt.d $f18,$f16; bc1t L.420
l.d $f18,D
l.d $f16,Radix
mul.d $f16,$f18,$f16
sub.d $f16,$f16,$f18
l.d $f10,W
sub.d $f18,$f10,$f18
c.eq.d $f16,$f18; bc1t L.423
li $25,1
sw $25,Anomaly
b L.424
L.423:
l.d $f18,D
s.d $f18,Z2
sw $0,I
l.d $f16,One
l.d $f10,Z
add.d $f16,$f16,$f10
l.d $f8,Half
mul.d $f16,$f16,$f8
add.d $f16,$f18,$f16
s.d $f16,Y
add.d $f18,$f18,$f10
l.d $f16,Q
add.d $f18,$f18,$f16
s.d $f18,X
jal SR3750  # int
l.d $f18,D
l.d $f16,One
l.d $f10,Z
sub.d $f16,$f16,$f10
l.d $f8,Half
mul.d $f16,$f16,$f8
add.d $f16,$f18,$f16
add.d $f16,$f16,$f18
s.d $f16,Y
sub.d $f16,$f18,$f10
add.d $f18,$f16,$f18
s.d $f18,X
l.d $f18,X
l.d $f16,Q
add.d $f16,$f18,$f16
add.d $f18,$f16,$f18
s.d $f18,X
jal SR3750  # int
jal NewD  # int
l.d $f18,D
l.d $f16,Z2
sub.d $f18,$f18,$f16
l.d $f10,W
sub.d $f16,$f10,$f16
c.eq.d $f18,$f16; bc1t L.425
li $25,1
sw $25,Anomaly
b L.426
L.425:
l.d $f18,D
l.d $f16,Z2
sub.d $f18,$f18,$f16
l.d $f10,One
l.d $f8,Z
sub.d $f10,$f10,$f8
l.d $f6,Half
mul.d $f10,$f10,$f6
add.d $f10,$f16,$f10
add.d $f10,$f18,$f10
s.d $f10,Y
sub.d $f16,$f16,$f8
l.d $f10,Q
add.d $f16,$f16,$f10
add.d $f18,$f18,$f16
s.d $f18,X
jal SR3750  # int
l.d $f18,One
l.d $f16,Z
add.d $f18,$f18,$f16
l.d $f16,Half
mul.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,Q
s.d $f18,X
jal SR3750  # int
lw $25,I
bne $25,$0,L.427
li $25,1
sw $25,Anomaly
L.427:
L.426:
L.424:
L.417:
L.409:
L.394:
lw $25,I
beq $25,$0,L.431
lw $25,Anomaly
beq $25,$0,L.429
L.431:
move $4,$0
la $5,L.432
jal BadCond  # int
la $4,L.433
l.d $f18,W
mfc1.d $6,$f18
jal printf  # int
la $4,L.434
jal printf  # int
li $25,1
sw $25,SqRWrng
L.429:
L.390:
lw $25,Anomaly
bne $25,$0,L.435
l.d $f18,MinSqEr
l.d $f16,Zero
c.lt.d $f18,$f16; bc1t L.437
l.d $f18,MaxSqEr
c.le.d $f18,$f16; bc1f L.437
li $25,1
sw $25,RSqrt
la $4,L.439
jal printf  # int
b L.438
L.437:
l.d $f18,MaxSqEr
l.d $f16,U2
add.d $f18,$f18,$f16
l.d $f10,Half
sub.d $f16,$f16,$f10
c.le.d $f18,$f16; bc1f L.443
l.d $f18,MinSqEr
c.le.d $f18,$f10; bc1f L.443
l.d $f16,Radix
add.d $f18,$f18,$f16
c.lt.d $f18,$f10; bc1f L.440
L.443:
li $25,1
sw $25,SqRWrng
b L.441
L.440:
li $25,2
sw $25,RSqrt
la $4,L.444
jal printf  # int
L.441:
L.438:
L.435:
lw $25,SqRWrng
beq $25,$0,L.445
la $4,L.447
jal printf  # int
la $4,L.448
l.d $f18,MinSqEr
l.d $f16,Half
sub.d $f18,$f18,$f16
mfc1.d $6,$f18
jal printf  # int
la $4,L.449
l.d $f18,Half
l.d $f16,MaxSqEr
add.d $f18,$f18,$f16
mfc1.d $6,$f18
jal printf  # int
li $4,1
l.d $f18,MaxSqEr
l.d $f16,MinSqEr
sub.d $f18,$f18,$f16
l.d $f16,Radix
mul.d $f16,$f16,$f16
c.lt.d $f18,$f16; bc1f L.452
li $30,1
b L.453
L.452:
move $30,$0
L.453:
move $5,$30
la $6,L.451
jal TstCond  # int
L.445:
li $25,90
sw $25,Milestone
jal Pause  # int
la $4,L.454
jal printf  # int
sw $0,N
sw $0,I
l.d $f18,Zero
neg.d $f18,$f18
s.d $f18,Z
li $25,3
sw $25,M
sw $0,Break
L.455:
l.d $f18,One
s.d $f18,X
jal SR3980  # int
lw $25,I
bgt $25,10,L.458
li $25,1023
sw $25,I
jal SR3980  # int
L.458:
l.d $f18,Z
l.d $f16,MinusOne
c.eq.d $f18,$f16; bc1f L.460
li $25,1
sw $25,Break
b L.461
L.460:
l.d $f18,MinusOne
s.d $f18,Z
jal PrintIfNPositive  # int
sw $0,N
li $25,-4
sw $25,I
L.461:
L.456:
lw $25,Break
beq $25,$0,L.455
jal PrintIfNPositive  # int
lw $25,N
sw $25,N1
sw $0,N
l.d $f18,A1
s.d $f18,Z
l.d $f12,W
jal log  # real
mov.d $f30,$f0
l.d $f12,A1
jal log  # real
l.d $f18,Two
mul.d $f18,$f18,$f30
div.d $f12,$f18,$f0
jal floor  # real
trunc.w.d $f2,$f0,$25; mfc1 $25,$f2
sw $25,M
sw $0,Break
L.462:
l.d $f18,Z
s.d $f18,X
li $25,1
sw $25,I
jal SR3980  # int
l.d $f18,Z
l.d $f16,AInvrse
c.eq.d $f18,$f16; bc1f L.465
li $25,1
sw $25,Break
b L.466
L.465:
l.d $f18,AInvrse
s.d $f18,Z
L.466:
L.463:
lw $25,Break
beq $25,$0,L.462
li $25,100
sw $25,Milestone
lw $25,NoTrials
sw $25,M
l.d $f18,Three
s.d $f18,Z
L.467:
l.d $f18,Z
s.d $f18,X
li $25,1
sw $25,I
jal SR3980  # int
L.470:
l.d $f18,Z
l.d $f16,Two
add.d $f18,$f18,$f16
s.d $f18,Z
L.471:
l.d $f18,Z
l.d $f16,Three
mov.d $f30,$f16
div.d $f12,$f18,$f16
jal floor  # real
mul.d $f18,$f30,$f0
l.d $f16,Z
c.eq.d $f18,$f16; bc1t L.470
L.468:
l.d $f18,Z
l.d $f16,Eight
l.d $f10,Three
mul.d $f16,$f16,$f10
c.lt.d $f18,$f16; bc1t L.467
lw $25,N
ble $25,$0,L.473
la $4,L.475
jal printf  # int
la $4,L.476
jal printf  # int
L.473:
jal PrintIfNPositive  # int
lw $25,N
lw $24,N1
addu $25,$25,$24
sw $25,N
lw $25,N
bne $25,$0,L.477
la $4,L.479
jal printf  # int
L.477:
lw $25,N
ble $25,$0,L.480
jal Pause  # int
b L.481
L.480:
la $4,L.44
jal printf  # int
L.481:
li $25,110
sw $25,Milestone
la $4,L.482
jal printf  # int
l.d $f18,U1
s.d $f18,D
l.d $f18,Precision
mov.d $f30,$f18
mov.d $f12,$f18
jal floor  # real
c.eq.d $f30,$f0; bc1t L.483
l.d $f18,BInvrse
s.d $f18,D
l.d $f18,Precision
s.d $f18,X
L.485:
l.d $f18,D
l.d $f16,BInvrse
mul.d $f18,$f18,$f16
s.d $f18,D
l.d $f18,X
l.d $f16,One
sub.d $f18,$f18,$f16
s.d $f18,X
L.486:
l.d $f18,X
l.d $f16,Zero
c.le.d $f18,$f16; bc1f L.485
L.483:
l.d $f18,One
s.d $f18,Y
l.d $f18,D
s.d $f18,Z
L.488:
l.d $f18,Y
s.d $f18,C
l.d $f18,Z
s.d $f18,Y
l.d $f18,Y
mul.d $f18,$f18,$f18
s.d $f18,Z
L.489:
l.d $f18,Y
l.d $f16,Z
c.le.d $f18,$f16; bc1t L.491
add.d $f18,$f16,$f16
c.le.d $f18,$f16; bc1f L.488
L.491:
l.d $f18,C
s.d $f18,Y
l.d $f18,Y
l.d $f16,D
mul.d $f18,$f18,$f16
s.d $f18,Z
L.492:
l.d $f18,Y
s.d $f18,C
l.d $f18,Z
s.d $f18,Y
l.d $f18,Y
l.d $f16,D
mul.d $f18,$f18,$f16
s.d $f18,Z
L.493:
l.d $f18,Y
l.d $f16,Z
c.le.d $f18,$f16; bc1t L.495
add.d $f18,$f16,$f16
c.le.d $f18,$f16; bc1f L.492
L.495:
l.d $f18,Radix
l.d $f16,Two
c.lt.d $f18,$f16; bc1f L.496
l.d $f18,Two
s.d $f18,HInvrse
b L.497
L.496:
l.d $f18,Radix
s.d $f18,HInvrse
L.497:
l.d $f18,One
l.d $f16,HInvrse
div.d $f16,$f18,$f16
s.d $f16,H
l.d $f16,C
div.d $f18,$f18,$f16
s.d $f18,CInvrse
s.d $f16,E0
l.d $f18,E0
l.d $f16,H
mul.d $f18,$f18,$f16
s.d $f18,Z
L.498:
l.d $f18,E0
s.d $f18,Y
l.d $f18,Z
s.d $f18,E0
l.d $f18,E0
l.d $f16,H
mul.d $f18,$f18,$f16
s.d $f18,Z
L.499:
l.d $f18,E0
l.d $f16,Z
c.le.d $f18,$f16; bc1t L.501
add.d $f18,$f16,$f16
c.le.d $f18,$f16; bc1f L.498
L.501:
l.d $f18,E0
s.d $f18,UfThold
l.d $f18,Zero
s.d $f18,E1
s.d $f18,Q
l.d $f18,U2
s.d $f18,E9
l.d $f18,One
l.d $f16,E9
add.d $f18,$f18,$f16
s.d $f18,S
l.d $f18,C
l.d $f16,S
mul.d $f16,$f18,$f16
s.d $f16,D
l.d $f16,D
c.le.d $f16,$f18; bc1f L.502
l.d $f18,Radix
l.d $f16,U2
mul.d $f18,$f18,$f16
s.d $f18,E9
l.d $f18,One
l.d $f16,E9
add.d $f18,$f18,$f16
s.d $f18,S
l.d $f18,C
l.d $f16,S
mul.d $f16,$f18,$f16
s.d $f16,D
l.d $f16,D
c.le.d $f16,$f18; bc1f L.503
move $4,$0
la $5,L.506
jal BadCond  # int
l.d $f18,E0
s.d $f18,Underflow
l.d $f18,Zero
s.d $f18,Y1
l.d $f18,Z
s.d $f18,PseudoZero
jal Pause  # int
b L.503
L.502:
l.d $f18,D
s.d $f18,Underflow
l.d $f18,Underflow
l.d $f16,H
mul.d $f18,$f18,$f16
s.d $f18,PseudoZero
l.d $f18,Zero
s.d $f18,UfThold
L.507:
l.d $f18,Underflow
s.d $f18,Y1
l.d $f18,PseudoZero
s.d $f18,Underflow
l.d $f18,E1
add.d $f16,$f18,$f18
c.le.d $f16,$f18; bc1f L.510
l.d $f18,Underflow
l.d $f16,HInvrse
mul.d $f18,$f18,$f16
s.d $f18,Y2
l.d $f18,Y1
l.d $f16,Y2
sub.d $f12,$f18,$f16
jal fabs  # real
s.d $f0,E1
l.d $f18,Y1
s.d $f18,Q
l.d $f16,UfThold
l.d $f10,Zero
c.eq.d $f16,$f10; bc1f L.512
l.d $f16,Y2
c.eq.d $f18,$f16; bc1t L.512
l.d $f18,Y1
s.d $f18,UfThold
L.512:
L.510:
l.d $f18,PseudoZero
l.d $f16,H
mul.d $f18,$f18,$f16
s.d $f18,PseudoZero
L.508:
l.d $f18,Underflow
l.d $f16,PseudoZero
c.le.d $f18,$f16; bc1t L.514
add.d $f18,$f16,$f16
c.le.d $f18,$f16; bc1f L.507
L.514:
L.503:
l.d $f18,PseudoZero
l.d $f16,Zero
c.eq.d $f18,$f16; bc1t L.515
la $4,L.44
jal printf  # int
l.d $f18,PseudoZero
s.d $f18,Z
l.d $f16,Zero
c.le.d $f18,$f16; bc1f L.517
move $4,$0
la $5,L.519
jal BadCond  # int
la $4,L.520
jal printf  # int
la $4,L.521
l.d $f18,PseudoZero
mfc1.d $6,$f18
jal printf  # int
l.d $f18,PseudoZero
neg.d $f18,$f18
s.d $f18,X
l.d $f18,X
l.d $f16,Zero
c.le.d $f18,$f16; bc1f L.518
la $4,L.524
jal printf  # int
la $4,L.525
l.d $f18,X
mfc1.d $6,$f18
jal printf  # int
b L.518
L.517:
li $4,3
la $5,L.526
jal BadCond  # int
la $4,L.527
l.d $f18,PseudoZero
mfc1.d $6,$f18
jal printf  # int
L.518:
jal TstPtUf  # int
L.515:
li $25,120
sw $25,Milestone
l.d $f18,CInvrse
l.d $f16,Y
mul.d $f16,$f18,$f16
l.d $f10,Y1
mul.d $f18,$f18,$f10
c.le.d $f16,$f18; bc1t L.528
l.d $f18,H
l.d $f16,S
mul.d $f18,$f18,$f16
s.d $f18,S
l.d $f18,Underflow
s.d $f18,E0
L.528:
l.d $f18,E1
l.d $f16,Zero
c.eq.d $f18,$f16; bc1t L.530
l.d $f16,E0
c.eq.d $f18,$f16; bc1t L.530
li $4,2
la $5,L.157
jal BadCond  # int
l.d $f18,E1
l.d $f16,E0
c.lt.d $f18,$f16; bc1f L.532
la $4,L.534
jal printf  # int
la $4,L.535
jal printf  # int
l.d $f18,PseudoZero
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.533
l.d $f18,E1
s.d $f18,E0
b L.533
L.532:
la $4,L.538
jal printf  # int
la $4,L.539
jal printf  # int
L.533:
L.530:
la $4,L.540
l.d $f18,E0
mfc1.d $6,$f18
jal printf  # int
l.d $f18,E0
s.d $f18,Z
jal TstPtUf  # int
l.d $f18,E0
s.d $f18,Underflow
lw $25,N
bne $25,1,L.541
l.d $f18,Y
s.d $f18,Underflow
L.541:
li $25,4
sw $25,I
l.d $f18,E1
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.543
li $25,3
sw $25,I
L.543:
l.d $f18,UfThold
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.545
lw $25,I
subu $25,$25,2
sw $25,I
L.545:
li $25,1
sw $25,UfNGrad
lw $25,I
blt $25,1,L.547
bgt $25,4,L.547
sll $25,$25,2
lw $25,L.571-4($25)
j $25
L.571:
.align 2; .word L.549
.align 2; .word L.556
.align 2; .word L.561
.align 2; .word L.562
L.549:
l.d $f18,Underflow
s.d $f18,UfThold
l.d $f18,CInvrse
l.d $f16,Q
mul.d $f16,$f18,$f16
l.d $f10,Y
mul.d $f18,$f18,$f10
l.d $f10,S
mul.d $f18,$f18,$f10
c.eq.d $f16,$f18; bc1t L.550
l.d $f18,Y
s.d $f18,UfThold
move $4,$0
la $5,L.552
jal BadCond  # int
la $4,L.553
l.d $f18,UfThold
mfc1.d $6,$f18
jal printf  # int
la $4,L.554
l.d $f18,C
mfc1.d $6,$f18
jal printf  # int
la $4,L.555
jal printf  # int
L.550:
jal Pause  # int
b L.548
L.556:
move $4,$0
la $5,L.557
jal BadCond  # int
la $4,L.558
jal printf  # int
la $4,L.559
l.d $f18,Q
mfc1.d $6,$f18
l.d $f18,Y2
s.d $f18,16($sp)
jal printf  # int
l.d $f18,Q
l.d $f16,Y2
sub.d $f12,$f18,$f16
jal fabs  # real
la $4,L.560
mfc1.d $6,$f0
jal printf  # int
l.d $f18,Q
s.d $f18,UfThold
b L.548
L.561:
l.d $f18,X
s.d $f18,X
b L.548
L.562:
l.d $f18,Q
l.d $f16,UfThold
c.eq.d $f18,$f16; bc1f L.563
l.d $f18,E1
l.d $f10,E0
c.eq.d $f18,$f10; bc1f L.563
l.d $f10,E9
div.d $f18,$f18,$f10
sub.d $f12,$f16,$f18
jal fabs  # real
l.d $f18,E1
c.le.d $f0,$f18; bc1f L.563
sw $0,UfNGrad
la $4,L.565
jal printf  # int
la $4,L.566
jal printf  # int
l.d $f18,E0
l.d $f16,CInvrse
mul.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,Y
l.d $f10,OneAndHalf
l.d $f8,U2
add.d $f10,$f10,$f8
mul.d $f18,$f18,$f10
s.d $f18,Y
l.d $f18,One
add.d $f18,$f18,$f8
mul.d $f18,$f16,$f18
s.d $f18,X
l.d $f18,Y
l.d $f16,X
div.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,Y
l.d $f16,E0
c.eq.d $f18,$f16; bc1f L.568
li $30,1
b L.569
L.568:
move $30,$0
L.569:
sw $30,IEEE
L.563:
L.547:
L.548:
lw $25,UfNGrad
beq $25,$0,L.573
la $4,L.44
jal printf  # int
la $25,sigfpe
sw $25,sigsave
la $4,ovfl_buf
jal setjmp  # int
beq $2,$0,L.575
la $4,L.577
jal printf  # int
l.d $f18,H
add.d $f18,$f18,$f18
s.d $f18,R
b L.576
L.575:
l.d $f18,Underflow
l.d $f16,UfThold
div.d $f12,$f18,$f16
jal sqrt  # real
s.d $f0,R
L.576:
sw $0,sigsave
l.d $f18,R
l.d $f16,H
c.le.d $f18,$f16; bc1f L.578
l.d $f18,R
l.d $f16,UfThold
mul.d $f16,$f18,$f16
s.d $f16,Z
l.d $f16,Z
l.d $f10,One
l.d $f8,H
mul.d $f18,$f18,$f8
add.d $f8,$f10,$f8
mul.d $f18,$f18,$f8
add.d $f18,$f10,$f18
mul.d $f18,$f16,$f18
s.d $f18,X
b L.579
L.578:
l.d $f18,UfThold
s.d $f18,Z
l.d $f18,Z
l.d $f16,One
l.d $f10,H
mul.d $f8,$f10,$f10
add.d $f10,$f16,$f10
mul.d $f10,$f8,$f10
add.d $f16,$f16,$f10
mul.d $f18,$f18,$f16
s.d $f18,X
L.579:
l.d $f18,X
l.d $f16,Z
c.eq.d $f18,$f16; bc1t L.580
sub.d $f18,$f18,$f16
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.580
li $4,3
la $5,L.157
jal BadCond  # int
la $4,L.582
l.d $f18,X
mfc1.d $6,$f18
l.d $f18,Z
s.d $f18,16($sp)
jal printf  # int
l.d $f18,X
l.d $f16,Z
sub.d $f18,$f18,$f16
s.d $f18,Z9
la $4,L.583
l.d $f18,Z9
mfc1.d $6,$f18
jal printf  # int
la $4,L.584
jal printf  # int
la $4,L.585
jal printf  # int
la $4,L.586
jal printf  # int
la $4,L.587
jal printf  # int
la $4,L.588
jal printf  # int
la $4,L.589
jal printf  # int
la $25,sigfpe
sw $25,sigsave
la $4,ovfl_buf
jal setjmp  # int
beq $2,$0,L.590
la $4,L.592
jal printf  # int
b L.591
L.590:
la $4,L.593
l.d $f18,X
l.d $f16,Z
div.d $f18,$f18,$f16
l.d $f16,Half
sub.d $f18,$f18,$f16
sub.d $f18,$f18,$f16
mfc1.d $6,$f18
jal printf  # int
L.591:
sw $0,sigsave
L.580:
L.573:
la $4,L.594
l.d $f18,UfThold
mfc1.d $6,$f18
la $25,L.595
sw $25,16($sp)
jal printf  # int
la $4,L.596
jal printf  # int
la $4,L.597
jal printf  # int
l.d $f18,U1
mul.d $f16,$f18,$f18
s.d $f16,Y2
l.d $f16,Y2
mul.d $f16,$f16,$f16
s.d $f16,Y
l.d $f16,Y
mul.d $f18,$f16,$f18
s.d $f18,Y2
l.d $f18,Y2
l.d $f16,UfThold
c.le.d $f18,$f16; bc1f L.598
l.d $f18,Y
l.d $f16,E0
c.le.d $f18,$f16; bc1t L.600
li $4,2
la $5,L.157
jal BadCond  # int
li $25,5
sw $25,I
b L.601
L.600:
li $4,1
la $5,L.157
jal BadCond  # int
li $25,4
sw $25,I
L.601:
la $4,L.602
lw $5,I
jal printf  # int
L.598:
li $25,130
sw $25,Milestone
l.d $f12,UfThold
jal log  # real
mov.d $f30,$f0
l.d $f12,HInvrse
jal log  # real
l.d $f18,Half
l.d $f16,TwoForty
mul.d $f16,$f16,$f30
div.d $f16,$f16,$f0
sub.d $f12,$f18,$f16
jal floor  # real
neg.d $f18,$f0
l.d $f16,TwoForty
div.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,Y
add.d $f18,$f18,$f18
s.d $f18,Y2
la $4,L.603
jal printf  # int
la $4,L.604
l.d $f18,HInvrse
mfc1.d $6,$f18
l.d $f18,Y
s.d $f18,16($sp)
jal printf  # int
la $4,L.605
l.d $f18,HInvrse
mfc1.d $6,$f18
l.d $f18,Y
s.d $f18,16($sp)
jal printf  # int
l.d $f12,HInvrse
l.d $f14,Y2
jal pow  # real
s.d $f0,V9
la $4,L.606
l.d $f18,V9
mfc1.d $6,$f18
jal printf  # int
l.d $f18,V9
l.d $f16,Zero
c.lt.d $f18,$f16; bc1t L.609
l.d $f16,Radix
add.d $f16,$f16,$f16
l.d $f10,E9
add.d $f16,$f16,$f10
l.d $f10,UfThold
mul.d $f16,$f16,$f10
c.le.d $f18,$f16; bc1t L.607
L.609:
li $4,1
la $5,L.610
jal BadCond  # int
la $4,L.611
l.d $f18,UfThold
mfc1.d $6,$f18
jal printf  # int
b L.608
L.607:
l.d $f18,V9
l.d $f16,UfThold
l.d $f10,One
l.d $f8,E9
add.d $f10,$f10,$f8
mul.d $f16,$f16,$f10
c.le.d $f18,$f16; bc1f L.612
la $4,L.614
jal printf  # int
b L.613
L.612:
li $4,2
la $5,L.610
jal BadCond  # int
la $4,L.611
l.d $f18,UfThold
mfc1.d $6,$f18
jal printf  # int
L.613:
L.608:
li $25,140
sw $25,Milestone
la $4,L.44
jal printf  # int
l.d $f18,Zero
s.d $f18,X
li $25,2
sw $25,I
l.d $f16,Two
l.d $f10,Three
mul.d $f16,$f16,$f10
s.d $f16,Y
s.d $f18,Q
sw $0,N
L.615:
l.d $f18,X
s.d $f18,Z
lw $25,I
addu $25,$25,1
sw $25,I
l.d $f18,Y
lw $25,I
addu $25,$25,$25
mtc1 $25,$f16; cvt.d.w $f16,$f16
div.d $f18,$f18,$f16
s.d $f18,Y
l.d $f18,Y
l.d $f16,Q
add.d $f18,$f18,$f16
s.d $f18,R
l.d $f18,Z
l.d $f16,R
add.d $f10,$f18,$f16
s.d $f10,X
l.d $f10,X
sub.d $f18,$f18,$f10
add.d $f18,$f18,$f16
s.d $f18,Q
L.616:
l.d $f18,X
l.d $f16,Z
c.le.d $f18,$f16; bc1f L.615
l.d $f18,OneAndHalf
l.d $f16,One
l.d $f10,Eight
div.d $f16,$f16,$f10
add.d $f16,$f18,$f16
l.d $f10,X
l.d $f8,ThirtyTwo
mul.d $f18,$f18,$f8
div.d $f18,$f10,$f18
add.d $f18,$f16,$f18
s.d $f18,Z
l.d $f18,Z
mul.d $f18,$f18,$f18
s.d $f18,X
l.d $f18,X
mul.d $f18,$f18,$f18
s.d $f18,Exp2
l.d $f18,F9
s.d $f18,X
l.d $f18,X
l.d $f16,U1
sub.d $f18,$f18,$f16
s.d $f18,Y
la $4,L.618
l.d $f18,Exp2
mfc1.d $6,$f18
jal printf  # int
li $25,1
sw $25,I
L.619:
l.d $f18,X
l.d $f16,BInvrse
sub.d $f10,$f18,$f16
s.d $f10,Z
l.d $f10,One
add.d $f8,$f18,$f10
l.d $f6,Z
sub.d $f16,$f10,$f16
sub.d $f16,$f6,$f16
div.d $f16,$f8,$f16
s.d $f16,Z
mov.d $f12,$f18
l.d $f14,Z
jal pow  # real
l.d $f18,Exp2
sub.d $f18,$f0,$f18
s.d $f18,Q
l.d $f12,Q
jal fabs  # real
l.d $f18,TwoForty
l.d $f16,U2
mul.d $f18,$f18,$f16
c.le.d $f0,$f18; bc1t L.623
li $25,1
sw $25,N
l.d $f18,X
l.d $f16,BInvrse
sub.d $f18,$f18,$f16
l.d $f10,One
sub.d $f16,$f10,$f16
sub.d $f18,$f18,$f16
s.d $f18,V9
li $4,2
la $5,L.625
jal BadCond  # int
l.d $f12,X
l.d $f14,Z
jal pow  # real
la $4,L.626
mfc1.d $6,$f0
jal printf  # int
la $4,L.627
l.d $f18,V9
mfc1.d $6,$f18
l.d $f18,Z
s.d $f18,16($sp)
jal printf  # int
la $4,L.628
l.d $f18,Q
mfc1.d $6,$f18
jal printf  # int
la $4,L.629
jal printf  # int
la $4,L.630
jal printf  # int
b L.621
L.623:
l.d $f18,Y
l.d $f16,X
sub.d $f16,$f18,$f16
l.d $f10,Two
mul.d $f16,$f16,$f10
add.d $f16,$f16,$f18
s.d $f16,Z
s.d $f18,X
l.d $f18,Z
s.d $f18,Y
l.d $f18,One
l.d $f16,X
l.d $f10,F9
sub.d $f16,$f16,$f10
mul.d $f16,$f16,$f16
add.d $f16,$f18,$f16
s.d $f16,Z
l.d $f16,Z
c.le.d $f16,$f18; bc1t L.631
lw $25,I
lw $24,NoTrials
bge $25,$24,L.631
lw $25,I
addu $25,$25,1
sw $25,I
b L.619
L.631:
l.d $f18,X
l.d $f16,One
c.le.d $f18,$f16; bc1t L.633
lw $25,N
bne $25,$0,L.621
la $4,L.637
jal printf  # int
b L.621
L.633:
l.d $f18,One
l.d $f16,U2
add.d $f18,$f18,$f16
s.d $f18,X
add.d $f18,$f16,$f16
s.d $f18,Y
l.d $f18,Y
l.d $f16,X
add.d $f18,$f18,$f16
s.d $f18,Y
li $25,1
sw $25,I
b L.619
L.621:
li $25,150
sw $25,Milestone
la $4,L.638
jal printf  # int
sw $0,N
l.d $f18,A1
s.d $f18,Z
l.d $f12,C
jal log  # real
mov.d $f30,$f0
l.d $f12,A1
jal log  # real
l.d $f18,Half
div.d $f16,$f30,$f0
sub.d $f12,$f18,$f16
jal floor  # real
s.d $f0,Q
sw $0,Break
L.639:
l.d $f18,CInvrse
s.d $f18,X
l.d $f12,Z
l.d $f14,Q
jal pow  # real
s.d $f0,Y
jal IsYeqX  # int
l.d $f18,Q
neg.d $f18,$f18
s.d $f18,Q
l.d $f18,C
s.d $f18,X
l.d $f12,Z
l.d $f14,Q
jal pow  # real
s.d $f0,Y
jal IsYeqX  # int
l.d $f18,Z
l.d $f16,One
c.lt.d $f18,$f16; bc1f L.642
li $25,1
sw $25,Break
b L.643
L.642:
l.d $f18,AInvrse
s.d $f18,Z
L.643:
L.640:
lw $25,Break
beq $25,$0,L.639
jal PrintIfNPositive  # int
lw $25,N
bne $25,$0,L.644
la $4,L.646
jal printf  # int
L.644:
la $4,L.44
jal printf  # int
li $25,160
sw $25,Milestone
jal Pause  # int
la $4,L.647
jal printf  # int
la $4,L.648
jal printf  # int
l.d $f18,CInvrse
neg.d $f18,$f18
s.d $f18,Y
l.d $f18,HInvrse
l.d $f16,Y
mul.d $f18,$f18,$f16
s.d $f18,V9
la $25,sigfpe
sw $25,sigsave
la $4,ovfl_buf
jal setjmp  # int
beq $2,$0,L.649
sw $0,I
l.d $f18,Y
s.d $f18,V9
b L.651
L.649:
L.652:
l.d $f18,Y
s.d $f18,V
l.d $f18,V9
s.d $f18,Y
l.d $f18,HInvrse
l.d $f16,Y
mul.d $f18,$f18,$f16
s.d $f18,V9
L.653:
l.d $f18,V9
l.d $f16,Y
c.lt.d $f18,$f16; bc1t L.652
li $25,1
sw $25,I
L.651:
sw $0,sigsave
l.d $f18,V9
s.d $f18,Z
la $4,L.655
jal printf  # int
la $4,L.656
l.d $f18,Y
mfc1.d $6,$f18
jal printf  # int
l.d $f18,Y
neg.d $f16,$f18
s.d $f16,V9
l.d $f16,V9
s.d $f16,V0
l.d $f16,V
sub.d $f18,$f16,$f18
l.d $f10,V0
add.d $f16,$f16,$f10
c.eq.d $f18,$f16; bc1f L.657
la $4,L.659
jal printf  # int
b L.658
L.657:
la $4,L.660
jal printf  # int
li $4,3
la $5,L.661
jal BadCond  # int
L.658:
l.d $f18,Z
l.d $f16,Y
c.eq.d $f18,$f16; bc1t L.662
li $4,1
la $5,L.157
jal BadCond  # int
la $4,L.664
l.d $f18,Y
mfc1.d $6,$f18
l.d $f18,Z
s.d $f18,16($sp)
jal printf  # int
L.662:
lw $25,I
beq $25,$0,L.665
l.d $f18,V
l.d $f16,HInvrse
l.d $f10,U2
mul.d $f8,$f16,$f10
sub.d $f8,$f8,$f16
mul.d $f8,$f18,$f8
s.d $f8,Y
l.d $f8,Y
l.d $f6,One
sub.d $f16,$f6,$f16
mul.d $f16,$f16,$f10
mul.d $f18,$f16,$f18
add.d $f18,$f8,$f18
s.d $f18,Z
l.d $f18,Z
l.d $f16,V0
c.lt.d $f18,$f16; bc1f L.667
l.d $f18,Z
s.d $f18,Y
L.667:
l.d $f18,Y
l.d $f16,V0
c.lt.d $f18,$f16; bc1f L.669
l.d $f18,Y
s.d $f18,V
L.669:
l.d $f18,V0
l.d $f16,V
sub.d $f16,$f18,$f16
c.lt.d $f16,$f18; bc1f L.666
l.d $f18,V0
s.d $f18,V
b L.666
L.665:
l.d $f18,Y
l.d $f16,HInvrse
l.d $f10,U2
mul.d $f8,$f16,$f10
sub.d $f8,$f8,$f16
mul.d $f8,$f18,$f8
s.d $f8,V
l.d $f8,V
l.d $f6,One
sub.d $f16,$f6,$f16
mul.d $f16,$f16,$f10
mul.d $f18,$f16,$f18
add.d $f18,$f8,$f18
s.d $f18,V
L.666:
la $4,L.673
l.d $f18,V
mfc1.d $6,$f18
jal printf  # int
lw $25,I
beq $25,$0,L.674
la $4,L.676
l.d $f18,V0
mfc1.d $6,$f18
jal printf  # int
b L.675
L.674:
la $4,L.677
jal printf  # int
L.675:
l.d $f18,V
l.d $f16,One
mul.d $f18,$f18,$f16
s.d $f18,V9
la $4,L.678
l.d $f18,V9
mfc1.d $6,$f18
jal printf  # int
l.d $f18,V
l.d $f16,One
div.d $f18,$f18,$f16
s.d $f18,V9
la $4,L.679
l.d $f18,V9
mfc1.d $6,$f18
jal printf  # int
la $4,L.680
jal printf  # int
la $4,L.681
jal printf  # int
li $25,170
sw $25,Milestone
l.d $f18,V
neg.d $f16,$f18
c.lt.d $f16,$f18; bc1f L.686
l.d $f16,V0
neg.d $f10,$f16
c.lt.d $f10,$f16; bc1f L.686
l.d $f16,UfThold
neg.d $f10,$f16
c.lt.d $f10,$f18; bc1f L.686
c.lt.d $f16,$f18; bc1t L.682
L.686:
move $4,$0
la $5,L.687
jal BadCond  # int
la $4,L.688
l.d $f18,V
mfc1.d $6,$f18
l.d $f18,V0
s.d $f18,16($sp)
l.d $f18,UfThold
s.d $f18,24($sp)
jal printf  # int
L.682:
li $25,175
sw $25,Milestone
la $4,L.44
jal printf  # int
li $25,1
sw $25,Indx
L.689:
lw $25,Indx
beq $25,1,L.695
beq $25,2,L.696
beq $25,3,L.697
b L.693
L.695:
l.d $f18,UfThold
s.d $f18,Z
b L.694
L.696:
l.d $f18,E0
s.d $f18,Z
b L.694
L.697:
l.d $f18,PseudoZero
s.d $f18,Z
L.693:
L.694:
l.d $f18,Z
l.d $f16,Zero
c.eq.d $f18,$f16; bc1t L.698
l.d $f12,Z
jal sqrt  # real
s.d $f0,V9
l.d $f18,V9
mul.d $f18,$f18,$f18
s.d $f18,Y
l.d $f18,Y
l.d $f16,One
l.d $f10,Radix
l.d $f8,E9
mul.d $f10,$f10,$f8
sub.d $f8,$f16,$f10
div.d $f8,$f18,$f8
l.d $f6,Z
c.lt.d $f8,$f6; bc1t L.702
add.d $f16,$f16,$f10
mul.d $f16,$f16,$f6
c.le.d $f18,$f16; bc1t L.700
L.702:
l.d $f18,V9
l.d $f16,U1
c.le.d $f18,$f16; bc1t L.703
li $4,1
la $5,L.157
jal BadCond  # int
b L.704
L.703:
li $4,2
la $5,L.157
jal BadCond  # int
L.704:
la $4,L.705
l.d $f18,Z
mfc1.d $6,$f18
jal printf  # int
la $4,L.706
l.d $f18,Y
mfc1.d $6,$f18
jal printf  # int
L.700:
L.698:
L.690:
lw $25,Indx
addu $25,$25,1
sw $25,Indx
lw $25,Indx
ble $25,3,L.689
li $25,180
sw $25,Milestone
li $25,1
sw $25,Indx
L.707:
lw $25,Indx
bne $25,1,L.711
l.d $f18,V
s.d $f18,Z
b L.712
L.711:
l.d $f18,V0
s.d $f18,Z
L.712:
l.d $f12,Z
jal sqrt  # real
s.d $f0,V9
l.d $f18,One
l.d $f16,Radix
l.d $f10,E9
mul.d $f8,$f16,$f10
sub.d $f8,$f18,$f8
l.d $f6,V9
mul.d $f8,$f8,$f6
s.d $f8,X
l.d $f8,X
mul.d $f8,$f6,$f8
s.d $f8,V9
l.d $f8,V9
l.d $f6,Two
mul.d $f16,$f6,$f16
mul.d $f16,$f16,$f10
sub.d $f18,$f18,$f16
l.d $f16,Z
mul.d $f18,$f18,$f16
c.lt.d $f8,$f18; bc1t L.715
c.le.d $f8,$f16; bc1t L.713
L.715:
l.d $f18,V9
s.d $f18,Y
l.d $f18,X
l.d $f16,W
c.lt.d $f18,$f16; bc1f L.716
li $4,1
la $5,L.157
jal BadCond  # int
b L.717
L.716:
li $4,2
la $5,L.157
jal BadCond  # int
L.717:
la $4,L.718
l.d $f18,Z
mfc1.d $6,$f18
jal printf  # int
la $4,L.719
l.d $f18,Y
mfc1.d $6,$f18
jal printf  # int
L.713:
L.708:
lw $25,Indx
addu $25,$25,1
sw $25,Indx
lw $25,Indx
ble $25,2,L.707
li $25,190
sw $25,Milestone
jal Pause  # int
l.d $f18,UfThold
l.d $f16,V
mul.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,Radix
mul.d $f18,$f18,$f18
s.d $f18,Y
l.d $f18,X
l.d $f16,Y
mul.d $f10,$f18,$f16
l.d $f8,One
c.lt.d $f10,$f8; bc1t L.722
c.le.d $f18,$f16; bc1t L.720
L.722:
l.d $f18,X
l.d $f16,Y
mul.d $f10,$f18,$f16
l.d $f8,U1
c.lt.d $f10,$f8; bc1t L.725
div.d $f16,$f16,$f8
c.le.d $f18,$f16; bc1t L.723
L.725:
li $4,2
la $5,L.726
jal BadCond  # int
b L.724
L.723:
li $4,3
la $5,L.157
jal BadCond  # int
L.724:
la $4,L.727
l.d $f18,X
mfc1.d $6,$f18
la $25,L.728
sw $25,16($sp)
jal printf  # int
L.720:
li $25,200
sw $25,Milestone
li $25,1
sw $25,Indx
L.729:
l.d $f18,F9
s.d $f18,X
lw $25,Indx
blt $25,2,L.733
bgt $25,5,L.733
sll $25,$25,2
lw $25,L.740-8($25)
j $25
L.740:
.align 2; .word L.735
.align 2; .word L.736
.align 2; .word L.737
.align 2; .word L.738
L.735:
l.d $f18,One
l.d $f16,U2
add.d $f18,$f18,$f16
s.d $f18,X
b L.734
L.736:
l.d $f18,V
s.d $f18,X
b L.734
L.737:
l.d $f18,UfThold
s.d $f18,X
b L.734
L.738:
l.d $f18,Radix
s.d $f18,X
L.733:
L.734:
l.d $f18,X
s.d $f18,Y
la $25,sigfpe
sw $25,sigsave
la $4,ovfl_buf
jal setjmp  # int
beq $2,$0,L.742
la $4,L.744
l.d $f18,X
mfc1.d $6,$f18
jal printf  # int
b L.743
L.742:
l.d $f18,Y
l.d $f16,X
div.d $f18,$f18,$f16
l.d $f16,Half
sub.d $f18,$f18,$f16
sub.d $f18,$f18,$f16
s.d $f18,V9
l.d $f18,V9
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.745
b L.730
L.745:
l.d $f18,V9
l.d $f16,U1
neg.d $f16,$f16
c.eq.d $f18,$f16; bc1f L.747
lw $25,Indx
bge $25,5,L.747
li $4,3
la $5,L.157
jal BadCond  # int
b L.748
L.747:
li $4,1
la $5,L.157
jal BadCond  # int
L.748:
la $4,L.749
l.d $f18,X
mfc1.d $6,$f18
jal printf  # int
la $4,L.750
l.d $f18,V9
mfc1.d $6,$f18
jal printf  # int
L.743:
sw $0,sigsave
L.730:
lw $25,Indx
addu $25,$25,1
sw $25,Indx
lw $25,Indx
ble $25,5,L.729
li $25,210
sw $25,Milestone
l.d $f18,Zero
s.d $f18,MyZero
la $4,L.44
jal printf  # int
la $4,L.751
jal printf  # int
la $25,sigfpe
sw $25,sigsave
la $4,L.752
jal printf  # int
la $4,ovfl_buf
jal setjmp  # int
bne $2,$0,L.753
la $4,L.755
l.d $f18,One
l.d $f16,MyZero
div.d $f18,$f18,$f16
mfc1.d $6,$f18
jal printf  # int
L.753:
sw $0,sigsave
la $25,sigfpe
sw $25,sigsave
la $4,L.756
jal printf  # int
la $4,ovfl_buf
jal setjmp  # int
bne $2,$0,L.757
la $4,L.755
l.d $f18,Zero
l.d $f16,MyZero
div.d $f18,$f18,$f16
mfc1.d $6,$f18
jal printf  # int
L.757:
sw $0,sigsave
li $25,220
sw $25,Milestone
jal Pause  # int
la $4,L.44
jal printf  # int
move $30,$0
L.764:
sll $25,$30,2
lw $25,ErrCnt($25)
beq $25,$0,L.768
la $4,L.770
sll $25,$30,2
lw $5,L.759($25)
lw $6,ErrCnt($25)
jal printf  # int
L.768:
L.765:
addu $30,$30,1
blt $30,4,L.764
la $4,L.44
jal printf  # int
lw $25,ErrCnt
lw $24,ErrCnt+4
addu $25,$25,$24
lw $24,ErrCnt+8
addu $25,$25,$24
lw $24,ErrCnt+12
addu $25,$25,$24
ble $25,$0,L.771
lw $25,ErrCnt
lw $24,ErrCnt+4
addu $25,$25,$24
lw $24,ErrCnt+8
addu $25,$25,$24
bne $25,$0,L.776
lw $25,ErrCnt+12
ble $25,$0,L.776
la $4,L.781
jal printf  # int
la $4,L.782
jal printf  # int
L.776:
lw $25,ErrCnt
lw $24,ErrCnt+4
addu $25,$25,$24
bne $25,$0,L.783
lw $25,ErrCnt+8
ble $25,$0,L.783
la $4,L.787
jal printf  # int
la $4,L.788
jal printf  # int
L.783:
lw $25,ErrCnt
lw $24,ErrCnt+4
addu $25,$25,$24
ble $25,$0,L.789
la $4,L.792
jal printf  # int
la $4,L.793
jal printf  # int
L.789:
lw $25,ErrCnt
ble $25,$0,L.772
la $4,L.796
jal printf  # int
la $4,L.797
jal printf  # int
b L.772
L.771:
la $4,L.798
jal printf  # int
lw $25,RMult
bne $25,1,L.803
lw $25,RDiv
bne $25,1,L.803
lw $25,RAddSub
bne $25,1,L.803
lw $25,RSqrt
beq $25,1,L.799
L.803:
la $4,L.804
jal printf  # int
b L.800
L.799:
l.d $f18,StickyBit
l.d $f16,One
c.lt.d $f18,$f16; bc1t L.805
l.d $f18,Radix
l.d $f10,Two
sub.d $f10,$f18,$f10
l.d $f8,Nine
sub.d $f18,$f18,$f8
sub.d $f18,$f18,$f16
mul.d $f18,$f10,$f18
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.805
la $4,L.807
jal printf  # int
la $4,L.808
jal printf  # int
l.d $f18,Radix
l.d $f16,Two
c.eq.d $f18,$f16; bc1f L.809
l.d $f18,Precision
l.d $f10,Four
l.d $f8,Three
mul.d $f10,$f10,$f8
mul.d $f16,$f10,$f16
sub.d $f16,$f18,$f16
l.d $f10,TwentySeven
sub.d $f18,$f18,$f10
sub.d $f18,$f18,$f10
l.d $f10,One
add.d $f18,$f18,$f10
mul.d $f18,$f16,$f18
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.809
la $4,L.811
jal printf  # int
b L.810
L.809:
la $4,L.812
jal printf  # int
L.810:
lw $25,IEEE
beq $25,$0,L.813
la $4,L.815
jal printf  # int
b L.814
L.813:
la $4,L.816
jal printf  # int
la $4,L.817
jal printf  # int
L.814:
L.805:
la $4,L.818
jal printf  # int
L.800:
L.772:
lw $25,fpecount
beq $25,$0,L.819
la $4,L.821
lw $5,fpecount
jal printf  # int
L.819:
la $4,L.822
jal printf  # int
L.6:
l.d $f26,32($sp)
l.d $f28,40($sp)
l.d $f30,48($sp)
lw $30,56($sp)
lw $31,60($sp)
addu $sp,$sp,64
j $31
.end main
.globl Sign
.text
.align 2; .ent Sign
Sign:
$fp3=0
.frame $sp,0,$31
l.d $f18,L.7
c.lt.d $f12,$f18; bc1t L.848
l.d $f16,L.8
b L.849
L.848:
l.d $f16,L.850
L.849:
mov.d $f0,$f16
L.846:
j $31
.end Sign
.globl Pause
.text
.align 2; .ent Pause
Pause:
$fp4=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
la $4,L.852
lw $5,Milestone
jal printf  # int
la $4,L.853
lw $5,PageNo
jal printf  # int
lw $25,Milestone
addu $25,$25,1
sw $25,Milestone
lw $25,PageNo
addu $25,$25,1
sw $25,PageNo
L.851:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end Pause
.globl TstCond
.text
.align 2; .ent TstCond
TstCond:
$fp5=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
sw $4,24($sp)
sw $5,28($sp)
sw $6,32($sp)
lw $25,$fp5+4($sp)
bne $25,$0,L.855
lw $4,$fp5+0($sp)
lw $5,$fp5+8($sp)
jal BadCond  # int
la $4,L.815
jal printf  # int
L.855:
L.854:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end TstCond
.data; .align 2; L.858:.word L.859
.word L.860
.word L.861
.word L.862
.text
.globl BadCond
.text
.align 2; .ent BadCond
BadCond:
$fp6=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0xc0000000,-4
sw $30,16($sp)
sw $31,20($sp)
move $30,$4
sw $5,28($sp)
sll $25,$30,2
lw $24,ErrCnt($25)
addu $24,$24,1
sw $24,ErrCnt($25)
la $4,L.863
sll $25,$30,2
lw $5,L.858($25)
lw $6,$fp6+4($sp)
jal printf  # int
L.857:
lw $30,16($sp)
lw $31,20($sp)
addu $sp,$sp,24
j $31
.end BadCond
.globl Random
.text
.align 2; .ent Random
Random:
$fp7=40
.frame $sp,40,$31
addu $sp,$sp,-40
.fmask 0xf0000000,-16
s.d $f28,16($sp)
s.d $f30,24($sp)
.mask 0x80000000,-8
sw $31,32($sp)
l.d $f18,Random1
l.d $f16,Random9
add.d $f30,$f18,$f16
mul.d $f28,$f30,$f30
mul.d $f28,$f28,$f28
mul.d $f30,$f30,$f28
mov.d $f12,$f30
jal floor  # real
sub.d $f28,$f30,$f0
l.d $f18,L.865
mul.d $f18,$f18,$f30
add.d $f18,$f28,$f18
s.d $f18,Random1
l.d $f0,Random1
L.864:
l.d $f28,16($sp)
l.d $f30,24($sp)
lw $31,32($sp)
addu $sp,$sp,40
j $31
.end Random
.globl SqXMinX
.text
.align 2; .ent SqXMinX
SqXMinX:
$fp8=56
.frame $sp,56,$31
addu $sp,$sp,-56
.fmask 0xc0000000,-24
s.d $f30,32($sp)
.mask 0x80000000,-16
sw $31,40($sp)
sw $4,56($sp)
l.d $f18,X
l.d $f16,BInvrse
mul.d $f30,$f18,$f16
sub.d $f16,$f18,$f30
s.d $f16,$fp8-8($sp)
mul.d $f12,$f18,$f18
jal sqrt  # real
sub.d $f18,$f0,$f30
l.d $f16,$fp8-8($sp)
sub.d $f18,$f18,$f16
l.d $f16,OneUlp
div.d $f18,$f18,$f16
s.d $f18,SqEr
l.d $f18,SqEr
l.d $f16,Zero
c.eq.d $f18,$f16; bc1t L.867
l.d $f18,SqEr
l.d $f16,MinSqEr
c.lt.d $f18,$f16; bc1f L.869
l.d $f18,SqEr
s.d $f18,MinSqEr
L.869:
l.d $f18,SqEr
l.d $f16,MaxSqEr
c.le.d $f18,$f16; bc1t L.871
l.d $f18,SqEr
s.d $f18,MaxSqEr
L.871:
l.d $f18,J
l.d $f16,L.8
add.d $f18,$f18,$f16
s.d $f18,J
lw $4,$fp8+0($sp)
la $5,L.44
jal BadCond  # int
la $4,L.873
l.d $f18,X
mul.d $f16,$f18,$f18
mfc1.d $6,$f16
s.d $f18,16($sp)
l.d $f18,OneUlp
l.d $f16,SqEr
mul.d $f18,$f18,$f16
s.d $f18,24($sp)
jal printf  # int
la $4,L.874
jal printf  # int
L.867:
L.866:
l.d $f30,32($sp)
lw $31,40($sp)
addu $sp,$sp,56
j $31
.end SqXMinX
.globl NewD
.text
.align 2; .ent NewD
NewD:
$fp9=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
l.d $f18,Z1
l.d $f16,Q
mul.d $f18,$f18,$f16
s.d $f18,X
l.d $f18,Half
l.d $f16,X
l.d $f10,Radix
div.d $f16,$f16,$f10
sub.d $f12,$f18,$f16
jal floor  # real
l.d $f18,Radix
mul.d $f16,$f0,$f18
l.d $f10,X
add.d $f16,$f16,$f10
s.d $f16,X
l.d $f16,Q
l.d $f10,X
l.d $f8,Z
mul.d $f6,$f10,$f8
sub.d $f16,$f16,$f6
div.d $f16,$f16,$f18
mul.d $f6,$f10,$f10
l.d $f4,D
div.d $f18,$f4,$f18
mul.d $f18,$f6,$f18
add.d $f18,$f16,$f18
s.d $f18,Q
l.d $f18,Two
mul.d $f18,$f18,$f10
mul.d $f18,$f18,$f4
sub.d $f18,$f8,$f18
s.d $f18,Z
l.d $f18,Z
l.d $f16,Zero
c.le.d $f18,$f16; bc1f L.876
l.d $f18,Z
neg.d $f18,$f18
s.d $f18,Z
l.d $f18,Z1
neg.d $f18,$f18
s.d $f18,Z1
L.876:
l.d $f18,Radix
l.d $f16,D
mul.d $f18,$f18,$f16
s.d $f18,D
L.875:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end NewD
.globl SR3750
.text
.align 2; .ent SR3750
SR3750:
$fp10=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
l.d $f18,X
l.d $f16,Radix
sub.d $f10,$f18,$f16
l.d $f8,Z2
sub.d $f16,$f8,$f16
c.lt.d $f10,$f16; bc1t L.879
sub.d $f18,$f18,$f8
l.d $f16,W
sub.d $f16,$f16,$f8
c.le.d $f18,$f16; bc1f L.879
lw $25,I
addu $25,$25,1
sw $25,I
l.d $f18,X
l.d $f16,D
mul.d $f12,$f18,$f16
jal sqrt  # real
s.d $f0,X2
l.d $f18,X2
l.d $f16,Z2
sub.d $f18,$f18,$f16
l.d $f10,Y
sub.d $f16,$f10,$f16
sub.d $f18,$f18,$f16
s.d $f18,Y2
l.d $f18,X8
l.d $f16,Half
sub.d $f10,$f10,$f16
div.d $f18,$f18,$f10
s.d $f18,X2
l.d $f18,X2
mul.d $f10,$f16,$f18
mul.d $f10,$f10,$f18
sub.d $f18,$f18,$f10
s.d $f18,X2
l.d $f18,Y2
add.d $f18,$f18,$f16
l.d $f10,X2
sub.d $f16,$f16,$f10
add.d $f18,$f18,$f16
s.d $f18,SqEr
l.d $f18,SqEr
l.d $f16,MinSqEr
c.lt.d $f18,$f16; bc1f L.881
l.d $f18,SqEr
s.d $f18,MinSqEr
L.881:
l.d $f18,Y2
l.d $f16,X2
sub.d $f18,$f18,$f16
s.d $f18,SqEr
l.d $f18,SqEr
l.d $f16,MaxSqEr
c.le.d $f18,$f16; bc1t L.883
l.d $f18,SqEr
s.d $f18,MaxSqEr
L.883:
L.879:
L.878:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end SR3750
.globl IsYeqX
.text
.align 2; .ent IsYeqX
IsYeqX:
$fp11=32
.frame $sp,32,$31
addu $sp,$sp,-32
.mask 0x80000000,-8
sw $31,24($sp)
l.d $f18,Y
l.d $f16,X
c.eq.d $f18,$f16; bc1t L.886
lw $25,N
bgt $25,$0,L.888
l.d $f18,Z
l.d $f16,Zero
c.eq.d $f18,$f16; bc1f L.890
l.d $f18,Q
c.le.d $f18,$f16; bc1f L.890
la $4,L.892
jal printf  # int
b L.891
L.890:
li $4,2
la $5,L.893
jal BadCond  # int
L.891:
la $4,L.894
l.d $f18,Z
mfc1.d $6,$f18
l.d $f18,Q
s.d $f18,16($sp)
jal printf  # int
la $4,L.895
l.d $f18,Y
mfc1.d $6,$f18
jal printf  # int
la $4,L.896
l.d $f18,X
mfc1.d $6,$f18
jal printf  # int
la $4,L.897
l.d $f18,Y
l.d $f16,X
sub.d $f18,$f18,$f16
mfc1.d $6,$f18
jal printf  # int
L.888:
lw $25,N
addu $25,$25,1
sw $25,N
L.886:
L.885:
lw $31,24($sp)
addu $sp,$sp,32
j $31
.end IsYeqX
.globl SR3980
.text
.align 2; .ent SR3980
SR3980:
$fp12=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
L.899:
lw $25,I
mtc1 $25,$f18; cvt.d.w $f18,$f18
s.d $f18,Q
l.d $f12,Z
l.d $f14,Q
jal pow  # real
s.d $f0,Y
jal IsYeqX  # int
lw $25,I
addu $25,$25,1
sw $25,I
lw $24,M
ble $25,$24,L.902
b L.901
L.902:
l.d $f18,Z
l.d $f16,X
mul.d $f18,$f18,$f16
s.d $f18,X
L.900:
l.d $f18,X
l.d $f16,W
c.lt.d $f18,$f16; bc1t L.899
L.901:
L.898:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end SR3980
.globl PrintIfNPositive
.text
.align 2; .ent PrintIfNPositive
PrintIfNPositive:
$fp13=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
lw $25,N
ble $25,$0,L.905
la $4,L.907
lw $5,N
jal printf  # int
L.905:
L.904:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end PrintIfNPositive
.globl TstPtUf
.text
.align 2; .ent TstPtUf
TstPtUf:
$fp14=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
sw $0,N
l.d $f18,Z
l.d $f16,Zero
c.eq.d $f18,$f16; bc1t L.909
la $4,L.911
jal printf  # int
la $4,L.912
jal printf  # int
la $25,sigfpe
sw $25,sigsave
la $4,ovfl_buf
jal setjmp  # int
beq $2,$0,L.913
b L.915
L.913:
l.d $f18,Z
add.d $f16,$f18,$f18
div.d $f18,$f16,$f18
s.d $f18,Q9
la $4,L.916
l.d $f18,Q9
mfc1.d $6,$f18
jal printf  # int
l.d $f18,Q9
l.d $f16,Two
sub.d $f12,$f18,$f16
jal fabs  # real
l.d $f18,Radix
l.d $f16,U2
mul.d $f18,$f18,$f16
c.lt.d $f0,$f18; bc1f L.917
la $4,L.919
jal printf  # int
la $4,L.920
jal printf  # int
b L.918
L.917:
l.d $f18,Q9
l.d $f16,One
c.lt.d $f18,$f16; bc1t L.923
l.d $f16,Two
c.le.d $f18,$f16; bc1t L.921
L.923:
L.915:
li $25,1
sw $25,N
lw $25,ErrCnt+4
addu $25,$25,1
sw $25,ErrCnt+4
la $4,L.926
jal printf  # int
b L.922
L.921:
li $25,1
sw $25,N
lw $25,ErrCnt+8
addu $25,$25,1
sw $25,ErrCnt+8
la $4,L.929
jal printf  # int
L.922:
L.918:
sw $0,sigsave
l.d $f18,Z
l.d $f16,One
mul.d $f10,$f18,$f16
s.d $f10,V9
l.d $f10,V9
s.d $f10,Random1
mul.d $f10,$f16,$f18
s.d $f10,V9
l.d $f10,V9
s.d $f10,Random2
div.d $f16,$f18,$f16
s.d $f16,V9
l.d $f16,Random1
c.eq.d $f18,$f16; bc1f L.930
l.d $f16,Random2
c.eq.d $f18,$f16; bc1f L.930
l.d $f16,V9
c.eq.d $f18,$f16; bc1f L.930
lw $25,N
ble $25,$0,L.931
jal Pause  # int
b L.931
L.930:
li $25,1
sw $25,N
li $4,2
la $5,L.934
jal BadCond  # int
la $4,L.935
l.d $f18,Z
mfc1.d $6,$f18
jal printf  # int
l.d $f18,Z
l.d $f16,Random1
c.eq.d $f18,$f16; bc1t L.936
la $4,L.938
l.d $f18,Random1
mfc1.d $6,$f18
jal printf  # int
L.936:
l.d $f18,Z
l.d $f16,Random2
c.eq.d $f18,$f16; bc1t L.939
l.d $f18,Random1
c.eq.d $f16,$f18; bc1t L.939
la $4,L.941
l.d $f18,Random2
mfc1.d $6,$f18
jal printf  # int
L.939:
l.d $f18,Z
l.d $f16,V9
c.eq.d $f18,$f16; bc1t L.942
la $4,L.944
l.d $f18,V9
mfc1.d $6,$f18
jal printf  # int
L.942:
l.d $f18,Random2
l.d $f16,Random1
c.eq.d $f18,$f16; bc1t L.945
lw $25,ErrCnt+8
addu $25,$25,1
sw $25,ErrCnt+8
li $4,2
la $5,L.949
jal BadCond  # int
la $4,L.950
l.d $f18,Random2
mfc1.d $6,$f18
jal printf  # int
la $4,L.951
l.d $f18,Random1
mfc1.d $6,$f18
jal printf  # int
L.945:
jal Pause  # int
L.931:
L.909:
L.908:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end TstPtUf
.globl notify
.text
.align 2; .ent notify
notify:
$fp15=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
sw $4,24($sp)
la $4,L.953
lw $5,$fp15+0($sp)
jal printf  # int
la $4,L.954
jal printf  # int
L.952:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end notify
.globl msglist
.text
.align 2; .ent msglist
msglist:
$fp16=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0xc0000000,-4
sw $30,16($sp)
sw $31,20($sp)
move $30,$4
b L.957
L.956:
la $4,L.959
move $25,$30
addu $30,$25,4
lw $5,($25)
jal printf  # int
L.957:
lw $25,($30)
bne $25,$0,L.956
L.955:
lw $30,16($sp)
lw $31,20($sp)
addu $sp,$sp,24
j $31
.end msglist
.data; .align 2; L.961:.word L.962
.word L.963
.word L.964
.word L.965
.word L.966
.word L.967
.word L.968
.word L.969
.word L.970
.word 0x0
.text
.globl Instructions
.text
.align 2; .ent Instructions
Instructions:
$fp17=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
la $4,L.961
jal msglist  # int
L.960:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end Instructions
.data; .align 2; L.972:.word L.973
.word L.974
.word L.975
.word L.976
.word L.977
.word L.978
.word L.979
.word L.980
.word L.981
.word L.982
.word L.983
.word L.984
.word L.985
.word L.986
.word 0x0
.text
.globl Heading
.text
.align 2; .ent Heading
Heading:
$fp18=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
la $4,L.972
jal msglist  # int
L.971:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end Heading
.data; .align 2; L.988:.word L.989
.word L.990
.word L.991
.word L.992
.word L.993
.word L.994
.word L.995
.word L.996
.word L.997
.word L.998
.word L.999
.word L.1000
.word L.1001
.word L.1002
.word L.1003
.word L.1004
.word L.1005
.word L.1006
.word L.1007
.word 0x0
.text
.globl Characteristics
.text
.align 2; .ent Characteristics
Characteristics:
$fp19=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
la $4,L.988
jal msglist  # int
L.987:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end Characteristics
.data; .align 2; L.1009:.word L.1010
.word L.1011
.word L.1012
.word L.1013
.word L.1014
.word L.1015
.word L.1016
.word L.1017
.word L.1018
.word L.1019
.word L.1020
.word L.1021
.word L.1022
.word L.1023
.word L.1024
.word L.1025
.word L.1026
.word 0x0
.text
.globl History
.text
.align 2; .ent History
History:
$fp20=24
.frame $sp,24,$31
addu $sp,$sp,-24
.mask 0x80000000,-8
sw $31,16($sp)
la $4,L.1009
jal msglist  # int
L.1008:
lw $31,16($sp)
addu $sp,$sp,24
j $31
.end History
.globl pow
.text
.align 2; .ent pow
pow:
$fp21=72
.frame $sp,72,$31
addu $sp,$sp,-72
.fmask 0xfc000000,-40
s.d $f26,16($sp)
s.d $f28,24($sp)
s.d $f30,32($sp)
.mask 0xc0800000,-24
sw $23,40($sp)
sw $30,44($sp)
sw $31,48($sp)
mov.d $f30,$f12
mov.d $f28,$f14
move $23,$0
sw $0,$fp21-8($sp)
l.d $f18,L.7
c.eq.d $f28,$f18; bc1f L.1028
l.d $f0,L.8
b L.1027
L.1028:
l.d $f18,L.1033
c.lt.d $f28,$f18; bc1t L.1032
l.d $f18,L.1034
c.le.d $f28,$f18; bc1t L.1030
L.1032:
l.d $f18,L.850
c.eq.d $f30,$f18; bc1t L.1030
mov.d $f12,$f30
jal log  # real
mul.d $f12,$f28,$f0
jal exp  # real
b L.1027
L.1030:
l.d $f18,L.7
c.lt.d $f28,$f18; bc1f L.1035
neg.d $f28,$f28
li $25,1
sw $25,$fp21-8($sp)
L.1035:
mov.d $f12,$f28
la $6,$fp21-16($sp)
jal modf  # real
mov.d $f28,$f0
l.d $f18,L.7
c.eq.d $f28,$f18; bc1t L.1037
mov.d $f12,$f30
jal log  # real
mul.d $f12,$f28,$f0
jal exp  # real
mov.d $f26,$f0
b L.1038
L.1037:
l.d $f26,L.8
L.1038:
mov.d $f12,$f30
la $6,$fp21-4($sp)
jal frexp  # real
mov.d $f30,$f0
l.d $f18,$fp21-16($sp)
trunc.w.d $f2,$f18,$25; mfc1 $25,$f2
move $30,$25
beq $25,$0,L.1039
L.1041:
and $25,$30,1
beq $25,$0,L.1045
mul.d $f26,$f26,$f30
lw $25,$fp21-4($sp)
addu $23,$23,$25
L.1045:
sra $25,$30,1
move $30,$25
bne $25,$0,L.1047
b L.1043
L.1047:
mul.d $f30,$f30,$f30
lw $25,$fp21-4($sp)
sll $25,$25,1
sw $25,$fp21-4($sp)
l.d $f18,L.1051
c.lt.d $f30,$f18; bc1f L.1041
l.d $f18,L.1052
mul.d $f30,$f18,$f30
lw $25,$fp21-4($sp)
subu $25,$25,1
sw $25,$fp21-4($sp)
b L.1041
L.1043:
L.1039:
lw $25,$fp21-8($sp)
beq $25,$0,L.1053
l.d $f18,L.8
div.d $f26,$f18,$f26
negu $23,$23
L.1053:
mov.d $f12,$f26
move $6,$23
jal ldexp  # real
L.1027:
l.d $f26,16($sp)
l.d $f28,24($sp)
l.d $f30,32($sp)
lw $23,40($sp)
lw $30,44($sp)
lw $31,48($sp)
addu $sp,$sp,72
j $31
.end pow
.globl UfNGrad
.comm UfNGrad,4
.globl SqRWrng
.comm SqRWrng,4
.globl IEEE
.comm IEEE,4
.globl Anomaly
.comm Anomaly,4
.globl Monot
.comm Monot,4
.globl NotMonot
.comm NotMonot,4
.globl Done
.comm Done,4
.globl Break
.comm Break,4
.globl RSqrt
.comm RSqrt,4
.globl RAddSub
.comm RAddSub,4
.globl RDiv
.comm RDiv,4
.globl RMult
.comm RMult,4
.globl GAddSub
.comm GAddSub,4
.globl GDiv
.comm GDiv,4
.globl GMult
.comm GMult,4
.globl N1
.comm N1,4
.globl N
.comm N,4
.globl M
.comm M,4
.globl PageNo
.comm PageNo,4
.globl Milestone
.comm Milestone,4
.globl fpecount
.comm fpecount,4
.globl ErrCnt
.comm ErrCnt,16
.globl Z9
.comm Z9,8
.globl Z2
.comm Z2,8
.globl Z1
.comm Z1,8
.globl PseudoZero
.comm PseudoZero,8
.globl Z
.comm Z,8
.globl Random2
.comm Random2,8
.globl Y2
.comm Y2,8
.globl Y1
.comm Y1,8
.globl Y
.comm Y,8
.globl Random1
.comm Random1,8
.globl X8
.comm X8,8
.globl X2
.comm X2,8
.globl X1
.comm X1,8
.globl X
.comm X,8
.globl W
.comm W,8
.globl V9
.comm V9,8
.globl V0
.comm V0,8
.globl V
.comm V,8
.globl U2
.comm U2,8
.globl U1
.comm U1,8
.globl UfThold
.comm UfThold,8
.globl OneUlp
.comm OneUlp,8
.globl S
.comm S,8
.globl Underflow
.comm Underflow,8
.globl T
.comm T,8
.globl Random9
.comm Random9,8
.globl R
.comm R,8
.globl Q9
.comm Q9,8
.globl Q
.comm Q,8
.globl Precision
.comm Precision,8
.globl MyZero
.comm MyZero,8
.globl J
.comm J,8
.globl StickyBit
.comm StickyBit,8
.globl I
.comm I,4
.globl HInvrse
.comm HInvrse,8
.globl H
.comm H,8
.globl F9
.comm F9,8
.globl F6
.comm F6,8
.globl Third
.comm Third,8
.globl E9
.comm E9,8
.globl MaxSqEr
.comm MaxSqEr,8
.globl SqEr
.comm SqEr,8
.globl MinSqEr
.comm MinSqEr,8
.globl E3
.comm E3,8
.globl Exp2
.comm Exp2,8
.globl E1
.comm E1,8
.globl E0
.comm E0,8
.globl FourD
.comm FourD,8
.globl D
.comm D,8
.globl CInvrse
.comm CInvrse,8
.globl C
.comm C,8
.globl A1
.comm A1,8
.globl AInvrse
.comm AInvrse,8
.globl ch
.comm ch,8
.globl Indx
.comm Indx,4
.globl BMinusU2
.comm BMinusU2,8
.globl RadixD2
.comm RadixD2,8
.globl BInvrse
.comm BInvrse,8
.globl Radix
.comm Radix,8
.globl sigsave
.comm sigsave,4
.globl ovfl_buf
.comm ovfl_buf,112
.extern _iob 0
.rdata
.align 3; L.1052:.word 0x40000000
.word 0x0
.align 3; L.1051:.word 0x3fe00000
.word 0x0
.align 3; L.1034:.word 0x40913000
.word 0x0
.align 3; L.1033:.word 0xc0913000
.word 0x0
L.1026:.ascii "see source comments for more history.\000"
L.1025:.ascii "BASIC version of this program (C) 1983 by Prof. W. M. Kahan;\000"
L.1024:.ascii "as used by certain early WANG machines.\012\000"
L.1023:.ascii "floating-point numbers, but also allows logarithmic encoding\000"
L.1022:.ascii "\012The program is based upon a conventional radix representatio"
.ascii "n for\000"
L.1021:.ascii "of pathologies, and to say how well the arithmetic is implemente"
.ascii "d.\000"
L.1020:.ascii "of the arithmetic, this program tries to cope with a wider varie"
.ascii "ty\000"
L.1019:.ascii "the Radix, Precision and range (over/underflow thresholds)\000"
L.1018:.ascii "W. J. Cody and W. Waite. Although both programs try to discover\000"
L.1017:.ascii "book  `Software Manual for the Elementary Functions' (1980) by\000"
L.1016:.ascii "program called `MACHAR', which can be found at the end of the\000"
L.1015:.ascii "The diagnostic capabilities of this program go beyond an earlier"
.ascii "\000"
L.1014:.ascii "Failures may confound subsequent diagnoses.\012\000"
L.1013:.ascii "   FAILUREs, like 2+2 == 5 .\000"
L.1012:.ascii "   Serious DEFECTs, like lack of a guard digit, and\000"
L.1011:.ascii "   FLAWs, like lack of a sticky bit,\000"
L.1010:.ascii "The program attempts to discriminate among\000"
L.1007:.ascii "     Decimal-Binary conversion is NOT YET tested for accuracy.\000"
L.1006:.ascii "     Extra-precise subexpressions are revealed but NOT YET teste"
.ascii "d.\000"
L.1005:.ascii "     Sqrt is tested.  Y^X is not tested.\000"
L.1004:.ascii "\011and for contamination with pseudo-zeros.\000"
L.1003:.ascii "     Comparisions are checked for consistency with subtraction\000"
L.1002:.ascii "     V0  tells, roughly, whether  Infinity  is represented.\000"
L.1001:.ascii "     V = an overflow threshold, roughly.\000"
L.1000:.ascii "     E0 and PseudoZero tell whether underflow is abrupt, gradual"
.ascii ", or fuzzy.\000"
L.999:.ascii "     UnderflowThreshold = an underflow threshold.\000"
L.998:.ascii "     Whether a Sticky Bit used correctly for rounding.\000"
L.997:.ascii "\011for Mult., Div., Add/Subt. and Sqrt.\000"
L.996:.ascii "     Whether arithmetic is chopped, correctly rounded, or someth"
.ascii "ing else\000"
L.995:.ascii "     Adequacy of guard digits for Mult., Div. and Subt.\000"
L.994:.ascii "     U1 = 1/Radix^Precision = One Ulp of numbers a little less t"
.ascii "han 1.0 .\000"
L.993:.ascii "\011(OneUlpnit in the Last Place) of 1.000xxx .\000"
L.992:.ascii "     U2 = Radix/Radix^Precision = One Ulp\000"
L.991:.ascii "     Precision = number of significant digits carried.\000"
L.990:.ascii "     Radix = 1, 2, 4, 8, 10, 16, 100, 256 ...\000"
L.989:.ascii "Running this program should reveal these characteristics:\000"
L.986:.ascii "\011Other relevant compiler options:\000"
L.985:.ascii "\011Optimization level:\012\000"
L.984:.ascii "\011Compiler:\012\000"
L.983:.ascii "\011Computer:\012\000"
L.982:.ascii "\011Version:\01110 February 1989;\000"
L.981:.ascii "\011Precision:\011double;\000"
L.980:.ascii "In doing so, please include the following information:\000"
L.979:.ascii "\011San Francisco, CA 94143-0704, USA\012\000"
L.978:.ascii "\011University of California\000"
L.977:.ascii "\011Computer Center U-76\000"
L.976:.ascii "\011Richard Karpinski\000"
L.975:.ascii "Please send suggestions and interesting results to\000"
L.974:.ascii "cope with unanticipated and newly uncovered arithmetic pathologi"
.ascii "es.\012\000"
L.973:.ascii "Users are invited to help debug and augment this program so it w"
.ascii "ill\000"
L.970:.ascii "Answer questions with Y, y, N or n (unless otherwise indicated)."
.ascii "\012\000"
L.969:.ascii "amend it to make further progress.\012\000"
L.968:.ascii "program anyway to see how many milestones it passes, and then\000"
L.967:.ascii "warning.  If persuasion avails naught, don't despair but run thi"
.ascii "s\000"
L.966:.ascii "to persevere with a surrogate value after, perhaps, displaying s"
.ascii "ome\000"
L.965:.ascii "error like Over/Underflow or Division by Zero occurs, but rather"
.ascii "\000"
L.964:.ascii "try to persuade the computer NOT to terminate execution when an\000"
L.963:.ascii "    `END OF TEST',\012\000"
L.962:.ascii "Lest this program stop prematurely, i.e. before displaying\012\000"
L.959:.byte 37,115,10,0
L.954:.ascii "   PLEASE NOTIFY KARPINKSI!\012\000"
L.953:.ascii "%s test appears to be inconsistent...\012\000"
L.951:.ascii "\011differs from Z * 1 = %.17e\012\000"
L.950:.ascii "\011Comparison alleges that 1 * Z = %.17e\012\000"
L.949:.ascii "Multiplication does not commute!\012\000"
L.944:.ascii "Z / 1 = %.17e\012\000"
L.941:.ascii "1 * Z == %g\012\000"
L.938:.ascii "Z * 1 = %.17e \000"
L.935:.ascii "%.17e\012\011compares different from  \000"
L.934:.ascii "What prints as Z = \000"
L.929:.ascii "This is a DEFECT!\012\000"
L.926:.ascii "This is a VERY SERIOUS DEFECT!\012\000"
L.920:.ascii " has NOT just been signaled.\012\000"
L.919:.ascii "This is O.K., provided Over/Underflow\000"
L.916:.ascii "What the machine gets for (Z + Z) / Z is  %.17e .\012\000"
L.912:.ascii "(Z + Z) / Z should be safe.\012\000"
L.911:.ascii "Since comparison denies Z = 0, evaluating \000"
L.907:.ascii "Similar discrepancies have occurred %d times.\012\000"
L.897:.ascii "\011\011they differ by %.17e .\012\000"
L.896:.ascii "\011which compared unequal to correct %.17e ;\012\000"
L.895:.ascii "\011yielded %.17e;\012\000"
L.894:.ascii "\011(%.17e) ^ (%.17e)\012\000"
L.893:.ascii "computing\012\000"
L.892:.ascii "WARNING:  computing\012\000"
L.874:.ascii "\011instead of correct value 0 .\012\000"
L.873:.ascii "sqrt( %.17e) - %.17e  = %.17e\012\000"
.align 3; L.865:.word 0x3ed4f8b5
.word 0x88e368f0
L.863:.ascii "%s:  %s\000"
L.862:.ascii "FLAW\000"
L.861:.ascii "DEFECT\000"
L.860:.ascii "SERIOUS DEFECT\000"
L.859:.ascii "FAILURE\000"
L.853:.ascii "          Page: %d\012\012\000"
L.852:.ascii "\012Diagnosis resumes after milestone Number %d\000"
.align 3; L.850:.word 0xbff00000
.word 0x0
L.822:.ascii "END OF TEST.\012\000"
L.821:.ascii "\012A total of %d floating point exceptions were registered.\012"
.ascii "\000"
L.818:.ascii "The arithmetic diagnosed appears to be Excellent!\012\000"
L.817:.ascii " during Gradual Underflow.\012\000"
L.816:.ascii ",\012except for possibly Double Rounding\000"
L.815:.byte 46,10,0
L.812:.ascii "854\000"
L.811:.ascii "754\000"
L.808:.ascii "the proposed IEEE standard P\000"
L.807:.ascii "Rounding appears to conform to \000"
L.804:.ascii "The arithmetic diagnosed seems Satisfactory.\012\000"
L.798:.ascii "No failures, defects nor flaws have been discovered.\012\000"
L.797:.ascii " program's subsequent diagnoses.\012\000"
L.796:.ascii "Potentially fatal FAILURE may have spoiled this\000"
L.793:.ascii "unacceptable Serious Defects.\012\000"
L.792:.ascii "The arithmetic diagnosed has \000"
L.788:.ascii "despite inconvenient Defects.\012\000"
L.787:.ascii "The arithmetic diagnosed may be Acceptable\012\000"
L.782:.ascii "Satisfactory though flawed.\012\000"
L.781:.ascii "The arithmetic diagnosed seems \000"
L.770:.ascii "The number of  %-29s %d.\012\000"
L.763:.ascii "FLAWs  discovered =\000"
L.762:.ascii "DEFECTs  discovered =\000"
L.761:.ascii "SERIOUS DEFECTs  discovered =\000"
L.760:.ascii "FAILUREs  encountered =\000"
L.756:.ascii "\012    Trying to compute 0 / 0 produces ...\000"
L.755:.ascii "  %.7e .\012\000"
L.752:.ascii "    Trying to compute 1 / 0 produces ...\000"
L.751:.ascii "What message and/or values does Division by Zero produce?\012\000"
L.750:.ascii "  instead, X / X - 1/2 - 1/2 = %.17e .\012\000"
L.749:.ascii "  X / X differs from 1 when X = %.17e\012\000"
L.744:.ascii "  X / X  traps when X = %g\012\000"
L.728:.ascii "is too far from 1.\012\000"
L.727:.ascii " unbalanced range; UfThold * V = %.17e\012\011%s\012\000"
L.726:.ascii "Badly\000"
L.719:.ascii " is too far from sqrt(Z) ^ 2 (%.17e) .\012\000"
L.718:.ascii "Comparison alleges that Z = %17e\012\000"
L.706:.ascii " is too far from sqrt(Z) ^ 2 = %.17e .\012\000"
L.705:.ascii "Comparison alleges that what prints as Z = %.17e\012\000"
L.688:.ascii "+-%g, +-%g\012and +-%g are confused by Overflow.\000"
L.687:.ascii "Comparisons involving \000"
L.681:.ascii "above is a DEFECT.\012\000"
L.680:.ascii "Any overflow signal separating this * from the one\012\000"
L.679:.ascii "                           nor for V / 1 = %.17e .\012\000"
L.678:.ascii "No Overflow should be signaled for V * 1 = %.17e\012\000"
L.677:.ascii "There is no saturation value because the system traps on overflo"
.ascii "w.\012\000"
L.676:.ascii "Overflow saturates at V0 = %.17e .\012\000"
L.673:.ascii "Overflow threshold is V  = %.17e .\012\000"
L.664:.ascii "overflow past %.17e\012\011shrinks to %.17e .\012\000"
L.661:.ascii "-(-Y) differs from Y.\012\000"
L.660:.ascii "finds a \000"
L.659:.ascii "Seems O.K.\012\000"
L.656:.ascii "Trying it on Y = %.17e .\012\000"
L.655:.ascii "Can `Z = -Y' overflow?\012\000"
L.648:.ascii "This may generate an error.\012\000"
L.647:.ascii "Searching for Overflow threshold:\012\000"
L.646:.ascii " ... no discrepancies found.\012\000"
L.638:.ascii "Testing powers Z^Q at four nearly extreme values.\012\000"
L.637:.ascii "Accuracy seems adequate.\012\000"
L.630:.ascii "\011calculations involving tiny interest rates.\012\000"
L.629:.ascii "\011This much error may spoil financial\012\000"
L.628:.ascii "\011differs from correct value by %.17e .\012\000"
L.627:.ascii "\011(1 + (%.17e) ^ (%.17e);\012\000"
L.626:.ascii " %.17e for\012\000"
L.625:.ascii "Calculated\000"
L.618:.ascii "Testing X^((X + 1) / (X - 1)) vs. exp(2) = %.17e as X -> 1.\012\000"
L.614:.ascii "This computed value is O.K.\012\000"
L.611:.ascii "   threshold = %.17e .\012\000"
L.610:.ascii "this is not between 0 and underflow\012\000"
L.606:.ascii "actually calculating yields: %.17e .\012\000"
L.605:.ascii "should afflict the expression\012\011(%.17e) ^ (%.17e);\012\000"
L.604:.ascii "UfThold = (%.17e) ^ (%.17e)\012only underflow \000"
L.603:.ascii "Since underflow occurs below the threshold\012\000"
L.602:.ascii "Range is too narrow; U1^%d Underflows.\012\000"
L.597:.ascii "merely roundoff.\012\000"
L.596:.ascii "calculation may suffer larger Relative error than \000"
L.595:.ascii " below which\000"
L.594:.ascii "The Underflow threshold is %.17e, %s\012\000"
L.593:.ascii "X / Z = 1 + %g .\012\000"
L.592:.ascii "X / Z fails!\012\000"
L.589:.ascii "encounter Division by Zero although actually\012\000"
L.588:.ascii "  ... (f(X) - f(Z)) / (X - Z) ...\012\000"
L.587:.ascii "    if (X == Z)  ...  else\000"
L.586:.ascii "confusion when innocent statements like\012\000"
L.585:.ascii "this is a SERIOUS DEFECT\012that causes \000"
L.584:.ascii "    Should this NOT signal Underflow, \000"
L.583:.ascii "yet X - Z yields %.17e .\012\000"
L.582:.ascii "X = %.17e\012\011is not equal to Z = %.17e .\012\000"
L.577:.ascii "Underflow / UfThold failed!\012\000"
L.566:.ascii "(roundoff in UfThold) < E0.\012\000"
L.565:.ascii "Underflow is gradual; it incurs Absolute Error =\012\000"
L.560:.ascii "|Q - Y| = %.17e .\012\000"
L.559:.ascii "print out as Q = %.17e, Y = %.17e .\012\000"
L.558:.ascii "Q == Y while denying that |Q - Y| == 0; these values\012\000"
L.557:.ascii "Underflow confuses Comparison, which alleges that\012\000"
L.555:.ascii " or else multiplication gets too many last digits wrong.\012\000"
L.554:.ascii " coming down from %.17e\012\000"
L.553:.ascii "approach a threshold = %.17e\012\000"
L.552:.ascii "Either accuracy deteriorates as numbers\012\000"
L.540:.ascii "Smallest strictly positive number found is E0 = %g .\012\000"
L.539:.ascii " threshold than products.\012\000"
L.538:.ascii "Difference underflows at a higher\000"
L.535:.ascii " threshold than differences.\012\000"
L.534:.ascii "Products underflow at a higher\000"
L.527:.ascii "value PseudoZero that prints out as %g .\012\000"
L.526:.ascii "Underflow can stick at an allegedly positive\012\000"
L.525:.ascii "positive, isn't; it prints out as  %g .\012\000"
L.524:.ascii "But -PseudoZero, which should be\012\000"
L.521:.ascii "PseudoZero that prints out as: %g .\012\000"
L.520:.ascii "allegedly negative value\012\000"
L.519:.ascii "Positive expressions can underflow to an\012\000"
L.506:.ascii "multiplication gets too many last digits wrong.\012\000"
L.482:.ascii "Seeking Underflow thresholds UfThold and E0.\012\000"
L.479:.ascii "... no discrepancis found.\012\000"
L.476:.ascii "\011involving interest rates.\012\000"
L.475:.ascii "Errors like this may invalidate financial calculations\012\000"
L.454:.ascii "Testing powers Z^i for small Integers Z and i.\012\000"
L.451:.ascii "sqrt gets too many last digits wrong\000"
L.449:.ascii "to %.7e ulps.\012\000"
L.448:.ascii "Observed errors run from %.7e \000"
L.447:.ascii "Square root is neither chopped nor correctly rounded.\012\000"
L.444:.ascii "Square root appears to be chopped.\012\000"
L.439:.ascii "Square root appears to be correctly rounded.\012\000"
L.434:.ascii " fails test whether sqrt rounds or chops.\012\000"
L.433:.ascii "Radix^Precision = %.7e\012\000"
L.432:.ascii "Anomalous arithmetic with Integer < \000"
L.392:.ascii "Testing whether sqrt is rounded or chopped.\012\000"
L.370:.ascii "sqrt(X) is non-monotonic for X near %.7e .\012\000"
L.369:.ascii "sqrt has passed a test for Monotonicity.\012\000"
L.352:.ascii "Test for sqrt monotonicity.\012\000"
L.341:.ascii "Testing if sqrt(X * X) == X for %d Integers X.\012\000"
L.336:.ascii "Square root of 0.0, -0.0 or 1.0 wrong\000"
L.334:.ascii "\012Running test of square root(x).\012\000"
L.333:.ascii "     No failures found in %d integer pairs.\012\000"
L.332:.ascii "X * Y == Y * X trial fails.\012\000"
.align 3; L.323:.word 0x40080000
.word 0x0
L.322:.ascii "Testing on %d random pairs.\012\000"
L.321:.ascii "Does Multiplication commute?  \000"
L.318:.ascii "lack(s) of guard digits or failure(s) to correctly round or chop"
.ascii "\012(noted above) count as one flaw in the final tally below\000"
L.316:.ascii "Sticky bit used incorrectly or not at all.\012\000"
L.315:.ascii "Sticky bit apparently used correctly.\012\000"
L.298:.ascii "Checking for sticky bit.\012\000"
L.295:.ascii "(X - Y) + (Y - X) is non zero!\012\000"
L.292:.ascii "Addition/Subtraction neither rounds nor chops.\012\000"
L.291:.ascii "Add/Subtract\000"
L.288:.ascii "Addition/Subtraction appears to round correctly.\012\000"
L.281:.ascii "Add/Subtract appears to be chopped.\012\000"
L.276:.ascii "Incomplete carry-propagation in Addition\000"
L.272:.ascii "Radix * ( 1 / Radix ) differs from 1\000"
L.270:.ascii "/ is neither chopped nor correctly rounded.\012\000"
L.267:.ascii "Division appears to chop.\012\000"
L.264:.ascii "Division\000"
L.261:.ascii "Division appears to round correctly.\012\000"
L.256:.ascii "Multiplication\000"
L.253:.ascii "* is neither chopped nor correctly rounded.\012\000"
L.252:.ascii "Multiplication appears to chop.\012\000"
L.249:.ascii "Multiplication appears to round correctly.\012\000"
L.239:.ascii "X * (1/X) differs from 1\000"
L.220:.ascii "Checking rounding on multiply, divide and add/subtract.\012\000"
L.219:.ascii "     *, /, and - appear to have guard digits, as they should.\012"
.ascii "\000"
L.216:.ascii "  ...  if (X == 1.0) {.....} else {.../(X-1.0)...}\012\000"
L.215:.ascii "  such precautions against division by zero as\012\000"
L.214:.ascii "  subtraction yields  (1-U1) - 1 = 0 , thereby vitiating\012\000"
L.213:.ascii "comparison alleges  (1-U1) < 1  although\012\000"
L.210:.ascii "- lacks Guard Digit, so cancellation is obscured\000"
L.205:.ascii "* and/or / gets too many last digits wrong\000"
L.201:.ascii "Computed value of 1/1.000..1 >= 1\000"
L.199:.ascii "Division lacks a Guard Digit, so X/1 != X\000"
L.194:.ascii "Division lacks a Guard Digit, so error can exceed 1 ulp\012or  1"
.ascii "/3  and  3/9  and  9/27 may disagree\000"
L.190:.ascii "* gets too many final digits wrong.\012\000"
L.188:.ascii "* lacks a Guard Digit, so 1*X != X\000"
L.185:.ascii "\012Checking for guard digit in *, /, and -.\012\000"
L.184:.ascii "Subtraction appears to be normalized, as it should be.\000"
L.179:.ascii "Subtraction is not normalized X=Y,X+Z != Y+Z!\000"
L.175:.ascii "roughly %g extra significant decimals.\012\000"
L.174:.ascii "precisely with about %g extra B-digits, i.e.\012\000"
L.173:.ascii "Some subexpressions appear to be calculated extra\012\000"
L.167:.ascii "of an\012extra-precision\000"
L.166:.ascii "Z1 = %.7e, or Z2 = %.7e \000"
L.165:.ascii ", or exact rational arithmetic a result\012\000"
L.164:.ascii "Because of unusual Radix = %f\000"
L.160:.ascii "\011U2 = %.7e, Z2 - U2 = %.7e\012\000"
L.159:.ascii "\011U1 = %.7e, Z1 - U1 = %.7e\012\000"
L.158:.ascii "Precision\000"
L.157:.byte 0
L.150:.ascii "That feature is not tested further by this program.\012\000"
L.145:.ascii "Possibly some part of this\000"
L.144:.ascii "by extra-precise evaluation of arithmetic subexpressions.\012\000"
L.143:.ascii "are symptoms of inconsistencies introduced\012\000"
L.142:.ascii "respectively  %.7e,  %.7e,  %.7e,\012\000"
L.141:.ascii "Disagreements among the values X1, Y1, Z1,\012\000"
L.119:.ascii "Precision worse than 5 decimal figures  \000"
L.117:.ascii "The number of significant digits of the Radix is %f .\012\000"
L.116:.ascii "logarithmic encoding has precision characterized solely by U1.\012"
.ascii "\000"
L.113:.ascii "of significant digits but, by itself, this is a minor flaw.\012\000"
L.112:.ascii "Precision cannot be characterized by an Integer number\012\000"
L.99:.ascii "Comparison is fuzzy,X=1 but X-1/2-1/2 != 0\000"
L.95:.ascii "(1-U1)-1/2 < 1/2 is FALSE, prog. fails?\000"
.align 3; L.93:.word 0x40240000
.word 0x0
L.88:.ascii "Radix is not as good as 2 or 10\000"
L.84:.ascii "Radix is too big: roundoff problems\000"
L.82:.ascii "MYSTERY: recalculated Radix = %.7e .\012\000"
L.81:.ascii "Radix confirmed.\012\000"
.align 3; L.78:.word 0x3f847ae1
.word 0x47ae147a
L.77:.ascii "gets better closest relative separation U1 = %.7e .\012\000"
L.76:.ascii "confirms closest relative separation U1 .\012\000"
L.61:.ascii "Recalculating radix and precision\012 \000"
L.60:.ascii "Closest relative separation found is U1 = %.7e .\012\012\000"
L.54:.ascii "Radix = %f .\012\000"
L.45:.ascii "Searching for Radix and Precision.\012\000"
L.44:.byte 10,0
L.43:.ascii "-1, 0, 1/2, 1, 2, 3, 4, 5, 9, 27, 32 & 240 are O.K.\012\000"
L.38:.ascii "5 != 4+1, 240/3 != 80, 240/4 != 60, or 240/5 != 48\000"
L.34:.ascii "9 != 3*3, 27 != 9*3, 32 != 8*4, or 32-27-4-1 != 0\000"
L.30:.ascii "1/2 + (-1) + 1/2 != 0\000"
L.26:.ascii "-1+1 != 0, (-1)+abs(1) != 0, or -1+(-1)*(-1) != 0\000"
L.22:.ascii "3 != 2+1, 4 != 3+1, 4+2*(-2) != 0, or 4-3-1 != 0\000"
.align 3; L.20:.word 0x3f50624d
.word 0xd2f1a9fb
L.19:.ascii "Comparison alleges that -0.0 is Non-zero!\012\000"
L.14:.ascii "0+0 != 0, 1-1 != 0, 1 <= 0, or 1+1 != 2\000"
L.12:.ascii "Program is now RUNNING tests on small integers:\012\000"
.align 3; L.8:.word 0x3ff00000
.word 0x0
.align 3; L.7:.word 0x0
.word 0x0
L.2:.ascii "\012* * * FLOATING-POINT ERROR * * *\012\000"
