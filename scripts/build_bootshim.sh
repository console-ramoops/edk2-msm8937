cd BootShim
make BootShim64.bin UEFI_BASE=0x80200000 UEFI_SIZE=0x00100000
rm -f BootShim64.elf BootShim.elf
cd ..
