`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CAPP 
// Engineer: Pham Quan Dung
// 
// Create Date: 11/22/2018 09:25:15 AM
// Design Name: Laser Pulse
// Module Name: laser_pulse
// Project Name: LiDAR
//////////////////////////////////////////////////////////////////////////////////

//module laser_pulse(CLK, RSTn, EN, PULSE);
module laser_pulse(CLK, RSTn, EN, MODE, PULSE_1, PULSE_2, PULSE_3);
parameter COUNTER_WIDTH = 17;
parameter W = 3;
//input and output
input CLK, EN, RSTn;
//output reg PULSE;
input [1:0] MODE;
output reg PULSE_1, PULSE_2, PULSE_3;
reg[COUNTER_WIDTH-1:0] reg_cnt; // NXT ++ MOD

//20184.04.12 -- NXT ADD ---
//{{{
// Define a small look-up table (Later, we should change it to SRAM)
reg [COUNTER_WIDTH-1:0] CNT_MAX[0:5];
reg [W:0] PULSE_CNT_MAX[0:8];
wire [2:0] pulse_mode[0:2];		// => Create an input
assign pulse_mode[0] = 0;
assign pulse_mode[1] = 1;
assign pulse_mode[2] = 2;
always@(reg_cnt) begin
	CNT_MAX[0] = 99999;	// WARNING: Check those values.
	CNT_MAX[1] = 999;
	CNT_MAX[2] = 1999;
	CNT_MAX[3] = 3999;
end
always@(reg_cnt) begin
	PULSE_CNT_MAX[0] = 2;
	PULSE_CNT_MAX[1] = 3;
	PULSE_CNT_MAX[2] = 4;
	PULSE_CNT_MAX[3] = 5;
	PULSE_CNT_MAX[4] = 6;
	PULSE_CNT_MAX[5] = 7;
	PULSE_CNT_MAX[6] = 8;
	PULSE_CNT_MAX[7] = 9;	
end
// Function	: Main counter
// Input	:	 
//			EN	0/1	1: Active Counter
//			MODE 00/01/10/11
//				00:
//				01:
//				10:
//				11:
// Output
//			reg_cnt
always @(posedge CLK or negedge RSTn) begin
	if (!RSTn) begin
		reg_cnt <=  {COUNTER_WIDTH{1'b0}};
	end
	else begin
		if(!EN)
			reg_cnt <=  {COUNTER_WIDTH{1'b0}};
		else begin
			if(reg_cnt == CNT_MAX[MODE])
				reg_cnt <=  {COUNTER_WIDTH{1'b0}};
			else
				reg_cnt <= reg_cnt + 1;
		end
	end
end

// Function: Pulse generator
// Input:	
//			reg_cnt
//
// Output
//			PULSE_1, PULSE_2, PULSE_3
always @(posedge CLK or negedge RSTn) begin
	if (!RSTn) begin
		PULSE_1 <=1'b0;
		PULSE_2 <=1'b0;
		PULSE_3 <=1'b0;
	end
	else begin
		if(!EN) begin
			PULSE_1 <=1'b0;
			PULSE_2 <=1'b0;
			PULSE_3 <=1'b0;
		end
		else begin
			if(reg_cnt == 1)
				PULSE_1 <= 1'b1;
			else if(reg_cnt == PULSE_CNT_MAX[pulse_mode[0]])
				PULSE_1 <= 1'b0;
			if(reg_cnt == 1)
                PULSE_2 <= 1'b1;
            else if(reg_cnt == PULSE_CNT_MAX[pulse_mode[1]])
                PULSE_2 <= 1'b0;                
			if(reg_cnt == 1)
                PULSE_3 <= 1'b1;
            else if(reg_cnt == 100)
                PULSE_3 <= 1'b0;                				
		end
	end
end

//


//}}}


//20184.04.12 -- NXT DEL ---
//{{{

//initial
//Pulse Generator starts. START pulse has only one cycle (50% duty as CLK).
//Period of CLK is 2ns (f_clk = 500MHz) => Need laser pulse whose frequency is 1MHz (Time period is 1000 ns). Duty cycle is 50% (500ns) => reg_cnt = 249(count to 250).
// Thus: 500MHz down to a Hz => reg_cnt = 500MHz/a -1
//Duty a% => reg_cnt = (reg_cnt+1)* a%
//always @(posedge CLK) begin
//    EN_1d <=EN;
//end
//always @(posedge CLK or negedge RSTn) begin 
//    case(MODE)
//    2'b01:begin
//        if (!RSTn) begin
//            reg_cnt = 0;
//        end
//        else begin
//            if(EN) begin
//                if(reg_cnt == 999) begin
//                    reg_cnt <= 0;
//                    PULSE_1 <= 2'b0;
//                    PULSE_2 <= 2'b0;
//                    PULSE_3 <= 2'b0;
//                end
//                else    
//                    reg_cnt <= reg_cnt + 1;
//                if(reg_cnt < 3) 
//                    PULSE_1 <= 2'b1;
//                else 
//                    PULSE_1 <= 2'b0;
//                if(reg_cnt < 2)
//                    PULSE_2 <= 2'b1;
//                else 
//                    PULSE_2 <= 2'b0;
//                if (reg_cnt < 1)
//                    PULSE_3 <= 2'b1;
//                else
//                    PULSE_3 <= 2'b0;    
//            end
//            if (!EN) begin
//                reg_cnt <= 0;
//                PULSE_1 <= 2'b0;
//                PULSE_2 <= 2'b0;
//                PULSE_3 <= 2'b0;
//            end
//         end
//    end
//    2'b10:begin
//        if (!RSTn) begin
//            reg_cnt = 0;
//        end
//        else begin
//            if(EN) begin
//                if(reg_cnt == 1999) begin
//                    reg_cnt <= 0;
//                    PULSE_1 <= 2'b0;
//                    PULSE_2 <= 2'b0;
//                    PULSE_3 <= 2'b0;
//                end
//                else    
//                    reg_cnt <= reg_cnt + 1;
//                if(reg_cnt < 6) 
//                    PULSE_1 <= 2'b1;
//                else 
//                    PULSE_1 <= 2'b0;
//                if(reg_cnt < 4)
//                    PULSE_2 <= 2'b1;
//                else 
//                    PULSE_2 <= 2'b0;
//                if (reg_cnt < 2)
//                    PULSE_3 <= 2'b1;
//                else
//                    PULSE_3 <= 2'b0;    
//            end
//            if (!EN) begin
//                reg_cnt <= 0;
//                PULSE_1 <= 2'b0;
//                PULSE_2 <= 2'b0;
//                PULSE_3 <= 2'b0;
//            end
//         end
//    end
//    2'b11:begin
//        if (!RSTn) begin
//            reg_cnt = 0;
//        end
//        else begin
//            if(EN) begin
//                if(reg_cnt == 2999) begin
//                    reg_cnt <= 0;
//                    PULSE_1 <= 2'b0;
//                    PULSE_2 <= 2'b0;
//                    PULSE_3 <= 2'b0;
//                end
//                else    
//                    reg_cnt <= reg_cnt + 1;
//                if(reg_cnt < 8) 
//                    PULSE_1 <= 2'b1;
//                else 
//                    PULSE_1 <= 2'b0;
//                if(reg_cnt < 5)
//                    PULSE_2 <= 2'b1;
//                else 
//                    PULSE_2 <= 2'b0;
//                if (reg_cnt < 3)
//                    PULSE_3 <= 2'b1;
//                else
//                    PULSE_3 <= 2'b0;    
//            end
//            if (!EN) begin
//                reg_cnt <= 0;
//                PULSE_1 <= 2'b0;
//                PULSE_2 <= 2'b0;
//                PULSE_3 <= 2'b0;
//            end
//         end
//    end
//endcase
//end
//always @(posedge CLK or negedge RSTn) begin
//    if (!RSTn) begin
//        reg_cnt = 0;
//    end
//    else begin
//        if(EN) begin
//            if(reg_cnt == 9999) begin
//                reg_cnt <= 0;
//                PULSE <= 2'b0;
//            end
//            else    
//                reg_cnt <= reg_cnt + 1;
//            if(reg_cnt < 1) 
//                PULSE <= 2'b1;
//            else 
//                PULSE <= 2'b0;
//        end
//        if (!EN) begin
//            reg_cnt <= 0;
//            PULSE <= 2'b0;
//        end
//     end
//end

//}}}
endmodule
