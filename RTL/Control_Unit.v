// ============================================================
// Control Unit
// Instruction format: [7:4] opcode, [3:2] R1, [1:0] R2
// Convention: ALU result is written back into R1
// ============================================================
module Control_Unit(
    input  [7:0] instruction,
    output [3:0] opcode,
    output [1:0] r1_address,
    output [1:0] r2_address,
    output [1:0] write_address,
    output reg write_enable
);

    assign opcode        = instruction[7:4];
    assign r1_address    = instruction[3:2];
    assign r2_address    = instruction[1:0];
    assign write_address = instruction[3:2]; // result written back to R1

    always @(*) begin
        case (opcode)
            4'b0000, // ADD
            4'b0001, // SUB
            4'b0010, // AND
            4'b0011, // OR
            4'b0100, // NOT
            4'b0101, // NAND
            4'b0110, // NOR
            4'b0111, // LEFT SHIFT
            4'b1000, // RIGHT SHIFT
            4'b1001, // INCREMENT
            4'b1010, // DECREMENT
            4'b1011, // PASS A
            4'b1100, // PASS B
            4'b1101, // CLEAR
            4'b1110, // XOR
            4'b1111: // XNOR
                write_enable = 1'b1;

            default:
                write_enable = 1'b0;
        endcase
    end

endmodule
