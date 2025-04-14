module ins_mem (
    input [7:0] pc_addr,  // 8-bit address
    output reg [15:0] inst // 16-bit instruction output
);
     
    // 64 memory locations, each storing a 8-bit instruction
    reg [7:0] ins_mem [255:0];
    
    // Loading instructions from an external file
    initial begin
        $readmemb("InsMem.mem", ins_mem);
    end
    
    always @(pc_addr) begin
        inst = {ins_mem[pc_addr],ins_mem[pc_addr+1]};
    end

endmodule
