`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 04:47:54 PM
// Design Name: 
// Module Name: alu
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


module alu (
    input [31:0] a,
    input [31:0] b,
    input [3:0] control,
    output reg [31:0] result,
    output zero
);
    always @(*) begin
        case (control)
            4'b0000: result = a & b;  // AND
            4'b0001: result = a | b;  // OR
            4'b0010: result = a + b;  // ADD
            4'b0110: result = a - b;  // SUB
            4'b0111: result = (a < b) ? 32'd1 : 32'd0; // SLT
            default: result = 32'd0;
        endcase
    end

    assign zero = (result == 0);
endmodule

