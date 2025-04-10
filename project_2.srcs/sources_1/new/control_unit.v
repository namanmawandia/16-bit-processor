module control_unit(
    input [3:0] opcode,        // 4-bit opcode
    output reg RegWrite,       // Register write enable
    output reg MemWrite,       // Memory write enable
    output reg MemRead,        // Memory read enable
    output reg ALUSrc,         // ALU source select: 0 = reg, 1 = imm
    output reg RegWriteSrc,    // 0 = ALU result, 1 = Memory data
    output reg Branch,         // Branch flag for BEQ/BNE
    output reg Jump,           // Jump flag
    output reg [3:0] ALUOp     // ALU operation selection (directly assigned from opcode)
);

    always @(*) begin
        // Default control signals (safe defaults)
        RegWrite    = 0;
        MemWrite    = 0;
        MemRead     = 0;
        ALUSrc      = 0;
        RegWriteSrc = 0;
        Branch      = 0;
        Jump        = 0;
        ALUOp       = opcode;  // ALU operation directly follows the opcode

        case (opcode)
            4'b0000: begin // R-Type Instructions (ADD, SUB, SLL, AND)
                RegWrite = 1;
                ALUSrc   = 0; // Use register values
                RegWriteSrc = 0; // Result comes from ALU
            end

            4'b0001: begin // Load Word (LW)
                RegWrite = 1;
                MemRead  = 1;
                ALUSrc   = 1; // Use immediate for address calculation
                RegWriteSrc = 1; // Write data from memory to register
            end

            4'b0010: begin // Store Word (SW)
                MemWrite = 1;
                ALUSrc   = 1; // Use immediate for address calculation
            end

            4'b0011: begin // Add Immediate (ADDI)
                RegWrite = 1;
                ALUSrc   = 1; // Use immediate value
                RegWriteSrc = 0; // Write ALU result to register
            end

            4'b0100: begin // Branch if Equal (BEQ)
                Branch = 1;
                ALUSrc = 0; // Use register values
            end

            4'b0101: begin // Branch if Not Equal (BNE)
                Branch = 1;
                ALUSrc = 0; // Use register values
            end

            4'b0110: begin // Jump (JMP)
                Jump = 1;
            end

            default: begin
                // Safe defaults to prevent unintended behavior
                RegWrite = 0;
                MemWrite = 0;
                MemRead  = 0;
                ALUSrc   = 0;
                RegWriteSrc = 0;
                Branch   = 0;
                Jump     = 0;
            end
        endcase
    end
endmodule
