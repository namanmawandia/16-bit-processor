`timescale 1ns / 1ps

module top_module_tb();
    
    reg clk;
    reg reset;
    reg enable;
    reg manual_clock;
    reg clock_mode;
    wire [7:0] debug_out;
    wire [7:0] segments;
    wire [3:0] anodes;
    
   
    top_module uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .manual_clock(manual_clock),
        .clock_mode(clock_mode),
        .debug_out(debug_out),
        .segments(segments),
        .anodes(anodes)
    );
    
   
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    
    
    initial begin
        
        reset = 1;
        enable = 0;
        manual_clock = 0;
        clock_mode = 0; 
        
        
        #100;
        reset = 0;
        #20;
        enable = 1;
        #200;
        
        clock_mode = 1;
        #50;
        
        // Test several manual clock pulses
        repeat (10) begin
            manual_clock = 1;
            #50;
            manual_clock = 0;
            #50;
        end
        
       
        reset = 1;
        #50;
        reset = 0;
        #50;
        
       
        repeat (5) begin
            manual_clock = 1;
            #30;
            manual_clock = 0;
            #30;
        end
        
        
        clock_mode = 0;
        #200;
        
        
        $display("Simulation completed");
        $finish;
    end
    
    
    initial begin
        $monitor("Time=%0t, PC=%h, ALU_Result=%h, Zero_Flag=%b, Display=%h, Anodes=%b", 
                 $time, debug_out, uut.alu_result, uut.zero_flag, segments, anodes);
    end
    
    
    initial begin
        $dumpfile("top_module_tb.vcd");
        $dumpvars(0, top_module_tb);
    end
    
endmodule