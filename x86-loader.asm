[org 0x7C00] ;; org = origin

xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7C00

mov si, message
call print

readmem:
xor ax, ax
mov es, ax
mov bx, 0x0500

mov ah, 0x02
mov al, 1
mov ch, 0
mov cl, 2
mov dh, 0
mov dl, 0x80
int 0x13

jc disk_error

jmp 0x0000:0x0500


disk_error:
mov si, error_msg
call print
hlt

print:
lodsb
or al, al
jz print_done
mov ah, 0x0E
int 0x10
jmp print

print_done:
ret

message db "hi from loader", 0
error_msg db "error loading from disk", 0

times 510-($-$$) db 0
dw 0xAA55
