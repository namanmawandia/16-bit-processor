/* In our zero_extension module that takes a 2-bit input and zero-extends 
it to a 16-bit output by padding 14 leading zeros. */

module zero_extension(
    input [1:0] input_data,
    output reg [15:0] output_data
);

    always @* begin
        output_data = {14'b0, input_data};
    end

endmodule
