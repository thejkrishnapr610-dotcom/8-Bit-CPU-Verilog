`timescale 1ns/1ps

module CPU_Top_tb;

    reg clk;
    reg reset;

    wire [7:0] pc_out;
    wire [7:0] instruction_out;
    wire [3:0] opcode_out;
    wire [1:0] r1_address_out;
    wire [1:0] r2_address_out;
    wire [7:0] read_data1_out;
    wire [7:0] read_data2_out;
    wire [7:0] alu_result_out;
    wire carry_out;
    wire zero_out;
    wire overflow_out;
    wire negative_out;
    wire write_enable_out;

    CPU_Top DUT(
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .instruction_out(instruction_out),
        .opcode_out(opcode_out),
        .r1_address_out(r1_address_out),
        .r2_address_out(r2_address_out),
        .read_data1_out(read_data1_out),
        .read_data2_out(read_data2_out),
        .alu_result_out(alu_result_out),
        .carry_out(carry_out),
        .zero_out(zero_out),
        .overflow_out(overflow_out),
        .negative_out(negative_out),
        .write_enable_out(write_enable_out)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1'b1;
        #12;
        reset = 1'b0;
        #120;
        $stop;
    end

    initial begin
        $monitor("Time=%0t PC=%0d INST=%b OPCODE=%b R1=%0d R2=%0d A=%0d B=%0d RESULT=%0d C=%b Z=%b O=%b N=%b WE=%b",
                 $time, pc_out, instruction_out, opcode_out, r1_address_out, r2_address_out,
                 read_data1_out, read_data2_out, alu_result_out, carry_out, zero_out,
                 overflow_out, negative_out, write_enable_out);
    end

endmodule
