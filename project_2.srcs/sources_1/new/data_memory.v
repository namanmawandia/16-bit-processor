/* We are defining here a data_memory module. On the falling edge of the clock, if wr is high, 
the module writes data_in to the specified addr. If rd is high, it reads from memory and drives data_out; 
otherwise, data_out is set to high-impedance.
*/

module data_memory(
  input clk,
  input [15:0] data_in,
  input wr,
  input rd,
  input [7:0] addr,
  output reg [15:0] data_out
);

  reg [15:0] memory [0:255];

  always @(negedge clk) begin
    if (wr) begin
      memory[addr] <= data_in; 
    end
  end

  always @(addr or rd) begin
    if (rd) begin
      data_out = memory[addr];  
    end else begin
      data_out = 16'bzzzzzzzzzzzzzzzz;
    end
  end

endmodule
