module program_counter(
    input wire clk,       // Clock signal
    input wire reset,     // Reset signal
    input wire enable,    // Enable signal (increments PC if high)
    input wire [7:0] mux_pc_out,
    output reg [7:0] pc   // 8-bit Program Counter output
);

    // Initialize PC to 0
    initial begin
        pc = 8'b00000000;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 8'b00000000; // Reset PC to 0
        end
        else if (enable) begin
            pc <= mux_pc_out; // Increment PC by 1
        end
    end

endmodule
