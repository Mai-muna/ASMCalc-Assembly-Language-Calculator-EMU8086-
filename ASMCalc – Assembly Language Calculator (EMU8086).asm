.MODEL SMALL
 
.STACK 100H

.DATA 
    menu db "Basic Calculator in Assembly (EMU8086)", 0Dh, 0Ah, "$"
    menu_ops db "Choose an operation:", 0Dh, 0Ah,'$'
    ops db "1. Addition", 0Dh, 0Ah,
        db "2. Subtraction", 0Dh, 0Ah
        db "3. Multiplication", 0Dh, 0Ah,
        db "4. Division", 0Dh, 0Ah
        db "5. Decimal to Binary", 0Dh, 0Ah,
        db "6. Decimal to Hexadecimal", 0Dh, 0Ah
        db "7. Power", 0Dh, 0Ah,
        db "8. Square Root", 0Dh, 0Ah
        db "9. Factorial", 0Dh, 0Ah,
        db "10. Permutation", 0Dh, 0Ah, 
        db "11. Combination", 0DH, 0AH,"$"
    msg_01 db 'Please enter the decimal number: $'
    msg_02 db 0Dh, 0Ah, 'Binary number: $'  
    msg_03 db 0Dh, 0Ah, 'Hexadecimal number: $'
    enter_num db "Enter a number: $"
    invalid_choice db "Invalid choice, try again! $"
    result_msg db "Result: $"
    remainder_msg db "Remainder: $"
    newline db 0Dh, 0Ah, "$"
    end_msg db 'Do you want to continue?', 0Dh, 0Ah,
            db '1.YES   2.No $'
    num1 dw ?
    num2 dw ?
    res dw 0
    remainder dw ?
    NUMBER dw ?
    

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX

;-----------DISPLAY----------------
Display_menu:

    LEA DX, newline
    MOV AH,09H
    int 21h
    
    LEA DX, menu
    MOV AH, 09H
    INT 21H
    
    LEA DX, menu_ops
    MOV AH, 09H
    INT 21H
    
    LEA DX, ops
    MOV AH, 09H
    INT 21H

user_choice:
    mov ah,1
    int 21h
    sub al,30h
    mov ah,10
    mul ah 
    add num1,ax 

    mov ah,1
    int 21h
    sub al,30h
    mov ah,0
    add num1,ax
    mov bx, num1



LEA DX, newline
MOV AH,09H
int 21h 

op_selection:
    cmp bx, 1
    je Addition
    cmp bx, 2
    je Subtraction
    cmp bx, 3
    je Multiplication
    cmp bx, 4
    je Division
    CMP bx, 5  
    je Decimal_to_binary
    cmp bx, 6
    je Decimal_to_hex
    cmp bx, 7                            
    je power
    cmp bx, 8
    je SquareRoot
    cmp bx, 9
    je Factorial
    cmp bx, 10
    je permutation
    cmp bx, 11
    je combination

display_result proc
    LEA DX, newline
    MOV AH,09H
    int 21h 
    
    LEA DX, result_msg
    MOV AH,09H
    int 21h 
    
    MOV AX, 0  
    MOV DX, 0 
    MOV AX, res    
    MOV NUMBER, AX  
    MOV CX, 4                                     
    MOV BX, 1000
    PRINT_DIGITS: 
        mov dx, 0      
        MOV AX, NUMBER  
        DIV BX           
        MOV NUMBER, DX  

        ADD AL, 30H      
        MOV DL, AL
        MOV AH, 2
        INT 21H  

        MOV AX, BX       
        MOV DX, 0
        MOV BX, 10
        DIV BX
        MOV BX, AX
    LOOP PRINT_DIGITS
 

    RET
display_result endp

display_remainder proc
    LEA DX, newline
    MOV AH,09H
    int 21h 
    
    LEA DX, remainder_msg
    MOV AH,09H
    int 21h 
    
    MOV AX, 0  
    MOV DX, 0 
    MOV AX, remainder    
    MOV NUMBER, AX  
    MOV CX, 4                                     
    MOV BX, 1000
    PRINT_DIGITS_rem: 
        mov dx, 0     
        MOV AX, NUMBER  
        DIV BX           ; AX / BX
        MOV NUMBER, DX  

        ADD AL, 30H
        MOV DL, AL
        MOV AH, 2
        INT 21H  

        MOV AX, BX
        MOV DX, 0
        MOV BX, 10
        DIV BX
        MOV BX, AX
    LOOP PRINT_DIGITS_rem
 

    RET
display_remainder endp

;-----------INPUT----------------
Get_num1 proc
     
        LEA DX, enter_num
        MOV AH,09H
        int 21h 
    
        mov ah,1
        int 21h
        sub al,30h
        mov ah,0
        mov cx,1000
        mul cx 
        mov num1,ax
    
        mov ah,1
        int 21h
        sub al,30h
        mov ah,100
        mul ah 
        add num1,ax 
    
        mov ah,1
        int 21h
        sub al,30h
        mov ah,10
        mul ah 
        add num1,ax 
    
        mov ah,1
        int 21h
        sub al,30h
        mov ah,0
        add num1,ax   
        
        LEA DX, newline
        MOV AH,09H
        int 21h
    RET
Get_num1 endp


Get_num2 proc
     
        LEA DX, enter_num
        MOV AH,09H
        int 21h 
    
        mov ah,1
        int 21h
        sub al,30h
        mov ah,0
        mov cx,1000
        mul cx 
        mov num2,ax
    
        mov ah,1
        int 21h
        sub al,30h
        mov ah,100
        mul ah 
        add num2,ax 
    
        mov ah,1
        int 21h
        sub al,30h
        mov ah,10
        mul ah 
        add num2,ax 
    
        mov ah,1
        int 21h
        sub al,30h
        mov ah,0
        add num2,ax   
    
        LEA DX, newline
        MOV AH,09H
        int 21h 
    RET
Get_num2 endp

;----------OPERATIONS-------------
Addition:
    call Get_num1
    call Get_num2
    MOV AX, num1
    ADD AX, num2
    MOV res, AX
    call display_result
    jmp repeat
    
Subtraction:
    call Get_num1
    call Get_num2
    MOV AX, num1
    SUB AX, num2
    MOV res, AX
    call display_result
    jmp repeat
        
Multiplication:
    call Get_num1
    call Get_num2
    MOV AX, num1
    MUL num2
    MOV res, AX
    call display_result
    jmp repeat
    
Division:
    call Get_num1
    call Get_num2
    MOV AX, num1
    MOV DX, 0
    DIV num2
    MOV res, AX 
    MOV remainder, DX 
    call display_result
    call display_remainder
    jmp repeat
    
power:
    call Get_num1
    LEA DX, enter_num
    MOV AH,09H
    int 21h
    mov ah,1
    int 21h
    sub al,30h
    mov ah,0
    mov bx, ax
    mov cx, num1
    mov ax, num1
    mov res, ax
    p:
        mov ax, res
        mul cx
        mov res, ax
        dec bx
        cmp bx,1
        jg p
    call display_result
    jmp repeat
    
Factorial:
    CALL Get_num1           
    MOV CX, num1             
    MOV AX, 1                
    Factorial_Loop:
        MUL CX                   
        DEC CX                   
        JZ Factorial_Done        
        JMP Factorial_Loop
    Factorial_Done:
        MOV res, AX          
        call display_result
    jmp repeat
        
SquareRoot:
    mov ax, 0
    mov dx, 0
    mov bx, 0
    mov cx, 0
    
    CALL Get_num1
    MOV AX, num1         
    CMP AX, 0
    JE SquareRoot_Done    

    MOV CX, 0            
    MOV BX, 1              

    SquareRoot_Loop:
    	SUB AX, BX            
    	JL SquareRoot_Done    
    	INC CX                
    	ADD BX, 2             
    	JMP SquareRoot_Loop       
    
    SquareRoot_Done:
    	MOV res, CX           
    	CALL display_result
    JMP repeat


Decimal_to_binary:    
    
    mov ah, 09h
    lea dx, msg_01
    int 21h

    mov ah,1
    int 21h
    sub al,30h
    mov ah,0
    mov cx,10
    mul cx 
    mov num1,ax

    mov ah,1
    int 21h
    sub al,30h
    mov ah,0 
    add num1,ax         

   
    mov ax, num1
    mov bx, 2
    mov cx, 0
    mov dx, 0

    BinLoop:
        div bx             
        push dx           
        inc cx
        mov dx, 0
        cmp ax, 0
        jne BinLoop
    
        mov ah, 09h
        lea dx, msg_02
        int 21h

    PrintLoop:
        pop dx
        add dl, '0'       
        mov ah, 02h
        int 21h
        loop PrintLoop
    
        jmp repeat

Decimal_to_hex:

    mov ah, 09h
    lea dx, msg_01
    int 21h

    mov ah,1
    int 21h
    sub al,30h
    mov ah,0
    mov cx,10
    mul cx 
    mov num1,ax

    mov ah,1
    int 21h
    sub al,30h
    mov ah,0 
    add num1,ax           

   
    mov ah, 09h
    lea dx, msg_02
    int 21h

   
    mov ax, num1
    mov bx, 16           
    mov cx, 0          
    mov dx, 0

    HexLoop:
        div bx              
        push dx              
        inc cx
        mov dx, 0
        cmp ax, 0
        jne HexLoop
    
    PrintHex:
        pop dx
        cmp dl, 9
        jbe Digit
        add dl, 7           
    Digit:
        add dl, '0'
        mov ah, 02h
        int 21h
        loop PrintHex
    
        jmp repeat

    
    
permutation:
    call Get_num1
    call Get_num2
    mov dx, num1
    mov bx, num2    
    sub dx, bx
    mov bx,dx
    MOV AX, 1                
    loop1:
        MUL bX                    
        DEC bX                    
        JZ loop1_Done       
        JMP loop1
    loop1_Done:
        MOV cx, AX
    mov bx, num1
    mov ax, 1
    loop2:
        MUL bX                    
        DEC bX                    
        JZ loop2_done         
        JMP loop2
    loop2_done:    
        div cx
        mov res, ax    
        call display_result
    jmp repeat

combination:
    call Get_num1
    call Get_num2
    mov dx, num1
    mov bx, num2
    sub dx, bx
    mov bx,dx
    MOV AX, 1                
    loop4:
        MUL bX                    
        DEC bX                    
        JZ loop4_Done       
        JMP loop4
    loop4_Done:
        MOV cx, AX
    mov bx, num1
    mov ax, 1
    loop5:
        MUL bX                    
        DEC bX                    
        JZ loop5_done         
        JMP loop5
    loop5_done:    
        div cx
        mov remainder, ax
    mov bx, num2
    mov ax, 1
    loop3:
        MUL bX                    
        DEC bX                    
        JZ loop3_done         
        JMP loop3
    loop3_done:
        mov cx, ax
        mov ax, remainder
        div cx
        mov res, ax        
        call display_result
    jmp repeat

;-------------RESTART-----------        
repeat:
    
    mov num1, 0
    mov num2, 0
    mov NUMBER, 0
    mov remainder, 0
    mov res, 0
    mov ax, 0
    mov bx, 0
    mov cx, 0
    mov dx, 0
    
    LEA DX, newline
    MOV AH,09H
    int 21h
    
    LEA DX, end_msg
    MOV AH, 09H
    INT 21H
    
    LEA DX, newline
    MOV AH,09H
    int 21h
    
    mov ah,1
    int 21h
    sub al,30h
    mov bl, al
    cmp bl, 1
    je display_menu
    jmp end

        
    
end:    
    MOV AX,4C00H
    INT 21H

   