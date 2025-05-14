`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 04:47:35 PM
// Design Name: 
// Module Name: mux_5
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_5 (
    input [4:0] a,
    input [4:0] b,
    input sel,
    output [4:0] y
);
    assign y = sel ? b : a;
endmodule

