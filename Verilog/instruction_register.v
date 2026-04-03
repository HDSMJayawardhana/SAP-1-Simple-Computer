// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: Instruction Register (IR)
// Load 8-bit from bus when LI is LOW with CLK
// Output lower nibble (LSNibble 4) to bus when EI is LOW
// Upper nibble goes to controller as opcode
// ============================================================

module instruction_register (
    input        clk,
    input        CLR,       // Active LOW clear
    input        LI,        // Active LOW load
    input        EI,        // Active LOW enable output
    input  [7:0] bus_in,
    output [7:0] bus_out,   // Lower nibble to bus
    output [3:0] opcode     // Upper nibble to controller
);

    reg [7:0] instruction;

    always @(posedge clk or negedge CLR) begin
        if (!CLR)
            instruction <= 8'b00000000;
        else if (!LI)
            instruction <= bus_in;
    end

    // Lower nibble (address) to bus when EI is LOW
    assign bus_out = (!EI) ? {4'b0000, instruction[3:0]} : 8'bz;

    // Upper nibble = opcode to controller
    assign opcode  = instruction[7:4];

endmodule
