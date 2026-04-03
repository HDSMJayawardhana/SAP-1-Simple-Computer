// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: Memory Address Register (MAR)
// Load 4-bit address from bus when LM is LOW with CLK
// ============================================================

module mar (
    input        clk,
    input        LM,        // Active LOW load
    input  [7:0] bus_in,
    output [3:0] addr_out   // 4-bit address to RAM
);

    reg [3:0] addr;

    always @(posedge clk) begin
        if (!LM)
            addr <= bus_in[3:0];
    end

    assign addr_out = addr;

endmodule
