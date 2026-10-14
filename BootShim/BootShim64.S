.text
.globl _start

_start:
    /* 0x00: Branch to real start */
    b       _real_start

    /* 0x04: Reserved */
    .long   0

    /* 0x08: Image load offset from 2MB base (little-endian) */
    .quad   0x00080000

    /* 0x10: Effective size of kernel image, little-endian */
    .quad   UEFI_SIZE

    /* 0x18: Kernel flags (little-endian, 4K page size) */
    .quad   0x0000000000000002

    /* 0x20: Reserved */
    .quad   0

    /* 0x28: Reserved */
    .quad   0

    /* 0x30: Reserved */
    .quad   0

    /* 0x38: Magic number, "ARM\x64" = 0x644D5241 */
    .long   0x644D5241

    /* 0x3C: Reserved */
    .long   0

_real_start:
    /* Preserve DTB address passed by lk2nd in x0 */
    mov     x21, x0

    /* Get address of payload (UEFI FD concatenated after BootShim) */
    adr     x0, _Payload

    /* Expected UEFI Base */
    ldr     x1, UefiBase
    cmp     x0, x1
    b.eq    _Entry

    ldr     x2, UefiSize

_CopyLoop:
    /* 8 bytes per iteration */
    ldr     x3, [x0], #8
    str     x3, [x1], #8
    subs    x2, x2, #8
    b.gt    _CopyLoop

_Entry:
    /* Restore DTB pointer in x0, clear x1, x2, x3 per Linux arm64 boot protocol */
    mov     x0, x21
    mov     x1, xzr
    mov     x2, xzr
    mov     x3, xzr

    /* Jump to UEFI entry point */
    ldr     x5, UefiBase
    br      x5

.align 3
UefiBase:
    .quad   UEFI_BASE

UefiSize:
    .quad   UEFI_SIZE

.ltorg

.align 4
_Payload:
