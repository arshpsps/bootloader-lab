[org 0x7C00]

;; completely clean all registers, apparantly to avoid undefined behavior
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7C00

mov si, message ; mov message address into source index register

.print:
lodsb ; just google or chatgpt ds:si, its weird af, it does increment SI, so basically next character address
or al, al ; check if al is zero (string empty / null terminated)
jz .done ; if it is empty, jump to .done
mov ah, 0x0E ; switch bios mode to "teletype"
int 0x10 ; bios interrupt (basically bios ka syscall) for print
jmp .print ; loop for next letter / character

.done:
cli ; clean interrupts
hlt ; halt cpu, infinite

message db "hi poo", 0 ; null terminated string, ascii

;; so real mode / bios spec expects the last 2 bytes (510, 511) of bootloader to be a "boot signature",
;; "boot signature" just a magic number that bios reads and goes "oh this is bootable"
times 510-($-$$) db 0 ; this is padding magic to go to the 2nd last byte, cuz out program is prolly smaller
dw 0xAA55 ; boot signature, puts 0x55 in byte 510 and 0xAA in byte 511
