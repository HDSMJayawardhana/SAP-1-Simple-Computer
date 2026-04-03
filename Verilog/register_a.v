// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: Register A (Accumulator)
// Load 8-bit from bus when LA is LOW with CLK
// Output to bus when EA is HIGH (else High Impedance)
// Always output to ALU (second output)
// ============================================================

module register_a (
    input        clk,
    input        LA,        // Active LOW load
    input        EA,        // Active HIGH enable to bus
    input  [7:0] bus_in,
    output [7:0] bus_out,   // Tri-state output to bus
    output [7:0] alu_out    // Always output to ALU
);

    reg [7:0] data;

    // Load from bus on rising edge when LA is LOW
    always @(posedge clk) begin
        if (!LA)
            data <= bus_in;
    end

    // Tri-state output to bus
    assign bus_out = EA ? data : 8'bz;

    // Always output to ALU
    assign alu_out = data;

endmodule
