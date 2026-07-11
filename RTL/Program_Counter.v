// ============================================================
// 8-bit Program Counter
// Increments by 1 when enable is high
// ============================================================
module Program_Counter(
    input clk,
    input reset,
    input enable,
    output reg [7:0] pc
);

    always @(posedge clk) begin
        if (reset)
            pc <= 8'd0;
        else if (enable)
            pc <= pc + 8'd1;
    end

endmodule
