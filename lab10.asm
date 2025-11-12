; Example1.asm
COMMENT!
Name: M Hasnain Siddiqui
Roll no: 24K-0516 !

.data
var1 DWORD 5
var2 DWORD 6

.code
    push var2
    push var1
    call AddTwo
    exit

AddTwo PROC
    push ebp
    mov ebp, esp
    ; core: read arguments and add (example as minimal core)
    mov eax, [ebp + 8]
    add eax, [ebp + 12]
    pop ebp
    ret
AddTwo ENDP
; Example2.asm
COMMENT!
Name: M Hasnain Siddiqui
Roll no: 24K-0516 !

.data
var1 DWORD 5
var2 DWORD 6

.code
    push var2
    push var1
    call AddTwo
    exit

AddTwo PROC
    push ebp
    mov ebp, esp
    mov eax, [ebp + 12]
    add eax, [ebp + 8]
    pop ebp
    ret
AddTwo ENDP
; Example3.asm
COMMENT!
Name: M Hasnain Siddiqui
Roll no: 24K-0516 !

.data
; (manual shows WORD/DUFl placeholders — core call shown)
myWord WORD 1234h

.code
    ; calling some routine that returns/uses word-sized values
    call RandomRange
    exit

RandomRange PROC
    push ebp
    mov ebp, esp
    ; (core: placeholder for logic that uses stack/returns a WORD in AX)
    ; ... (implementation depends on lab text)
    pop ebp
    ret
RandomRange ENDP
; Example4.asm
COMMENT!
Name: M Hasnain Siddiqui
Roll no: 24K-0516 !

.code
    call makeArray
    exit

makeArray PROC
    push ebp
    mov ebp, esp
    sub esp, 32           ; reserves 32 bytes of local space on stack
    lea esi, [ebp - 32]   ; load effective address of local array into ESI
    ; core: (use ESI as pointer to local array)
    ; ... (array initialization/manipulation)
    add esp, 32           ; free local 32 bytes
    pop ebp
    ret
makeArray ENDP
; Example5.asm
COMMENT!
Name: M Hasnain Siddiqui
Roll no: 24K-0516 !

.code
    call MySub
    exit

MySub PROC
    push ebp
    mov ebp, esp
    sub esp, 8                ; allocate 8 bytes of local space
    mov DWORD PTR [ebp - 4], 10   ; first local = 10
    mov DWORD PTR [ebp - 8], 20   ; second local = 20
    mov esp, ebp
    pop ebp
    ret
MySub ENDP
; Example6.asm
COMMENT!
Name: M Hasnain Siddiqui
Roll no: 24K-0516 !

.data
var1 DWORD 5
var2 DWORD 6

.code
    push var2
    push var1
    call AddTwo
    exit

AddTwo PROC
    enter 0, 0            ; automatically creates stack frame
    mov eax, [ebp + 12]
    add eax, [ebp + 8]
    leave                 ; reverses enter
    ret
AddTwo ENDP
; Example7.asm
COMMENT!
Name: M Hasnain Siddiqui
Roll no: 24K-0516 !

.code
; Demonstrates LOCAL directive (core form)
ProcWithLocals PROC
    push ebp
    mov ebp, esp
    LOCAL a:DWORD, b:DWORD
    ; use locals via their stack offsets
    mov DWORD PTR [ebp-4], 100
    mov DWORD PTR [ebp-8], 200
    ; ... core local use
    mov esp, ebp
    pop ebp
    ret
ProcWithLocals ENDP
; Example8.asm
COMMENT!
Name: M Hasnain Siddiqui
Roll no: 24K-0516 !

.code
; Core recursive procedure example (factorial-like)
    ; call Factorial example:
    ; push 5
    ; call Fact
    ; exit

Fact PROC
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]     ; n
    cmp eax, 1
    jle .base
    dec eax
    push eax                ; push (n-1)
    call Fact               ; recursive call -> returns in EAX (fact(n-1))
    mov ebx, [ebp + 8]     ; original n
    mul ebx                ; EDX:EAX = EAX * EBX (core multiply)
    jmp .done
.base:
    mov eax, 1
.done:
    pop ebp
    ret
Fact ENDP

