
# 4-Memory (MEM) Stage

## Overview
The Memory stage (MEM) is the fourth stage of the MIPS pipeline. It handles data memory access operations, such as loading from or storing to memory.

### Purpose:
- Access data memory for load and store instructions.
- Pass the result to the Writeback (WB) stage if necessary.

### Components:
- **Data Memory:** Holds the data to be read or written.
- **AND Gate (Branch Decision):** Combines branch control signal and zero flag.
- **MEM/WB Latch:** Passes data and control signals to the Writeback stage.

### Connections:
- The ALU result from the EX stage is used as the memory address.
- The Write Data input holds the value to be stored.
- The output data is forwarded to the WB stage.

---

## Code Description
The `mem_stage` module is responsible for accessing the data memory and managing control signals for load and store instructions.

- **Memory Read/Write:** Uses the ALU result as the memory address.
- **Branch Decision:** Uses the `Branch` signal and `Zero` flag to determine if branching is needed.
- **Data Forwarding:** Passes data to the Writeback stage via the MEM/WB latch.

---

## Functionality
If the instruction requires memory access (like `LW` or `SW`), the module reads from or writes to the specified address. The output data is then passed to the WB stage.

---

## Testing and Verification
- Tested with load (`LW`) and store (`SW`) instructions.
- Verified correct data transfer between memory and pipeline registers.
- Confirmed proper branching when the Zero flag is set.

---

## Common Issues and Fixes
- **Memory Read/Write Failures:** Ensured that `data.txt` was correctly loaded.
- **Branch Misprediction:** Adjusted branch decision logic.
- **Data Corruption:** Fixed address calculation and byte alignment issues.

