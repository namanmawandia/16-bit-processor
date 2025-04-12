module alu (
    input [15:0] rs_data1,     // Source register 1 data
    input [15:0] rs_data2,     // Source register 2 data
    input [3:0] alu_op,        // ALU operation code
    input [3:0] func_code,     // Function code for R-type instructions
    input [3:0] imm,           // 4-bit immediate value (for ADDI, LW, SW, BEQ, BNE)
    input alu_src,             // Select between register or immediate value
    output reg [15:0] result,  // ALU result output
    output reg zero_flag       // Flag to indicate zero result (for branch instructions)
);

    parameter ADD  = 4'b0000;   // Addition
    parameter SUB  = 4'b0001;   // Subtraction
    parameter SLL  = 4'b0010;   // Shift Left Logical
    parameter AND  = 4'b0011;   // Bitwise AND
    
    
    parameter ADDI = 4'b0011;   // Add Immediate (I-type)
    parameter LW   = 4'b0001;   // Load Word (I-type)
    parameter SW   = 4'b0010;   // Store Word (I-type)
    parameter BEQ  = 4'b0100;   // Branch if Equal (I-type)
    parameter BNE  = 4'b0101;   // Branch if Not Equal (I-type)

    always @(*) begin
        if (alu_op == 4'b0000) begin  // R-type instructions
            case (func_code)
                ADD:  result = rs_data1 + rs_data2;       // ADD (R-type)
                SUB:  result = rs_data1 - rs_data2;       // SUB (R-type)
                SLL:  result = rs_data1 << rs_data2[3:0]; // SLL (R-type) shift by lower 4 bits
                AND:  result = rs_data1 & rs_data2;       // AND (R-type)
                default: result = 16'b0;                  // Default case
            endcase
            zero_flag = (result == 16'b0);
        end else begin  // I-type and other instructions
            case (alu_op)
                ADDI: begin
                      result = rs_data2 + {{12{imm[3]}}, imm}; // ADDI (sign-extended 4-bit immediate)
                      zero_flag = (result == 16'b0);
                      end
                LW:   begin
                      result = rs_data2 + {{12{imm[3]}}, imm}; // LW (address calculation)
                      zero_flag = (result == 16'b0);
                      end
                SW:   begin
                      result = rs_data2 + {{12{imm[3]}}, imm}; // SW (address calculation)
                      zero_flag = (result == 16'b0);
                      end
                BEQ:  begin
                      result = rs_data2 - rs_data1; // BEQ (set one flag if equal)
                      zero_flag = (result == 16'b0);
                      end
                BNE:  begin 
                      result = rs_data2 - rs_data1; // BNE (set one flag if not equal)
                      zero_flag = ~(result == 16'b0);
                      end
                default:  begin 
                          result = 16'b0;
                          zero_flag = (result == 16'b0);
                          end
            endcase
        end
    end

endmodule