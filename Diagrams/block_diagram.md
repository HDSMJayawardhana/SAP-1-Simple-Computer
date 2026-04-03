# SAP-1 Simple Computer - Block Diagram

```
                    ┌─────────────────────────────────────────────┐
                    │              8-BIT DATA BUS                  │
                    └──┬──────┬──────┬──────┬──────┬──────┬───────┘
                       │      │      │      │      │      │
              ┌────────┴─┐  ┌─┴────┐ │  ┌──┴───┐  │  ┌───┴────┐
   CLK,CLR ──►│ Program  │  │ MAR  │ │  │ RAM  │  │  │   IR   │
   CP,EP   ──►│ Counter  │  │(4bit)│ │  │16x8  │  │  │(8 bit) │
              │  (4bit)  │  └──┬───┘ │  └──┬───┘  │  └───┬────┘
              └──────────┘     │     │     │      │      │
                               └─────┘     │      │   opcode
                                           │      │      │
              ┌───────────┐            ┌───┴──────┴──────┴────────┐
   CLK,LA  ──►│Register A │            │    Controller Sequencer   │
   EA      ──►│(Accumul.) │◄──────────►│  Ring Counter + Control  │
              └─────┬─────┘            │  Matrix (T1-T6)          │
                    │ (to ALU)         └──────────────────────────┘
              ┌─────┴─────┐
              │    ALU    │◄── OS (3-bit Operation Select)
              │  ADD/SUB  │
              │  XOR/AND  │
              │  OR/NAND  │
              │    NOR    │
              └─────┬─────┘
                    │ EU (enable)
              ┌─────┴─────┐   ┌────────────────┐
   CLK,LB  ──►│Register B │   │ Output Register│──► 7-Segment
              │  (8 bit)  │   │    (8 bit)     │    Display
              └───────────┘   └────────────────┘
```

## Control Signals

| Signal | Type | Description |
|--------|------|-------------|
| CP | Active HIGH | Program Counter increment |
| EP | Active HIGH | PC output to bus |
| LM | Active LOW | MAR load |
| CE | Active LOW | RAM chip enable |
| LI | Active LOW | IR load |
| EI | Active LOW | IR output to bus |
| LA | Active LOW | Register A load |
| EA | Active HIGH | Register A to bus |
| EU | Active HIGH | ALU to bus |
| LB | Active LOW | Register B load |
| LO | Active LOW | Output Register load |

## Instruction Set

| Opcode | Mnemonic | Operation |
|--------|----------|-----------|
| 0000 | LDA | Load RAM data → Accumulator |
| 0001 | ADD | Add RAM data to Accumulator |
| 0010 | SUB | Subtract RAM data from Accumulator |
| 1110 | OUT | Load Accumulator → Output Register |
| 1111 | HLT | Halt processing |

## ALU Operation Select

| OS (O1,O2,O3) | Operation |
|---------------|-----------|
| 000 | Addition |
| 001 | Subtraction |
| 010 | Bitwise XOR |
| 011 | Bitwise AND |
| 100 | Bitwise OR |
| 101 | Bitwise NAND |
| 110 | Bitwise NOR |

## Controller Sequence (LDA Instruction)

| Step | Action | Control Signals |
|------|--------|-----------------|
| T1 | PC → MAR | EP=1, LM=0 |
| T2 | Increment PC | CP=1 |
| T3 | RAM → IR | CE=0, LI=0 |
| T4 | IR(addr) → MAR | EI=0, LM=0 |
| T5 | RAM → Reg A | CE=0, LA=0 |
| T6 | No operation | - |
