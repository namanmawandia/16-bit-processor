`timescale 1ns / 1ps

module program_counter_tb;

    parameter CLK_PERIOD = 10;


    reg clk;
    reg reset;
    reg enable;        
    reg [7:0] mux_pc_out;  
    wire [7:0] pc;

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mux_pc_out(mux_pc_out),
        .pc(pc)
    );

    always #(CLK_PERIOD / 2) clk = ~clk;

    // Stimulus block
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        enable = 0;
        mux_pc_out = 8'h00;

        #(CLK_PERIOD*2) reset = 0;

        mux_pc_out = 8'h01;
        #CLK_PERIOD;
        mux_pc_out = 8'h02;
        #CLK_PERIOD;
        mux_pc_out = 8'h03;
        #CLK_PERIOD;

        reset = 1;
        mux_pc_out = 8'h01;
        #CLK_PERIOD;
        reset = 0;
        #CLK_PERIOD;

        mux_pc_out = 8'h04;
        #CLK_PERIOD;
        mux_pc_out = 8'h05;
        #CLK_PERIOD;

        $finish;
    end

    always @(posedge clk) begin
        $display("[%0t] PC: 0x%h, RESET: %b",
                $time, pc, reset);
    end

endmodule