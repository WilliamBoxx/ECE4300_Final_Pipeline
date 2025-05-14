`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2025 04:45:09 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input [31:0] Address,
    input [31:0] WriteData,
    input MemWrite,
    input MemRead,
    output reg [31:0] ReadData
);

    reg [31:0] memory [0:255];  // 256 words of memory
    integer i;  // Loop variable for printing memory

    // Memory Initialization
    initial begin
        $readmemb("data.txt", memory);
        for (i = 0; i < 6; i = i + 1) 
            $display("Data Memory[%0d] = %b", i, memory[i]);
    end

    // Memory Read
    always @(*) begin
        if (MemRead)
            ReadData = memory[Address[9:2]];  // Word addressing
        else
            ReadData = 32'b0;
    end

    // Memory Write
    always @(posedge MemWrite) begin
        if (MemWrite)
            memory[Address[9:2]] <= WriteData;
    end

endmodule