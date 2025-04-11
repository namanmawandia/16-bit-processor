`timescale 1ns / 1ps

module register_file_tb;

    // Parameters
    parameter CLK_PERIOD = 10;

    // Signals
    reg clk;
    reg reset;
    reg [3:0] rs1_addr;
    reg [3:0] rs2_addr;
    reg [3:0] wr_addr;
    reg [15:0] wr_data;
    reg reg_wr_en;
    wire [15:0] rs1_data;
    wire [15:0] rs2_data;

    register_file dut (
        .clk(clk),
        .reset(reset),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .wr_addr(wr_addr),
        .wr_data(wr_data),
        .reg_wr_en(reg_wr_en),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        reg_wr_en = 0;
        rs1_addr = 4'b0000;
        rs2_addr = 4'b0001;
        wr_addr = 4'b0000;
        wr_data = 16'h0000;

        // Apply reset
        #20;
        reset = 0;

        // Scenario 1: Write to register 5
        wr_addr = 4'b0101;
        wr_data = 16'b1010101010101010;
        reg_wr_en = 1;
        #10;
        reg_wr_en = 0;

        // Read from register 5
        rs1_addr = 4'b0101;
        rs2_addr = 4'b0000; // reading from register 0 which should be 0
        #10;
        $display("Scenario 1 - Write to R5, Read R5 and R0:");
        $display("R5: %b, R0: %b", rs1_data, rs2_data);

        // Scenario 2: Write to register 10, then read from it
        wr_addr = 4'b1010;
        wr_data = 16'hF0F0;
        reg_wr_en = 1;
        #10;
        reg_wr_en = 0;

        rs1_addr = 4'b1010;
        rs2_addr = 4'b0101;
        #10;
        $display("Scenario 2 - Write to R10, Read R10 and R5:");
        $display("R10: %b, R5: %b", rs1_data, rs2_data);

        // Scenario 3: Check reset clears all registers
        reset = 1;
        #10;
        reset = 0;
        rs1_addr = 4'b1010;
        rs2_addr = 4'b0101;
        #10;
        $display("Scenario 3 - After reset, Read R10 and R5:");
        $display("R10: %b, R5: %b", rs1_data, rs2_data);

        $finish;
    end

endmodule
