/*  We are using ins_mem tto simulates the instruction memory. It takes an 8-bit program 
counter address (pc_addr) as input and outputs the corresponding 16-bit instruction (inst). 
The memory is initialized with values from an external file named InsMem.mem
*/

module ins_mem (
    input [7:0] pc_addr,
    output reg [15:0] inst
);
     
    reg [15:0] ins_mem [255:0];
    
    initial begin
        $readmemb("InsMem.mem", ins_mem);
    end
    
    always @(pc_addr) begin
        inst <= ins_mem[pc_addr];
    end

endmodule
