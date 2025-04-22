`timescale 1ns / 1ps

module control_unit_tb;

    parameter CLK_PERIOD = 10;

    reg [3:0] opcode;          
    wire RegWrite;            
    wire MemWrite;             
    wire MemRead;              
    wire ALUSrc;              
    wire RegWriteSrc;          
    wire Branch;              
    wire Jump;                 
    wire [3:0] ALUOp;        

    
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

    
    initial begin
        
        opcode = 4'b0000; 
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0001;  
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0010;  
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0011;  
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0100; 
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0101;  
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        opcode = 4'b0110;  
        #10;
        $display("Opcode: %b, RegWrite: %b, MemWrite: %b, MemRead: %b, ALUSrc: %b, RegWriteSrc: %b, Branch: %b, Jump: %b, ALUOp: %b", 
                 opcode, RegWrite, MemWrite, MemRead, ALUSrc, RegWriteSrc, Branch, Jump, ALUOp);

        
        $finish;
    end

endmodule
