`timescale 1ns / 1ns

module InstructionMemory_tb;

    // Testbench Signals
    reg clk;
    reg [7:0] pc_addr;      // 8-bit Program Counter Address
    wire [15:0] inst;       // 16-bit Instruction Output
    reg [7:0] prev_pc;      // Register to store the previous PC address

    // Instantiate the instruction memory module
    ins_mem ins_mem_inst (
        .pc_addr(pc_addr),
        .inst(inst)
    );

    // Clock generation (period = 10ns)
    always begin
        #5 clk = ~clk;  // Toggle clock every 5ns
    end

    // Initial Block for Test Procedure
    initial begin
        // Initialize signals
        clk = 0;
        pc_addr = 8'h00;  // Start with PC address 0x00
        prev_pc = 8'h00;  // Initialize previous PC to 0
        #10;              // Wait for 10ns

        // Simulate the Program Counter and Instruction Fetching
        repeat (256) begin
            #5;  // Wait for 5ns (clock cycle)
            
            // Increment Program Counter (PC)
            pc_addr = pc_addr + 1;

            // Wrap PC around if it reaches 255 (0xFF)
            if (pc_addr == 8'hFF) 
                pc_addr = 8'h00;

            // Display instruction fetched if PC changes
            if (pc_addr != prev_pc)
                $display("PC Address: %h, Instruction: %h", pc_addr, inst);

            // Store the current PC address for the next cycle
            prev_pc = pc_addr;
        end

        // End simulation after looping through all 256 addresses
        $finish;
    end

endmodule
