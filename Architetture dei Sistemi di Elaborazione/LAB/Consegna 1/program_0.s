
.data
  v1:  	.byte    	2, 6, -3, 11, 9, 11, -3, 6, 2
  v2:  	.byte    	4, 7, -10,3, 11, 9, 7, 6, 4
  v3:  	.byte    	9, 22, 5, -1, 9, -1, 5, 22, 9
  f1: .space 1
  f2: .space 1
  f3: .space 1
  v4: .space 9 

.text;----------------
; Program lab_01.s
;----------------

MAIN:   daddui R1, R0, 8     ;inizialize R1 to the length of the array
        dadd R2, R0, R0     ;inzialize R2 to 0 for count


LOOPV1: beq R1, R2, PALV1
        lb R3, v1(R2)
        lb R4, v1(R1)
        bne R3, R4, EXIT_V1
        daddi R1, R1, -1    
        daddui R2, R2, 1    
        j LOOPV1

PALV1:  daddui R21, R0, 1
        sb R21, f1(R0);storing 1 to the flag that indicates that v1 is palindrome
EXIT_V1:
V2:     daddui R1, R0, 8
        dadd R2, R0, R0
LOOPV2: beq R1, R2, PALV2
        lb R3, v2(R2)
        lb R4, v2(R1)
        bne R3, R4, EXIT_V2
        daddi R1, R1, -1
        daddui R2, R2, 1
        j LOOPV2

PALV2:  daddui R21, R0, 1
        sb R21, f2(R0);storing 1 to the flag that indicates that v2 is palindrome
EXIT_V2: 
V3:     daddui R1, R0, 8
        dadd R2, R0, R0
LOOPV3: beq R1, R2, PALV3
        lb R3, v3(R2)
        lb R4, v3(R1)
        bne R3, R4, EXIT_V3
        daddi R1, R1, -1
        daddui R2, R2, 1
        j LOOPV3

PALV3:  daddui R21, R0, 1
        sb R21, f3(R0);storing 1 to the flag that indicates that v3 is palindrome
EXIT_V3:
SUM:    dadd R13, R0, R0 ;sum
        dadd R14, R0, R0 ;counter
        daddui R15, R0, 9 ;index
        
        lb R21,f1(R0) ;these loads may be omitted but ill keep them here anyways
        lb R22,f2(R0)
        lb R23,f3(R0)
LOOPSUM:
        beq R14, R15, EXIT_SUM
SUMV1:
        beqz R21, SUMV2
        lb R16, v1(R14)
        dadd R13, R13, R16
SUMV2:
        beqz R22, SUMV3
        lb R17, v2(R14)
        dadd R13, R13, R17
SUMV3:    
        beqz R23, INCREMENT
        lb R18, v3(R14)
        dadd R13, R13, R18        
INCREMENT:    
        sb R13,v4(R14)
        daddi R14, R14, 1
        daddi R13, R0, 0

        j LOOPSUM
EXIT_SUM: 
        HALT