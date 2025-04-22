module data_memory_tb;

  parameter integer CLK_PERIOD = 10;

  reg clk;                         
  reg [15:0] data_in;              
  reg wr, rd;                    
  reg [7:0] addr;                
  wire [15:0] data_out;         

  
  data_memory mem (
    .clk(clk),
    .data_in(data_in),
    .wr(wr),
    .rd(rd),
    .addr(addr),
    .data_out(data_out)
  );

  initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk = ~clk;
  end

  initial begin

    wr = 0;
    rd = 0;
    addr = 8'b00000000;             
    data_in = 16'b0000000000000000;  

    #20; 

    wr = 1;                        
    addr = 8'b00000101;             
    data_in = 16'b000000000000100;  
    #20; 

    wr = 0;                        
    rd = 1;                    
    addr = 8'b00000101;           
    #20; 
    
    $finish;                     
  end

  always @(posedge clk) begin
    $display("Time: %0t | Addr: %b | Wr: %b | Rd: %b | Data In: %b | Data Out: %b",
             $time, addr, wr, rd, data_in, data_out);
  end

endmodule