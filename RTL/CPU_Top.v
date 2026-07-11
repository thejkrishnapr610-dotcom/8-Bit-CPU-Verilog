// ============================================================
// Connected 8-bit CPU Top Module
// Fetch -> Decode -> Read Registers -> Execute -> Write Back
// Instruction format: opcode[7:4], R1[3:2], R2[1:0]
// Write-back convention: R1 = R1 operation R2
// ============================================================
module CPU_Top(
    input clk,
    input reset,
    output [7:0] pc_out,
    output [7:0] instruction_out,
    output [3:0] opcode_out,
    output [1:0] r1_address_out,
    output [1:0] r2_address_out,
    output [7:0] read_data1_out,
    output [7:0] read_data2_out,
    output [7:0] alu_result_out,
    output carry_out,
    output zero_out,
    output overflow_out,
    output negative_out,
    output write_enable_out
);

    wire [7:0] pc;
    wire [7:0] instruction;
    wire [3:0] opcode;
    wire [1:0] r1_address;
    wire [1:0] r2_address;
    wire [1:0] write_address;
    wire write_enable;
    wire [7:0] read_data1;
    wire [7:0] read_data2;
    wire [7:0] alu_result;
    wire carry;
    wire zero;
    wire overflow;
    wire negative;

    Program_Counter PC_inst(
        .clk(clk),
        .reset(reset),
        .enable(1'b1),
        .pc(pc)
    );

    Instruction_Memory IM_inst(
        .address(pc),
        .instruction(instruction)
    );

    Control_Unit CU_inst(
        .instruction(instruction),
        .opcode(opcode),
        .r1_address(r1_address),
        .r2_address(r2_address),
        .write_address(write_address),
        .write_enable(write_enable)
    );

    Register_File RF_inst(
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .read_address1(r1_address),
        .read_address2(r2_address),
        .write_address(write_address),
        .write_data(alu_result),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    ALU ALU_inst(
        .A(read_data1),
        .B(read_data2),
        .opcode(opcode),
        .result(alu_result),
        .carry(carry),
        .zero(zero),
        .overflow(overflow),
        .negative(negative)
    );

    assign pc_out = pc;
    assign instruction_out = instruction;
    assign opcode_out = opcode;
    assign r1_address_out = r1_address;
    assign r2_address_out = r2_address;
    assign read_data1_out = read_data1;
    assign read_data2_out = read_data2;
    assign alu_result_out = alu_result;
    assign carry_out = carry;
    assign zero_out = zero;
    assign overflow_out = overflow;
    assign negative_out = negative;
    assign write_enable_out = write_enable;

endmodule
