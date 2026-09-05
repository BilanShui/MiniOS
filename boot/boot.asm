MBOOT_MAGIC  equ 0x1BADB002
MBOOT_FLAGS  equ 0x00000003
MBOOT_CHECK  equ -(MBOOT_MAGIC + MBOOT_FLAGS)

section .multiboot
    dd MBOOT_MAGIC
    dd MBOOT_FLAGS
    dd MBOOT_CHECK

section .bss
    resb 16384
stack_top:

section .text
global _start
extern kernel_main          ; ✅ 声明外部 C 函数

_start:
    mov esp, stack_top
    call kernel_main
    cli
.hang:
    hlt
    jmp .hang
