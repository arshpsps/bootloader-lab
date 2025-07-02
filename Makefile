.PHONY: all run clean builds

all: builds/disk.img

builds/disk.img: builds/x86-loader.img builds/x86-example-kernel.bin
	cat builds/x86-loader.img builds/x86-example-kernel.bin > builds/disk.img

builds/x86-loader.img: x86-loader.asm | builds/
	nasm -f bin x86-loader.asm -o builds/x86-loader.img

builds/x86-example-kernel.bin: x86-example-kernel.asm | builds/
	nasm -f bin x86-example-kernel.asm -o builds/x86-example-kernel.bin

builds/x86-bios-hello.img: x86-bios-hello.asm | builds/
	nasm -f bin x86-bios-hello.asm -o builds/x86-bios-hello.img

builds/:
	mkdir -p builds

run: builds/disk.img
	qemu-system-i386 -drive format=raw,file=builds/disk.img

hello: builds/x86-bios-hello.img
	qemu-system-i386 -drive format=raw,file=builds/x86-bios-hello.img

clean:
	rm -rf builds
