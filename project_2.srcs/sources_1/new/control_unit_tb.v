`timescale 1ns / 1ps

module control_unit_tb;

    // Parameters
    parameter CLK_PERIOD = 10;

    // Signals
    reg [3:0] opcode;          // 4-bit opcode for 16-bit ALU operations
    wire RegWrite;             // Register write enable
    wire MemWrite;             // Memory write enable
    wire MemRead;              // Memory read enable
    wire ALUSrc;               // ALU source select: 0 = reg, 1 = imm
    wire RegWriteSrc;          // Register write source (ALU result or Memory)
    wire Branch;               // Branch control (BEQ/BNE)
    wire Jump;                 // Jump control (JMP)
    wire [3:0] ALUOp;         // ALU operation code (directly from opcode)

    
    control_unit cu (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ALUSrc(ALUSrc),
        .RegWriteSrc(RegWriteSrc),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)
    );

    // Initial stimulus
    initial begin
        // Test cases with 16-bit opcodes
        opcode = 4'b0000;  // Opcode 0000: R-Type Instructions (ADD, SUB, SLL, AND)
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0001;  // Opcode 0001: Load Word (LW)
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0010;  // Opcode 0010: Store Word (SW)
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0011;  // Opcode 0011: Add Immediate (ADDI)
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0100;  // Opcode 0100: Branch if Equal (BEQ)
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0101;  // Opcode 0101: Branch if Not Equal (BNE)
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0110;  // Opcode 0110: Jump (JMP)
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        // Finish simulation
        $finish;
    end

endmodule
