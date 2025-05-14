`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 04:44:15 PM
// Design Name: 
// Module Name: execute
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


module execute (
    input clk,
    input [1:0] ctlwb_in, ctlm_in,
    input [31:0] npc, rdata1, rdata2, s_extend,
    input [4:0] instr_2016, instr_1511,
    input [1:0] alu_op,
    input [5:0] funct,
    input alusrc, regdst,

    output [1:0] ctlwb_out, ctlm_out,
    output [31:0] adder_out, alu_result_out, rdata2_out,
    output [4:0] muxout_out
);

    // Wires to connect the internal modules
    wire [31:0] adder_result;
    wire [31:0] alu_in2;
    wire [3:0] alu_control;
    wire [31:0] alu_result;
    wire alu_zero;
    wire [4:0] regdst_muxout;

    // 1. ADDER: npc + s_extend
    execute_adder adder_inst(
        .a(npc), 
        .b(s_extend), 
        .result(adder_result)
    );

    // 2. MUX (32-bit): choose between rdata2 and s_extend
    mux_32 alusrc_mux(
        .a(rdata2), 
        .b(s_extend), 
        .sel(alusrc), 
        .y(alu_in2)
    );

    // 3. ALU CONTROL: generate ALU control signal based on alu_op and funct
    alu_control alu_ctrl_inst(
        .alu_op(alu_op), 
        .funct(funct), 
        .select(alu_control)
    );

    // 4. ALU: perform operation
    alu alu_inst(
        .a(rdata1), 
        .b(alu_in2), 
        .control(alu_control), 
        .result(alu_result), 
        .zero(alu_zero)
    );

    // 5. MUX (5-bit): select destination register
    mux_5 regdst_mux(
        .a(instr_2016), 
        .b(instr_1511), 
        .sel(regdst), 
        .y(regdst_muxout)
    );

    // 6. EX/MEM LATCH: store intermediate values
    ex_mem_latch ex_mem_reg(
        .clk(clk),
        .ctlwb_in(ctlwb_in),
        .ctlm_in(ctlm_in),
        .adder_in(adder_result),
        .alu_result_in(alu_result),
        .rdata2_in(rdata2),
        .muxout_in(regdst_muxout),

        .ctlwb_out(ctlwb_out),
        .ctlm_out(ctlm_out),
        .adder_out(adder_out),
        .alu_result_out(alu_result_out),
        .rdata2_out(rdata2_out),
        .muxout_out(muxout_out)
    );

endmodule