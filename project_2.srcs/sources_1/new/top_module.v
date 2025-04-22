/*
We use clk and reset for timing.
We support step or auto mode with enable and manual clock and clock mode.
We drive a 7-segment display with segments and anodes.

We have generated a pulse for each manual clock press and swithced clocks based on mode.
*/

module top_module(
    input wire clk,               
    input wire reset,             
    input wire enable,            
    input wire manual_clock,      
    input wire clock_mode,       
    output wire [7:0] debug_out, 
    output reg [7:0] segments,    
    output reg [3:0] anodes      
);


    wire [15:0] alu_result;
    wire zero_flag;
    wire [7:0] pc_out_addr;
    wire [15:0] inst;
    wire [15:0] rs1_data;
    wire [15:0] rs2_data;
    wire RegWrite, MemWrite, MemRead, ALUSrc;
    wire [3:0] ALUOp;
    wire [15:0] imm;
    
    reg manual_clock_prev = 0;
    wire manual_clock_pulse;
    wire system_clock;
    
    reg [19:0] debounce_counter = 0;
    reg debounced_manual_clock = 0;
    
    reg [19:0] refresh_counter = 0;
    wire [1:0] display_selector;
    reg [3:0] current_digit;
    
    wire [15:0] display_value;
    assign display_value = alu_result;
    
    assign debug_out = rs1_data;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            debounce_counter <= 0;
            debounced_manual_clock <= 0;
        end else begin
            if (manual_clock != debounced_manual_clock) begin
                if (debounce_counter < 20'd500_000) begin 
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
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            manual_clock_prev <= 0;
        end else begin
            manual_clock_prev <= debounced_manual_clock;
        end
    end
    
    
    assign manual_clock_pulse = ~manual_clock_prev & debounced_manual_clock;
    
    
    assign system_clock = clock_mode ? manual_clock_pulse : clk;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end
    
    
    assign display_selector = refresh_counter[19:18];
    
    always @(*) begin
        case (display_selector)
            2'b00: begin
                anodes = 4'b1110;  
                current_digit = display_value[3:0];  
            end
            2'b01: begin
                anodes = 4'b1101;  
                current_digit = display_value[7:4];  
            end
            2'b10: begin
                anodes = 4'b1011;  
                current_digit = display_value[11:8]; 
            end
            2'b11: begin
                anodes = 4'b0111;  
                current_digit = display_value[15:12]; 
            end
        endcase
    end
    
    always @(*) begin
        case (current_digit)
            4'h0: segments = 8'b11000000; 
            4'h1: segments = 8'b11111001; 
            4'h2: segments = 8'b10100100; 
            4'h3: segments = 8'b10110000; 
            4'h4: segments = 8'b10011001; 
            4'h5: segments = 8'b10010010; 
            4'h6: segments = 8'b10000010; 
            4'h7: segments = 8'b11111000; 
            4'h8: segments = 8'b10000000; 
            4'h9: segments = 8'b10010000; 
            4'hA: segments = 8'b10001000; 
            4'hB: segments = 8'b10000011; 
            4'hC: segments = 8'b11000110; 
            4'hD: segments = 8'b10100001; 
            4'hE: segments = 8'b10000110; 
            4'hF: segments = 8'b10001110; 
            default: segments = 8'b11111111; 
        endcase
    end

   
    datapath datapath_instance(
        .clk(system_clock),       
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