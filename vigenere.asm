%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    mov ebx, 0
    mov ecx, 0
    while:
        movzx eax, BYTE[esi + ebx]
        cmp eax, 65
        jl increase
        cmp eax, 122
        jg increase
        cmp eax, 90
        jg comp
        continue:
            mov edx, [ebp + 24]
            cmp ecx, edx
            jge grt
            jl lw

    comp:
        cmp eax, 97
        jl increase
        jmp continue

    grt:
        sub ecx, edx
        cmp ecx, edx
        jge grt
        movzx edx, BYTE[edi + ecx]
        inc ecx
        cmp edx, 90
        jle upper
        cmp edx, 97
        jge lower

    lw:
        movzx edx, BYTE[edi + ecx]
        inc ecx
        cmp edx, 90
        jle upper
        cmp edx, 97
        jge lower

    upper:
        sub edx, 65
        cmp eax, 90
        jle compareUp
        cmp eax, 97
        jge compareLow

    lower:
        sub edx, 97
        cmp eax, 90
        jle compareUp
        cmp eax, 97
        jge compareLow

    gobacktolow:
        sub eax, 122
        add eax, 96
        jmp increase

    gobacktoup:
        sub eax, 90
        add eax, 64
        jmp increase

    compareLow:
        add eax, edx
        cmp eax, 122
        jg gobacktolow
        jmp increase

    compareUp:
        add eax, edx
        cmp eax, 90
        jg gobacktoup
        jmp increase

    increase:
        mov edx, [ebp + 8]
        mov BYTE[edx + ebx], al
        mov [ebp + 8], edx
        mov edx, [ebp + 16]
        inc ebx
        cmp ebx, edx 
        jl while

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY