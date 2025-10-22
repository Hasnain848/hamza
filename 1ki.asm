INCLUDE Irvine32.inc

.data
M1 BYTE "Example 1: Stack Loop Demo", 0
M2 BYTE "Final Value: ", 0

.code
main PROC
mov ebx, 0 
mov ecx, 5
mov edx, OFFSET M1
call WriteString
call Crlf

OUTER_L:
push ecx 
mov ecx, 10

INNER_L:
inc ebx
loop INNER_L

pop ecx 
loop OUTER_L

call Crlf
mov edx, OFFSET M2
call WriteString
mov eax, ebx
call WriteDec
call Crlf

exit
main ENDP
END main

INCLUDE Irvine32.inc

.data
V1 WORD 15
V2 WORD 25
M1 BYTE "Initial Values: ", 0
M2 BYTE "Sum after POP: ", 0
M3 BYTE "Final Result: ", 0
SP BYTE " ", 0

.code
main PROC
call Crlf

mov edx, OFFSET M1
call WriteString

movzx eax, V1 
call WriteDec
mov edx, OFFSET SP
call WriteString
movzx eax, V2 
call WriteDec
call Crlf

mov ax, V1 
push ax      
mov ax, V2 
push ax      

pop bx       
pop ax       
add ax, bx   

call Crlf
mov edx, OFFSET M2
call WriteString
movzx eax, ax 
call WriteDec
call Crlf

push ax 
pop bx  

call Crlf
mov edx, OFFSET M3
call WriteString
movzx eax, bx 
call WriteDec
call Crlf

exit
main ENDP
END main

INCLUDE Irvine32.inc

.data
V_HIST WORD 101, 102, 103, 104, 105
R_HIST WORD 5 DUP(?)

M1 BYTE "Original History:", 0
M2 BYTE "Rollback Order:", 0
SP BYTE " ", 0

A_SZ = (LENGTHOF V_HIST)
E_SZ = (TYPE V_HIST)

.code
main PROC
call Crlf

mov edx, OFFSET M1
call WriteString
call Crlf

mov ecx, A_SZ
mov esi, OFFSET V_HIST

LBL_DO:
movzx eax, WORD PTR [esi] 
call WriteDec
mov edx, OFFSET SP
call WriteString
add esi, E_SZ
loop LBL_DO

call Crlf

mov ecx, A_SZ 
mov esi, OFFSET V_HIST

LBL_PV:
mov ax, [esi]       
push ax             
add esi, E_SZ
loop LBL_PV

mov ecx, A_SZ 
mov edi, OFFSET R_HIST

LBL_P2V:
pop ax              
mov [edi], ax       
add edi, E_SZ
loop LBL_P2V

call Crlf
mov edx, OFFSET M2
call WriteString
call Crlf

mov ecx, A_SZ 
mov esi, OFFSET R_HIST

LBL_DR:
movzx eax, WORD PTR [esi]
call WriteDec
mov edx, OFFSET SP
call WriteString
add esi, E_SZ
loop LBL_DR

call Crlf

exit
main ENDP
END main

INCLUDE Irvine32.inc

.data
MULTIPLIER DWORD 2
M1 BYTE "Product is: ", 0

.code
main PROC
mov eax, 1 
mov ecx, 3

LBL_PUSH:
push MULTIPLIER 
add MULTIPLIER, 2
loop LBL_PUSH

mov ecx, 3

LBL_MUL:
pop ebx 
mul ebx 
loop LBL_MUL

mov edx, OFFSET M1
call WriteString
call WriteDec
call CrLf

exit
main ENDP
END main

INCLUDE Irvine32.inc

.data
M1 BYTE "Largest number is:", 0

.code
main PROC
push 5 
push 7
push 3
push 2 

mov eax, 0 
mov ecx, 4

LBL1:
pop edx 
cmp edx, eax
jle SKIP

mov eax, edx

SKIP:
loop LBL1

mov edx, OFFSET M1
call WriteString
call WriteDec
call CrLf

exit
main ENDP
END main

INCLUDE Irvine32.inc

.data
M1 BYTE "Flags saved.", 0
M2 BYTE "Flags restored.", 0

.code
main PROC
mov eax, 5
sub eax, 5 

pushfd

mov edx, OFFSET M1
call WriteString
call CrLf

mov eax, 10
add eax, 1 

popfd

mov edx, OFFSET M2
call WriteString
call CrLf

call DumpRegs 

exit
main ENDP
END main


INCLUDE Irvine32.inc

.data
V_A WORD 5
V_B WORD 6
M1 BYTE "The sum is: ", 0

.code
PROC_A PROC
movzx eax, V_A
add eax, V_B
ret
PROC_A ENDP

main PROC
call PROC_A

mov edx, OFFSET M1
call WriteString
call WriteDec
call CrLf

exit
main ENDP
END main

INCLUDE Irvine32.inc

I_COUNT = 3

.data
M1 BYTE "Enter a signed Integer: ", 0
M2 BYTE "The sum of the Integers is: ", 0
DATA_ARR DWORD I_COUNT DUP(?)

.code
PROC_IN PROC USES ecx edx esi 
LBL_IN:
mov edx, OFFSET M1
call WriteString
call ReadInt
call CrLf
mov [esi], eax
add esi, TYPE DWORD 
loop LBL_IN
ret
PROC_IN ENDP

PROC_SUM PROC USES esi ecx 
mov eax, 0
LBL_SUM:
add eax, [esi]
add esi, TYPE DWORD
loop LBL_SUM
ret
PROC_SUM ENDP

PROC_OUT PROC USES edx 
mov edx, OFFSET M2
call WriteString
call WriteDec
call CrLf
ret
PROC_OUT ENDP

main PROC
call Clrscr

mov esi, OFFSET DATA_ARR
mov ecx, I_COUNT
call PROC_IN

mov esi, OFFSET DATA_ARR
mov ecx, I_COUNT

call PROC_SUM
call PROC_OUT

exit
main ENDP
END main

INCLUDE Irvine32.inc

.data
V_A DWORD 5
V_B DWORD 6
M1 BYTE "Sum in PROC_A: ", 0
M2 BYTE "Values in PROC_B: ", 0

.code
PROC_B PROC USES edx
mov edx, OFFSET M2
call WriteString
call CrLf

movsx eax, V_A
call WriteInt   
call CrLf

movsx eax, V_B
call WriteInt
call CrLf

ret
PROC_B ENDP

PROC_A PROC USES edx
mov eax, V_A
mov ebx, V_B
add eax, ebx

mov edx, OFFSET M1
call WriteString
call WriteInt
call CrLf

call PROC_B

ret
PROC_A ENDP

main PROC
call PROC_A
call CrLf

exit
main ENDP
END main