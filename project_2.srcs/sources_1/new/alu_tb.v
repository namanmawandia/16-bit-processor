`timescale 1ns / 1ps

module alu_tb;
    
    parameter CLK_PERIOD = 10;

    reg [15:0] rs_data1_tb;
    reg [15:0] rs_data2_tb;
    reg [3:0] alu_op_tb;      
    reg [3:0] func_code_tb;   
    reg [3:0] imm_tb;         
    reg alu_src_tb;          

   
    wire [15:0] result_tb;
    wire zero_tb;  

   
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

    reg clk;
    always # (CLK_PERIOD / 2) clk = ~clk;

    initial begin
        clk = 0;
        
        rs_data1_tb = 16'd100;
        rs_data2_tb = 16'd50;
        alu_op_tb = 4'b0000;      
        func_code_tb = 4'b0000;   
        alu_src_tb = 0;
        #100;

        rs_data1_tb = 16'd200;
        rs_data2_tb = 16'd200;    
        alu_op_tb = 4'b0000;    
        func_code_tb = 4'b0001;  
        alu_src_tb = 0;
        #100;

        rs_data1_tb = 16'd15;
        rs_data2_tb = 16'd3;      
        alu_op_tb = 4'b0000;      
        func_code_tb = 4'b0010;  
        alu_src_tb = 0;
        #100;

        rs_data1_tb = 16'b1010101010101010;
        rs_data2_tb = 16'b1100110011001100;
        alu_op_tb = 4'b0000;      
        func_code_tb = 4'b0011;   
        alu_src_tb = 0;
        #100;

        rs_data1_tb = 16'd20;
        imm_tb = 4'b0010;        
        alu_op_tb = 4'b0011;      
        alu_src_tb = 1;          
        #100;

        
        rs_data1_tb = 16'd400;   
        imm_tb = 4'b0100;        
        alu_op_tb = 4'b0001;      
        alu_src_tb = 1;
        #100;

       
        rs_data1_tb = 16'd600;  
        imm_tb = 4'b0010;        
        alu_op_tb = 4'b0010;      
        alu_src_tb = 1;
        #100;

        
        rs_data1_tb = 16'd50;
        rs_data2_tb = 16'd50;     
        imm_tb = 4'b0001;         
        alu_op_tb = 4'b0100;      
        alu_src_tb = 0;
        #100;

       
        rs_data1_tb = 16'd10;
        rs_data2_tb = 16'd20;     
        imm_tb = 4'b0001;         
        alu_op_tb = 4'b0101;      
        alu_src_tb = 0;
        #100;

        
        rs_data1_tb = 16'd30;
        rs_data2_tb = 16'd30;     
        imm_tb = 4'b0001;
        alu_op_tb = 4'b0101;     
        alu_src_tb = 0;
        #100;

        
        rs_data1_tb = 16'd0;      
        rs_data2_tb = 16'd0;     
        imm_tb = 4'b0011;         
        alu_op_tb = 4'b0110;      
        alu_src_tb = 1;
        #100;

        $finish;
    end

   
    always @(negedge clk) begin
        $display("Time=%0t | ALU Op=%b | Func Code=%b | RS1=%d | RS2=%d | Imm=%b | Result=%d | Zero=%b",
                 $time, alu_op_tb, func_code_tb, rs_data1_tb, rs_data2_tb, imm_tb, result_tb, zero_tb);
    end

endmodule
