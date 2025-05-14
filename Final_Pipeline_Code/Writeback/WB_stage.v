`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2025 04:45:49 PM
// Design Name: 
// Module Name: WB_stage
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


module WB_stage(
    input wire clk,
    input wire reset,
    input wire [1:0] mem_wb_wb_ctl,       // Write-back control signals (RegWrite, MemToReg)
    input wire [31:0] mem_wb_alu_result,   // ALU result from MEM/WB latch
    input wire [31:0] mem_wb_read_data,    // Data read from memory
    input wire [4:0] mem_wb_mux_reg_dst,   // Destination register
    output wire [31:0] wb_write_data,      // Data to write back to register file
    output wire [4:0] wb_write_reg,        // Register address to write
    output wire wb_reg_write               // Write enable signal for register file
);

    // Wire to select between ALU result and memory read data
    wire [31:0] wb_data_mux_out;

    // Control signal extraction
    wire reg_write = mem_wb_wb_ctl[0];     // RegWrite control signal
    wire mem_to_reg = mem_wb_wb_ctl[1];    // MemToReg control signal

    // MUX: Choose between memory data and ALU result
    assign wb_data_mux_out = (mem_to_reg) ? mem_wb_read_data : mem_wb_alu_result;

    // Output assignments
    assign wb_write_data = wb_data_mux_out;
    assign wb_write_reg = mem_wb_mux_reg_dst;
    assign wb_reg_write = reg_write;

endmodule