module register_file (
    input wire clk,
    input wire reset,
    input [3:0] rs1_addr,   // Read address 1 (4 bits for 16 registers)
    input [3:0] rs2_addr,   // Read address 2
    input [3:0] wr_addr,    // Write address
    input [15:0] wr_data,   // Data to write
    input reg_wr_en,        // Write enable
    output reg [15:0] rs1_data, // Output for read port 1
    output reg [15:0] rs2_data  // Output for read port 2
);

    // Declare 16 registers, each 16 bits wide
    reg [15:0] registers [15:0];
    integer i;
    
    // Reset and write logic
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 16; i = i + 1)
                registers[i] <= 16'b0;
        end else if (reg_wr_en) begin
            registers[wr_addr] <= wr_data;
        end
    end

    // Combinational read logic
    always @(*) begin
        rs1_data = registers[rs1_addr];
        rs2_data = registers[rs2_addr];
    end

endmodule
