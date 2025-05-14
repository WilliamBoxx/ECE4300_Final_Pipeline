`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 04:41:23 PM
// Design Name: 
// Module Name: control
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


module control(
    input  wire        clk,
    input  wire        rst,
    input  wire [5:0]  opcode,  // Typically derived from if_id_instr[31:26]
    output reg  [1:0]  wb,      // Write-back control signals
    output reg  [2:0]  mem,     // Memory control signals
    output reg  [3:0]  ex       // Execute (ALU) control signals
);
    always @(*) begin
        // Default control signal assignments
        wb  = 2'b00;
        mem = 3'b000;
        ex  = 4'b0000;
        case (opcode)
            6'b000000: begin // R-type instruction
                wb  = 2'b10;     // Example: enable register write (ALU result)
                mem = 3'b000;     // No memory access
                ex  = 4'b0010;    // ALU operation (e.g., add/sub based on the function field)
            end
            6'b100011: begin // LW (Load Word)
                wb  = 2'b01;     // Write data coming from memory
                mem = 3'b001;     // Memory read control
                ex  = 4'b0010;    // ALU will perform addition for address calculation
            end
            6'b101011: begin // SW (Store Word)
                wb  = 2'b00;     // No register write-back
                mem = 3'b010;     // Memory write control
                ex  = 4'b0010;    // ALU for address calculation
            end
            6'b000100: begin // BEQ (Branch Equal)
                wb  = 2'b00;     // No register write-back
                mem = 3'b100;     // Branch control (example)
                ex  = 4'b0110;    // ALU subtraction for equality check
            end
            default: begin
                wb  = 2'b00;
                mem = 3'b000;
                ex  = 4'b0000;
            end
        endcase
    end
endmodule

