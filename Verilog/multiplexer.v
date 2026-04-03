// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: ALU Multiplexer
// Selects one of 7 arithmetic/logic results
// Based on 3-bit Operation Select input
// ============================================================

module mux_alu (
    input  [7:0] add_result,
    input  [7:0] sub_result,
    input  [7:0] xor_result,
    input  [7:0] and_result,
    input  [7:0] or_result,
    input  [7:0] nand_result,
    input  [7:0] nor_result,
    input  [2:0] OS,            // Operation Select
    output reg [7:0] alu_out
);

    always @(*) begin
        case (OS)
            3'b000: alu_out = add_result;
            3'b001: alu_out = sub_result;
            3'b010: alu_out = xor_result;
            3'b011: alu_out = and_result;
            3'b100: alu_out = or_result;
            3'b101: alu_out = nand_result;
            3'b110: alu_out = nor_result;
            default: alu_out = 8'b00000000;
        endcase
    end

endmodule
