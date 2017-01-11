/*
 *	Copyright (c) 2017 Metro94
 *
 *	File:        boot.c
 *	Description: boot code for S5P6818
 *	Author:      Metro94 <flattiles@gmail.com>
 *  Date:        
 */

#include <common.h>
#include <io.h>

#include <serial.h>

void bootMaster(uint32_t cpuid)
{
//	int i, d = 0;

	initSerial();

	// clrsetbits32(0xc001b020, 3 << 24, 2 << 24);
	// setbits32(0xc001b004, 1 << 12);

	// while (1) {
	// 	for (i = 0; i < 1000000; ++i)
	// 		d ^= i;
	// 	tglbits32(0xc001b000, 1 << 12);
	// }

	printDec(ref32(0xc0011170));

	while (1);
}

void bootSlave(uint32_t cpuid)
{
}
