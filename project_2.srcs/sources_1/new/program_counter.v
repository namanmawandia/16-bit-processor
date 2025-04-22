/*We have implemnted a program_counter module that outputs an 8-bit program counter value. 
On a rising clock edge,if reset is high, the counter is reset to zero. 
Otherwise, it updates the PC with the value from mux_pc_out. The enable input is present but unused in the logic.*/

module program_counter(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [7:0] mux_pc_out,
    output reg [7:0] pc
);

    initial begin
        pc = 8'b00000000;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 8'b00000000;
        end else begin
            pc <= mux_pc_out;
        end
    end

endmodule
