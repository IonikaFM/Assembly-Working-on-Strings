%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    mov ecx, 0
    while:
        movzx eax, BYTE[esi + ecx]
        movzx edx, BYTE[ebx]
        cmp eax, edx
        je equal
        jmp increase

    equal:
        mov edi, 0
        mov edx, [ebp + 24]
        mov [ebp - 4], ecx
        cmp edx, 1
        je final
        compare:
            inc ecx 
            inc edi
            mov ebx, [ebp + 20]
            cmp ecx, ebx
            jge getBack
            mov ebx, [ebp + 24]
            sub ebx, 1
            cmp edi, ebx
            ;sub ebx, 1
            jg getBack
            je final
            mov ebx, [ebp + 16]
            movzx eax, BYTE[esi + ecx]
            movzx edx, BYTE[ebx + edi]
            cmp eax, edx
            je compare
            jmp getBack

    final:
        mov ebx, [ebp + 16]
        movzx eax, BYTE[esi + ecx]
        movzx edx, BYTE[ebx + edi]
        cmp eax, edx
        jne getBack
        mov ecx, [ebp - 4]
        mov edi, ecx
        mov eax, [ebp + 8]
        mov [eax], edi
        jmp end
            
    getBack:
        mov ecx, [ebp - 4]

    increase:
        ;PRINTF32 `%d\n\x0`, ecx 
        inc ecx
        mov edx, [ebp + 20]
        cmp ecx, edx 
        jl while
        inc ecx
        mov edi, ecx
        mov eax, [ebp + 8]
        mov [eax], edi
        jmp end

    ;; DO NOT MODIFY
    end:
        ;PRINTF32 `%d\n\x0`, edi
        popa
        leave
        ret
    ;; DO NOT MODIFY