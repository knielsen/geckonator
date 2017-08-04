/*
 * This file is part of geckonator.
 * Copyright 2017 Emil Renner Berthing <esmil@esmil.dk>
 *
 * geckonator is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * geckonator is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with geckonator. If not, see <http://www.gnu.org/licenses/>.
 */

.syntax unified
.fpu softvfp
.thumb

.global __halt
.extern main

.section .text.Reset_Handler, "ax", %progbits
.weak Reset_Handler
.thumb_func
Reset_Handler:
	/* copy data with *r1++ = *r0++ while r1 <= r2 */
	ldr	r0, =__etext
	ldr	r1, =__data_start__
	ldr	r2, =__data_end__
	b	2f
.ltorg
1:	ldmia	r0!, {r4}
	stmia	r1!, {r4}
2:	cmp	r1, r2
	bls	1b

	/* clear bss with *r1++ = r0 (== 0) while r1 <= r2 */
	movs	r0, #0
	ldr	r1, =__bss_start__
	ldr	r2, =__bss_end__
	b	4f
.ltorg
3:	stmia	r1!, {r0}
4:	cmp	r1, r2
	bls	3b
	bl	main

.section .text.__halt, "ax", %progbits

.thumb_func
__halt:
.weak Default_Handler
.thumb_set Default_Handler,__halt
	cpsid	i
0:	b	0b
