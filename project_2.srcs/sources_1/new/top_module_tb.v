`timescale 1ns / 1ps

module top_module_tb();
    // Testbench signals
    reg clk;
    reg reset;
    reg enable;
    reg manual_clock;
    reg clock_mode;
    wire [7:0] debug_out;
    wire [7:0] segments;
    wire [3:0] anodes;
    
    // Instantiate the Unit Under Test (UUT)
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
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock (10ns period)
    end
    
    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        enable = 0;
        manual_clock = 0;
        clock_mode = 0; // Use automatic clock initially
        
        // Apply reset
        #100;
        reset = 0;
        
        // Test automatic clock mode
        #20;
        enable = 1;
        #200;
        
        // Test manual clock mode
        clock_mode = 1;
        #50;
        
        // Test several manual clock pulses
        repeat (10) begin
            manual_clock = 1;
            #50;
            manual_clock = 0;
            #50;
        end
        
        // Test reset during operation
        reset = 1;
        #50;
        reset = 0;
        #50;
        
        // Test more manual clock pulses after reset
        repeat (5) begin
            manual_clock = 1;
            #30;
            manual_clock = 0;
            #30;
        end
        
        // Switch back to automatic mode
        clock_mode = 0;
        #200;
        
        // Complete the simulation
        $display("Simulation completed");
        $finish;
    end
    
    // Monitor important signals
    initial begin
        $monitor("Time=%0t, PC=%h, ALU_Result=%h, Zero_Flag=%b, Display=%h, Anodes=%b", 
                 $time, debug_out, uut.alu_result, uut.zero_flag, segments, anodes);
    end
    
    // Optional: Save waveform data
    initial begin
        $dumpfile("top_module_tb.vcd");
        $dumpvars(0, top_module_tb);
    end
    
endmodule