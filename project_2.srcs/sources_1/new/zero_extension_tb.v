module zero_extension_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Signals
  reg [1:0] input_data;       // 2-bit input data to be zero-extended
  wire [15:0] output_data;    // 16-bit zero-extended output data

  // Instantiate the Zero Extension module
  zero_extension dut (
      .input_data(input_data),
      .output_data(output_data)
  );

  // Initial stimulus
  initial begin
      // Initialize input data with an example value
      input_data = 2'b10; // Example 2-bit input (binary for "2")
      
      // Wait for some time to allow signals to propagate
      #10;
      
      // Display the values in binary
      $display("Time: %0t | Input data: %b | Output data: %b",
               $time, input_data, output_data);
      
      // Change the input to observe a different zero extension
      input_data = 2'b01; // Example: binary for "1"
      #10;
      
      // Display the new values
      $display("Time: %0t | Input data: %b | Output data: %b",
               $time, input_data, output_data);
      
      // End simulation
      #10;
      $finish;
  end

endmodule

