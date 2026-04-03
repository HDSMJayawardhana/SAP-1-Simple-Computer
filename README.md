# 💻 CO221 - Building Digital Modules of a Simple Computer (SAP-1)

> **Course:** CO221 - Digital Design
> **Department:** Computer Engineering, University of Peradeniya
> **Based on:** SAP-1 Computer (Malvino & Brown, Chapter 140)

---

## 📌 Project Overview

This project implements digital modules of a **SAP-1 (Simple As Possible)**
computer system using **Verilog HDL**.
The modules are interconnected via an **8-bit data bus**.

---

## 🖥️ System Architecture

```
┌─────────────────────────────────────────────┐
│              8-BIT DATA BUS                  │
└──┬──────┬──────┬──────┬──────┬──────┬───────┘
   │      │      │      │      │      │
  PC    MAR    RAM     IR   REG-A  REG-B
                             │      │
                           ┌─┴──────┴─┐
                           │   ALU    │
                           └────┬─────┘
                           OUT-REG
                           7-SEG Display
```

---

## 📂 Repository Structure

```
SAP-1-Simple-Computer/
│
├── README.md
├── docs/
│   └── Project_Description.pdf
├── verilog/
│   ├── register_a.v           # Accumulator
│   ├── register_b.v           # Register B
│   ├── program_counter.v      # 4-bit Program Counter
│   ├── alu.v                  # Arithmetic & Logic Unit
│   ├── mar.v                  # Memory Address Register
│   ├── ram.v                  # 16x8 RAM
│   ├── instruction_register.v # Instruction Register
│   ├── output_register.v      # Output Register
│   ├── controller_sequencer.v # Controller/Sequencer
│   ├── multiplexer.v          # ALU Multiplexer
│   ├── ring_counter.v         # 6-bit Ring Counter
│   └── sap1_top.v             # Top-level Integration
├── testbench/
│   ├── tb_register_a.v
│   ├── tb_alu.v
│   ├── tb_program_counter.v
│   └── tb_sap1_top.v
└── diagrams/
    ├── block_diagram.md
    └── alu_diagram.md
```

---

## 🧩 Modules Description

| Module | Description |
|--------|-------------|
| **Register A** | 8-bit Accumulator with tri-state bus output |
| **Register B** | 8-bit register feeding ALU |
| **Program Counter** | 4-bit counter with clear and bus enable |
| **ALU** | 7 operations: ADD, SUB, XOR, AND, OR, NAND, NOR |
| **MAR** | 4-bit Memory Address Register |
| **RAM** | 16×8 bit memory with write/read control |
| **Instruction Register** | Holds current instruction, splits opcode/address |
| **Output Register** | Holds result for 7-segment display |
| **Ring Counter** | 6-bit timing generator (T1–T6) |
| **Controller Sequencer** | Generates control signals per opcode & timing |
| **Multiplexer** | Selects ALU operation output |

---

## 📋 Instruction Set

| Opcode | Mnemonic | Operation |
|--------|----------|-----------|
| 0000 | LDA | Load RAM → Accumulator |
| 0001 | ADD | Add RAM → Accumulator |
| 0010 | SUB | Subtract RAM → Accumulator |
| 1110 | OUT | Accumulator → Output Register |
| 1111 | HLT | Halt |

---

## ⚙️ ALU Operations

| OS (O1,O2,O3) | Operation |
|---------------|-----------|
| 000 | Addition |
| 001 | Subtraction |
| 010 | Bitwise XOR |
| 011 | Bitwise AND |
| 100 | Bitwise OR |
| 101 | Bitwise NAND |
| 110 | Bitwise NOR |

---

## 🛠️ How to Simulate

### Using ModelSim / Vivado

```bash
# Compile all verilog files
vlog verilog/*.v testbench/tb_sap1_top.v

# Run simulation
vsim tb_sap1_top

# View waveforms
add wave *
run 500ns
```

### Using Icarus Verilog (Free)

```bash
# Install
sudo apt install iverilog gtkwave

# Compile
iverilog -o sap1_sim verilog/*.v testbench/tb_sap1_top.v

# Run
./sap1_sim

# View waveform
gtkwave dump.vcd
```

---

## 🔧 Tools Used

| Tool | Purpose |
|------|---------|
| **Proteus** | Circuit Simulation (Phase 1) |
| **Verilog HDL** | Hardware Description |
| **ModelSim/Vivado** | Simulation |
| **74-Series ICs** | Physical Implementation |
| **KiCad/Eagle** | PCB Design (Phase 2) |

---

## 📚 References

- Malvino & Brown - *Digital Computer Electronics* (SAP-1, Chapter 140)
- CO221 Digital Design Lecture Notes
- University of Peradeniya, Department of Computer Engineering

---

## 📜 License

Academic project — CO221, University of Peradeniya.
