
# Writeback (WB) Stage

## Overview
The Writeback stage (WB) is the final stage of the MIPS pipeline. Its primary role is to write the results from the previous stages into the register file.

### Purpose:
- Write the ALU result or memory data back to the register file.
- Complete the execution of the instruction by storing the result.

### Components:
- **MUX (WB MUX):** Chooses between ALU result and memory data.
- **Register File:** Updates the specified register with the result.
- **MEM/WB Latch:** Holds data from the memory stage to be written back.

### Connections:
- The MUX selects either the data from memory or the result from the ALU.
- The selected data is written to the specified register.
- The write enable signal ensures the correct register is updated.

---

## Code Description
The `WB_stage` module consolidates data from the ALU result and memory data to be written back to the register file.

- **Write Data Selection:** Uses a MUX to choose between the ALU output and memory data.
- **Register Update:** Writes the selected data to the destination register.

---

## Functionality
At each clock cycle, the WB stage writes the result into the specified register if the write enable signal is active. The WB stage marks the completion of an instruction.

---

## Testing and Verification
- Verified that both ALU and memory results are correctly written to registers.
- Tested with arithmetic operations (ADD, SUB) and load instructions (LW).
- Cross-checked register values with expected outcomes.

---

## Common Issues and Fixes
- **Data Mismatch:** Corrected the MUX selection logic.
- **Register Write Failure:** Ensured the write enable signal was correctly generated.
- **Incorrect Data Written:** Adjusted the control signals and the MEM/WB latch data path.

