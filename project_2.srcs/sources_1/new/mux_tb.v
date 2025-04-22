`timescale 1ns / 1ps

module mux_tb;

    reg [15:0] input1;
    reg [15:0] input2;
    reg select;

    wire [15:0] out;

    mux #(16) uut (
        .input1(input1),
        .input2(input2),
        .select(select),
        .out(out)
    );

    initial begin
        input1 = 16'b0000000000000001;
        input2 = 16'b0000000000000010;
        select = 0;
        #10;

        select = 1;
        #10;

        input1 = 16'hAAAA;
        input2 = 16'h5555;
        select = 0;
        #10;

        select = 1;
        #10;

        $finish;
    end

    always @(out) begin
        $display("Time = %0t | select = %b | out = %b", $time, select, out);
    end

endmodule
