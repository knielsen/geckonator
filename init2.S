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

.global __Vectors

	.section .text.__halt, "ax", %progbits
	/* Default handler is defined in another object as the only function in
	the .text.__halt section. */
	.thumb_set extern_halt, .


.section .vectors, "a", %progbits

.macro interrupt name
	.weak \name
	.thumb_set \name,extern_halt
	.long \name
.endm

.type __Vectors, %object
__Vectors:
	/* the first vector in Cortex is the stack pointer */
	.long __StackTop                /* top of stack */
	.long Reset_Handler             /* reset handler */
	interrupt NMI_Handler           /* nmi handler */
	interrupt HardFault_Handler     /* hard fault handler */
	.long Default_Handler           /* reserved */
	.long Default_Handler           /* reserved */
	.long Default_Handler           /* reserved */
	.long Default_Handler           /* reserved */
	.long Default_Handler           /* reserved */
	.long Default_Handler           /* reserved */
	.long Default_Handler           /* reserved */
	interrupt SVC_Handler           /* svcall handler */
	.long Default_Handler           /* reserved */
	.long Default_Handler           /* reserved */
	interrupt PendSV_Handler        /* pendsv handler */
	interrupt SysTick_Handler       /* systick handler */
	/* external interrupts */
	interrupt DMA_IRQHandler        /*  0 - DMA */
	interrupt GPIO_EVEN_IRQHandler  /*  1 - GPIO_EVEN */
	interrupt TIMER0_IRQHandler     /*  2 - TIMER0 */
	interrupt ACMP0_IRQHandler      /*  3 - ACMP0 */
	interrupt ADC0_IRQHandler       /*  4 - ADC0 */
	interrupt I2C0_IRQHandler       /*  5 - I2C0 */
	interrupt GPIO_ODD_IRQHandler   /*  6 - GPIO_ODD */
	interrupt TIMER1_IRQHandler     /*  7 - TIMER1 */
	interrupt USART1_RX_IRQHandler  /*  8 - USART1_RX */
	interrupt USART1_TX_IRQHandler  /*  9 - USART1_TX */
	interrupt LEUART0_IRQHandler    /* 10 - LEUART0 */
	interrupt PCNT0_IRQHandler      /* 11 - PCNT0 */
	interrupt RTC_IRQHandler        /* 12 - RTC */
	interrupt CMU_IRQHandler        /* 13 - CMU */
	interrupt VCMP_IRQHandler       /* 14 - VCMP */
	interrupt MSC_IRQHandler        /* 15 - MSC */
	interrupt AES_IRQHandler        /* 16 - AES */
	interrupt USART0_RX_IRQHandler  /* 17 - USART0_RX */
	interrupt USART0_TX_IRQHandler  /* 18 - USART0_TX */
	interrupt USB_IRQHandler        /* 19 - USB */
	interrupt TIMER2_IRQHandler     /* 20 - TIMER2 */
