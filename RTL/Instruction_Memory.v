// ============================================================
// Instruction Memory
// 256 locations, each instruction is 8-bit
// ============================================================
module Instruction_Memory(
    input  [7:0] address,
    output [7:0] instruction
);

    reg [7:0] memory [0:255];
    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 8'd0;

        // Keep program.mem inside Programs folder
        $readmemb("program.mem", memory);
    end

    assign instruction = memory[address];

endmodule
