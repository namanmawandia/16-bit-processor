`timescale 1ns / 1ps

module program_counter_tb;

    // Parameters
    parameter CLK_PERIOD = 10;

    // Signals
    reg clk;
    reg reset;
    reg enable;
    wire [7:0] pc;
    wire [7:0] mux_pc_out;

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mux_pc_out(mux_pc_out),
        .pc(pc)
    );

    // Clock Generation
    always #(CLK_PERIOD / 2) clk = ~clk;

    // Stimulus block
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        enable = 0;

        // Hold reset high initially
        #20;
        reset = 0; // Deassert reset
        enable = 1; // Enable PC increment

        // Let it count for a few cycles
        #100;

        // Disable counting
        enable = 0;
        #30;

        // Trigger reset again
        reset = 1;
        #10;
        reset = 0;

        // Re-enable counting
        enable = 1;
        #50;

        // Stop simulation
        $finish;
    end

    // Display PC value at every positive clock edge
    always @(posedge clk) begin
        $display("Time: %0t | PC: %d | Reset: %b | Enable: %b | Mux_pc_out: %b", $time, pc, reset, enable,mux_pc_out);
    end

endmodule
