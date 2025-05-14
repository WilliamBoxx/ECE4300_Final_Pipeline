`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 04:48:15 PM
// Design Name: 
// Module Name: alu_control
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


module alu_control (
    input [1:0] alu_op,
    input [5:0] funct,
    output reg [3:0] select
);
    always @(*) begin
        case (alu_op)
            2'b00: select = 4'b0010; // lw/sw: ADD
            2'b01: select = 4'b0110; // beq: SUB
            2'b10: begin
                case (funct)
                    6'b100000: select = 4'b0010; // ADD
                    6'b100010: select = 4'b0110; // SUB
                    6'b100100: select = 4'b0000; // AND
                    6'b100101: select = 4'b0001; // OR
                    6'b101010: select = 4'b0111; // SLT
                    default:   select = 4'b1111; // Invalid
                endcase
            end
            default: select = 4'b0000; // Default to AND
        endcase
    end
endmodule