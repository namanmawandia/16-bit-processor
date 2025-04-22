/* We are making the register_file module with 16 registers. 
On a rising clock edge, if reset is high, all registers are cleared. 
If reg_wr_en is high, wr_data is written to the register at wr_addr. 
The outputs rs1_data and rs2_data continuously reflect the contents of the registers at rs1_addr and rs2_addr. */

module register_file (
    input wire clk,
    input wire reset,
    input [3:0] rs1_addr,
    input [3:0] rs2_addr,
    input [3:0] wr_addr,
    input [15:0] wr_data,
    input reg_wr_en,
    output reg [15:0] rs1_data,
    output reg [15:0] rs2_data
);

    reg [15:0] registers [15:0];
    integer i;
    
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 16; i = i + 1)
                registers[i] <= 16'b0;
        end else if (reg_wr_en) begin
            registers[wr_addr] <= wr_data;
        end
    end

    always @(*) begin
        rs1_data = registers[rs1_addr];
        rs2_data = registers[rs2_addr];
    end

endmodule
