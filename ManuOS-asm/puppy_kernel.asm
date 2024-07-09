bits 16
section .data
    welcome db 'Welcome to ManuOS(kernel mode)', 0
    version db 'ManuOS 0.0.1-puppy', 0
    help db 'Commands: m(manu), v(version), h(help), t(text editor)', 0
    not_found db 'Command not found: ', 0
    txt_msg db 'Text editor v1.2 ', 0
    escmsg db 'Press ESC to exit', 0
    msg db 'Hello, World!', 0
    manu db 'Manu', 0
    cm1 db 'version', 0
    cm2 db 'help', 0
    cm3 db 'txt', 0

section .bss
    cmd_buffer resb 0x50

section .text
    global start

start:
    call newline
    mov bx, welcome
    call print_str
    call newline
    jmp terminal

l1:
    mov al, '1'
    call print_chr
    jmp halt

l2:
    mov al, '2'
    call print_chr
    jmp halt

halt:
    nop
    jmp halt

terminal:
    mov al, '>'
    call print_chr
    mov di, cmd_buffer
    .tloop:
        call read
        cmp al, 0
        je halt ; If no more input, stop the program
        call print_chr
        mov [di], al
        inc di
        cmp al, 0x0d
        jne .tloop

    mov byte [di], 0 ; Null-terminate the command
    call handle_commands
    jmp terminal

handle_commands:
    mov bl, 'm'
    cmp bl, [cmd_buffer]
    je .manu
    mov bl, 'v'
    cmp bl, [cmd_buffer]
    je .version_command
    mov bl, 'h'
    cmp bl, [cmd_buffer]
    je .help_command
    mov bl, 't'
    cmp bl, [cmd_buffer]
    je init_text_editor
    mov bx, not_found
    call print_str
    mov bx, cmd_buffer
    call print_str
    call newline
    ret

    .manu:
        call newline
        mov bx, manu
        call print_str
        call newline
        ret
    .version_command:
        call newline
        mov bx, version
        call print_str
        call newline
        ret
    .help_command:
        call newline
        mov bx, help
        call print_str
        call newline
        ret

newline:
    mov al, 0x0a
    call print_chr
    mov al, 0x0d
    call print_chr
    ret

; TEXT EDITOR
init_text_editor:
    call clrscr
    mov bx, txt_msg
    call print_str
    mov bx, escmsg
    call print_str
    call newline
text_editor:
    call read
    call print_chr
    call check_txt_functions
    jmp text_editor

check_txt_functions:
    .if_esc:
        cmp al, 0x1b
        jne .if_enter
        call clrscr
        jmp terminal
    .if_enter:
        cmp al, 0x0d
        jne .no_backspace
        mov al, 0x0a
        call print_chr
        mov al, 0x0d
        call print_chr
        .no_backspace:
            ret

read: ; Parameters: none Returns: al = character
    mov ah, 0x00
    int 0x16
    ret

print_chr: ; Parameters: al = character Returns: none
    mov ah, 0x0e
    int 0x10
    ret

print_str: ; Parameters: bx = pointer to string Returns: none
    push bx
    mov ah, 0x0e
    .print_str_loop:
        mov al, [bx]
        cmp al, 0
        je .end_print_str
        int 0x10
        inc bx
        jmp .print_str_loop

    .end_print_str:
        pop bx
        ret

clrscr: ; Parameters: none Returns: none
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    ret
