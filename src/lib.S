/*
 *	Copyright (c) 2017 Metro94
 *
 *	File:        lib.S
 *	Description: general code for S5P6818
 *	Author:      Metro94 <flattiles@gmail.com>
 *  Date:        
 */

// uint64_t getCPUID(void);
	.global getCPUID
getCPUID:
	mrs		x1, MPIDR_EL1
	and		x0, x1, #0x3		// Get Affinity Level 0
	lsr		x1, x1, #8
	and		x1, x1, #0xF		// Get Affinity Level 1
	orr		x0, x0, x1
	ret

//	Set Clock

//	PLL/Clock	Raw			Target(Example)
//	PLL0		550MHz		1000MHz
//	PLL1		147.5MHz	1600MHz
//	PLL2		96MHz		1600MHz
//	PLL3		125MHz		N/A
//	FCLKCPU0	275MHz(0)	1000MHz(0)
//	HCLKCPU0	137.5MHz	250MHz
//	FCLKCPU1	275MHz(0)	1000MHz(0)
//	HCLKCPU1	137.5MHz	250MHz
//	MDCLK		550MHz(0)	800MHz(1)
//	MCLK		550MHz		800MHz
//	MBCLK		275MHz		400MHz
//	MPCLK		137.5MHz	200MHz
//	FASTBCLK	275MHz(0)	400MHz(2)
//	BCLK		275MHz(0)	320MHz(2)
//	PCLK		137.5MHz	160MHz
//	HDMIPCLK	275MHz(0)	100MHz(2)
//	GR3DBCLK	275MHz(0)	320MHz(2)
//	GR3DPCLK	137.5MHz	160MHz
//	MPEGBCLK	275MHz(0)	266MHz(2)
//	MPEGPCLK	137.5MHz	133MHz

// void setClock(void);
	.global setClock
setClock:
	ldr		x1, =0xc0010000		// system control registers base

0:
	ldr		w0, [x1, #0x228]
	tst		w0, #(1 << 15)
	bne		0b

	ldr		w0, [x1, #0x00]
	orr		w0, w0, #0xf		// all PLL changable
	str		w0, [x1, #0x00]

	// Update related clock
	ldr		w0, =S5P6818_CLKDIVREG0
	str		w0, [x1, #0x20]

	ldr		w0, =S5P6818_CLKDIVREG1
	str		w0, [x1, #0x24]

	ldr		w0, =S5P6818_CLKDIVREG2
	str		w0, [x1, #0x28]

	ldr		w0, =S5P6818_CLKDIVREG3
	str		w0, [x1, #0x2c]

	ldr		w0, =S5P6818_CLKDIVREG4
	str		w0, [x1, #0x30]

	ldr		w0, =S5P6818_CLKDIVREG5
	str		w0, [x1, #0x34]

	ldr		w0, =S5P6818_CLKDIVREG6
	str		w0, [x1, #0x38]

	ldr		w0, =S5P6818_CLKDIVREG7
	str		w0, [x1, #0x3c]

	ldr		w0, =S5P6818_CLKDIVREG8
	str		w0, [x1, #0x40]

	// Update PLL

	ldr		w0, =S5P6818_PLLSETREG0
	str		w0, [x1, #0x08]

	ldr		w0, =S5P6818_PLLSETREG1
	str		w0, [x1, #0x0c]

	ldr		w0, =S5P6818_PLLSETREG2
	str		w0, [x1, #0x10]

	ldr		w0, =S5P6818_PLLSETREG3
	str		w0, [x1, #0x14]

	ldr		w0, [x1, #0x228]
	orr		w0, w0, #(1 << 15)
	str		w0, [x1, #0x228]

1:
	ldr		w0, [x1, #0x228]
	tst		w0, #(1 << 15)
	bne		1b

	ldr		w0, [x1, #0x00]
	bic		w0, w0, #0xf		// all PLL unchangable
	str		w0, [x1, #0x00]

	ret
