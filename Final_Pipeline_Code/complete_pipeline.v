`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2025 04:53:35 PM
// Design Name: 
// Module Name: complete_pipeline
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

module complete_pipeline (
    input wire clk,
    input wire reset
);

// Intermediate signals and pipeline registers
// IF/ID stage signals
wire [31:0] IF_ID_npc, IF_ID_instr;

// ID/EX stage signals
wire [1:0] id_ex_wb;
wire [2:0] id_ex_mem;
wire [3:0] id_ex_execute;
wire [31:0] id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext;
wire [4:0] id_ex_instr_bits_20_16, id_ex_instr_bits_15_11;

// EX/MEM stage signals
wire [1:0] ex_mem_wb;
wire [1:0] ex_mem_m;
wire [31:0] ex_mem_alu_result, ex_mem_adder, ex_mem_rdata2;
wire [4:0] ex_mem_muxout;
wire ex_mem_zero;

// MEM/WB stage signals
wire [1:0] mem_wb_wb_ctl;
wire [31:0] mem_wb_alu_result, mem_wb_read_data;
wire [4:0] mem_wb_mux_reg_dst;

// WB stage signals
wire [31:0] wb_write_data;
wire [4:0] wb_write_reg;
wire wb_reg_write;

// 1) IF stage
final_IF_stage final_stage (
    .clk(clk),
    .reset(reset),
    .ex_mem_pcrsrc(ex_mem_m[0]),
    .ex_mem_npc(ex_mem_adder),
    .IF_ID_npc(IF_ID_npc),
    .IF_ID_instr(IF_ID_instr)
);

// 2) ID stage
decode id_stage (
    .clk(clk),
    .rst(reset),
    .wb_reg_write(wb_reg_write),
    .wb_write_reg_location(wb_write_reg),
    .mem_wb_write_data(wb_write_data),
    .if_id_instr(IF_ID_instr),
    .if_id_npc(IF_ID_npc),
    .id_ex_wb(id_ex_wb),
    .id_ex_mem(id_ex_mem),
    .id_ex_execute(id_ex_execute),
    .id_ex_npc(id_ex_npc),
    .id_ex_readdat1(id_ex_readdat1),
    .id_ex_readdat2(id_ex_readdat2),
    .id_ex_sign_ext(id_ex_sign_ext),
    .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16),
    .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11)
);

// 3) EX stage
execute ex_stage (
    .clk(clk),
    .ctlwb_in(id_ex_wb),
    .ctlm_in(id_ex_mem[1:0]),
    .npc(id_ex_npc),
    .rdata1(id_ex_readdat1),
    .rdata2(id_ex_readdat2),
    .s_extend(id_ex_sign_ext),
    .instr_2016(id_ex_instr_bits_20_16),
    .instr_1511(id_ex_instr_bits_15_11),
    .alu_op(id_ex_execute[1:0]),
    .funct(id_ex_sign_ext[5:0]),
    .alusrc(id_ex_execute[2]),
    .regdst(id_ex_execute[3]),
    .ctlwb_out(ex_mem_wb),
    .ctlm_out(ex_mem_m),
    .adder_out(ex_mem_adder),
    .alu_result_out(ex_mem_alu_result),
    .rdata2_out(ex_mem_rdata2),
    .muxout_out(ex_mem_muxout)
);

// 4) MEM stage
mem_stage mem_stage (
    .clk(clk),
    .ALUResult(ex_mem_alu_result),
    .WriteData(ex_mem_rdata2),
    .WriteReg(ex_mem_muxout),
    .WBControl(ex_mem_wb),
    .MemWrite(ex_mem_m[1]),
    .MemRead(ex_mem_m[0]),
    .Branch(id_ex_execute[2]),
    .Zero(ex_mem_zero),
    .ReadData(mem_wb_read_data),
    .ALUResult_out(mem_wb_alu_result),
    .WriteReg_out(mem_wb_mux_reg_dst),
    .WBControl_out(mem_wb_wb_ctl),
    .PCSrc(ex_mem_m[0])
);

// 5) WB stage
WB_stage WB_stage (
    .clk(clk),
    .reset(reset),
    .mem_wb_wb_ctl(mem_wb_wb_ctl),
    .mem_wb_alu_result(mem_wb_alu_result),
    .mem_wb_read_data(mem_wb_read_data),
    .mem_wb_mux_reg_dst(mem_wb_mux_reg_dst),
    .wb_write_data(wb_write_data),
    .wb_write_reg(wb_write_reg),
    .wb_reg_write(wb_reg_write)
);

endmodule
