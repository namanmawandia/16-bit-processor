module ins_mem (
    input [7:0] pc_addr,  // 8-bit address
    output reg [15:0] inst // 16-bit instruction output
);
     
    // 64 memory locations, each storing a 16-bit instruction
    reg [15:0] ins_mem [255:0];
    
    // Load instructions from an external file
    initial begin
        $readmemb("InsMem.mem", ins_mem); // Load memory contents from a binary file
    end
    
    // Fetch instruction when the program counter (pc_addr) changes
    always @(pc_addr) begin
        inst <= ins_mem[pc_addr];
    end

endmodule
