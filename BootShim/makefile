ARCH              ?= aarch64
TARGET64          ?= aarch64-linux-gnu
CROSS_COMPILE64   ?= $(TARGET64)-
CC64              ?= $(CROSS_COMPILE64)gcc
OBJCOPY64         ?= $(CROSS_COMPILE64)objcopy

TARGET32          ?= arm-linux-gnueabi
CROSS_COMPILE32   ?= $(TARGET32)-
CC32              ?= $(CROSS_COMPILE32)gcc
OBJCOPY32         ?= $(CROSS_COMPILE32)objcopy

all: BootShim64.bin

BootShim64.bin: BootShim64.elf
	$(OBJCOPY64) -O binary $< $@

BootShim64.elf: BootShim64.S
	$(CC64) -c $< -o $@ -DUEFI_BASE=$(UEFI_BASE) -DUEFI_SIZE=$(UEFI_SIZE)

BootShim.bin: BootShim.elf
	$(OBJCOPY32) -O binary $< $@

BootShim.elf: BootShim.S
	$(CC32) -c $< -o $@ -DUEFI_BASE=$(UEFI_BASE) -DUEFI_SIZE=$(UEFI_SIZE)

clean:
	rm -f BootShim64.elf BootShim64.bin BootShim.elf BootShim.bin