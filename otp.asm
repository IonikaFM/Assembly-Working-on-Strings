%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext asdgqasd
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

    mov eax, 0

    loop:
        mov [ebp - 4], ecx
        mov [ebp - 8], eax
        mov ecx, eax
        movzx eax, BYTE[esi + ecx]
        movzx ebx, BYTE[edi + ecx]
        xor eax, ebx
        mov BYTE[edx + ecx], al
        mov ecx, [ebp - 4]
        mov eax, [ebp - 8]
        inc eax
        cmp eax, ecx 
        jl loop

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY