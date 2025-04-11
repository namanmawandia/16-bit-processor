module data_memory(
input clk,                   // Clock input
  input [15:0] data_in,        // 16-bit data input
  input wr,                    // Write control signal
  input rd,                    // Read control signal
  input [7:0] addr,            // 8-bit address input (still 256 entries)
  output reg [15:0] data_out   // 16-bit data output
    );

  reg [15:0] memory [0:255];   // 256 x 16-bit memory array

  // Write operation on falling edge of clock
  always @(negedge clk) begin
    if (wr) begin
      memory[addr] <= data_in; 
    end
  end

  // Read operation
  always @(addr or rd) begin
    if (rd) begin
      data_out = memory[addr];  
    end else begin
      data_out = 16'bzzzzzzzzzzzzzzzz;  // High-impedance when not reading
    end
  end

endmodule
