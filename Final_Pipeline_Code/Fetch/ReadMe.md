
# Fetch (IF) Stage

## Overview
The Fetch stage (IF) is the first stage in the MIPS pipeline. Its primary function is to fetch the next instruction from memory and update the program counter (PC) to point to the next instruction. 

### Purpose:
- Fetch instructions from memory.
- Update the PC to point to the next instruction.

### Components:
- **Program Counter (PC):** Holds the address of the current instruction.
- **Adder:** Increments the PC by 4 (next instruction).
- **MUX:** Selects between the incremented PC or a branch address.
- **Instruction Memory:** Retrieves the instruction from the memory.
- **IF/ID Latch:** Stores the fetched instruction and the updated PC.

### Connections:
- The PC is incremented by the adder.
- The MUX selects between the next sequential PC or a branch address.
- The instruction memory outputs the fetched instruction to the IF/ID latch.

---

## Code Description
The `IF_stage` module implements the program counter and instruction memory. The module first increments the PC and then reads the instruction from memory.

- **PC Update:** Uses an adder to increment the PC.
- **Branching:** A MUX selects the next PC based on whether a branch is taken.
- **Instruction Fetch:** Reads the instruction from instruction memory.

---

## Functionality
When the `clk` signal rises, the PC is updated, and the next instruction is fetched. If a branch is taken, the PC will update with the branch address. Otherwise, it will increment normally.

---

## Testing and Verification
- Verified with multiple instruction sets.
- Checked if PC increments correctly.
- Confirmed branch instructions correctly update the PC.

---

## Common Issues and Fixes
- **Instruction Fetch Failure:** Ensured the `risc.txt` file is correctly loaded.
- **Branch Address Mismatch:** Verified the PC update logic during branch conditions.
