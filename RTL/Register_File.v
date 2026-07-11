// ============================================================
// Register File
// Four 8-bit registers: R0, R1, R2, R3
// Two asynchronous read ports and one synchronous write port
// ============================================================
module Register_File(
    input clk,
    input reset,
    input write_enable,
    input [1:0] read_address1,
    input [1:0] read_address2,
    input [1:0] write_address,
    input [7:0] write_data,
    output [7:0] read_data1,
    output [7:0] read_data2
);

    reg [7:0] memory [0:3];

    assign read_data1 = memory[read_address1];
    assign read_data2 = memory[read_address2];

    always @(posedge clk) begin
        if (reset) begin
            memory[0] <= 8'd10; // R0 initial value
            memory[1] <= 8'd20; // R1 initial value
            memory[2] <= 8'd30; // R2 initial value
            memory[3] <= 8'd40; // R3 initial value
        end
        else if (write_enable) begin
            memory[write_address] <= write_data;
        end
    end

endmodule
