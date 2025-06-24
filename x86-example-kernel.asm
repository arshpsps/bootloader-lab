[org 0x0500]
[BITS 16]

start:
    mov ax, 0xB800 ;; video memory segment
    mov es, ax
    xor di, di ;; di is basically cursor placement

    mov cx, 80 * 25 ;; cx is how many times the "rep" instruction is repeated
    mov ax, 0x0720 ;; clear ' '
    rep stosw ;; repeats stosw, writing ax content each time

    xor di, di ;; resets di to 0,0 position

    mov si, message
.next_char:
    lodsb ;; get a char into al, increment SI
    or al, al ;; check if al char is null
    jz .done ;; if null, move to done
    mov ah, 0x07 ;; ah has attributes (color info for writing to video)
    stosw ;; writes ax, ax = ah (high bits, attributes) + al (low bits, text char)
    jmp .next_char

.done:
    jmp $

message db "kernel hello!", 0
