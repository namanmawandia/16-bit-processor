`timescale 1ns / 1ps

module datapath_tb;

  parameter CLK_PERIOD = 10; 

  reg clk;
  reg reset;
  reg enable;

  wire [7:0] pc_out_addr;
  wire [15:0] instruction;
  wire [15:0] readData1;
  wire [15:0] readData2;
  wire [15:0] alu_result;
  wire [15:0] imm;
  wire ALUSrc, MemRead, MemWrite, RegWrite;
  wire [3:0] ALUOp;
  wire [15:0] write_data;
  wire zero_flag;

 datapath dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .pc_out_addr(pc_out_addr),
    .inst(instruction),
    .rs1_data(readData1),
    .rs2_data(readData2),
    .alu_result(alu_result),
    .ALUSrc(ALUSrc),
    .ALUOp(ALUOp),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .imm(imm),
    .zero_flag(zero_flag)
  );

  initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk = ~clk;
  end

  integer file;

  initial begin
    file = $fopen("processor16bit_output.txt", "w");
    if (file == 0) begin
      $display("Error: could not open output file.");
      $finish;
    end

    $fwrite(file, "Time\tPC\tInstruction\tReadData1\tReadData2\tALU_Result\tALUSrc\tALUOp\tRegWrite\tMemRead\tMemWrite\tImm\n");

    reset = 1;
    #10;
    reset = 0;
    enable = 1; 
  end

  always @(posedge clk) begin
    $display("Time: %0t, PC: %h, Instruction: %h, ReadData1: %h, ReadData2: %h, ALU_Result: %h, ALUSrc: %b, ALUOp: %h, RegWrite: %b, MemRead: %b, MemWrite: %b, Zero_flag: %b",
      $time, pc_out_addr, instruction, readData1, readData2, alu_result, ALUSrc, ALUOp, RegWrite, MemRead, MemWrite, zero_flag);

    $display("   r0=%h, r1=%h, r2=%h, r3=%h, r4=%h, address[4]:%h",
      dut.reg_file.registers[0],
      dut.reg_file.registers[1],
      dut.reg_file.registers[2],
      dut.reg_file.registers[3],
      dut.reg_file.registers[4],
       dut.data_mem.memory[4]);

    $fwrite(file, "%0t\t%0h\t%0h\t%0h\t%0h\t%0h\t%0b\t%0h\t%0b\t%0b\t%0b\t%0b\n",
      $time, pc_out_addr, instruction, readData1, readData2, alu_result, ALUSrc, ALUOp, RegWrite, MemRead, MemWrite,zero_flag);
  end

  initial begin
    #200;
    $fclose(file);
    $finish;
  end

endmodule