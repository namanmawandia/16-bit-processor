`timescale 1ns / 1ns

module InstructionMemory_tb;

    reg clk;
    reg [7:0] pc_addr;      
    wire [15:0] inst;       
    reg [7:0] prev_pc;      

    
    ins_mem ins_mem_inst (
        .pc_addr(pc_addr),
        .inst(inst)
    );

    always begin
        #5 clk = ~clk; 
    end

    // Initial Block for Test Procedure
    initial begin

        clk = 0;
        pc_addr = 8'h00;  
        prev_pc = 8'h00;  
        #10;              

        repeat (256) begin
            #5;  
            
            
            pc_addr = pc_addr + 1;

            if (pc_addr == 8'hFF) 
                pc_addr = 8'h00;

            if (pc_addr != prev_pc)
                $display("PC Address: %h, Instruction: %h", pc_addr, inst);

            prev_pc = pc_addr;
        end

        $finish;
    end

endmodule
