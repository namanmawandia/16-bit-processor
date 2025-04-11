module zero_extension(
    input [1:0] input_data,       // Input data to be zero-extended
    output reg [15:0] output_data  // Zero-extended output data (16-bit)
);

    // Zero extension operation
    always @* begin
        output_data = {14'b0, input_data};
    end

endmodule
