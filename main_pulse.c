#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "xparameters.h"
#include "xil_io.h"
#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_cache.h"

#ifndef ENABLE_ICACHE
#define ENABLE_ICACHE()		Xil_ICacheEnable()
#endif
#ifndef	ENABLE_DCACHE
#define ENABLE_DCACHE()		Xil_DCacheEnable()
#endif
#ifndef	DISABLE_ICACHE
#define DISABLE_ICACHE()	Xil_ICacheDisable()
#endif
#ifndef DISABLE_DCACHE
#define DISABLE_DCACHE()	Xil_DCacheDisable()
#endif

int main(){
	xil_printf("Start of IP Laser Pulse");
	//
	int choice, exit_flag;
	exit_flag = 0;
	print("Choose Feature to Test:\r\n");
	print("Choose 1: Turn on PULSE for LASER\r\n");
	print("Choose 2: Turn off PULSE for LASER\r\n\r\n");
	while(exit_flag != 1){
		ENABLE_ICACHE();
		ENABLE_DCACHE();
		choice = inbyte();
		if (isalpha(choice)) {
			choice = toupper(choice);
		}
		switch(choice) {
			case '1':
				Xil_Out32(XPAR_AXI_LASER_PULSE_0_S00_AXI_BASEADDR, 0x00000001);
				print("Turn on PULSE for LASER\r\n\r\n");
				break;
			case '2':
				Xil_Out32(XPAR_AXI_LASER_PULSE_0_S00_AXI_BASEADDR, 0x00000000);
				print("Turn off PULSE for LASER\r\n\r\n");
				break;
			default:
				break;
		}
	}

	return 0;
}
