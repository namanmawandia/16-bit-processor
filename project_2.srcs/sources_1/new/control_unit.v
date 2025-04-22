/*
This unit as named controls decision making in a lot of processes. 
It receives a opcode from the instruction and depending upon multiple case 
statements returns the output/decision. It gives signals like read or write enable, 
ALU source selectio, pc increment or branch/jump, etc. Also, as the basic step, 
it decides which type of instruction we are on right now (R-type, I-type, etc).

*/

module control_unit(
    input [3:0] opcode,        
    output reg RegWrite,       
    output reg MemWrite,       
    output reg MemRead,        
    output reg ALUSrc,         
    output reg RegWriteSrc,    
    output reg Branch,         
    output reg Jump,         
    output reg [3:0] ALUOp     
);

    always @(*) begin
        RegWrite    = 0;
        MemWrite    = 0;
        MemRead     = 0;
        ALUSrc      = 0;
        RegWriteSrc = 0;
        Branch      = 0;
        Jump        = 0;
        ALUOp       = opcode; 

        case (opcode)
            4'b0000: begin 
                RegWrite = 1;
                ALUSrc   = 0; 
                RegWriteSrc = 0; 
            end

            4'b0001: begin 
                RegWrite = 1;
                MemRead  = 1;
                ALUSrc   = 1; 
                RegWriteSrc = 1; 
            end

            4'b0010: begin 
                MemWrite = 1;
                ALUSrc   = 1; 
            end

            4'b0011: begin 
                RegWrite = 1;
                ALUSrc   = 1; 
                RegWriteSrc = 0;
            end

            4'b0100: begin 
                Branch = 1;
                ALUSrc = 0; 
            end

            4'b0101: begin
                Branch = 1;
                ALUSrc = 0;
            end

            4'b0110: begin 
                Jump = 1;
            end

            default: begin
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
