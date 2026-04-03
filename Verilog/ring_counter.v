// ============================================================
// CO221 - Digital Design | SAP-1 Simple Computer
// Module: 6-bit Ring Counter
// Generates T1 to T6 timing signals
// Active HIGH outputs
// ============================================================

module ring_counter (
    input      clk,
    input      CLR,     // Active LOW clear
    output reg [5:0] T  // T[0]=T1, T[1]=T2 ... T[5]=T6
);

    always @(posedge clk or negedge CLR) begin
        if (!CLR)
            T <= 6'b000001;  // Start at T1
        else begin
            // Shift left, wrap around
            T <= {T[4:0], T[5]};
        end
    end

endmodule
