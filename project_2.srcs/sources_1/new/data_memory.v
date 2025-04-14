module data_memory(
input clk,                   // Clock input
  input [15:0] data_in,        // 16-bit data input
  input wr,                    // Write control signal
  input rd,                    // Read control signal
  input [7:0] addr,            // 8-bit address input (still 256 entries)
  output reg [15:0] data_out   // 16-bit data output
    );

  reg [7:0] memory [0:255];   // 256 x 16-bit memory array
  integer i;
  wire [7:0] high_byte = data_in[15:8];
  wire [7:0] low_byte = data_in[7:0];
  
  // Write operation on falling edge of clock
  always @(negedge clk) begin
    if (wr) begin
      memory[addr] <= high_byte;
      memory[addr+1] <= low_byte; 
    end
  end

  // Read operation
  always @(addr or rd) begin
    if (rd) begin
      data_out = {memory[addr],memory[addr+1]};  
    end else begin
      data_out = 16'bzzzzzzzzzzzzzzzz;  // High-impedance when not reading
    end
  end

  initial begin
        // zero initialization
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 8'b0;
   end

endmodule
