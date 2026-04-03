// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: ALU
// Two 8-bit inputs, 3-bit operation select, 8-bit output
// No clock used (combinational)
// Operations: ADD, SUB, XOR, AND, OR, NAND, NOR
// ============================================================

module alu (
    input  [7:0] A,         // From Accumulator
    input  [7:0] B,         // From Register B
    input  [2:0] OS,        // Operation Select (O1,O2,O3)
    input        EU,        // Enable output to bus
    output [7:0] bus_out,   // ALU result to bus
    output [7:0] alu_result // Internal result
);

    reg [7:0] result;

    // Combinational ALU operations
    always @(*) begin
        case (OS)
            3'b000: result = A + B;          // Addition
            3'b001: result = A - B;          // Subtraction
            3'b010: result = A ^ B;          // Bitwise XOR
            3'b011: result = A & B;          // Bitwise AND
            3'b100: result = A | B;          // Bitwise OR
            3'b101: result = ~(A & B);       // Bitwise NAND
            3'b110: result = ~(A | B);       // Bitwise NOR
            default: result = 8'b00000000;
        endcase
    end

    // Tri-state output to bus
    assign bus_out    = EU ? result : 8'bz;
    assign alu_result = result;

endmodule
