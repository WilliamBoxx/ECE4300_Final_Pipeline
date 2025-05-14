`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 04:35:25 PM
// Design Name: 
// Module Name: decode
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


module decode( 
    input  wire         clk,
    input  wire         rst,
    input  wire         wb_reg_write,
    input  wire [4:0]   wb_write_reg_location,
    input  wire [31:0]  mem_wb_write_data,
    input  wire [31:0]  if_id_instr,
    input  wire [31:0]  if_id_npc,
    output wire [1:0]   id_ex_wb,
    output wire [2:0]   id_ex_mem,
    output wire [3:0]   id_ex_execute,
    output wire [31:0]  id_ex_npc,
    output wire [31:0]  id_ex_readdat1,
    output wire [31:0]  id_ex_readdat2,
    output wire [31:0]  id_ex_sign_ext,
    output wire [4:0]   id_ex_instr_bits_20_16,
    output wire [4:0]   id_ex_instr_bits_15_11
);

    // Internal wires connecting the modules
    wire [31:0] sign_ext_internal;
    wire [31:0] readdat1_internal;
    wire [31:0] readdat2_internal;
    wire [1:0]  wb_internal;
    wire [2:0]  mem_internal;
    wire [3:0]  ex_internal;

    // Sign Extension: Extend the 16-bit immediate from if_id_instr to 32 bits.
    signExtend sE0(
        .immediate(if_id_instr[15:0]),
        .extended(sign_ext_internal)
    );

    // Register File:
    // - Source registers: rs from bits [25:21] and rt from bits [20:16]
    // - Write-back: register write enable, destination, and data from WB stage.
    regfile rf0(
        .clk(clk),
        .rst(rst),
        .regwrite(wb_reg_write),
        .rs(if_id_instr[25:21]),
        .rt(if_id_instr[20:16]),
        .rd(wb_write_reg_location),
        .writedata(mem_wb_write_data),
        .A_readdat1(readdat1_internal),
        .B_readdat2(readdat2_internal)
    );

    // Control Unit:
    // - Opcode is extracted from bits [31:26] of if_id_instr.
    // - Generates control signals for WB, MEM, and EX stages.
    control c0(
        .clk(clk),
        .rst(rst),
        .opcode(if_id_instr[31:26]),
        .wb(wb_internal),
        .mem(mem_internal),
        .ex(ex_internal)
    ); 

    // ID/EX Pipeline Latch:
    // - Latches control signals and data (NPC, register file outputs, sign extended immediate,
    //   and selected instruction fields) for the next stage.
    idExLatch iEL0(
        .clk(clk),
        .rst(rst),
        .ctl_wb(wb_internal),
        .ctl_mem(mem_internal),
        .ctl_ex(ex_internal),
        .npc(if_id_npc),
        .readdat1(readdat1_internal),
        .readdat2(readdat2_internal),
        .sign_ext(sign_ext_internal),
        .instr_bits_20_16(if_id_instr[20:16]),
        .instr_bits_15_11(if_id_instr[15:11]),
        .wb_out(id_ex_wb),
        .mem_out(id_ex_mem),
        .ctl_out(id_ex_execute),
        .npc_out(id_ex_npc),
        .readdat1_out(id_ex_readdat1),
        .readdat2_out(id_ex_readdat2),
        .sign_ext_out(id_ex_sign_ext),
        .instr_bits_20_16_out(id_ex_instr_bits_20_16),
        .instr_bits_15_11_out(id_ex_instr_bits_15_11)
    );

endmodule
