// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: SAP-1 Top Level Integration
// Connects all modules via 8-bit data bus
// ============================================================

module sap1_top (
    input        clk,
    input        CLR,
    output [7:0] display_out
);

    // 8-bit Data Bus
    wire [7:0] bus;

    // Control signals
    wire CP, EP, LM, CE, LI, EI, LA, EA, EU, LB, LO, HLT;
    wire [2:0] OS;

    // Internal wires
    wire [3:0] pc_addr;
    wire [3:0] mar_addr;
    wire [7:0] reg_a_to_alu;
    wire [7:0] reg_b_to_alu;
    wire [7:0] alu_result;
    wire [3:0] opcode;

    // Program Counter
    program_counter PC (
        .clk(clk), .CLR(CLR),
        .CP(CP), .EP(EP),
        .bus_out(bus)
    );

    // MAR
    mar MAR (
        .clk(clk), .LM(LM),
        .bus_in(bus),
        .addr_out(mar_addr)
    );

    // RAM
    ram RAM (
        .clk(clk), .WE(1'b1), .CE(CE),
        .addr(mar_addr),
        .bus_in(bus),
        .bus_out(bus)
    );

    // Instruction Register
    instruction_register IR (
        .clk(clk), .CLR(CLR),
        .LI(LI), .EI(EI),
        .bus_in(bus),
        .bus_out(bus),
        .opcode(opcode)
    );

    // Register A
    register_a REG_A (
        .clk(clk), .LA(LA), .EA(EA),
        .bus_in(bus),
        .bus_out(bus),
        .alu_out(reg_a_to_alu)
    );

    // Register B
    register_b REG_B (
        .clk(clk), .LB(LB),
        .bus_in(bus),
        .alu_out(reg_b_to_alu)
    );

    // ALU
    alu ALU (
        .A(reg_a_to_alu),
        .B(reg_b_to_alu),
        .OS(OS), .EU(EU),
        .bus_out(bus),
        .alu_result(alu_result)
    );

    // Output Register
    output_register OUT_REG (
        .clk(clk), .LO(LO),
        .bus_in(bus),
        .display_out(display_out)
    );

    // Controller Sequencer
    controller_sequencer CTRL (
        .clk(clk), .CLR(CLR),
        .opcode(opcode),
        .CP(CP), .EP(EP),
        .LM(LM), .CE(CE),
        .LI(LI), .EI(EI),
        .LA(LA), .EA(EA),
        .EU(EU), .LB(LB),
        .LO(LO), .HLT(HLT),
        .OS(OS)
    );

endmodule
