module zero_extension_tb;

  parameter CLK_PERIOD = 10; 

  reg [1:0] input_data;       
  wire [15:0] output_data;    

  zero_extension dut (
      .input_data(input_data),
      .output_data(output_data)
  );

  initial begin
      input_data = 2'b10; 
      
      #10;
      
      $display("Time: %0t | Input data: %b | Output data: %b",
               $time, input_data, output_data);
      
      input_data = 2'b01; 
      #10;
      
      $display("Time: %0t | Input data: %b | Output data: %b",
               $time, input_data, output_data);
      
      #10;
      #10;
      $finish;
  end

endmodule

