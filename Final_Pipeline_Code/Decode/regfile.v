`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 04:41:01 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input  wire        clk,
    input  wire        rst,
    input  wire        regwrite,
    input  wire [4:0]  rs,            // source register address 1
    input  wire [4:0]  rt,            // source register address 2
    input  wire [4:0]  rd,            // destination register address
    input  wire [31:0] writedata,     // data to write
    output wire [31:0] A_readdat1,    // read data from rs
    output wire [31:0] B_readdat2     // read data from rt
);
    // Define a register array with 32 registers of 32 bits each
    reg [31:0] registers [0:31];
    integer i;
    
    // Asynchronous read from the register file
    assign A_readdat1 = registers[rs];
    assign B_readdat2 = registers[rt];
    
    // Synchronous write and reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers to 0 on reset
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end else if (regwrite) begin
            registers[rd] <= writedata;
        end
    end
endmodule

