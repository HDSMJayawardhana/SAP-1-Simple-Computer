// ============================================================
// Testbench: SAP-1 Full System
// ============================================================

`timescale 1ns/1ps

module tb_sap1_top;

    reg        clk;
    reg        CLR;
    wire [7:0] display_out;

    // Instantiate SAP-1
    sap1_top uut (
        .clk(clk),
        .CLR(CLR),
        .display_out(display_out)
    );

    // Clock: 10ns period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        CLR = 0;    // Reset
        #20;
        CLR = 1;    // Release reset

        // Run for 500ns
        #500;

        $display("Output Register Value: %d", display_out);
        $finish;
    end

    // Monitor bus activity
    initial begin
        $monitor("Time=%0t | CLR=%b | Display=%d",
                  $time, CLR, display_out);
    end

endmodule
