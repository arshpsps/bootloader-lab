.PHONY: all run clean builds

all: builds/disk.img

builds/disk.img: builds/x86-loader.img builds/x86-example-kernel.bin
	cat builds/x86-loader.img builds/x86-example-kernel.bin > builds/disk.img

builds/x86-loader.img: x86-loader.asm | builds
	nasm -f bin x86-loader.asm -o builds/x86-loader.img

builds/x86-example-kernel.bin: x86-example-kernel.asm | builds
	nasm -f bin x86-example-kernel.asm -o builds/x86-example-kernel.bin

builds:
	mkdir -p builds

run: builds/disk.img
	qemu-system-i386 -drive format=raw,file=builds/disk.img

clean:
	rm -rf builds
