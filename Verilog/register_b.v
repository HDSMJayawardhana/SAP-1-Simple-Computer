// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: Register B
// Load 8-bit from bus when LB is LOW with CLK
// Always output to ALU
// ============================================================

module register_b (
    input        clk,
    input        LB,        // Active LOW load
    input  [7:0] bus_in,
    output [7:0] alu_out    // Always output to ALU
);

    reg [7:0] data;

    // Load from bus on rising edge when LB is LOW
    always @(posedge clk) begin
        if (!LB)
            data <= bus_in;
    end

    // Always output to ALU
    assign alu_out = data;

endmodule
