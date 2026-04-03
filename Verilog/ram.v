// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: RAM 16x8
// 16 locations, 8-bit wide
// Write when WE is LOW
// Output when CE is LOW and EU is HIGH
// ============================================================

module ram (
    input        clk,
    input        WE,        // Active LOW write enable
    input        CE,        // Active LOW chip enable
    input  [3:0] addr,      // 4-bit address from MAR
    input  [7:0] bus_in,
    output [7:0] bus_out
);

    reg [7:0] memory [0:15];

    // Initialize RAM with sample program
    initial begin
        // Sample: LDA 14, ADD 15, OUT, HLT
        memory[0]  = 8'b0000_1110; // LDA 14
        memory[1]  = 8'b0001_1111; // ADD 15
        memory[2]  = 8'b1110_0000; // OUT
        memory[3]  = 8'b1111_0000; // HLT
        memory[4]  = 8'b0000_0000;
        memory[5]  = 8'b0000_0000;
        memory[6]  = 8'b0000_0000;
        memory[7]  = 8'b0000_0000;
        memory[8]  = 8'b0000_0000;
        memory[9]  = 8'b0000_0000;
        memory[10] = 8'b0000_0000;
        memory[11] = 8'b0000_0000;
        memory[12] = 8'b0000_0000;
        memory[13] = 8'b0000_0000;
        memory[14] = 8'b0001_1110; // Data: 30 (0x1E)
        memory[15] = 8'b0000_1110; // Data: 14 (0x0E)
    end

    // Write to RAM
    always @(posedge clk) begin
        if (!WE)
            memory[addr] <= bus_in;
    end

    // Read from RAM (tri-state)
    assign bus_out = (!CE) ? memory[addr] : 8'bz;

endmodule
