.MODEL SMALL
.STACK 100H
.DATA

N1 DW ?
N2 DW ?
CR EQU 0DH

.CODE
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    
     ; fast BX = 0
    XOR BX, BX
    
    INPUT_LOOP1:
    ; char input 
    MOV AH, 1
    INT 21H
    
    ; if \n, stop taking input
    CMP AL, CR    
    JE END_INPUT_LOOP1
    
    ; fast char to digit
    ; also clears AH
    AND AX, 000FH
    
    ; save AX 
    MOV CX, AX
    
    ; BX = BX * 10 + AX
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX
    JMP INPUT_LOOP1
    
    END_INPUT_LOOP1:
    MOV N1, BX
                        
    XOR BX, BX
    XOR AX,AX
    MOV AH,2
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H 
    
    INPUT_LOOP2:
    ; char input 
    MOV AH, 1
    INT 21H
    
    ; if \n, stop taking input
    CMP AL, CR    
    JE  END_INPUT_LOOP2
    
    ; fast char to digit
    ; also clears AH
    AND AX, 000FH
    
    ; save AX 
    MOV CX, AX
    
    ; BX = BX * 10 + AX
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX 
    JMP INPUT_LOOP2
    
    END_INPUT_LOOP2:
    MOV N2, BX
    XOR AX,AX
    XOR BX,BX
    XOR DX,DX 
    MOV AX,N1
    MOV BX,N2 
    
    
    GCD:
    CMP AX,BX
    JA GREATER
    JB SMALLER
    JE ENDC
     
    GREATER:
    MOV DX,AX
    SUB DX,BX
    MOV AX,DX
    JMP GCD
    
    SMALLER:
    MOV DX,BX
    SUB DX,AX
    MOV BX,DX
    JMP GCD
    
                        
    
    ENDC:
    MOV AH,2
    XOR BX,BX
    MOV BX,DX
    MOV DX,DX
    MOV DL,13
    INT 21H
    MOV DL,10
    INT 21H 
    XOR DX,DX
    MOV DX,BX
    ADD DX,48 
    INT 21H
    MOV AH,4CH
    INT 21H
    
    
MAIN ENDP
END MAIN