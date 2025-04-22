/*
The main computational unit of our processor.
 It performs operations based on opcode and function code and has case statements accordingly.
  GIves an output in ALU result and zero flag. Accepts two 16-bit operands 
  (from registers or immediate values). 

Operations supported : -
ADD
SUB
SLL
AND
ADDI
LW
SW
BEQ, 
BNE

*/
module alu (
    input [15:0] rs_data1,     
    input [15:0] rs_data2,     
    input [3:0] alu_op,        
    input [3:0] func_code,     
    input [3:0] imm,           
    input alu_src,            
    output reg [15:0] result,  
    output reg zero_flag       
);

    parameter ADD  = 4'b0000;   
    parameter SUB  = 4'b0001;   
    parameter SLL  = 4'b0010;   
    parameter AND  = 4'b0011;  
    
    
    parameter ADDI = 4'b0011;   
    parameter LW   = 4'b0001;  
    parameter SW   = 4'b0010;   
    parameter BEQ  = 4'b0100;   
    parameter BNE  = 4'b0101;   

    always @(*) begin
        if (alu_op == 4'b0000) begin  
            case (func_code)
                ADD:  result = rs_data1 + rs_data2;       
                SUB:  result = rs_data1 - rs_data2;       
                SLL:  result = rs_data1 << rs_data2; 
                AND:  result = rs_data1 & rs_data2;       
                default: result = 16'b0;                  
            endcase
            zero_flag = (result == 16'b0);
        end else begin  
            case (alu_op)
                ADDI: begin
                      result = rs_data2 + {{12{imm[3]}}, imm}; 
                      zero_flag = (result == 16'b0);
                      end
                LW:   begin
                      result = rs_data2 + {{12{imm[3]}}, imm}; 
                      zero_flag = (result == 16'b0);
                      end
                SW:   begin
                      result = rs_data2 + {{12{imm[3]}}, imm}; 
                      zero_flag = (result == 16'b0);
                      end
                BEQ:  begin
                      result = rs_data2 - rs_data1; 
                      zero_flag = (result == 16'b0);
                      end
                BNE:  begin 
                      result = rs_data2 - rs_data1; 
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