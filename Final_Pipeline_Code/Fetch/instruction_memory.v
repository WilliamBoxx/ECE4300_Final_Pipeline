`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2025 04:25:08 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(
    input [6:0] addr,      // 7-bit address (supports 128 words)
    output [31:0] data
);

    reg [31:0] memory [0:127];  // Memory array for instructions
    integer i;  // Loop variable for printing memory

    // Memory Initialization
    initial begin
        $readmemb("risc.txt", memory);
        for (i = 0; i < 24; i = i + 1) 
            $display("Instruction Memory[%0d] = %b", i, memory[i]);
    end

    // Fetch instruction
    assign data = memory[addr];

endmodule



