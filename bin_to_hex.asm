%include "io.mac"

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    mov eax, ecx
    sub eax, 1
    mov edi, 0
    mov esi, 0
    mov edx, 0
    mov [ebp - 4], esi
    while:
        mov esi, [ebp + 12]
        movzx ebx, BYTE[esi + eax]
        cmp edi, 0
        je is0
        cmp edi, 1
        je is1
        cmp edi, 2
        je is2
        cmp edi, 3
        je is3
        cmp edi, 4
        je goToZero
        sum:
            cmp ebx, 0x30
            je BinIs0
            makeAdd:
                add edx, esi
        sub eax, 1
        inc edi
        cmp eax, 0xffffffff
        jg while
        jmp verify

    BinIs0:
        mov esi, 0
        jmp makeAdd

    is0:
        mov esi, 1
        jmp sum

    is1:
        mov esi, 2
        jmp sum

    is2:
        mov esi, 4
        jmp sum

    is3:
        mov esi, 8
        jmp sum

    goToZero:
        cmp edx, 9
        jle digit
        jg letter
        string:
            push edx
            ;PRINTF32 `%hx\n\x0`, edx
            mov esi, [ebp - 4]
            inc esi
            mov [ebp - 4], esi
            mov edi, 0
            mov edx, 0
            jmp is0

    letter:
        sub edx, 10
        add edx, 65
        jmp string

    digit:
        add edx, 48
        jmp string

    verify:
        cmp edi, 0
        jne pushLast
        jmp jump
    
    pushLast:
        cmp edx, 9
        jle digit1
        jg letter1
        string1:
            push edx
            mov esi, [ebp - 4]
            inc esi
            mov [ebp - 4], esi
            jmp jump

    letter1:
        sub edx, 10
        add edx, 65
        jmp string1

    digit1:
        add edx, 48
        jmp string1

    jump:
        mov eax, 0
        mov edi, [ebp - 4]
        mov edx, [ebp + 8]
        jmp popAll

    popAll:
        pop ebx
        mov BYTE[edx + eax], bl
        inc eax
        cmp eax, edi
        jl popAll
        jmp end

    end:
        ;; DO NOT MODIFY
        mov ebx, 10
        mov BYTE[edx + edi], bl
        popa
        leave
        ret
        ;; DO NOT MODIFY