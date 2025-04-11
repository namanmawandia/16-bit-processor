`timescale 1ns / 1ps

module alu_tb;
    
    parameter CLK_PERIOD = 10;

    // Inputs
    reg [15:0] rs_data1_tb;
    reg [15:0] rs_data2_tb;
    reg [3:0] alu_op_tb;      // 4-bit opcode for instruction type
    reg [3:0] func_code_tb;   // 4-bit function code for R-type instructions
    reg [3:0] imm_tb;         // 4-bit immediate value for I-type
    reg alu_src_tb;           // Immediate or register-based operation

    // Outputs
    wire [15:0] result_tb;
    wire zero_tb;  // Zero flag

    // Instantiate the ALU module
    alu uut (
        .rs_data1(rs_data1_tb),
        .rs_data2(rs_data2_tb),
        .alu_op(alu_op_tb),
        .func_code(func_code_tb),
        .imm(imm_tb),
        .alu_src(alu_src_tb),
        .result(result_tb),
        .zero_flag(zero_tb)
    );

    // Clock generation
    reg clk;
    always # (CLK_PERIOD / 2) clk = ~clk;

    // Test cases
    initial begin
        clk = 0;
        
        // Test R-type: ADD (opcode = 0000, func_code = 0000)
        rs_data1_tb = 16'd100;
        rs_data2_tb = 16'd50;
        alu_op_tb = 4'b0000;      // R-type
        func_code_tb = 4'b0000;   // ADD
        alu_src_tb = 0;
        #100;

        // Test R-type: SUB (opcode = 0000, func_code = 0001)
        rs_data1_tb = 16'd200;
        rs_data2_tb = 16'd200;    // Result should be 0 (zero flag = 1)
        alu_op_tb = 4'b0000;      // R-type
        func_code_tb = 4'b0001;   // SUB
        alu_src_tb = 0;
        #100;

        // Test R-type: SLL (opcode = 0000, func_code = 0010)
        rs_data1_tb = 16'd15;
        rs_data2_tb = 16'd3;      // Shift by 3
        alu_op_tb = 4'b0000;      // R-type
        func_code_tb = 4'b0010;   // SLL
        alu_src_tb = 0;
        #100;

        // Test R-type: AND (opcode = 0000, func_code = 0011)
        rs_data1_tb = 16'b1010101010101010;
        rs_data2_tb = 16'b1100110011001100;
        alu_op_tb = 4'b0000;      // R-type
        func_code_tb = 4'b0011;   // AND
        alu_src_tb = 0;
        #100;

        // Test I-type: ADDI (opcode = 0011)
        rs_data1_tb = 16'd20;
        imm_tb = 4'b0010;         // Immediate = 2
        alu_op_tb = 4'b0011;      // ADDI
        alu_src_tb = 1;           // Immediate mode
        #100;

        // Test I-type: LW (opcode = 0001)
        rs_data1_tb = 16'd400;    // Base address
        imm_tb = 4'b0100;         // Offset = 4
        alu_op_tb = 4'b0001;      // LW
        alu_src_tb = 1;
        #100;

        // Test I-type: SW (opcode = 0010)
        rs_data1_tb = 16'd600;    // Base address
        imm_tb = 4'b0010;         // Offset = 2
        alu_op_tb = 4'b0010;      // SW
        alu_src_tb = 1;
        #100;

        // Test I-type: BEQ (opcode = 0100) - Should branch
        rs_data1_tb = 16'd50;
        rs_data2_tb = 16'd50;     // Equal values ? Zero flag should be 1
        imm_tb = 4'b0001;         // Branch offset
        alu_op_tb = 4'b0100;      // BEQ
        alu_src_tb = 0;
        #100;

        // Test I-type: BNE (opcode = 0101) - Should branch
        rs_data1_tb = 16'd10;
        rs_data2_tb = 16'd20;     // Not equal ? Zero flag should be 0
        imm_tb = 4'b0001;         // Branch offset
        alu_op_tb = 4'b0101;      // BNE
        alu_src_tb = 0;
        #100;

        // Test I-type: BNE (opcode = 0101) - Should NOT branch
        rs_data1_tb = 16'd30;
        rs_data2_tb = 16'd30;     // Equal values ? Zero flag should be 1 (no branch)
        imm_tb = 4'b0001;
        alu_op_tb = 4'b0101;      // BNE
        alu_src_tb = 0;
        #100;

        // Test J-type: JMP (opcode = 0110)
        rs_data1_tb = 16'd0;      // Ignored
        rs_data2_tb = 16'd0;      // Ignored
        imm_tb = 4'b0011;         // Address offset
        alu_op_tb = 4'b0110;      // JMP
        alu_src_tb = 1;
        #100;

        $finish;
    end

    // Display
    always @(negedge clk) begin
        $display("Time=%0t | ALU Op=%b | Func Code=%b | RS1=%d | RS2=%d | Imm=%b | Result=%d | Zero=%b",
                 $time, alu_op_tb, func_code_tb, rs_data1_tb, rs_data2_tb, imm_tb, result_tb, zero_tb);
    end

endmodule
