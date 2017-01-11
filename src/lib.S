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
