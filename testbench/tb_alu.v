// ============================================================
// Testbench: ALU
// ============================================================

`timescale 1ns/1ps

module tb_alu;

    reg  [7:0] A, B;
    reg  [2:0] OS;
    reg        EU;
    wire [7:0] bus_out;
    wire [7:0] alu_result;

    // Instantiate ALU
    alu uut (
        .A(A), .B(B),
        .OS(OS), .EU(EU),
        .bus_out(bus_out),
        .alu_result(alu_result)
    );

    initial begin
        $display("=== ALU Testbench ===");
        EU = 1;

        // Test Addition (OS = 000)
        A = 8'd30; B = 8'd14; OS = 3'b000;
        #10;
        $display("ADD: %d + %d = %d (Expected: 44)", A, B, alu_result);

        // Test Subtraction (OS = 001)
        A = 8'd30; B = 8'd14; OS = 3'b001;
        #10;
        $display("SUB: %d - %d = %d (Expected: 16)", A, B, alu_result);

        // Test XOR (OS = 010)
        A = 8'hFF; B = 8'h0F; OS = 3'b010;
        #10;
        $display("XOR: %h XOR %h = %h (Expected: F0)", A, B, alu_result);

        // Test AND (OS = 011)
        A = 8'hFF; B = 8'h0F; OS = 3'b011;
        #10;
        $display("AND: %h AND %h = %h (Expected: 0F)", A, B, alu_result);

        // Test OR (OS = 100)
        A = 8'hF0; B = 8'h0F; OS = 3'b100;
        #10;
        $display("OR: %h OR %h = %h (Expected: FF)", A, B, alu_result);

        // Test NAND (OS = 101)
        A = 8'hFF; B = 8'hFF; OS = 3'b101;
        #10;
        $display("NAND: %h NAND %h = %h (Expected: 00)", A, B, alu_result);

        // Test NOR (OS = 110)
        A = 8'h00; B = 8'h00; OS = 3'b110;
        #10;
        $display("NOR: %h NOR %h = %h (Expected: FF)", A, B, alu_result);

        $display("=== ALU Test Complete ===");
        $finish;
    end

endmodule
