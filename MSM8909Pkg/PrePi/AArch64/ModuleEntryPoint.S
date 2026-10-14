//
//  Copyright (c) 2011-2015, ARM Limited. All rights reserved.
//  Copyright (c) 2019, RUIKAI LIU and MR TUNNEL. All rights reserved.
//  Copyright (c) 2026, Project Silicium contributors. All rights reserved.
//
//  SPDX-License-Identifier: BSD-2-Clause-Patent
//

#include <AsmMacroIoLibV8.h>
#include <Library/PcdLib.h>

.text
.align 3

GCC_ASM_IMPORT (CEntryPoint)
GCC_ASM_EXPORT (_ModuleEntryPoint)

.global _StackBase
.global _StackSize

.align 3
_StackBase:
  .quad FixedPcdGet32(PcdPrePiStackBase)

_StackSize:
  .quad FixedPcdGet32(PcdPrePiStackSize)

ASM_FUNC(_ModuleEntryPoint)
  /* Disable interrupts (D, A, I, F) */
  msr   daifset, #0xf

  /* Invalidate instruction cache */
  ic    iallu
  isb

  /* Invalidate TLB */
  tlbi  vmalle1
  dsb   sy
  isb

  /* Configure SCTLR_EL1:
   * Disable MMU (bit 0)
   * Disable Data cache (bit 2)
   * Clear Alignment check (bit 1)
   * Enable Instruction cache (bit 12)
   */
  mrs   x0, sctlr_el1
  bic   x0, x0, #(1 << 0)   /* M = 0 */
  bic   x0, x0, #(1 << 2)   /* C = 0 */
  bic   x0, x0, #(1 << 1)   /* A = 0 */
  orr   x0, x0, #(1 << 12)  /* I = 1 */
  msr   sctlr_el1, x0
  isb

  /* Enable FP/SIMD access (CPACR_EL1 bits [21:20] = 0b11) */
  mrs   x0, cpacr_el1
  orr   x0, x0, #(0x3 << 20)
  msr   cpacr_el1, x0
  isb

  /* Setup primary core stack */
  ldr   x0, _StackBase
  ldr   x1, _StackSize
  add   x4, x0, x1
  mov   sp, x4
  and   sp, x4, #~0xf

  /* Clear frame pointer */
  mov   x29, xzr

  /* Call CEntryPoint(StackBase, StackSize) */
  ldr   x0, _StackBase
  ldr   x1, _StackSize
  ldr   x4, =ASM_PFX(CEntryPoint)
  blr   x4

_NeverReturn:
  wfe
  b     _NeverReturn
