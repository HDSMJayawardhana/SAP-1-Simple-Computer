// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: Output Register
// Load 8-bit from bus when LO is LOW with CLK
// Output always available to 7-segment display
// ============================================================

module output_register (
    input        clk,
    input        LO,        // Active LOW load
    input  [7:0] bus_in,
    output [7:0] display_out // To 7-segment display
);

    reg [7:0] data;

    always @(posedge clk) begin
        if (!LO)
            data <= bus_in;
    end

    assign display_out = data;

endmodule
