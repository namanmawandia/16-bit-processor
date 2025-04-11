module data_memory_tb;

  // Clock period (10 time units total period)
  parameter integer CLK_PERIOD = 10;

  // Signals for the 16-bit data memory
  reg clk;                          // Clock signal
  reg [15:0] data_in;               // 16-bit data input
  reg wr, rd;                     // Write and read control signals
  reg [7:0] addr;                 // 8-bit address (256 locations)
  wire [15:0] data_out;             // 16-bit data output

  
  data_memory mem (
    .clk(clk),
    .data_in(data_in),
    .wr(wr),
    .rd(rd),
    .addr(addr),
    .data_out(data_out)
  );

  // Clock generation: toggle clock every half period
  initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk = ~clk;
  end

  // Stimulus to test the data memory module
  initial begin
    // Initialize signals
    wr = 0;
    rd = 0;
    addr = 8'b00000000;             // Start at address 0
    data_in = 16'b0000000000000000;  // Initialize data to 0

    #20; // Wait for a few clock cycles

    // Write operation: Write a 16-bit value to memory location 5
    wr = 1;                        // Enable write
    addr = 8'b00000101;             // Address 5
    data_in = 16'b000000000000100;  // 16-bit data (binary representation for A5A5)
    #20; // Wait for write to take place

    // Read operation: Read from memory location 5
    wr = 0;                        // Disable write
    rd = 1;                        // Enable read
    addr = 8'b00000101;             // Address 5
    #20; // Wait to observe the read result

    $finish;                       // End simulation
  end

  // Display at each positive clock edge
  always @(posedge clk) begin
    $display("Time: %0t | Addr: %b | Wr: %b | Rd: %b | Data In: %b | Data Out: %b",
             $time, addr, wr, rd, data_in, data_out);
  end

endmodule