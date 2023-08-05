org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main


; prints string using bios
; ds:si - points to zero-terminted string
puts:
    ; save registers
    push si
    push ax

.loop:
    lodsb ; loads byte from DS:SI into AL, increment SI by 1
    or al, al ; check al for 0
    jz .done ; jump if zero

    mov ah, 0x0E ; print character code
    mov bh, 0 ; 
    int 0x10 ; bios video interrup

    jmp .loop

.done:
    pop ax
    pop si
    ret
;;

main:
    ; setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00 ; stack grows to 0, so we won't overwrite our code

    ; print debug message
    mov si, message_hello
    call puts

    hlt

.halt:
    jmp .halt


message_hello:
    db 'hello computer!', ENDL, 0





times 510-($-$$) db 0
dw 0AA55h