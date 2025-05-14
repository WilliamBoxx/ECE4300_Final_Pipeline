module if_id_latch(
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] npc,
    input  wire [31:0] instr,
    output reg  [31:0] npcout,
    output reg  [31:0] instrout
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            npcout   <= 32'b0;
            instrout <= 32'b0;
        end else begin
            npcout   <= npc;
            instrout <= instr;
        end
    end

endmodule
