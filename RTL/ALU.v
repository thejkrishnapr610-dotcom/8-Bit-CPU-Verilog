// ============================================================
// 8-bit ALU
// Supports 16 arithmetic and logic operations
// ============================================================
module ALU(
    input  [7:0] A,
    input  [7:0] B,
    input  [3:0] opcode,
    output reg [7:0] result,
    output reg carry,
    output reg zero,
    output reg overflow,
    output reg negative
);

    reg [8:0] temp;

    always @(*) begin
        result   = 8'd0;
        carry    = 1'b0;
        overflow = 1'b0;
        temp     = 9'd0;

        case (opcode)
            4'b0000: begin // ADD: A + B
                temp = {1'b0, A} + {1'b0, B};
                result = temp[7:0];
                carry = temp[8];
                overflow = (A[7] == B[7]) && (result[7] != A[7]);
            end

            4'b0001: begin // SUB: A - B
                temp = {1'b0, A} - {1'b0, B};
                result = temp[7:0];
                carry = temp[8];
                overflow = (A[7] != B[7]) && (result[7] != A[7]);
            end

            4'b0010: result = A & B;        // AND
            4'b0011: result = A | B;        // OR
            4'b0100: result = ~A;           // NOT A
            4'b0101: result = ~(A & B);     // NAND
            4'b0110: result = ~(A | B);     // NOR

            4'b0111: begin                  // LEFT SHIFT
                carry = A[7];
                result = A << 1;
            end

            4'b1000: begin                  // RIGHT SHIFT
                carry = A[0];
                result = A >> 1;
            end

            4'b1001: begin                  // INCREMENT A
                temp = {1'b0, A} + 9'd1;
                result = temp[7:0];
                carry = temp[8];
            end

            4'b1010: begin                  // DECREMENT A
                temp = {1'b0, A} - 9'd1;
                result = temp[7:0];
                carry = temp[8];
            end

            4'b1011: result = A;            // PASS A
            4'b1100: result = B;            // PASS B
            4'b1101: result = 8'd0;         // CLEAR
            4'b1110: result = A ^ B;        // XOR
            4'b1111: result = ~(A ^ B);     // XNOR

            default: result = 8'd0;
        endcase

        zero     = (result == 8'd0);
        negative = result[7];
    end

endmodule
