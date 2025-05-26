# 16-Bit Processor Design (Non-Pipelined)

## Overview

This project involves the implementation, simulation, and hardware synthesis of a simple 16-bit processor. The processor is designed using Verilog HDL and the Xilinx Vivado development environment and is deployed on a Xilinx Basys 3 FPGA board.

## Objectives

- Design a 16-bit single-cycle, non-pipelined processor.
- Simulate and verify the processor's functionality using Verilog.
- Synthesize the design and deploy it on an FPGA for hardware testing.

## Tools and Resources

- **Language**: Verilog HDL
- **Development Environment**: Xilinx Vivado
- **Target Hardware**: Xilinx Basys 3 FPGA Board

Useful links:
- [Basys 3 Reference Manual](https://digilent.com/reference/_media/reference/programmable-logic/basys-3/basys3_rm.pdf)

## Deliverables

- Verilog source code for the processor (simulation and hardware versions)
- Final report including:
  - Diagrams (datapath and control path)
  - Component descriptions
  - Simulation results
  - Work distribution
- Live demonstration and individual interviews

## Processor Specifications

### General

- Word Size: 16 bits
- Byte-addressed memory
- Single-cycle, non-pipelined design

### Required Components

- Instruction Memory (≥64 locations)
- Data Memory (≥64 locations)
- Register File (16 registers: $s0 - $s15, 16 bits each)
- ALU
- Sign Extension
- Control Unit(s)
- Multiplexer(s)
- Program Counter

### Instruction Formats

- **R-Type**: `opcode | rt/rd | rs | function`
- **I-Type**: `opcode | rt/rd | rs | immediate`
- **J-Type**: `opcode | address`

### Supported Instructions

| Instruction | Opcode | Function Code | Type  |
|-------------|--------|---------------|-------|
| add         | 0000   | 0000          | R-type|
| sub         | 0000   | 0001          | R-type|
| sll         | 0000   | 0010          | R-type|
| and         | 0000   | 0011          | R-type|
| lw          | 0001   | N/A           | I-type|
| sw          | 0010   | N/A           | I-type|
| addi        | 0011   | N/A           | I-type|
| beq         | 0100   | N/A           | I-type|
| bne         | 0101   | N/A           | I-type|
| jmp         | 0110   | N/A           | J-type|

### Example Behaviors

- **add**: `R[rt/rd] = R[rs] + R[rt/rd]`
- **sub**: `R[rt/rd] = R[rs] - R[rt/rd]`
- **sll**: `R[rt/rd] << R[rs]`
- **and**: `R[rt/rd] = R[rs] & R[rt/rd]`
- **lw/sw**: Load/store from/to `R[rs] + immediate`
- **beq/bne**: Branch if equal/not equal
- **jmp**: Jump to `PC + (address << 1)`

## Memory

- Memory is byte-addressed.
- Maximum addressable memory: 65,536 bytes (16-bit address space).
- Memory can be initialized using `readmemb`/`readmemh` or hardcoded in `initial` blocks.

## Development Tips

- Start by designing the datapath and individual components.
- Implement instructions incrementally (begin with R-type).
- Use simulation to verify functionality before synthesizing for hardware.
- Consider modular and testable Verilog code organization.

---

