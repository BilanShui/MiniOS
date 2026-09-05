#!/bin/bash

echo "=== 编译 MiniOS ==="
nasm -f elf32 boot/boot.asm -o boot/boot.o
gcc -m32 -ffreestanding -c src/kernel.c -o src/kernel.o
ld -m elf_i386 -T linker.ld -o boot/kernel.elf boot/boot.o src/kernel.o

echo "=== 生成 ISO ==="
mkdir -p iso/boot/grub
cp boot/kernel.elf iso/boot/
cat > iso/boot/grub/grub.cfg << 'GRUBEOF'
set timeout=5
set default=0

menuentry "MiniOS" {
    multiboot /boot/kernel.elf
    boot
}
GRUBEOF

grub-mkrescue -o MiniOS.iso iso/

echo "=== 运行 ==="
qemu-system-i386 -cdrom MiniOS.iso
