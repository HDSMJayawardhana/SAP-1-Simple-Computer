// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: Program Counter
// 4-bit counter, increments when CP is HIGH on -CLK edge
// Output to bus when EP is HIGH
// Active LOW clear input (CLR)
// ============================================================

module program_counter (
    input        clk,
    input        CLR,       // Active LOW clear
    input        CP,        // Increment enable
    input        EP,        // Enable output to bus
    output [7:0] bus_out    // 4-bit output on 8-bit bus
);

    reg [3:0] count;

    always @(negedge clk or negedge CLR) begin
        if (!CLR)
            count <= 4'b0000;
        else if (CP)
            count <= count + 1;
    end

    // Output 4-bit count to lower nibble of bus
    assign bus_out = EP ? {4'b0000, count} : 8'bz;

endmodule
