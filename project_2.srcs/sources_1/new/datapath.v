/*
This is kind of a central module to connect and create flow of data between all components.
 Calls each component in a specified order after fetching all instructions. 
 It handles everything from ALU operations, accessing memory, incrementing pc, 
 handling control unit, sign extension, address calculation, zero flag, etc.

*/

module datapath(
    input clk,
    input reset,
    input enable,
    output wire [7:0] pc_out_addr,    
    output wire [15:0] inst,         
    output wire [15:0] rs1_data,    
    output wire [15:0] rs2_data,     
    output wire [15:0] alu_result,   
    output wire RegWrite,       
    output wire MemWrite,         
    output wire MemRead,         
    output wire ALUSrc,          
    output wire [3:0] ALUOp,    
    output wire [15:0] imm,      
    output wire zero_flag         
); 

    
    wire [7:0] pc;
    wire [15:0] se_imm; 
    wire [15:0] alu_src_mux_out;
    wire [15:0] mem_data_out;
    wire Branch;
    wire Jump;
    wire [7:0] branch_target;
    wire [7:0] jump_target;
    
    reg [7:0] mux_pc_out;

    program_counter pc_unit(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mux_pc_out(mux_pc_out),
        .pc(pc)             
    );

    assign pc_out_addr = pc; 

    ins_mem instruction_memory(
        .pc_addr(pc),
        .inst(inst)
    );

    control_unit control(
        .opcode(inst[15:12]),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ALUSrc(ALUSrc),
        .RegWriteSrc(RegWriteSrc),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)
    );

    register_file reg_file(
        .clk(clk),
        .reset(reset),
        .rs1_addr(inst[11:8]),   
        .rs2_addr(inst[7:4]),    
        .wr_addr(inst[11:8]),   
        .wr_data(alu_result),   
        .reg_wr_en(RegWrite),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );


    assign se_imm = {{12{inst[3]}}, inst[3:0]};

    alu alu_unit(
        .rs_data1(rs1_data),
        .rs_data2(rs2_data),
        .alu_op(ALUOp),
        .func_code(inst[3:0]),
        .imm(inst[3:0]),
        .alu_src(ALUSrc),
        .result(alu_result),
        .zero_flag(zero_flag)
    );

    data_memory data_mem(
        .clk(clk),
        .data_in(rs1_data),
        .wr(MemWrite),
        .rd(MemRead),
        .addr(alu_result[7:0]), 
        .data_out(mem_data_out)
    );


     mux #(16) reg_write_mux(
        .input1(alu_result),
        .input2(mem_data_out),
        .select(RegWriteSrc),
        .out(wr_data)
    );


    assign branch_target = pc + 2 + (se_imm[7:0] << 1);

    assign jump_target = pc + 2 + ({ {4{inst[11]}}, inst[11:0] } << 1);

   always @(*) begin
    if(Jump)
        mux_pc_out = jump_target;
    else if (zero_flag && Branch) 
        mux_pc_out = branch_target;
    else  
        mux_pc_out = pc + 2;
   end


    assign imm = inst[3:0];

endmodule
