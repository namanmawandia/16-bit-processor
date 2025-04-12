`timescale 1ns / 1ps

module top_module(
    input wire clk,               // Clock signal
    input wire reset,             // Reset signal (same as rst)
    input wire enable,            // Enable signal
    input wire manual_clock,      // Manual clock input from 2nd team
    input wire clock_mode,        // Clock mode selector
    output wire [8:0] debug_out,  // Debug output: {zero_flag, pc_out_addr}
    output reg [7:0] segments,    // Cathodes for 7-segment (adapted from 2nd team)
    output reg [3:0] anodes       // Anodes for display (same as in 2nd team)
);

    // Internal signals
    wire [15:0] alu_result;
    wire zero_flag;
    wire [7:0] pc_out_addr;
    wire [15:0] inst;
    wire [15:0] rs1_data;
    wire [15:0] rs2_data;
    wire RegWrite, MemWrite, MemRead, ALUSrc;
    wire [3:0] ALUOp;
    wire [15:0] imm;
    
    // Clock generation from 2nd team design
    reg manual_clock_prev = 0;
    wire manual_clock_pulse;
    wire system_clock;
    
    // Button debounce counters from 2nd team
    reg [19:0] debounce_counter = 0;
    reg debounced_manual_clock = 0;
    
    // Seven-segment display internals from 2nd team
    reg [19:0] refresh_counter = 0;
    wire [1:0] display_selector;
    reg [3:0] current_digit;
    
    // Display the ALU result (from your original design)
    wire [15:0] display_value;
    assign display_value = alu_result;
    
    // Debug output now shows both PC value and Zero flag:
    // Bit 8 contains the zero_flag, bits [7:0] contain the pc_out_addr.
    assign debug_out = {zero_flag, pc_out_addr};
    
    // Button debounce for manual clock - from 2nd team
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            debounce_counter <= 0;
            debounced_manual_clock <= 0;
        end else begin
            if (manual_clock != debounced_manual_clock) begin
                if (debounce_counter < 20'd500_000) begin // 5ms debounce at 100MHz
                    debounce_counter <= debounce_counter + 1;
                end else begin
                    debounced_manual_clock <= manual_clock;
                    debounce_counter <= 0;
                end
            end else begin
                debounce_counter <= 0;
            end
        end
    end
    
    // Edge detection for manual clock button - from 2nd team
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            manual_clock_prev <= 0;
        end else begin
            manual_clock_prev <= debounced_manual_clock;
        end
    end
    
    // Generate a single pulse on the rising edge of the manual clock button
    assign manual_clock_pulse = ~manual_clock_prev & debounced_manual_clock;
    
    // Clock selection logic - use either manual clock or automatic based on mode
    assign system_clock = clock_mode ? manual_clock_pulse : clk;
    
    // Refresh counter for seven-segment display multiplexing - from 2nd team
    always @(posedge clk or posedge reset) begin
        if (reset)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end
    
    // Use the 2 MSBs of the refresh counter to select which display to activate
    assign display_selector = refresh_counter[19:18];
    
    // Anode selection logic (active low) - from 2nd team
    always @(*) begin
        case (display_selector)
            2'b00: begin
                anodes = 4'b1110;       // Activate rightmost digit (LSB)
                current_digit = display_value[3:0];  // Rightmost hex digit
            end
            2'b01: begin
                anodes = 4'b1101;       // Activate second digit from right
                current_digit = display_value[7:4];  // Second hex digit
            end
            2'b10: begin
                anodes = 4'b1011;       // Activate third digit from right
                current_digit = display_value[11:8]; // Third hex digit
            end
            2'b11: begin
                anodes = 4'b0111;       // Activate leftmost digit (MSB)
                current_digit = display_value[15:12]; // Leftmost hex digit
            end
        endcase
    end
    
    // Seven-segment encoding (active low) - from 2nd team
    always @(*) begin
        case (current_digit)
            4'h0: segments = 8'b11000000; // 0
            4'h1: segments = 8'b11111001; // 1
            4'h2: segments = 8'b10100100; // 2
            4'h3: segments = 8'b10110000; // 3
            4'h4: segments = 8'b10011001; // 4
            4'h5: segments = 8'b10010010; // 5
            4'h6: segments = 8'b10000010; // 6
            4'h7: segments = 8'b11111000; // 7
            4'h8: segments = 8'b10000000; // 8
            4'h9: segments = 8'b10010000; // 9
            4'hA: segments = 8'b10001000; // A
            4'hB: segments = 8'b10000011; // B
            4'hC: segments = 8'b11000110; // C
            4'hD: segments = 8'b10100001; // D
            4'hE: segments = 8'b10000110; // E
            4'hF: segments = 8'b10001110; // F
            default: segments = 8'b11111111; // All segments off
        endcase
    end

    // Instantiate your datapath module, using the selected clock
    datapath datapath_instance(
        .clk(system_clock),       // Use the selected clock source
        .reset(reset),
        .enable(enable),
        .pc_out_addr(pc_out_addr),
        .inst(inst),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .alu_result(alu_result),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp),
        .imm(imm),
        .zero_flag(zero_flag)
    );

endmodule