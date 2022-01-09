%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

    mov ebx, 0
    loop:
        movzx eax, BYTE[esi + ebx]
        ;;PRINTF32 `%d\n\x0`, eax
        cmp eax, 65
        jl increase
        cmp eax, 122
        jg increase
        cmp eax, 90
        jle upper
        cmp eax, 97
        jge lower
        jmp increase
        
    lower:
        add eax, edi
        jmp compareLow

    upper:
        add eax, edi
        jmp compareUp

    gobacktolow:
        sub eax, 122
        add eax, 96
        jmp compareLow

    gobacktoup:
        sub eax, 90
        add eax, 64
        jmp compareUp

    compareLow:
        cmp eax, 122
        jg gobacktolow
        jmp increase

    compareUp:
        cmp eax, 90
        jg gobacktoup
        jmp increase

    increase:
        mov BYTE[edx + ebx], al
        inc ebx
        cmp ebx, ecx 
        jl loop

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY