`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CAPP
// Engineer: Pham Quan Dung
// 
// Create Date: 11/22/2018 09:59:00 AM
// Design Name: Laser Pulse Generator testbench
// Module Name: testbench_pulse_generator
// Project Name: LiDAR
//////////////////////////////////////////////////////////////////////////////////


module testbench_pulse_generator();
reg CLK, RSTn;
//reg [1:0] MODE;
wire [1:0] MODE;
//reg EN;
wire EN;
wire PULSE_1, PULSE_2, PULSE_3;
//wire PULSE;

// AXI Registers
reg [31:0] axi_laser_reg0;
reg [31:0] axi_laser_reg1;
reg [31:0] axi_laser_reg2;
reg [31:0] axi_freq_reg3;

assign EN = axi_laser_reg0[0];
assign MODE  = axi_laser_reg0[3:1];

laser_pulse laser(.CLK(CLK), .RSTn(RSTn), .EN(EN), .MODE(MODE), .PULSE_1(PULSE_1), .PULSE_2(PULSE_2), .PULSE_3(PULSE_3));
//laser_pulse laser(.CLK(CLK), .RSTn(RSTn), .EN(EN), .PULSE(PULSE));
always #5 CLK = ~CLK;
initial begin
    CLK = 1;
    RSTn = 0;
//    MODE = 2'b11;
    axi_laser_reg0 = 32'b0001;
    #1
    RSTn = 1;
//    EN = 1;
//    axi_laser_reg0 = 32'b011;
//    axi_laser_reg0 = 32'b011;
//    axi_laser_reg0 = 32'b1;
//    #1
//    axi_laser_reg0 = 32'b0;
    #100000000
    axi_laser_reg0 = 32'b110;
//    axi_laser_reg0 = 32'b0;
//    axi_laser_reg0 = 32'b010;
//    #1
//    axi_laser_reg1 = 32'b0;
//    START = 1;
//    #1
//    START = 0;
end
endmodule
