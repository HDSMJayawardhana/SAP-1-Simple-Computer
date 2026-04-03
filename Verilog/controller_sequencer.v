// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: Controller Sequencer
// Generates control signals based on opcode and timing (T1-T6)
// Opcodes: LDA=0000, ADD=0001, SUB=0010,
//          OUT=1110, HLT=1111
// ============================================================

module controller_sequencer (
    input        clk,
    input        CLR,
    input  [3:0] opcode,    // From IR upper nibble
    output reg   CP,        // Program Counter increment
    output reg   EP,        // PC enable to bus
    output reg   LM,        // MAR load (active LOW)
    output reg   CE,        // RAM chip enable (active LOW)
    output reg   LI,        // IR load (active LOW)
    output reg   EI,        // IR enable (active LOW)
    output reg   LA,        // Reg A load (active LOW)
    output reg   EA,        // Reg A enable to bus
    output reg   EU,        // ALU enable to bus
    output reg   LB,        // Reg B load (active LOW)
    output reg   LO,        // Output Reg load (active LOW)
    output reg   HLT,       // Halt signal
    output [2:0] OS         // ALU operation select
);

    // Opcodes
    parameter LDA = 4'b0000;
    parameter ADD = 4'b0001;
    parameter SUB = 4'b0010;
    parameter OUT = 4'b1110;
    parameter HALT= 4'b1111;

    // Timing signals from ring counter
    wire [5:0] T;

    ring_counter RC (
        .clk(clk),
        .CLR(CLR),
        .T(T)
    );

    // ALU operation select based on opcode
    assign OS = (opcode == ADD) ? 3'b000 :
                (opcode == SUB) ? 3'b001 : 3'b000;

    always @(*) begin
        // Default all signals inactive
        CP  = 0; EP  = 0;
        LM  = 1; CE  = 1;
        LI  = 1; EI  = 1;
        LA  = 1; EA  = 0;
        EU  = 0; LB  = 1;
        LO  = 1; HLT = 0;

        // ==================
        // FETCH CYCLE (T1-T3)
        // Common for all instructions
        // ==================

        if (T[0]) begin  // T1: PC → MAR
            EP = 1;
            LM = 0;
        end

        if (T[1]) begin  // T2: Increment PC
            CP = 1;
        end

        if (T[2]) begin  // T3: RAM → IR
            CE = 0;
            LI = 0;
        end

        // ==================
        // EXECUTE CYCLE (T4-T6)
        // Depends on opcode
        // ==================

        case (opcode)

            LDA: begin
                if (T[3]) begin  // T4: IR(addr) → MAR
                    EI = 0;
                    LM = 0;
                end
                if (T[4]) begin  // T5: RAM → Reg A
                    CE = 0;
                    LA = 0;
                end
                // T6: No operation
            end

            ADD: begin
                if (T[3]) begin  // T4: IR(addr) → MAR
                    EI = 0;
                    LM = 0;
                end
                if (T[4]) begin  // T5: RAM → Reg B
                    CE = 0;
                    LB = 0;
                end
                if (T[5]) begin  // T6: ALU → Reg A
                    EU = 1;
                    LA = 0;
                end
            end

            SUB: begin
                if (T[3]) begin  // T4: IR(addr) → MAR
                    EI = 0;
                    LM = 0;
                end
                if (T[4]) begin  // T5: RAM → Reg B
                    CE = 0;
                    LB = 0;
                end
                if (T[5]) begin  // T6: ALU(SUB) → Reg A
                    EU = 1;
                    LA = 0;
                end
            end

            OUT: begin
                if (T[3]) begin  // T4: Reg A → Output Reg
                    EA = 1;
                    LO = 0;
                end
                // T5, T6: No operation
            end

            HALT: begin
                HLT = 1;        // Stop processing
            end

        endcase
    end

endmodule
