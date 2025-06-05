.PHONY: all run clean builds

all: builds/x86-loader.img

builds/x86-loader.img: x86-loader.asm | builds
	nasm -f bin x86-loader.asm -o builds/x86-loader.img

builds:
	mkdir -p builds

run: builds/x86-loader.img
	qemu-system-x86_64 -drive format=raw,file=builds/x86-loader.img

clean:
	rm -rf builds
